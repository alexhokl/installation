#### Steps

Upon booting into Debian installer,

1. select `Advanced options`, then
2. select `Automated install`, then
3. when prompted with "Location of initial preconfiguration file:", enter
   `https://raw.githubusercontent.com/alexhokl/installation/master/debian.preseed.cfg`
   or `https://raw.githubusercontent.com/alexhokl/installation/master/debian.preseed.no-root.cfg`
   if root account is not required

If root account is enabled during installation, execute the following; skip, otherwise.

```sh
su
apt-get update
apt-get install -y sudo
usermod -a -G sudo alex
shutdown -r now
```

```sh
sudo apt-get install -y apt-transport-https ca-certificates curl dirmngr --no-install-recommends
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian.2.user.sh -o debian.2.user.sh
chmod +x debian.2.user.sh
./debian.2.user.sh
rm debian.2.user.sh
shutdown -r now
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
  - `ssh user_name@server_name cat file.key | gpg --import`
- copy git credentials from another machine using SSH
- Open neovim and execute the following commands

```
:UpdateRemotePlugins
:GoInstallBinaries
:OmniSharpInstall
```

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
