#!/bin/bash

sudo apt install -y kdiff3
sudo apt install -y odbcinst1debian2

sudo ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt install -y \
	asciinema \
	autoconf \
	automake \
	bash-completion \
	bison \
	build-essential \
	calcurse \
	cgroupfs-mount \
	cmake \
	containerd.io \
	dkms \
	dnsutils \
	docker-ce \
	docker-ce-cli \
	dotnet-sdk-2.1 \
	dotnet-sdk-3.1 \
	dotnet-sdk-5.0 \
	dotnet-sdk-6.0 \
	exfat-fuse \
	exfat-utils \
	ffmpeg \
	ftp \
	g++ \
	gcc \
	gettext \
	git \
	gnupg-agent \
	gnupg2 \
	google-cloud-sdk \
	google-cloud-sdk-kpt \
	helm \
	hopenpgp-tools \
	indent \
	jq \
	kafkacat \
	kubectl \
	lib32stdc++6 \
	libapparmor-dev \
	libc6-dev \
	libcurl4-openssl-dev \
	libdbusmenu-gtk4 \
	liberror-perl \
	libexpat1-dev \
	libffi-dev \
	libgdbm-dev \
	libltdl-dev \
	libncurses5-dev \
	libncursesw5-dev \
	libnss3-dev \
	libpq-dev \
	libreadline-dev \
	libreswan \
	libsane-extras \
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
	locales \
	make \
	net-tools \
	network-manager \
	network-manager-l2tp \
	nnn \
	openssh-server \
	ovmf \
	pkg-config \
	postgresql-client \
	postgresql-client-common \
	powershell \
	printer-driver-cups-pdf \
	protonvpn \
	python-dev \
	rclone \
	sane \
	sane-utils \
	scdaemon \
	silversearcher-ag \
	snapd \
	ssh \
	sshfs \
	strace \
	tailscale \
	tmux \
	tree \
	tshark \
	ufw \
	unixodbc-dev \
	vim \
	webp \
	wget \
	xclip \
	xdotool \
	yarn=1.17.3-1 \
	zip \
	zlib1g-dev

if [ "debian" = "${DISTRIBUTION}" ]; then
  sudo apt install -y \
    ripgrep
fi

