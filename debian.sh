#!/bin/bash

VERSION_GOLANG=1.13.5
VERSION_SLACK=4.0.1
VERSION_BAT=0.11.0
VERSION_FLUTTER=1.7.8+hotfix.3
VERSION_REMARKABLE=1.87
VERSION_AZURE_DATA_STUDIO=1.10.0
VERSION_DOCKER_COMPOSE=1.24.1
VERSION_NODEJS=node_10.x
VERSION_RUBY=2.6.3
VERSION_GIT=2.23.0
VERSION_STEP=0.10.1
VERSION_HEXYL=0.5.1
VERSION_PYTHON=3.7.3
VERSION_PYTHON_MAJOR=3.7
VERSION_STERN=1.11.0
VERSION_K9S=0.8.2
VERSION_POPEYE=0.4.3
VERSION_OCTANT=0.6.0
VERSION_VAULT=1.3.0
INSTALL_DIR=/tmp/installation
export GOPATH=$HOME/git
GO_BIN_DIR=$GOPATH/bin
SOURCE_LIST=/etc/apt/sources.list
SOURCE_LIST_DIR=/etc/apt/sources.list.d
LOCAL_BIN=/usr/local/bin
BASH_COMPLETION_DIR=/etc/bash_completion.d

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
echo "deb http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee -a $SOURCE_LIST
curl -sS https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
curl -sS https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -

# nodejs
# curl -sL https://deb.nodesource.com/setup_${VERSION_NODEJS}.x | sudo -E bash -
echo "deb https://deb.nodesource.com/${VERSION_NODEJS} $(lsb_release -cs) main" | sudo tee $SOURCE_LIST_DIR/nodesource.list
echo "deb-src https://deb.nodesource.com/${VERSION_NODEJS} $(lsb_release -cs) main" | sudo tee -a $SOURCE_LIST_DIR/nodesource.list
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -

# yarn
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee -a $SOURCE_LIST
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# signal
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a $SOURCE_LIST
curl -sS https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# telegram
# echo "deb http://ppa.launchpad.net/atareao/telegram/ubuntu xenial main" | sudo tee -a $SOURCE_LIST
# echo "deb-src http://ppa.launchpad.net/atareao/telegram/ubuntu xenial main" | sudo tee -a $SOURCE_LIST

# unifi
if [ "debian" = $(. /etc/os-release; echo $ID) ]; then
  echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" | sudo tee -a $SOURCE_LIST;
  curl -sS https://dl.ubnt.com/unifi/unifi-repo.gpg | sudo apt-key add -;
fi

# etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee -a $SOURCE_LIST
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

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
		dkms \
		dnsutils \
		docker-ce \
		docker-ce-cli \
		dotnet-sdk-2.2 \
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
		google-cloud-sdk \
		indent \
		i3 \
		i3lock \
		i3status \
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
		libnss3-dev \
		libreadline-dev \
		libreswan \
		libseccomp-dev \
		libssl-dev \
		libtool \
		libtool-bin \
		libuv1-dev \
		libyaml-dev \
		make \
		mono-devel \
		mssql-tools \
		net-tools \
		network-manager \
		network-manager-l2tp \
		network-manager-l2tp-gnome \
		network-manager-pptp-gnome \
		nodejs \
		openvpn \
		openssh-server \
		pavucontrol \
		pkg-config \
		pptp-linux \
		printer-driver-cups-pdf \
		python-dev \
		python-pip \
		python3-dev \
		python3-pip \
		python3-setuptools \
		rclone \
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
		virtualbox-6.0 \
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
if [ "debian" = $(. /etc/os-release; echo $ID) ]; then
  git clone https://github.com/alexhokl/unifi $HOME/git/unifi;
fi
git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build

