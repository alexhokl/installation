- [Backup](#backup)
- [Steps](#steps)
- [Installing WiFi on Intel NUC](#installing-wifi-on-intel-nuc)
- [Configure VPN L2TP/IPSec](#configure-vpn-l2tpipsec)

#### BIOS settings on XPS 13 7390

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

#### Steps

After finishing the installation using a USB drive,

```sh
sudo apt install -y apt-transport-https curl --no-install-recommends
curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/ubuntu.sh | bash
shutdown -r now
```

```sh
sudo update-alternatives --install /usr/bin/vi vi "$(which nvim)" 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim "$(which nvim)" 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 60
sudo update-alternatives --config editor
```

- Ensure `env | grep GDM_LANG` does not return `en_HK.UTF-8` and
    `i3-dmenu-desktop` would not work otherwise
  - to set `GDM_LANG`, open Settings app via `i3-dmenu-desktop` and select
      "Region and Language" and change "Language" to either "English (UK)" or
      "English (US)"
- Download `.pem` file from a machine has GPG keys stored so that SSH is
    possible and change its file access to `chmod 600`
- SSH into the machine has the GPG key
  - Unfortunately, `ssh user_name@server_name gpg --export-secret-key KEY_ID | gpg --import`
      does not work due to `pinentry` setup
    - where `KEY_ID` is the key to be imported
  - Export the key into a file
    `gpg --export-secret-key EE510D8CB9F12960 > file.key`
  - `ssh user_name@server_name cat file.key | gpg --import`
- copy git credentials from another machine using SSH
- copy Docker Content Trust keys from another machine using SSH
    (`~/.docker/trust/private/`)
- Open neovim and execute the following commands

```
:UpdateRemotePlugins
:GoInstallBinaries
:OmniSharpInstall
```

##### Backup

```sh
curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/debian.backup.sh | bash
```

##### Sleep on Debian 10

To avoid the system goes into sleep in GNOME login screen, make sure setting
`sleep-inactive-ac-type` is set to `'blank'` in
`/etc/gdm3/greeter.dconf-defaults`.

##### Installing WiFi on Intel NUC

1. Download the latest driver from [Linux Support for Intel® Wireless
   Adapters](https://www.intel.com/content/www/us/en/support/articles/000005511/network-and-i-o/wireless-networking.html). Follow its instruction and copy the contents of the downloaded zip file to directory `/lib/firmware`.
2. `sudo modprobe -r iwlwifi`
3. `sudo modprobe iwlwifi`
4. Assuming the WiFi network interface is `wlan0`, `sudo ip link set wlan0 up`
5. `sudo iwlist scan`
6. `wpa_passphrase alex-wifi secret-password`
7. `sudo nvim /etc/network/interfaces` and put the value of `psk` in the above step  as value of `wpa-psk`.
8. `sudo chmod 0600 /etc/network/interfaces`

```
iface wlan0 inet dhcp
  wpa-ssid alex-wifi
  wpa-psk some-long-string
```

See also [How to use a WiFi interface](https://wiki.debian.org/WiFi/HowToUse)

##### Configure VPN L2TP/IPSec

1. Configure Strongswan by editing `/etc/ipsec.conf`

```
# ipsec.conf - strongSwan IPsec configuration file

# basic configuration

config setup
  # strictcrlpolicy=yes
  # uniqueids = no

# Add connections here.

# Sample VPN connections

conn %default
  ikelifetime=60m
  keylife=20m
  rekeymargin=3m
  keyingtries=1
  keyexchange=ikev1
  authby=secret
  ike=aes128-sha1-modp1024,3des-sha1-modp1024!
  esp=aes128-sha1-modp1024,3des-sha1-modp1024!

conn office
  keyexchange=ikev1
  left=%defaultroute
  auto=add
  authby=secret
  type=transport
  leftprotoport=17/1701
  rightprotoport=17/1701
  right=office.example.com
```

2. Edit `/etc/ipsec.secrets`

```
: PSK "The_Preshared_Key_From_Router"
```

3. `sudo chmod 600 /etc/ipsec.secrets`
4. Configure xl2tpd by editing `/etc/xl2tpd/xl2tpd.conf` 

```
[lac office]
lns = office.example.com
ppp debug = yes
pppoptfile = /etc/ppp/options.l2tpd.client
length bit = yes
```

5. Edit `/etc/ppp/options.l2tpd.client`

```
ipcp-accept-local
ipcp-accept-remote
refuse-eap
require-chap
noccp
noauth
mtu 1280
mru 1280
noipdefault
defaultroute
usepeerdns
connect-delay 5000
name your_vpn_username
password your_vpn_password
```

6. `sudo chmod 600 /etc/ppp/options.l2tpd.client`
7. `sudo service strongswan restart && sudo service xl2tpd restart`
8. IPSec connection is configured by this point and only IP route is to be
   configured and to kick start the connection (see [start VPN in bash](https://github.com/alexhokl/notes/blob/master/bash.md#start-vpn-ipsec))
