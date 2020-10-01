#!/bin/bash

sudo apt update
sudo apt install -y lsb-release

SOURCE_LIST=/etc/apt/sources.list
SOURCE_LIST_DIR=/etc/apt/sources.list.d
DISTRIBUTION=$(. /etc/os-release; echo $ID)
DISTRIBUTION_RELEASE=$(lsb_release -cs)
DISTRIBUTION_RELEASE_NO=10
if [ "ubuntu" = "${DISTRIBUTION}" ]; then
	if [ "focus" = "${DISTRIBUTION_RELEASE}" ]; then
  	DISTRIBUTION_RELEASE_NO=20.04
	else
		DISTRIBUTION_RELEASE_NO=18.04
	fi
fi
HARDWARE_TYPE=$(uname -i)  # unknown for crostini or virtual machine

# chrome
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee $SOURCE_LIST_DIR/google-chrome.list

# gcloud
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee $SOURCE_LIST_DIR/google-cloud-sdk.list
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# docker
echo "deb [arch=amd64] https://download.docker.com/linux/${DISTRIBUTION} ${DISTRIBUTION_RELEASE} stable" | sudo tee -a $SOURCE_LIST
curl -fsSL https://download.docker.com/linux/${DISTRIBUTION}/gpg | sudo apt-key add -

# kubectl
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a $SOURCE_LIST

# yubico
# echo "deb http://ppa.launchpad.net/yubico/stable/ubuntu wily main" | sudo tee -a $SOURCE_LIST
# echo "deb-src http://ppa.launchpad.net/yubico/stable/ubuntu wily main" | sudo tee -a $SOURCE_LIST
# sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 3653E21064B19D134466702E43D5C49532CBA1A9

# spotify
# echo "deb http://repository.spotify.com stable non-free" | sudo tee -a $SOURCE_LIST
# curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -

# Microsdft azure-cli, dotnet core, vscode, mssql-tools
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ ${DISTRIBUTION_RELEASE} main" | sudo tee -a $SOURCE_LIST
curl -sS https://packages.microsoft.com/config/${DISTRIBUTION}/${DISTRIBUTION_RELEASE_NO}/prod.list | sudo tee $SOURCE_LIST_DIR/mssql-release.list;
echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" | sudo tee $SOURCE_LIST_DIR/vscode.list
curl -sS https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# mono
# echo "deb http://download.mono-project.com/repo/${DISTRIBUTION} stable-${DISTRIBUTION_RELEASE} main" | sudo tee -a $SOURCE_LIST
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

# yarn
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee -a $SOURCE_LIST
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# signal
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a $SOURCE_LIST
curl -sS https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee -a $SOURCE_LIST
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

# dart
curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
curl -sS https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list | sudo tee $SOURCE_LIST_DIR/dart_stable.list

sudo apt update
sudo apt -y upgrade

curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/debian/basic_packages.sh | bash
if [ "unknown" != "$HARDWARE_TYPE" ]; then
	curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/debian/ui_packages.sh | bash
	curl -sS https://raw.githubusercontent.com/alexhokl/installation/master/debian/desktop_package.sh | bash
fi

if [ "unknown" != "$HARDWARE_TYPE" ]; then
	sudo snap install barrier
	sudo snap install helm --classic
	sudo snap install kontena-lens --classic
fi

git clone https://github.com/alexhokl/installation $HOME/git/installation
git clone https://github.com/alexhokl/dotfiles $HOME/git/dotfiles
git clone https://github.com/alexhokl/notes $HOME/git/notes
if [ "unknown" != "$HARDWARE_TYPE" ]; then
	git clone https://github.com/vivien/i3blocks-contrib $HOME/.config/i3blocks
fi

sudo usermod -aG docker $USER
sudo adduser $USER libvirt

source $HOME/git/installation/versions-on-github
source $HOME/git/installation/debian/functions
install_all

sudo apt --fix-broken install -y

cd $HOME/git/dotfiles
make bin
make dotfiles
cd $HOME

sudo sed -i -e 's/#\ en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
sudo locale-gen
