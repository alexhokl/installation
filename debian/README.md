- [Links](#links)
- [BIOS settings on XPS 13 7390](#bios-settings-on-xps-13-7390)
- [Steps](#steps)
- [Backup](#backup)
- [Installing WiFi on Intel NUC](#installing-wifi-on-intel-nuc)
- [Configure VPN L2TP/IPSec](#configure-vpn-l2tpipsec)

## Links

- [Ubuntu on Dell XPS 13 7390](https://certification.ubuntu.com/hardware/201906-27151)

## BIOS settings on XPS 13 7390

1. Press `F12` upon booting to enter BIOS menu
2. Select `BIOS SETUP` from the menu
3. From the menu on the left, select `POST Behaviour`
4. In section `Fastboot`, select `Thorough`
5. From the menu on the left, select `System Configuration`
6. In section `SATA Operation`, select `AHCI`
7. In section `Thunderbolt Adapter Configuration`, turn on `Enable Thunderbolt
   Boot Support` and select `No Security` in `Thunderbolt Security Level`
8. From the menu on the left, select `Secure Boot`
9. Turn off `Enable Secure Boot`
10. Apply changes and exit and press `F12` again to enter BIOS menu again
11. Select `BIOS SETUP` from the menu
12. From the menu of the left, select `Boot Options`
13. Select the correct USB drive
14. Apply changes and exit

## Steps

### Debian-specific

Upon booting into Debian installer,

1. select `Advanced options`, then
2. select `Automated install`, then
3. when prompted with "Location of initial preconfiguration file:", enter
   `https://raw.githubusercontent.com/alexhokl/installation/master/debian/preseed.cfg`
   or `https://raw.githubusercontent.com/alexhokl/installation/master/debian/preseed.no-root.cfg`
   if root account is not required

If root account is enabled during installation, execute the following; skip, otherwise.

```sh
passwd
su
passwd
/usr/sbin/usermod -a -G sudo alex
/usr/sbin/shutdown -r now
```

Once `sudo` is installed (or root account has been disabled), execute the
following.

### General

```sh
sudo apt update
sudo apt install -y apt-transport-https --no-install-recommends
curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/debian/setup.sh | bash
shutdown -r now
```

- Ensure `env | grep GDM_LANG` does not return `en_HK.UTF-8` and
    `i3-dmenu-desktop` would not work otherwise
  - to set `GDM_LANG`, open Settings app via `i3-dmenu-desktop` and select
      "Region and Language" and change "Language" to either "English (UK)" or
      "English (US)"
- Download GPG public key and import it using `gpg --import something.pub`
  - Once a Yubikey is inserted to the machine, the subkeys will be available to
    be used
- copy Docker Content Trust keys from another machine using SSH
    (`~/.docker/trust/private/`)

## Backup

```sh
curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/debian/backup.sh | bash
```

## Configure firewall for Tailscale

```sh
sudo ufw allow in on tailscale0 to any port 22
sudo ufw allow 41641/udp
```

## Configure firewall for Barrier

```sh
sudo ufw allow in on tailscale0 to any port 24800
```

## Configure VPN L2TP/IPSec

1. Create a file with content similar to the following in directory
   `/etc/NetworkManager/system-connections/` where the filename matches `id`
   used.

```conf
[connection]
id=your-vpn
uuid=bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb
type=vpn
autoconnect=false
permissions=

[vpn]
gateway=office.your-domain.com
ipsec-enabled=yes
ipsec-psk=YourPreSharedKey
password-flags=0
user=your-username
service-type=org.freedesktop.NetworkManager.l2tp

[vpn-secrets]
password=your-password

[ipv4]
dns-search=
method=auto

[ipv6]
addr-gen-mode=stable-privacy
dns-search=
ip6-privacy=0
method=auto
```

2. Ensure the file access mode is changed to `600` (`sudo chmod 600`).
3. Reset network manager by `systemctl restart NetworkManager.service`.
4. Check if the VPN has been setup correct by `nmcli c`.
5. Connect to the newly setup VPN by `nmcli c up your-vpn`.

Note that, if it fails to establish a connection with errors like `received
NO_PROPOSAL_CHOSEN error notify`, one can try removing all temporary secrets
by `sudo rm -f /etc/ipsec.d/nm-l2tp-ipsec-*.secrets`.

Note that `libreswan` can be installed to support older ciphers.

To support `PPTP` with `ufw`, GRE tunnels has to be enabled `sudo ufw allow
proto gre from 200.200.200.200`(assuming the VPN server located at
`200.200.200.200`).

## Installing WiFi on Intel NUC

Note that the driver installation may only be needed in Debian 9 (stretch)
installation (to be verifiied).

1. Download the latest driver from [Linux Support for Intel® Wireless
   Adapters](https://www.intel.com/content/www/us/en/support/articles/000005511/network-and-i-o/wireless-networking.html).
   Follow its instruction and copy the contents of the downloaded zip file to
   directory `/lib/firmware`.
2. `sudo modprobe -r iwlwifi`
3. `sudo modprobe iwlwifi`
4. Use `nmcli dev wifi` to list the available SSIDs.
5. `nmcli dev wifi connect your-ssid -a` to setup the connection.
6. `nmcli c up your-ssid` to connect to the newly setup WiFi connection.

See also [How to use a WiFi interface](https://wiki.debian.org/WiFi/HowToUse)
