- update OSX in App Store
- install XCode and Microsoft Remote Desktop from App Store
- set display scaled and choose "more space"
- setup keyboard with UK English and HK Chinese and download dictation
- setup three finger drag in "accessibility" (see https://support.apple.com/en-us/HT204609)
- setup "Require password immediately after sleep or screen saver begins" in "Security & Privacy"
- change default download directory of chrome to desktop
- install XCode command line tools, Homebrew and its packages

```sh
sudo xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

sudo xcodebuid -license accept

sudo curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /usr/local/etc/bash_completion.d/git-completion.bash
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /usr/local/etc/bash_completion.d/docker-compose
sudo curl -L https://raw.githubusercontent.com/alexhokl/go-bb-pr/master/go-bb-pr-completion.bash -o /usr/local/etc/bash_completion.d/go-bb-pr-completion.bash

curl https://raw.githubusercontent.com/alexhokl/installation/master/mac-preferences.scpt -o mac-preferences.scpt
osascript mac-preferences.scpt

brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
curl https://raw.githubusercontent.com/alexhokl/installation/master/brew-list.txt -o brew-list.txt
brew install $(cat brew-list.txt)
ACCEPT_EULA=y brew install --no-sandbox mssql-tools

cd $HOME
git clone --recursive https://github.com/alexhokl/.vim
cd $HOME/.vim
make

pip install setuptools
pip install --upgrade neovim
pip3 install --upgrade neovim

git clone https://github.com/alexhokl/dotfiles
cd dotfiles
git checkout mac
make dotfiles
chmod 700 ${HOME}/.gnupg
cd -
git clone https://github.com/alexhokl/installation
cd installation
npm install -g $(cat npm-list.txt)
for p in $(cat $HOME/git/installation/go-packages.txt); do go get -u $p; done
code --install-extension $(cat vscode-extensions.txt)
rbenv install 2.4.2
```

- in "Security & Privacy" and in "Privacy" tab, add "Amethyst" to "Accessibility" list
- import profile from [plist file](https://github.com/alexhokl/dotfiles/blob/master/com.googlecode.iterm2.plist) in iTerm2
- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- import GPG key from another machine

```sh
gpg2 --import my-key-filename.asc
```
