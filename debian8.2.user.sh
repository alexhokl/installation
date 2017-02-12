#!/bin/bash

git clone https://github.com/alexhokl/installation ${HOME}/git/installation
git clone https://github.com/alexhokl/dotfiles ${HOME}/git/dotfiles
git clone https://github.com/neovim/neovim ${HOME}/git/neovim

curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome-stable_current_amd64.deb
curl https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz -o go1.7.5.linux-amd64.tar.gz
curl -L https://github.com/atom/atom/releases/download/v1.13.1/atom-amd64.deb -o atom-amd64.4.deb
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
