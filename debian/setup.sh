#!/bin/bash

SOURCE_LIST=/etc/apt/sources.list
SOURCE_LIST_DIR=/etc/apt/sources.list.d

# chrome
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee $SOURCE_LIST_DIR/google-chrome.list

# gcloud
echo "deb https://packages.cloud.google.com/apt cloud-sdk-sid main" | sudo tee $SOURCE_LIST_DIR/google-cloud-sdk.list
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# docker
echo "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" | sudo tee -a $SOURCE_LIST
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

# kubectl
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a $SOURCE_LIST

# yubico
# echo "deb http://ppa.launchpad.net/yubico/stable/ubuntu wily main" | sudo tee -a $SOURCE_LIST
# echo "deb-src http://ppa.launchpad.net/yubico/stable/ubuntu wily main" | sudo tee -a $SOURCE_LIST
# sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 3653E21064B19D134466702E43D5C49532CBA1A9

# spotify
echo "deb http://repository.spotify.com stable non-free" | sudo tee -a $SOURCE_LIST
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -

# Microsdft azure-cli, dotnet core, vscode, mssql-tools
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee -a $SOURCE_LIST
if [ "debian" = $(. /etc/os-release; echo $ID) ]; then
  curl -sS https://packages.microsoft.com/config/$(. /etc/os-release; echo "$ID")/10/prod.list | sudo tee $SOURCE_LIST_DIR/mssql-release.list;
else
  curl -sS https://packages.microsoft.com/config/$(. /etc/os-release; echo "$ID")/18.04/prod.list | sudo tee $SOURCE_LIST_DIR/mssql-release.list;
fi
echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" | sudo tee $SOURCE_LIST_DIR/vscode.list
curl -sS https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# mono
echo "deb http://download.mono-project.com/repo/$(. /etc/os-release; echo "$ID") stable-$(lsb_release -cs) main" | sudo tee -a $SOURCE_LIST
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

# virtual box
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee -a $SOURCE_LIST
curl -sS https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
curl -sS https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -

# yarn
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee -a $SOURCE_LIST
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# signal
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a $SOURCE_LIST
curl -sS https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# telegram
# echo "deb http://ppa.launchpad.net/atareao/telegram/ubuntu xenial main" | sudo tee -a $SOURCE_LIST
# echo "deb-src http://ppa.launchpad.net/atareao/telegram/ubuntu xenial main" | sudo tee -a $SOURCE_LIST

# etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee -a $SOURCE_LIST
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

# dart
curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
curl -sS https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list | sudo tee $SOURCE_LIST_DIR/dart_stable.list

sudo apt update
sudo apt -y upgrade
sudo apt install -y kdiff3
sudo apt install -y odbcinst1debian2

sudo ACCEPT_EULA=Y apt install -y \
		asciinema \
		autoconf \
		automake \
		azure-cli \
		balena-etcher-electron \
		bison \
		bluez-tools \
		blueman \
		bridge-utils \
		build-essential \
		byzanz \
		cgroupfs-mount \
		cmake \
		code \
		containerd.io \
		darktable \
		dart \
		dkms \
		dnsutils \
		docker-ce \
		docker-ce-cli \
		dotnet-sdk-3.1 \
		exfat-fuse \
		exfat-utils \
		feh \
		ffmpeg \
		ftp \
		g++ \
		gcc \
		gettext \
		git \
		gnupg2 \
		gnupg-agent \
		google-chrome-stable \
		google-cloud-sdk \
		google-cloud-sdk-kpt \
		indent \
		i3 \
		i3blocks \
		i3lock \
		jq \
		kubectl \
		lib32stdc++6 \
		libapparmor-dev \
		libappindicator1 \
		libc6-dev \
		libcurl4-openssl-dev \
		libdbusmenu-gtk4 \
		liberror-perl \
		libexpat1-dev \
		libffi-dev \
		libgdbm-dev \
		libindicator7 \
		libltdl-dev \
		libncurses5-dev \
		libncursesw5-dev \
		libnss3-dev \
		libpq-dev \
		libreadline-dev \
		libreswan \
		libseccomp-dev \
		libssl-dev \
		libtool \
		libtool-bin \
		libuv1-dev \
		libvirt-clients \
		libvirt-daemon-system \
		libxml2-dev \
		libyaml-dev \
		libzip-dev \
		make \
		mono-devel \
		mssql-tools \
		net-tools \
		network-manager \
		network-manager-l2tp \
		network-manager-l2tp-gnome \
		network-manager-pptp-gnome \
		nnn \
		openvpn \
		openssh-server \
		pavucontrol \
		pkg-config \
		pptp-linux \
		printer-driver-cups-pdf \
		python-dev \
		qemu-kvm \
		rclone \
		rofi \
		rxvt-unicode-256color \
		scdaemon \
		scrot \
		silversearcher-ag \
		snapd \
		spotify-client \
		ssh \
		strace \
		suckless-tools \
		tmux \
		tree \
		ufw \
		unixodbc-dev \
		virt-manager \
		virtualbox-6.1 \
		vim \
		webp \
		xclip \
		xcompmgr \
		xdotool \
		xl2tpd \
		yarn \
		zip \
		zlib1g-dev

if [ "debian" = $(. /etc/os-release; echo $ID) ]; then
  sudo apt install -y \
    bluez-firmware \
    firmware-iwlwifi \
    peek;
else
  sudo add-apt-repository ppa:canonical-hwe-team/backport-iwlwifi;
  sudo apt-get update;
  sudo apt-get install backport-iwlwifi-dkms;
fi

sudo apt install -y signal-desktop

git clone https://github.com/alexhokl/installation $HOME/git/installation
git clone https://github.com/alexhokl/dotfiles $HOME/git/dotfiles
git clone https://github.com/alexhokl/notes $HOME/git/notes
git clone https://github.com/vivien/i3blocks-contrib $HOME/.config/i3blocks

source $HOME/git/installation/versions-on-github
source $HOME/git/installation/debian/functions

sudo usermod -aG docker $USER
sudo adduser $USER libvirt

install_nodejs
install_bat
install_slack
install_remarkable
install_azure_data_studio
install_hexyl
install_octant
install_step
install_minikube
install_helm
install_python
install_nvim
install_flutter
install_k9s
install_popeye
install_android_studio
install_azcopy
install_kubectx
install_icdiff
install_lolcat
install_have
install_light
install_speedtest
install_stern
install_sampler
install_hey
install_nuget
install_docker_compose
install_sqlpackage
install_vault
install_sc_im
install_vscode_extensions
install_ruby
install_vim
install_git
install_gh

sudo apt --fix-broken install -y

cd $HOME/git/dotfiles
make bin
make dotfiles
cd $HOME

sudo sed -i -e 's/#\ en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
sudo locale-gen

# to disable suspend on login screen
echo | sudo tee -a /etc/gdm3/greeter.dconf-defaults
cat $HOME/git/installation/debian/greeter.dconf-defaults.conf | sudo tee -a /etc/gdm3/greeter.dconf-defaults

# to enable touchpad in i3wm
echo | sudo tee -a /etc/X11/xorg.conf.d/90-touchpad.conf
cat $HOME/git/installation/debian/90-touchpad.conf | sudo tee -a /etc/X11/xorg.conf.d/90-touchpad.conf
