- update OSX in App Store
- install XCode and Microsoft Remote Desktop from App Store
- set display scaled and choose "more space"
- setup keyboard with UK English and HK Chinese and download dictation
- setup three finger drag in "accessibility" (see https://support.apple.com/en-us/HT204609)
- setup screen corners in "Screen Saver" of "Desktop & Screen Saver"
- set never to have screen saver
- setup "Require password immediately after sleep or screen saver begins" in "Security & Privacy"
- change size of dock and setup "automatically hide and show the dock"
- change default download directory of chrome to desktop
- install XCode command line tools, Homebrew and its packages

```sh
sudo xcode-select --install
sudo xcodebuid -license accept

sudo mkdir /etc/bash_completion.d
sudo curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /etc/bash_completion.d/git-completion.bash
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/docker/v$(docker version -f {{.Client.Version}})/contrib/completion/bash/docker -o /etc/bash_completion.d/docker
sudo curl -L https://raw.githubusercontent.com/alexhokl/go-bb-pr/master/go-bb-pr-completion.bash -o /etc/bash_completion.d/go-bb-pr-completion.bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

curl https://raw.githubusercontent.com/alexhokl/installation/master/brew-list.txt -o brew-list.txt
brew install $(cat brew-list.txt)

cd $HOME
git clone --recursive https://github.com/alexhokl/.vim.git .vim
ln -sf $HOME/.vim/vimrc $HOME/.vimrc
cd $HOME/.vim
git submodule update --init

mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
ln -snf "${HOME}/.vim" "${XDG_CONFIG_HOME}/nvim"
ln -snf "${HOME}/.vimrc" "${XDG_CONFIG_HOME}/nvim/init.vim"

pip3 install neovim

git clone https://github.com/alexhokl/dotfiles
cd dotfiles
git checkout mac
make dotfiles
chmod 700 ${HOME}/.gnupg
cd -
git clone https://github.com/alexhokl/installation
cd installation
apm install $(cat apm-list.txt)
npm install -g $(cat npm-list.txt)
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
go get github.com/spf13/cobra/cobra
go get github.com/unidoc/unidoc
go get github.com/go-swagger/go-swagger
go get github.com/alexhokl/go-bb-pr
code --install-extension ms-mssql.mssql
```

- in "Security & Privacy" and in "Privacy" tab, add "Amethyst" to "Accessibility" list
- import profile from [plist file](https://github.com/alexhokl/dotfiles/blob/master/com.googlecode.iterm2.plist) in iTerm2
- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- import GPG key from another machine

```sh
gpg2 --import my-key-filename.asc
```
