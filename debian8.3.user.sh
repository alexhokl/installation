#!/bin/bash

cd ${HOME}/git/neovim
git checkout v0.1.7
make
sudo make install
sudo pip2 install neovim
sudo pip3 install neovim
sudo gem install neovim
