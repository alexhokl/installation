##### Reference

- [Initial Server Setup With Debian 8](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-8)


#### Steps

- Install `curl`

```sh
su
vi /etc/apt/sources.list
(remove lines with  `cdrom` to avoid prompting for discs)
apt-get update
apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		--no-install-recommends
```

- Install APT packages

```sh
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian8.1.root.sh -o debian8.1.root.sh
chmod +x debian8.1.root.sh
./debian8.1.root.sh
rm debian8.1.root.sh
```

- Reboot the machine to make sure `sudo` works

- Install more packages

```sh
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian8.2.user.sh -o debian8.2.user.sh
chmod +x debian8.2.user.sh
./debian8.2.user.sh
rm debian8.2.user.sh
```

- Reboot to make sure docker for unprivileged user is enabled.

- Various installations

```sh
sudo apt-get -y install \
  libtool \
  libtool-bin \
  cmake \
  g++ \
  pkg-config \
  vim

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
```

- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- `gpg --gen-key` (and select "RSA and RSA", select 4096 as keysize, select "key does not expire", enter github registration email address for "email address")
- `gpg --list-secret-keys --keyid-format LONG` (and copy the number in "sec" after "4096R/"
- copy the number into `.gitconfig`
- `gpg --armor --export {key}` (replace key with the number in the previous step)
- add the GPG key onto GitHub
