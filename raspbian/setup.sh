#!/bin/bash

sudo apt update

SOURCE_LIST=/etc/apt/sources.list
SOURCE_LIST_DIR=/etc/apt/sources.list.d
DISTRIBUTION=$(. /etc/os-release; echo $ID)
DISTRIBUTION_RELEASE=$(lsb_release -cs)

# gcloud
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee $SOURCE_LIST_DIR/google-cloud-sdk.list
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a $SOURCE_LIST_DIR/google-cloud-sdk.list
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# docker
echo "deb [arch=armhf] https://download.docker.com/linux/${DISTRIBUTION} ${DISTRIBUTION_RELEASE} stable" | sudo tee -a $SOURCE_LIST
curl -fsSL https://download.docker.com/linux/${DISTRIBUTION}/gpg | sudo apt-key add -

# kubectl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee $SOURCE_LIST_DIR/kubernetes.list

# tailscale
curl -fsSL https://pkgs.tailscale.com/stable/${DISTRIBUTION}/${DISTRIBUTION_RELEASE}.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/${DISTRIBUTION}/${DISTRIBUTION_RELEASE}.list | sudo tee $SOURCE_LIST_DIR/tailscale.list

sudo apt update
sudo apt -y upgrade

curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/raspbian/packages.sh | bash

sudo usermod -aG docker $USER
sudo usermod -a -G wireshark $USER

sudo apt install --fix-broken -y
sudo apt autoremove -y
