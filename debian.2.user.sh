#!/bin/bash

sudo curl https://raw.githubusercontent.com/alexhokl/installation/master/sources.list -o /etc/apt/sources.list

echo "deb https://packages.cloud.google.com/apt cloud-sdk-sid main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# docker
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

# yubico
#sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 3653E21064B19D134466702E43D5C49532CBA1A9

# spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

# dotnet
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# mono
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

# virtual box
curl https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# signal
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# mssql-tools
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list

# unifi
curl https://dl.ubnt.com/unifi/unifi-repo.gpg | sudo apt-key add -

#kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt-get update
sudo apt-get -y upgrade

export ACCEPT_EULA=Y

sudo apt-get install -y \
		adduser \
		alsa-utils \
		apparmor \
		apt-transport-https \
		autoconf \
		automake \
		bash-completion \
		bc \
		bison \
		bluez-firmware \
		bluez-tools \
		blueman \
		bridge-utils \
		build-essential \
		byzanz \
		bzip2 \
		ca-certificates \
		cgroupfs-mount \
		cmake \
		code \
		coreutils \
		curl \
		dkms \
		dnsutils \
		feh \
		ffmpeg \
		file \
		firmware-iwlwifi \
		findutils \
		g++ \
		gcc \
		gettext \
		git \
		gnupg \
		gnupg2 \
		gnupg-agent \
		google-cloud-sdk \
		grep \
		gzip \
		hostname \
		indent \
		iptables \
		i3 \
		i3lock \
		i3status \
		jq \
		kdiff3 \
		less \
		lib32stdc++6 \
		libapparmor-dev \
		libappindicator1 \
		libav-tools \
		libc6-dev \
		libcurl4-openssl-dev \
		libdbusmenu-glib4 \
		libdbusmenu-gtk4 \
		liberror-perl \
		libexpat1-dev \
		libffi-dev \
		libgconf2-4 \
		libgdbm3 \
		libgdbm-dev \
		libindicator7 \
		libltdl-dev \
		libncurses5-dev \
		libreadline-dev \
		libseccomp-dev \
		libssl-dev \
		libtool \
		libtool-bin \
		libunwind8 \
		libuv1-dev \
		libyaml-dev \
		linux-headers-amd64 \
		linux-headers-4.9.0-6-amd64 \
		locales \
		lsof \
		make \
		mongodb \
		mono-devel \
		mount \
		msbuild \
		mssql-tools \
		net-tools \
		network-manager \
		network-manager-pptp-gnome \
		openvpn \
		openssh-server \
		pavucontrol \
		peek \
		pinentry-curses \
		pkg-config \
		pptp-linux \
		pulseaudio \
		pulseaudio-module-bluetooth \
		python-dev \
		python-pip \
		python3-dev \
		python3-pip \
		python3-setuptools \
		rxvt-unicode-256color \
		s3cmd \
		scdaemon \
		scrot \
		silversearcher-ag \
		software-properties-common \
		spotify-client \
		ssh \
		strace \
		strongswan \
		suckless-tools \
		tar \
		tmux \
		tree \
		tzdata \
		unifi \
		unixodbc-dev \
		unzip \
		virtualbox-5.2 \
		webp \
		xclip \
		xcompmgr \
		xdotool \
		xl2tpd \
		xz-utils \
		yarn \
		zip \
		zlib1g-dev

sudo apt install -y signal-desktop

git clone https://github.com/alexhokl/installation ${HOME}/git/installation
git clone https://github.com/alexhokl/dotfiles ${HOME}/git/dotfiles
git clone https://github.com/rbenv/rbenv.git ${HOME}/.rbenv
git clone https://github.com/rbenv/ruby-build.git ${HOME}/.rbenv/plugins/ruby-build

curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o chrome.deb
curl https://storage.googleapis.com/golang/go1.11.1.linux-amd64.tar.gz -o golang.tar.gz
curl -sSL https://downloads.slack-edge.com/linux_releases/slack-desktop-3.2.1-amd64.deb -o slack.deb
curl -sSL https://github.com/keeweb/keeweb/releases/download/v1.6.3/KeeWeb-1.6.3.linux.x64.deb -o keeweb.deb
curl -sSL https://github.com/sharkdp/bat/releases/download/v0.6.1/bat-musl_0.6.1_amd64.deb -o bat.deb
curl https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_v0.11.13-beta.tar.xz -o ${HOME}/git/flutter.xz
curl -o remarkable.deb https://remarkableapp.github.io/files/remarkable_1.87_all.deb
curl -o azuredatastudio.deb https://azuredatastudiobuilds.blob.core.windows.net/releases/1.2.4/azuredatastudio-linux-1.2.4.deb
tar xvf golang.tar.gz
source ${HOME}/git/dotfiles/.path

sudo mv go /usr/local/

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim

