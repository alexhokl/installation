#!/bin/bash

sudo ACCEPT_EULA=Y apt install -y \
		bluez-tools \
		blueman \
		bridge-utils \
		openvpn \
		pptp-linux \
		qemu-kvm \
		ufw \
		virt-manager \
		xl2tpd

if [ "debian" = ${DISTRIBUTION} ]; then
  sudo apt install -y \
    bluez-firmware \
    firmware-iwlwifi \
    peek
elif [ "ubuntu" = ${DISTRIBUTION} ]; then
  sudo add-apt-repository ppa:canonical-hwe-team/backport-iwlwifi;
  sudo apt-get update;
  sudo apt-get install backport-iwlwifi-dkms;
fi

