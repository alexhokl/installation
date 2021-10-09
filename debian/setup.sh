#!/bin/bash

sudo apt update
sudo apt install -y lsb-release

SOURCE_LIST_DIR=/etc/apt/sources.list.d
DISTRIBUTION=$(. /etc/os-release; echo $ID)
DISTRIBUTION_RELEASE=$(lsb_release -cs)
DISTRIBUTION_RELEASE_NO=11
if [ "ubuntu" = "${DISTRIBUTION}" ]; then
	DISTRIBUTION_RELEASE_NO=20.04
fi
HARDWARE_TYPE=$(uname -i)  # unknown for crostini or virtual machine
INSTALL_DIR=$(mktemp -d)
_ARCH=$(dpkg --print-architecture)

# chrome
curl -sS https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key --keyring /usr/share/keyrings/chrome.google.gpg add -
echo "deb [arch=$_ARCH signed-by=/usr/share/keyrings/chrome.google.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee $SOURCE_LIST_DIR/google-chrome.list

# gcloud
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a $SOURCE_LIST_DIR/google-cloud-sdk.list
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# docker
echo "deb [arch=$_ARCH] https://download.docker.com/linux/${DISTRIBUTION} ${DISTRIBUTION_RELEASE} stable" | sudo tee $SOURCE_LIST_DIR/docker.list
curl -fsSL https://download.docker.com/linux/${DISTRIBUTION}/gpg | sudo apt-key add -

# kubectl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee $SOURCE_LIST_DIR/kubernetes.list

# yubico
# echo "deb http://ppa.launchpad.net/yubico/stable/ubuntu wily main" | sudo tee $SOURCE_LIST_DIR/yubico.list
# echo "deb-src http://ppa.launchpad.net/yubico/stable/ubuntu wily main" | sudo tee -a $SOURCE_LIST_DIR/yubico.list
# sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 3653E21064B19D134466702E43D5C49532CBA1A9

# spotify
# echo "deb http://repository.spotify.com stable non-free" | sudo tee $SOURCE_LIST_DIR/spotify
# curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -

# Microsoft azure-cli, dotnet core, vscode, mssql-tools
echo "deb [arch=$_ARCH] https://packages.microsoft.com/repos/azure-cli/ ${DISTRIBUTION_RELEASE} main" | sudo tee $SOURCE_LIST_DIR/azure-cli.list
echo "deb [arch=$_ARCH] https://packages.microsoft.com/repos/vscode stable main" | sudo tee $SOURCE_LIST_DIR/vscode.list
curl -sS https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
# Microsoft GPG keys package
curl -sSL https://packages.microsoft.com/config/${DISTRIBUTION}/${DISTRIBUTION_RELEASE_NO}/packages-microsoft-prod.deb -o $INSTALL_DIR/packages-microsoft-prod.deb
sudo dpkg -i $INSTALL_DIR/packages-microsoft-prod.deb

# yarn
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee $SOURCE_LIST_DIR/yarn.list
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null

# signal
echo "deb [arch=$_ARCH signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a $SOURCE_LIST_DIR/signal.list
curl -sS https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# tailscale
curl -fsSL https://pkgs.tailscale.com/stable/${DISTRIBUTION}/${DISTRIBUTION_RELEASE}.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/${DISTRIBUTION}/${DISTRIBUTION_RELEASE}.list | sudo tee $SOURCE_LIST_DIR/tailscale.list

# protonvpn
curl -sSL https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb -o $INSTALL_DIR/protonvpn-repo.deb
sudo dpkg -i $INSTALL_DIR/protonvpn-repo.deb

# helm
curl -sSL https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee $SOURCE_LIST_DIR/helm-stable-debian.list

echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections

sudo apt update
sudo add-apt-repository universe
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

cd $HOME/git
cat $HOME/git/installation/repo_list | xargs -n 1 git clone
if [ "unknown" != "$HARDWARE_TYPE" ]; then
	git clone https://github.com/vivien/i3blocks-contrib $HOME/.config/i3blocks
fi
cd $HOME

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
cp ./ssh/config $HOME/.ssh/
cd $HOME

sudo sed -i -e 's/#\ en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
sudo locale-gen
