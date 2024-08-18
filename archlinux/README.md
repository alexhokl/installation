## References

- [Installation guide](https://wiki.archlinux.org/title/installation_guide)
- [Alacritty](https://wiki.archlinux.org/title/Alacritty)
- [Pipewire](https://wiki.archlinux.org/title/PipeWire)
- [Efficient Encrypted UEFI-Booting Arch
  Installation](https://gist.github.com/HardenedArray/31915e3d73a4ae45adc0efa9ba458b07)

## Partitioning

Assuming the system contains 8Gb of memory.

| Device      | Size            | File system      | Mount point     |
| ---         | ---             | ---              | ---             |
| `/dev/sda1` | +100M           | `EF00`           | `/mnt/boot/efi` |
| `/dev/sda1` | +250M           | `8300` (default) | `/mnt/boot`     |
| `/dev/sda3` | remaining space | `8300` (default) | `/mnt`          |

Note that, with this setup, `/mnt/boot` is not encrypted.

To start partitioning

```sh
gdisk /dev/sda
```

To format and mount the new partitions

```sh
curl -sSLO https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/setup.sh
chmod +x setup.sh
```

Edit `setup.sh` to fit the device names and size of swap partition.

If the hard disk involved is `/dev/nvme0n1` (check with `lsblk`), the memory is
16Gb and the ethernet interface is `eno1` (check with `ip a`), we can do the
following replacements

```sh
sed -i -e 's/sda/nvme0n1p/' setup.sh
sed -i -e 's/12G/24G/' setup.sh
sed -i -e 's/ens3/eno1/' setup.sh
```
Once the editing is done, run the following to complete the setup.

```sh
./setup.sh
```

## Install packages

After reboot, login as a normal user

```sh
./setup.sh
```

Once the above has been completed, reboot again.

The following commands can be ran to import keys from public key server.

```sh
gpg --keyserver hkps://pgp.mit.edu --recv-keys $KEYID
```

## Crostini

Reference: [Chrome OS
devices/Crostini](https://wiki.archlinux.org/title/Chrome_OS_devices/Crostini)

Open one `crosh` window by <kbd>ctrl</kbd><kbd>alt</kbd><kbd>t</kbd>.

```sh
vmc start termina
```

Open another `crosh` window.

```sh
vmc container termina arch https://us.lxd.images.canonical.com/ archlinux/current
```

It is fine if it shows the following error message.

```
"Error: routine at frontends/vmc.rs:403
`container_setup_user(vm_name,user_id_hash,container_name,username)` failed:
timeout while waiting for signal"
```

```sh
vsh termina
lxc exec arch -- bash
grep 1000:1000 /etc/passwd|cut -d':' -f1
pkill -9 -u alexhokl
groupmod -n alex alexhokl
usermod -d /home/alex -l alex -m -c alex alexhokl
passwd alex
sed -i -e 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers
sed -i -e 's/#\en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
usermod -aG wheel alex
exit
```

Sign out of ChromeOS so that all containers are shutdown and virtual machine is
off. Sign back on and open one `crosh` window by
<kbd>ctrl</kbd><kbd>alt</kbd><kbd>t</kbd>. Rename the `lxc` container of
ArchLinux created to `penguin`.

```sh
vmc start termina
lxc rename penguin debian
lxc rename arch penguin
```

Sign out of ChromeOS so that all containers are shutdown and virtual machine is
off. Sign back on and open Crostini terminal.

```sh
sudo pacman -Syu
sudo pacman -S --noconfirm pacman-contrib git rsync reflector base-devel wayland xorg-xwayland
sudo reflector -a 10 -c hk -f 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syu
mkdir git
git clone https://aur.archlinux.org/yay.git $HOME/git/yay
cd $HOME/git/yay
makepkg -si --noconfirm
yay -Syu --answerclean A --answerdiff N
yay -S --answerclean A --answerdiff N cros-container-guest-tools-git
systemctl --user enable sommelier-x@0.service
systemctl --user enable sommelier@0.service

USER_SETUP_SCRIPT_FILE=/home/$USER/setup.sh
curl -o $USER_SETUP_SCRIPT_FILE -sSL https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/user_setup_crostini.sh
chmod +x $USER_SETUP_SCRIPT_FILE
$USER_SETUP_SCRIPT_FILE
```

## VM on GCP

```sh
sudo pacman --noconfirm -Sy archlinux-keyring
sudo pacman --noconfirm -Syu
sudo pacman --noconfirm -S pacman-contrib git rsync reflector base-devel tailscale
sudo systemctl enable tailscaled
sudo tailscale up --ssh
```

```sh
sudo sed -i -e 's/#\en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
sudo ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
sudo locale-gen
echo LANG=en_GB.UTF-8 | sudo tee /etc/locale.conf
mkdir git
git clone https://aur.archlinux.org/yay.git $HOME/git/yay
cd $HOME/git/yay
makepkg -si --noconfirm
yay -Syu --answerclean A --answerdiff N
USER_SETUP_SCRIPT_FILE=/home/$USER/setup.sh
curl -o $USER_SETUP_SCRIPT_FILE -sSL https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/user_setup.sh
chmod +x $USER_SETUP_SCRIPT_FILE
$USER_SETUP_SCRIPT_FILE
```
