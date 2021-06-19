### Prepare Respbian Lite on a SD card

```sh
INSTALL_DIR=$(mktemp -d)
curl -o $INSTALL_DIR/raspbian.zip -sSL https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-05-28/2021-05-07-raspios-buster-armhf-lite.zip
unzip $INSTALL_DIR/raspbian.zip -d $INSTALL_DIR/
# unmount sd-card if it is mounted
sudo dd bs=4M if=$INSTALL_DIR/2021-05-07-raspios-buster-armhf-lite.img of=/dev/sdX conv=fsync
```

### Default credentials

Username: `pi`
Password: `raspberry`

### Initial setup

Connect Pi to a monitor and a keyboard.

After login, execute `sudo raspi-config`. In the menu, select `Localisation
Options` and configure the locale to use. In `Interface Options`, enable SSH
access. In `System Options`, configure WiFi SSID and passphrase. Also in `System
Options`, change password of user `pi`.

To prepare the Pi to access Tailscale network, generate a one-time key in [Auth
Keys](https://login.tailscale.com/admin/settings/authkeys).

After reboot, execute `ip a` to find out the IP address assigned. From this
moment on, one should be able to SSH into it by `ssh pi@192.168.1.999`.

```sh
curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/raspbian/setup.sh | bash
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf
sudo tailscale up --authkey your-one-time-key --hostname pi99
sudo ufw allow in on tailscale0 to any port 22
sudo ufw enable
```
