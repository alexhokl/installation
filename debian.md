#### Steps

Reference:
- [Initial Server Setup With Debian 8](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-8)

1.  Install sudo and enable myself to sudo
```sh
su
nano /etc/ap/sources.list
(remove lines with  `cdrom` to avoid prompting for discs)
apt-get update
apt-get sudo
usermod -a -G sudo alex
```
2. Reboot to allow the changes to be applied.

3.
```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -y libtool libtool-bin autoconf automake cmake g++ pkg-config unzip git-core build-essential vim curl
mkdir ~/git && cd ~/git
git clone https://github.com/neovim/neovim
cd ~/git/neovim
git checkout v0.1.7
make
sudo make install
cd ~/git
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs
curl https://raw.githubusercontent.com/alexhokl/installation/master/npm-list.txt -o npm-list.txt
sudo npm i -g $(cat npm-list.txt)
git clone https://github.com/alexhokl/dotfiles`

```
