#!/bin/bash

curl https://raw.githubusercontent.com/alexhokl/installation/master/debian8.3.user.sh -o debian8.3.user.sh
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian8.4.user.sh -o debian8.4.user.sh

chmod +x debian8.3.user.sh
chmod +x debian8.4.user.sh

curl -L https://github.com/git/git/archive/v2.11.1.zip -o git.zip
unzip git.zip
cd git-*
make prefix=/usr/local all
sudo make prefix=/usr/local install
