#### Steps

Reference:
- [Initial Server Setup With Debian 8](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-8)

-  Install sudo and enable myself to sudo
```sh
su
vi /etc/apt/sources.list
(remove lines with  `cdrom` to avoid prompting for discs)
apt-get update
apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
        sudo \
		--no-install-recommends
usermod -a -G sudo alex
cat <<-EOF > /etc/apt/sources.list
#deb http://httpredir.debian.org/debian stretch main contrib non-free
#deb-src http://httpredir.debian.org/debian/ stretch main contrib non-free
#deb http://httpredir.debian.org/debian/ stretch-updates main contrib non-free
#deb-src http://httpredir.debian.org/debian/ stretch-updates main contrib non-free
#deb http://security.debian.org/ stretch/updates main contrib non-free
#deb-src http://security.debian.org/ stretch/updates main contrib non-free
#deb http://httpredir.debian.org/debian/ jessie-backports main contrib non-free
#deb-src http://httpredir.debian.org/debian/ jessie-backports main contrib non-free
#deb http://httpredir.debian.org/debian experimental main contrib non-free
#deb-src http://httpredir.debian.org/debian experimental main contrib non-free
# neovim
deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu wily main
deb-src http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu wily main
# yubico
deb http://ppa.launchpad.net/yubico/stable/ubuntu wily main
deb-src http://ppa.launchpad.net/yubico/stable/ubuntu wily main
EOF
```
- Reboot to allow the changes to be applied.

- Install
```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -y install \
  libtool \
  libtool-bin \
  autoconf \
  automake \
  cmake \
  g++ \
  pkg-config \
  unzip \
  git-core \
  build-essential \
  vim \
  gnupg2 \
  curl \
  kdiff3 \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \
  apt-transport-https \
  ca-certificates \
  software-properties-common

curl https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz -o go1.7.5.linux-amd64.tar.gz
untar go1.7.5.linux-amd64.tar.gz
sudo mv go /usr/local/
sudo apt-get purge golang-go
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

mkdir ~/git && cd ~/git
git clone https://github.com/neovim/neovim
cd ~/git/neovim
git checkout v0.1.7
make
sudo make install
sudo pip2 install neovim
sudo pip3 install neovim
sudo gem install neovim
nvim
:UpdateRemotePlugins

sudo nvim /etc/locale.gen
(find and un-comment en_GB.UTF-8 and save and quit)
sudo local-gen

curl -L https://github.com/atom/atom/releases/download/v1.13.1/atom-amd64.deb -o atom-amd64.4.deb
sudo dpkg --install atom-amd64.deb

curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       debian-$(lsb_release -cs) \
       main"
sudo apt-get update
sudo apt-get -y install docker-engine
sudo service docker restart
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl daemon-reload
sudo systemctl enable docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /etc/bash_completion.d/git-completion.bash
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/docker/v$(docker version -f {{.Client.Version}})/contrib/completion/bash/docker -o /etc/bash_completion.d/docker
sudo curl -L https://raw.githubusercontent.com/alexhokl/go-bb-pr/master/go-bb-pr-completion.bash -o /etc/bash_completion.d/go-bb-pr-completion.bash

cd $HOME
git clone --recursive https://github.com/alexhokl/.vim.git .vim
ln -sf $HOME/.vim/vimrc $HOME/.vimrc
cd $HOME/.vim
git submodule update --init
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


sudo curl -sSL https://raw.githubusercontent.com/jeffkaufman/icdiff/master/icdiff -o /usr/local/bin/icdiff
sudo curl -sSL https://raw.githubusercontent.com/jeffkaufman/icdiff/master/git-icdiff -o /usr/local/bin/git-icdiff
sudo chmod +x /usr/local/bin/icdiff
sudo chmod +x /usr/local/bin/git-icdiff

sudo curl -sSL https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py  -o /usr/local/bin/speedtest
sudo chmod +x /usr/local/bin/speedtest

curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs
curl https://raw.githubusercontent.com/alexhokl/installation/master/npm-list.txt -o npm-list.txt
sudo npm i -g $(cat npm-list.txt)
git clone https://github.com/alexhokl/dotfiles`
```

- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- `gpg --gen-key` (and select "RSA and RSA", select 4096 as keysize, select "key does not expire", enter github registration email address for "email address")
- `gpg --list-secret-keys --keyid-format LONG` (and copy the number in "sec" after "4096R/"
- copy the number into `.gitconfig`
- `gpg --armor --export {key}` (replace key with the number in the previous step)
- add the GPG key onto GitHub
