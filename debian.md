#### Steps

Reference:
- [Initial Server Setup With Debian 8](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-8)

1.  Install sudo and enable myself to sudo
```sh
su
nano /etc/ap/sources.list
(remove lines with  `cdrom` to avoid prompting for discs)
apt-get update
apt-get sudo
usermod -a -G sudo alex
```
2. Reboot to allow the changes to be applied.

3.
```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install git-core build-essential neovim python-neovim
mkdir ~/git && cd ~/git
git clone https://github.com/alexhokl/dotfiles

```