mkdir $INSTALL_DIR $GO_BIN_DIR
curl -o $INSTALL_DIR/chrome.deb -sS https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
curl -o $INSTALL_DIR/golang.tar.gz -sS https://storage.googleapis.com/golang/go${VERSION_GOLANG}.linux-amd64.tar.gz
curl -o $INSTALL_DIR/python.tar.xz -sS https://www.python.org/ftp/python/${VERSION_PYTHON}/Python-${VERSION_PYTHON}.tar.xz
curl -o $INSTALL_DIR/slack.deb -sSL https://downloads.slack-edge.com/linux_releases/slack-desktop-${VERSION_SLACK}-amd64.deb
curl -o $INSTALL_DIR/bat.deb -sSL https://github.com/sharkdp/bat/releases/download/v${VERSION_BAT}/bat-musl_${VERSION_BAT}_amd64.deb
curl -o $INSTALL_DIR/flutter.xz -sS https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v${VERSION_FLUTTER}-stable.tar.xz
curl -o $INSTALL_DIR/remarkable.deb -sS https://remarkableapp.github.io/files/remarkable_${VERSION_REMARKABLE}_all.deb
curl -o $INSTALL_DIR/azuredatastudio.deb -sS https://azuredatastudiobuilds.blob.core.windows.net/releases/${VERSION_AZURE_DATA_STUDIO}/azuredatastudio-linux-${VERSION_AZURE_DATA_STUDIO}.deb
curl -o $INSTALL_DIR/step.deb -sSL https://github.com/smallstep/cli/releases/download/v${VERSION_STEP}/step-cli_${VERSION_STEP}_amd64.deb
curl -o $INSTALL_DIR/hexyl.deb -sSL https://github.com/sharkdp/hexyl/releases/download/v${VERSION_HEXYL}/hexyl_${VERSION_HEXYL}_amd64.deb
curl -o $INSTALL_DIR/postman.tar.gz -sSL https://dl.pstmn.io/download/latest/linux64
curl -o $INSTALL_DIR/sqlpackage.zip -sSL https://go.microsoft.com/fwlink/?linkid=2087431
curl -o $INSTALL_DIR/git.tar.gz -sSL https://github.com/git/git/archive/v${VERSION_GIT}.tar.gz
curl -o $INSTALL_DIR/nvim.appimage -sSL https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
curl -o $INSTALL_DIR/k9s.tar.gz -sSL https://github.com/derailed/k9s/releases/download/${VERSION_K9S}/k9s_${VERSION_K9S}_Linux_x86_64.tar.gz
curl -o $INSTALL_DIR/popeye.tar.gz -sSL https://github.com/derailed/popeye/releases/download/v${VERSION_POPEYE}/popeye_${VERSION_POPEYE}_Linux_x86_64.tar.gz
curl -o $INSTALL_DIR/octant.deb -sSL https://github.com/vmware/octant/releases/download/v${VERSION_OCTANT}/octant_${VERSION_OCTANT}_Linux-64bit.deb
curl -o $INSTALL_DIR/dart.deb -sSL https://storage.googleapis.com/dart-archive/channels/stable/release/latest/linux_packages/dart_2.5.0-1_amd64.deb
curl -o $INSTALL_DIR/android-studio.tar.gz -sSL https://dl.google.com/dl/android/studio/ide-zips/3.5.0.21/android-studio-ide-191.5791312-linux.tar.gz
curl -o $INSTALL_DIR/vault.zip -sSL https://releases.hashicorp.com/vault/${VERSION_VAULT}/vault_${VERSION_VAULT}_linux_amd64.zip
curl -o $INSTALL_DIR/azcopy.tar.gz -SSL https://aka.ms/downloadazcopy-v10-linux
sudo curl -o $LOCAL_BIN/docker-compose -sSL "https://github.com/docker/compose/releases/download/${VERSION_DOCKER_COMPOSE}/docker-compose-$(uname -s)-$(uname -m)"
sudo curl -o $BASH_COMPLETION_DIR/git-completion.bash -sS https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
sudo curl -o $BASH_COMPLETION_DIR/docker-compose -sS https://raw.githubusercontent.com/docker/compose/${VERSION_DOCKER_COMPOSE}/contrib/completion/bash/docker-compose
sudo curl -o $BASH_COMPLETION_DIR/go-bb-pr-completion.bash -sS https://raw.githubusercontent.com/alexhokl/go-bb-pr/master/go-bb-pr-completion.bash
sudo curl -o $BASH_COMPLETION_DIR/kubectx.bash -sS https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.bash
sudo curl -o $BASH_COMPLETION_DIR/kubens.bash -sS https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.bash
sudo curl -o $LOCAL_BIN/icdiff -sS https://raw.githubusercontent.com/jeffkaufman/icdiff/master/icdiff
sudo curl -o $LOCAL_BIN/git-icdiff -sS https://raw.githubusercontent.com/jeffkaufman/icdiff/master/git-icdiff
sudo curl -o $LOCAL_BIN/lolcat -sS https://raw.githubusercontent.com/tehmaze/lolcat/master/lolcat
sudo curl -o $LOCAL_BIN/speedtest -sS https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
sudo curl -o $LOCAL_BIN/minikube -sSL https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo curl -o $LOCAL_BIN/kubectx -sSL https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
sudo curl -o $LOCAL_BIN/kubens -sSL https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
sudo curl -o $LOCAL_BIN/stern -sSL https://github.com/wercker/stern/releases/download/${VERSION_STERN}/stern_linux_amd64
sudo curl -o $LOCAL_BIN/nuget.exe -sS https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
sudo curl -o $LOCAL_BIN/have -sSL https://misc.j3ss.co/binaries/have
sudo curl -o $LOCAL_BIN/light -sSL https://misc.j3ss.co/binaries/light

sudo dpkg -i $INSTALL_DIR/chrome.deb
sudo dpkg -i $INSTALL_DIR/bat.deb
sudo dpkg -i $INSTALL_DIR/slack.deb
sudo dpkg -i $INSTALL_DIR/remarkable.deb
sudo dpkg -i $INSTALL_DIR/azuredatastudio.deb
sudo dpkg -i $INSTALL_DIR/hexyl.deb
sudo dpkg -i $INSTALL_DIR/octant.deb
sudo dpkg -i $INSTALL_DIR/dart.deb

