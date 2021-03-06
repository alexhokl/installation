#!/bin/bash

sudo apt update
sudo apt install -y lsb-release

SOURCE_LIST=/etc/apt/sources.list
SOURCE_LIST_DIR=/etc/apt/sources.list.d
DISTRIBUTION=$(. /etc/os-release; echo $ID)
DISTRIBUTION_RELEASE=$(lsb_release -cs)
DISTRIBUTION_RELEASE_NO=10
if [ "ubuntu" = "${DISTRIBUTION}" ]; then
	if [ "focal" = "${DISTRIBUTION_RELEASE}" ]; then
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
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a $SOURCE_LIST_DIR/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# docker
echo "deb [arch=amd64] https://download.docker.com/linux/${DISTRIBUTION} ${DISTRIBUTION_RELEASE} stable" | sudo tee -a $SOURCE_LIST
curl -fsSL https://download.docker.com/linux/${DISTRIBUTION}/gpg | sudo apt-key add -

# kubectl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee $SOURCE_LIST_DIR/kubernetes.list

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

# yarn
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee $SOURCE_LIST_DIR/yarn.list
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null

# signal
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a $SOURCE_LIST
curl -sS https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee -a $SOURCE_LIST
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

# tailscale
curl -fsSL https://pkgs.tailscale.com/stable/${DISTRIBUTION}/${DISTRIBUTION_RELEASE}.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/${DISTRIBUTION}/${DISTRIBUTION_RELEASE}.list | sudo tee $SOURCE_LIST_DIR/tailscale.list

# protonvpn
curl -fsSL https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.protonvpn.com/debian unstable main'

# helm
curl -sSL https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee $SOURCE_LIST_DIR/helm-stable-debian.list
sudo apt install helm

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
sudo usermod -a -G wireshark $USER
sudo adduser $USER libvirt

source $HOME/git/installation/versions-on-github
source $HOME/git/installation/debian/functions
install_all

sudo update-alternatives --install /usr/bin/vi vi "$(which nvim)" 60
sudo update-alternatives --install /usr/bin/vim vim "$(which nvim)" 60
sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 60

sudo apt --fix-broken install -y

cd $HOME/git/dotfiles
make bin
make dotfiles
cd $HOME

sudo sed -i -e 's/#\ en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
sudo locale-gen
