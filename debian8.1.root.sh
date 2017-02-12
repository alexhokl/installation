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

apt-get update
apt-get -y upgrade

apt-get install -y \
		adduser \
		alsa-utils \
		apparmor \
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
		git-core \
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
    libdbusmenu-glib4 \
    libdbusmenu-gtk4 \
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
    libyaml-dev \
		locales \
		lsof \
		make \
		mount \
		net-tools \
		network-manager \
		openvpn \
		pinentry-curses \
    pkg-config \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
		rxvt-unicode-256color \
		s3cmd \
		scdaemon \
		silversearcher-ag \
    software-properties-common \
		ssh \
		strace \
		sudo \
		tar \
		tree \
		tzdata \
		unzip \
		xclip \
		xcompmgr \
		xz-utils \
		zip \
    zlib1g-dev \
		--no-install-recommends

usermod -a -G sudo alex
