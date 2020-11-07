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
fi

