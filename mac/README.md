### Creating installation media

Reference: [How to create a bootable installer for macOS
](https://support.apple.com/en-hk/HT201372)

The USB involved should be formatted with format `Mac OS Extended`.
(Note that, if erase cannot be done, it could be a problem with the partitioning
scheme of the USB media (which is typical when the media has been used or things
like Windows or Linux installation). This can be resolved by
`diskutil eraseDisk free EMPTY /dev/disk9`.)

```sh
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Name
```

Note: if directory `Applications/Install*` does not exist, one needs to visit
App Store and get the installation.

To boot up from an external drive, press `options` key upon starting a machine.
See also [How to create a bootable installer for
macOS](https://support.apple.com/en-hk/HT201372).

In case the machine shows `No bootable device`, try to clean the BIOS (NVRAM)
by holding keys `cmd` + `alt` + `P` + `R`. See [How to Reset NVRAM on your
Mac](https://support.apple.com/en-hk/HT204063) for more information.

### Setup steps

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

curl -sSLO https://raw.githubusercontent.com/alexhokl/installation/master/requirements.txt
python -m pip install --user -r requirements.txt

cd $HOME
git clone --recursive https://github.com/alexhokl/.vim
cd $HOME/.vim
make
cd $HOME

sudo xcodebuid -license accept

curl https://raw.githubusercontent.com/alexhokl/installation/master/mac/preferences.scpt -o mac-preferences.scpt
osascript mac-preferences.scpt

mkdir -p $HOME/Desktop/git
cd !$
git clone https://github.com/alexhokl/dotfiles
cd dotfiles
git checkout mac
make dotfiles
chmod 700 ${HOME}/.gnupg
cd $HOME/Desktop/git
git clone https://github.com/alexhokl/installation
cd installation
npm install -g $(cat npm-list.txt)
cat go_packages | xargs go get -u
cat vscode-extensions.txt | xargs -n 1 code --install-extension
cat dotnet_tools | xargs -n 1 dotnet tool install -g
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /usr/local/etc/bash_completion.d/docker-compose
```

- import profile from [plist file](https://github.com/alexhokl/dotfiles/blob/master/com.googlecode.iterm2.plist) in iTerm2
- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- import GPG key from another machine

```sh
gpg2 --import my-key-filename.asc
```
