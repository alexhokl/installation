- update OSX in App Store
- install XCode from App Store
- install Magnet from App Store
- set display scaled and choose "more space"
- setup keyboard with UK English and HK Chinese and download dictation
- setup three finger drag in "accessibility" (see https://support.apple.com/en-us/HT204609)
- setup "Require password immediately after sleep or screen saver begins" in "Security & Privacy"
- change default download directory of chrome to desktop
- install XCode command line tools, Homebrew and its packages

```sh
sudo xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

curl https://raw.githubusercontent.com/alexhokl/installation/master/brew-list.txt -o brew-list.txt
brew install $(cat brew-list.txt)
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
ACCEPT_EULA=y brew install mssql-tools

pip3 install setuptools
pip3 install --upgrade neovim

cd $HOME
git clone --recursive https://github.com/alexhokl/.vim
cd $HOME/.vim
make
cd $HOME

sudo xcodebuid -license accept

curl https://raw.githubusercontent.com/alexhokl/installation/master/mac/preferences.scpt -o mac-preferences.scpt
osascript mac-preferences.scpt

mkdir $HOME/Desktop/git
cd $HOME/Desktop/git
git clone https://github.com/alexhokl/dotfiles
cd dotfiles
git checkout mac
make dotfiles
chmod 700 ${HOME}/.gnupg
cd $HOME/Desktop/git
git clone https://github.com/alexhokl/installation
cd installation
npm install -g $(cat npm-list.txt)
for p in $(cat go-packages.txt); do go get -u $p; done
for e in $(cat vscode-extensions.txt); do code --install-extension $e; done
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /usr/local/etc/bash_completion.d/docker-compose
```

- import profile from [plist file](https://github.com/alexhokl/dotfiles/blob/master/com.googlecode.iterm2.plist) in iTerm2
- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- import GPG key from another machine

```sh
gpg2 --import my-key-filename.asc
```
