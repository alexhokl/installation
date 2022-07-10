#! /bin/zsh

xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew install bash
chsh -s /opt/homebrew/bin/bash