sudo apt --fix-broken install -y

curl -L https://git.io/get_helm.sh | bash

sudo tar xvf $INSTALL_DIR/golang.tar.gz -C /usr/local/

tar -xf $INSTALL_DIR/python.tar.xz -C $INSTALL_DIR/
cd $INSTALL_DIR/Python-${VERSION_PYTHON}
./configure --enable-optimizations
make
sudo make install
sudo update-alternatives --install /usr/bin/python python $LOCAL_BIN/python${VERSION_PYTHON_MAJOR} 1
sudo update-alternatives --set python $LOCAL_BIN/python${VERSION_PYTHON_MAJOR}
cd $HOME

chmod u+x $INSTALL_DIR/nvim.appimage
sudo mv $INSTALL_DIR/nvim.appimage /usr/bin/nvim

sudo tar xvzf $INSTALL_DIR/postman.tar.gz -C /opt/
sudo ln -s /opt/postman/app/Postman $LOCAL_BIN/Postman

for p in $(cat $HOME/git/installation/go-packages.txt); do /usr/local/go/bin/go get -u $p; done

tar xf $INSTALL_DIR/flutter.xz -C $HOME/git/

tar xvzf $INSTALL_DIR/k9s.tar.gz -C $INSTALL_DIR/
sudo mv $INSTALL_DIR/k9s $LOCAL_BIN/

tar xvzf $INSTALL_DIR/popeye.tar.gz -C $INSTALL_DIR/
sudo mv $INSTALL_DIR/popeye $LOCAL_BIN/

sudo tar xvzf $INSTALL_DIR/android-studio.tar.gz -C /usr/local/

tar xvzf $INSTALL_DIR/azcopy.tar.gz -C $INSTALL_DIR/
cd $INSTALL_DIR/azcopy_*
sudo mv azcopy $LOCAL_BIN/
cd $HOME

sudo usermod -aG docker $USER
sudo chmod a+x $LOCAL_BIN/docker-compose
sudo chmod a+x $LOCAL_BIN/icdiff
sudo chmod a+x $LOCAL_BIN/git-icdiff
sudo chmod a+x $LOCAL_BIN/lolcat
sudo chmod a+x $LOCAL_BIN/have
sudo chmod a+x $LOCAL_BIN/light
sudo chmod a+x $LOCAL_BIN/speedtest
sudo chmod a+x $LOCAL_BIN/stern
sudo chmod a+x $LOCAL_BIN/minikube
sudo chmod a+x $LOCAL_BIN/kubectx
sudo chmod a+x $LOCAL_BIN/kubens

unzip $INSTALL_DIR/sqlpackage.zip -d $INSTALL_DIR/sqlpackage
chmod a+x $INSTALL_DIR/sqlpackage/sqlpackage
sudo mv $INSTALL_DIR/sqlpackage /opt/
sudo ln -s /opt/sqlpackage/sqlpackage /usr/local/bin/sqlpackage

unzip $INSTALL_DIR/vault.zip
sudo mv vault $LOCAL_BIN/
$LOCAL_BIN/vault -autocomplete-install

sudo npm i -g $(cat $HOME/git/installation/npm-list.txt)

for e in $(cat $HOME/git/installation/vscode-extensions.txt); do /usr/bin/code --install-extension $e; done
mkdir -p $HOME/.config/Code/User
cp $HOME/git/installation/vscode_settings.json $HOME/.config/Code/User/settings.json

pip3 install --user $(cat $HOME/git/installation/pip.txt)

$HOME/.rbenv/bin/rbenv init
$HOME/.rbenv/bin/rbenv install $VERSION_RUBY
$HOME/.rbenv/bin/rbenv global $VERSION_RUBY
echo "gem: --no-document" > $HOME/.gemrc
$HOME/.rbenv/versions/$VERSION_RUBY/bin/gem install bundler
$HOME/.rbenv/versions/$VERSION_RUBY/bin/gem install travis

git clone --recursive https://github.com/alexhokl/.vim
cd $HOME/.vim
make install
cd $HOME

sudo apt purge -y git git-core
sudo apt autoremove -y
hash -r
tar xvzf $INSTALL_DIR/git.tar.gz -C $INSTALL_DIR/
cd $INSTALL_DIR/git-*
make prefix=/usr/local all
sudo make prefix=/usr/local install
cd $HOME

cd $HOME/git/dotfiles
make bin
make dotfiles
cd $HOME

sudo sed -i -e 's/#\ en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
sudo locale-gen

# to disable suspend on login screen
echo | sudo tee -a /etc/gdm3/greeter.dconf-defaults
cat $HOME/git/installation/debian.greeter.dconf-defaults.conf | sudo tee -a /etc/gdm3/greeter.dconf-defaults

# to enable touchpad in i3wm
echo | sudo tee -a /etc/X11/xorg.conf.d/90-touchpad.conf
cat $HOME/git/installation/debian.90-touchpad.conf | sudo tee -a /etc/X11/xorg.conf.d/90-touchpad.conf
