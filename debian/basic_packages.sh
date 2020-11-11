#!/bin/bash

sudo apt install -y kdiff3
sudo apt install -y odbcinst1debian2

sudo ACCEPT_EULA=Y apt install -y \
		asciinema \
		autoconf \
		automake \
		azure-cli \
		bison \
		build-essential \
		calcurse \
		cgroupfs-mount \
		cmake \
		containerd.io \
		dart \
		dkms \
		dnsutils \
		docker-ce \
		docker-ce-cli \
		dotnet-sdk-2.1 \
		dotnet-sdk-3.1 \
		exfat-fuse \
		exfat-utils \
		ffmpeg \
		ftp \
		g++ \
		gcc \
		gettext \
		git \
		gnupg2 \
		gnupg-agent \
		google-cloud-sdk \
		google-cloud-sdk-kpt \
		hopenpgp-tools \
		indent \
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
		libsqlite3-dev \
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
		mssql-tools \
		net-tools \
		network-manager \
		network-manager-l2tp \
		nnn \
		openssh-server \
		pkg-config \
		printer-driver-cups-pdf \
		python-dev \
		rclone \
		scdaemon \
		silversearcher-ag \
		snapd \
		ssh \
		sshfs \
		strace \
		tmux \
		translate-shell \
		tree \
		unixodbc-dev \
		vim \
		webp \
		xclip \
		xdotool \
		yarn \
		zip \
		zlib1g-dev

if [ "debian" = ${DISTRIBUTION} ]; then
  sudo apt install -y \
    ripgrep
fi

