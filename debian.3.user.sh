#!/bin/bash

git clone https://github.com/alexhokl/installation ${HOME}/git/installation
git clone https://github.com/alexhokl/dotfiles ${HOME}/git/dotfiles
git clone https://github.com/neovim/neovim ${HOME}/git/neovim
git clone https://github.com/rbenv/rbenv.git ${HOME}/.rbenv
git clone https://github.com/rbenv/ruby-build.git ${HOME}/.rbenv/plugins/ruby-build

curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome-stable_current_amd64.deb
curl https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz -o golang.tar.gz
curl -L https://atom.io/download/deb -o atom.deb
curl -sSL https://downloads.slack-edge.com/linux_releases/slack-desktop-3.1.0-amd64.deb -o slack.deb
curl -sSL https://github.com/keeweb/keeweb/releases/download/v1.6.3/KeeWeb-1.6.3.linux.x64.deb -o keeweb.deb
tar xvf golang.tar.gz
source ${HOME}/git/dotfiles/.path

sudo mv go /usr/local/

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

sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo dpkg -i atom.deb
sudo dpkg -i slack.deb
sudo dpkg -i keeweb.deb

sudo apt-get -y install docker-ce
sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/1.16.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /etc/bash_completion.d/git-completion.bash
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/docker/v$(docker version -f {{.Client.Version}})/contrib/completion/bash/docker -o /etc/bash_completion.d/docker
sudo curl -L https://raw.githubusercontent.com/alexhokl/go-bb-pr/master/go-bb-pr-completion.bash -o /etc/bash_completion.d/go-bb-pr-completion.bash

sudo curl -sSL https://raw.githubusercontent.com/jeffkaufman/icdiff/master/icdiff -o /usr/local/bin/icdiff
sudo curl -sSL https://raw.githubusercontent.com/jeffkaufman/icdiff/master/git-icdiff -o /usr/local/bin/git-icdiff
sudo chmod +x /usr/local/bin/icdiff
sudo chmod +x /usr/local/bin/git-icdiff

sudo curl -sSL https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py  -o /usr/local/bin/speedtest
sudo chmod +x /usr/local/bin/speedtest

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y git git-man liberror-perl nodejs
curl https://raw.githubusercontent.com/alexhokl/installation/master/npm-list.txt -o npm-list.txt
sudo npm i -g $(cat npm-list.txt)

sudo apt-get install -y dotnet-sdk-2.1.101
