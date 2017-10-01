#!/bin/bash

curl https://raw.githubusercontent.com/alexhokl/installation/master/sources.list -o /etc/apt/sources.list

echo "deb https://packages.cloud.google.com/apt cloud-sdk-sid main" > /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# docker
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# neovim
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 9DBB0BE9366964F134855E2255F96FCF8231B6DD

# yubico
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 3653E21064B19D134466702E43D5C49532CBA1A9

# spotify
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

# dotnet
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# mono
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

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
		bridge-utils \
		build-essential \
		bzip2 \
		ca-certificates \
		cgroupfs-mount \
		cmake \
		coreutils \
		curl \
		dnsutils \
		file \
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
		locales \
		lsof \
		make \
		mono-devel \
		mount \
		net-tools \
		network-manager \
		network-manager-pptp-gnome \
		openvpn \
		pinentry-curses \
		pkg-config \
		pptp-linux \
		python-dev \
		python-pip \
		python3-dev \
		python3-pip \
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
		unzip \
		xclip \
		xcompmgr \
		xz-utils \
		zip \
		zlib1g-dev \
		--no-install-recommends

apt-get purge git git-core

usermod -a -G sudo alex
