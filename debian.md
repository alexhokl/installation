##### Reference

- [Initial Server Setup With Debian 8](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-8)


#### Steps

- Open this page with Firefox

```sh
su
apt-get update
apt-get install -y apt-transport-https ca-certificates curl dirmngr --no-install-recommends
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian.1.root.sh -o debian.1.root.sh
chmod +x debian.1.root.sh
./debian.1.root.sh
rm debian.1.root.sh
shutdown -r now
```

```sh
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian.2.user.sh -o debian.2.user.sh
chmod +x debian.2.user.sh
./debian.2.user.sh
```

- Reboot to make sure docker for unprivileged user is enabled.

- Open neovim
  - update plugins via `:UpdateRemotePlugins`
  - install go binaries via `:GoInstallBinaries`
- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- `gpg2 --gen-key` (and select "RSA and RSA", select 4096 as keysize, select "key does not expire", enter github registration email address for "email address")
- `gpg2 --list-secret-keys --keyid-format LONG` (and copy the number in "sec" after "4096R/"
- copy the number into `.gitconfig`
- `gpg2 --armor --export {key}` (replace key with the number in the previous step)
- add the GPG key onto GitHub

```sh
sudo apt-get -y install g++

sudo nvim /etc/locale.gen
(find and un-comment en_GB.UTF-8 and save and quit)
sudo locale-gen
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

