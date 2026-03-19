#! /bin/bash

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/brew_list | xargs -n 1 brew install
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/cask_list | xargs -n 1 brew install --cask
brew link --force libpq
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_NO_ENV_FILTERING=1 ACCEPT_EULA=y brew install msodbcsql18
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | /bin/bash

pyenv install 3.11
pyenv global 3.11
curl -sSLO https://raw.githubusercontent.com/alexhokl/installation/master/requirements.txt
python -m pip install --upgrade --user pip
python -m pip install --upgrade --user -r $HOME/git/installation/requirements.txt

## latest LTS version of node
n lts

mkdir -p $HOME/git
for r in $(curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/repo_list); do
	n=$(basename $r)
	git clone $r $HOME/git/$n
done

git clone https://github.com/alexhokl/.vim $HOME/.vim
ln -sf $HOME/.vim $HOME/.config/nvim

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/go_packages \
	| xargs -n 1 go install
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/cargo_packages \
	| xargs -n 1 cargo install

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/vscode-extensions.txt \
	| xargs -n 1 code --force --install-extension

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/dotnet_tools \
	| xargs -n 1 dotnet tool install -g

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/npm-list.txt \
	| xargs -n 1 sudo npm i -g

source $HOME/git/installation/mac/functions
set_display_more_space
setup_preferences
setup_keyboard
setup_three_finger_drag
setup_tap_to_click
setup_caps_lock_to_control
setup_password_on_sleep

pushd $PWD
cd $HOME/git/dotfiles
make dotfiles
popd

mas install 497799835   # Xcode
mas install 803453959   # Slack for Desktop
mas install 1295203466  # Windows App
mas install 1475387142  # Tailscale

sudo xcodebuild -license accept

sudo ln -sf /opt/homebrew/bin/pinentry-mac /usr/local/bin/pinentry

bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
