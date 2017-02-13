#!/bin/bash

git clone https://github.com/alexhokl/installation ${HOME}/git/installation
git clone https://github.com/alexhokl/dotfiles ${HOME}/git/dotfiles
git clone https://github.com/neovim/neovim ${HOME}/git/neovim
git clone https://github.com/rbenv/rbenv.git ${HOME}/.rbenv
git clone https://github.com/rbenv/ruby-build.git ${HOME}/.rbenv/plugins/ruby-build

curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome-stable_current_amd64.deb
curl https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz -o go1.7.5.linux-amd64.tar.gz
curl -L https://github.com/atom/atom/releases/download/v1.13.1/atom-amd64.deb -o atom-amd64.deb
tar xvf go1.7.5.linux-amd64.tar.gz
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

sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo dpkg -i atom-amd64.deb

sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       debian-$(lsb_release -cs) \
       main"
sudo apt-get update
sudo apt-get -y install docker-engine
sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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

curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs
curl https://raw.githubusercontent.com/alexhokl/installation/master/npm-list.txt -o npm-list.txt
sudo npm i -g $(cat npm-list.txt)
