#!/bin/bash

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
sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 60
sudo update-alternatives --config editor

cd $HOME
pip3 install awscli --upgrade --user

sudo apt-get purge -y git git-core
sudo apt autoremove
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
