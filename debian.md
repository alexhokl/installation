##### Reference

- [Initial Server Setup With Debian 8](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-8)


#### Steps

- Install `curl`

```sh
su
vi /etc/apt/sources.list
(remove lines with  `cdrom` to avoid prompting for discs)
apt-get update
apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
        dirmngr \
		--no-install-recommends
```

- Install APT packages

```sh
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian8.1.root.sh -o debian8.1.root.sh
chmod +x debian8.1.root.sh
./debian8.1.root.sh
rm debian8.1.root.sh
shutdown -r now
```

- Install `git` and more APT packages

```sh
curl https://raw.githubusercontent.com/alexhokl/installation/master/debian8.2.user.sh -o debian8.2.user.sh
chmod +x debian8.2.user.sh
./debian8.2.user.sh
```

- Reboot to make sure docker for unprivileged user is enabled.

- Install Ruby and neovim

```sh
./debian8.4.user.sh
```

- Open neovim
  - update plugins via `:UpdateRemotePlugins`
  - install go binaries via `:GoInstallBinaries`
- generate new token from github for bash access (https://github.com/settings/tokens/new) and this token will be used a password for github authentication
- `gpg2 --gen-key` (and select "RSA and RSA", select 4096 as keysize, select "key does not expire", enter github registration email address for "email address")
- `gpg2 --list-secret-keys --keyid-format LONG` (and copy the number in "sec" after "4096R/"
- copy the number into `.gitconfig`
- `gpg2 --armor --export {key}` (replace key with the number in the previous step)
- add the GPG key onto GitHub

```sh
sudo apt-get -y install g++

sudo nvim /etc/locale.gen
(find and un-comment en_GB.UTF-8 and save and quit)
sudo local-gen
```
