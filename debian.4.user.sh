#!/bin/bash

source ${HOME}/git/dotfiles/.path
rbenv init
rbenv install 2.5.0
rbenv global 2.5.0
echo "gem: --no-document" > ${HOME}/.gemrc
gem install bundler

cd $HOME
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

cd $HOME/git/dotfiles
make dotfiles

pip install awscli --upgrade --user

apt-get purge git git-core
curl -L https://github.com/git/git/archive/v2.17.1.tar.gz -o git.tar.gz
tar xvzf git.tar.gz
cd git-*
make prefix=/usr/local all
sudo make prefix=/usr/local install
