#! /bin/bash

curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/brew_list | xargs -n 1 brew install
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/cask_list | xargs -n 1 brew install --cask
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
ACCEPT_EULA=y brew install mssql-tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | /bin/bash

curl -sSLO https://raw.githubusercontent.com/alexhokl/installation/master/requirements.txt
python -m pip install --upgrade --user pip
python -m pip install --upgrade --user -r $HOME/git/installation/requirements.txt

mkdir -p $HOME/git
for r in $(curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/repo_list); do
	n=$(basename $r)
	git clone $r $HOME/git/$n
done

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
install_vim

pushd $PWD
cd $HOME/git/dotfiles
make dotfiles
popd
