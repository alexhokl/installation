- update OSX in App Store
- install XCode from App Store
- set display scaled and choose "more space"
- setup keyboard with UK English and HK Chinese and download dictation
- setup three finger drag in "accessibility" (see https://support.apple.com/en-us/HT204609)
- setup screen corners in "Screen Saver" of "Desktop & Screen Saver"
- setup "Require password immediately after sleep or screen saver begins" in "Security & Privacy"
- change size of dock and setup "automatically hide and show the dock"
- download and install Chrome
- change default download directory of chrome to desktop
- install Chrome Remote Desktop
- install iTerm2, XCode and Homebrew
```console
curl -O https://iterm2.com/downloads/stable/iTerm2-3_1_3.zip
unzip iTerm2-3_1_3.zip
mv iTerm.app /Applications/
rm iTerm2-3_1_3.zip
/usr/local/git/uninstall.sh
sudo xcode-select --install
sudo xcodebuid -license accept
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

- Download [installation list](https://github.com/alexhokl/installation/blob/master/brew-list.txt)
```console
curl https://raw.githubusercontent.com/alexhokl/installation/master/brew-list.txt -o brew-list.txt
```
- `brew install $(cat brew-list.txt)`
- import profile from [plist file](https://github.com/alexhokl/dotfiles/blob/master/com.googlecode.iterm2.plist) in iTerm2
- configure vim and neovim (nvim)

```console
cd ~/
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
```

- `git clone https://github.com/alexhokl/dotfiles`
- in dotfiles repository, `make dotfiles`
- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- `gpg --gen-key` (and select "RSA and RSA",  select 4096 as keysize, select "key does not expire",  enter github registration email address for "email address")
- `gpg --list-secret-keys --keyid-format LONG` (and copy the number in "sec" after "4096R/"
- copy the number into `.gitconfig`
- `gpg --armor --export {key} | pbcopy` (replace key with the number in the previous step)
- add the GPG key onto GitHub

- `ln -s /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib /usr/local/lib/`
- `ln -s /usr/local/opt/openssl/lib/libssl.1.0.0.dylib /usr/local/lib/`
- in dotfiles repository, `apm install $(cat apm-list.txt)`
- `npm install -g $(cat npm-list.txt)`
- download and install dotnet (https://www.microsoft.com/net/core#macos)
- download and install Docker for Mac (installer includes docker-compose as well)
- setup bash auto-completions

```console
sudo mkdir /etc/bash_completion.d
sudo curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /etc/bash_completion.d/git-completion.bash
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/docker/v$(docker version -f {{.Client.Version}})/contrib/completion/bash/docker -o /etc/bash_completion.d/docker
sudo curl -L https://raw.githubusercontent.com/alexhokl/go-bb-pr/master/go-bb-pr-completion.bash -o /etc/bash_completion.d/go-bb-pr-completion.bash
```

- download and instal .Net Core (may need to select from a list of all
  installations rather than the default one)
- download and install Visual Studio Code for Mac
  - install extension `MSSQL`
- install Telegram from AppStore
- install Slack from AppStore
- `go get -u github.com/davecheney/httpstat`
