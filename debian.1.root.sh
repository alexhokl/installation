#!/bin/bash

curl https://raw.githubusercontent.com/alexhokl/installation/master/sources.list -o /etc/apt/sources.list

echo "deb https://packages.cloud.google.com/apt cloud-sdk-sid main" > /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# docker
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

# yubico
#apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 3653E21064B19D134466702E43D5C49532CBA1A9

# spotify
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# dotnet
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# mono
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

# virtual box
curl https://www.virtualbox.org/download/oracle_vbox_2016.asc | apt-key add -

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

# signal
curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add -

# mssql-tools
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list

apt-get update
apt-get -y upgrade

apt-get install -y \
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
		bzip2 \
		ca-certificates \
		cgroupfs-mount \
		cmake \
		code \
		coreutils \
		curl \
		dkms \
		dnsutils \
		ffmpeg \
		file \
		firmware-iwlwifi \
		findutils \
		gcc \
		gettext \
		gnupg \
		gnupg2 \
		gnupg-agent \
		google-cloud-sdk \
		grep \
		gzip \
		hostname \
		indent \
		iptables \
		jq \
		kdiff3 \
		less \
		libapparmor-dev \
		libappindicator1 \
		libav-tools \
		libc6-dev \
		libcurl4-openssl-dev \
		libdbusmenu-glib4 \
		libdbusmenu-gtk4 \
		libexpat1-dev \
		libffi-dev \
		libgdbm3 \
		libgdbm-dev \
		libindicator7 \
		libltdl-dev \
		libncurses5-dev \
		libreadline6-dev \
		libseccomp-dev \
		libssl-dev \
		libtool \
		libtool-bin \
		libunwind8 \
		libyaml-dev \
		libz-dev \
		locales \
		lsof \
		make \
		mono-devel \
		mount \
		mssql-tools \
		net-tools \
		network-manager \
		network-manager-pptp-gnome \
		openvpn \
		openssh-server \
		pavucontrol \
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
		silversearcher-ag \
		software-properties-common \
		spotify-client \
		ssh \
		strace \
		sudo \
		tar \
		tmux \
		tree \
		tzdata \
		unixodbc-dev \
		unzip \
		virtualbox-5.2 \
		webp \
		xclip \
		xcompmgr \
		xz-utils \
		yarn \
		zip \
		zlib1g-dev \
		--no-install-recommends

apt-get purge git git-core

apt install -y signal-desktop

usermod -a -G sudo alex
