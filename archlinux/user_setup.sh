sudo pacman -Syy

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/basic_packages \
  | xargs -n 1 sudo pacman -S --noconfirm
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/ui_packages \
  | xargs -n 1 sudo pacman -S --noconfirm
mkdir -p $HOME/.config/i3
curl -o $HOME/.config/i3/config -sSL https://raw.githubusercontent.com/alexhokl/dotfiles/master/.i3/config
curl -o $HOME/.i3blocks.conf https://raw.githubusercontent.com/alexhokl/dotfiles/master/.i3blocks.conf

# install python
pyenv install 3.10.0
pyenv global 3.10.0

# install n for node
curl -L https://bit.ly/n-install | bash

#install nodejs
sudo n install 20

mkdir -p $HOME/git
git clone https://aur.archlinux.org/yay.git $HOME/git/yay
cd $HOME/git/yay
makepkg -si --noconfirm
cd $HOME
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/aur_packages \
	| xargs -n 1 yay -S --noconfirm --answerclean A --answerdiff N

for r in $(curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/repo_list); do
	n=$(basename $r)
	git clone $r $HOME/git/$n
done
git clone https://github.com/vivien/i3blocks-contrib $HOME/.config/i3blocks

echo -n "docker wireshark libvirt" | xargs -d ' ' -I %% -n 1 sudo usermod -aG %% $USER

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/go_packages \
	| xargs -n 1 go install

rustup install stable
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/cargo_packages \
	| xargs -n 1 cargo install

python -m pip install --upgrade --user -r $HOME/git/installation/requirements.txt

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/vscode-extensions.txt \
	| xargs -n 1 /usr/bin/code --force --install-extension
mkdir -p $HOME/.config/Code/User
curl -o $HOME/.config/Code/User/settings.json -sSL https://raw.githubusercontent.com/alexhokl/installation/master/vscode_settings.json
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/dotnet_tools \
	| xargs -n 1 dotnet tool install -g
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/krew_list \
  | xargs -n 1 kubectl krew install
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/npm-list.txt \
	| xargs -n 1 sudo npm i -g

sudo pacman -R --noconfirm vim
sudo ln -s /usr/bin/nvim /usr/bin/vim
source $HOME/git/installation/debian/functions
install_vim

cd $HOME/git/dotfiles
make bin
make dotfiles
cd $HOME
mkdir -p $HOME/.ssh
curl -o $HOME/.ssh/config -sSL https://raw.githubusercontent.com/alexhokl/dotfiles/master/ssh/config

echo "StreamLocalBindUnlink yes" | sudo tee -a /etc/ssh/sshd_config

systemctl enable lightdm
systemctl enable sshd
systemctl enable bluetooth
systemctl enable containerd
systemctl enable docker
systemctl enable cups
systemctl enable NetworkManager
systemctl enable pcscd
systemctl enable tailscaled
systemctl --user enable pipewire
systemctl --user enable pipewire-pulse
