#!/bin/bash

curl https://raw.githubusercontent.com/alexhokl/installation/master/debian.3.user.sh -o debian.3.user.sh
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian.4.user.sh -o debian.4.user.sh

chmod +x debian.3.user.sh
chmod +x debian.4.user.sh

curl -L https://github.com/git/git/archive/v2.17.1.tar.gz -o git.tar.gz
tar xvzf git.tar.gz
cd git-*
make prefix=/usr/local all
sudo make prefix=/usr/local install