go get github.com/axw/gocov/gocov
go get github.com/brianredbeard/gpget
go get github.com/crosbymichael/gistit
go get github.com/crosbymichael/ip-addr
go get github.com/davecheney/httpstat
go get github.com/google/gops
go get github.com/jstemmer/gotags
go get github.com/nsf/gocode
go get github.com/rogpeppe/godef
go get github.com/shurcooL/markdownfmt
go get github.com/Soulou/curl-unix-socket
go get github.com/spf13/cobra/cobra
go get github.com/unidoc/unidoc
go get github.com/go-swagger/go-swagger
go get github.com/alexhokl/go-bb-pr
go get github.com/russross/blackfriday-tool
go get github.com/kubernetes/kompose
go get github.com/davecgh/go-spew/spew

sudo dpkg -i chrome.deb
sudo dpkg -i slack.deb
sudo dpkg -i keeweb.deb
sudo dpkg -i bat.deb
sudo dpkg -i remarkable.deb
sudo dpkg -i azuredatastudio.deb

sudo apt --fix-broken install -y

tar xf ${HOME}/git/flutter.xz -C ${HOME}/git/

sudo apt-get -y install docker-ce
sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /etc/bash_completion.d/git-completion.bash
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
sudo curl -L https://raw.githubusercontent.com/alexhokl/go-bb-pr/master/go-bb-pr-completion.bash -o /etc/bash_completion.d/go-bb-pr-completion.bash

sudo curl -sSL https://raw.githubusercontent.com/jeffkaufman/icdiff/master/icdiff -o /usr/local/bin/icdiff
sudo curl -sSL https://raw.githubusercontent.com/jeffkaufman/icdiff/master/git-icdiff -o /usr/local/bin/git-icdiff
sudo chmod +x /usr/local/bin/icdiff
sudo chmod +x /usr/local/bin/git-icdiff

sudo curl -sSL https://raw.githubusercontent.com/tehmaze/lolcat/master/lolcat -o /usr/local/bin/lolcat
sudo chmod +x /usr/local/bin/lolcat

sudo curl -sSL https://misc.j3ss.co/binaries/have -o /usr/local/bin/have
sudo chmod +x /usr/local/bin/have

sudo curl -sSL https://misc.j3ss.co/binaries/light -o /usr/local/bin/light
sudo chmod +x /usr/local/bin/light

sudo curl -sSL https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py  -o /usr/local/bin/speedtest
sudo chmod +x /usr/local/bin/speedtest

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
curl https://raw.githubusercontent.com/alexhokl/installation/master/npm-list.txt -o npm-list.txt
sudo npm i -g $(cat npm-list.txt)
curl https://raw.githubusercontent.com/alexhokl/installation/master/vscode-extensions.txt -o vscode-extensions.txt
for e in $(cat vscode-extensions.txt); do code --install-extension $e; done
mkdir -p ${HOME}/.config/Code/User
curl https://raw.githubusercontent.com/alexhokl/installation/master/vscode_settings.json -o ${HOME}/.config/Code/User/settings.json
sudo apt-get install -y dotnet-sdk-2.1
sudo curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe

source ${HOME}/git/dotfiles/.path
rbenv init
rbenv install 2.5.1
rbenv global 2.5.1
echo "gem: --no-document" > ${HOME}/.gemrc
gem install bundler
gem install travis

cd $HOME
pip install wheel
pip3 install wheel
pip install --upgrade neovim
pip3 install --upgrade neovim
git clone --recursive https://github.com/alexhokl/.vim.git .vim
ln -sf $HOME/.vim/vimrc $HOME/.vimrc
cd $HOME/.vim
git submodule update --init
cd $HOME/.vim/bundle/vimproc.vim
make
cd $HOME/.vim
mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
ln -snf "${HOME}/.vim" "${XDG_CONFIG_HOME}/nvim"
ln -snf "${HOME}/.vimrc" "${XDG_CONFIG_HOME}/nvim/init.vim"
sudo mkdir -p /root/.config
sudo ln -snf "${HOME}/.vim" /root/.config/nvim
sudo ln -snf "${HOME}/.vimrc" /root/.config/nvim/init.vim
sudo update-alternatives --install /usr/bin/vi vi "$(which nvim)" 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim "$(which nvim)" 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 60
sudo update-alternatives --config editor

cd $HOME
pip3 install awscli --upgrade --user

sudo apt-get purge -y git git-core
sudo apt autoremove -y
hash -r
curl -L https://github.com/git/git/archive/v2.19.1.tar.gz -o git.tar.gz
tar xvzf git.tar.gz
cd git-*
make prefix=/usr/local all
sudo make prefix=/usr/local install

cd $HOME
rm -rf git-*
rm *.deb
rm *.tar.gz
rm npm-list.txt

cd $HOME/git/dotfiles
make bin
make dotfiles

sudo sed -i -e 's/#\ en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
sudo locale-gen
