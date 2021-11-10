## Partitioning

Assuming the system contains 8Gb of memory.

| Device      | Size            | File system      | Mount point     |
| ---         | ---             | ---              | ---             |
| `/dev/sda1` | +100M           | `EF00`           | `/mnt/boot/efi` |
| `/dev/sda1` | +250M           | `8300` (default) | `/mnt/boot`     |
| `/dev/sda3` | remaining space | `8300` (default) | `/mnt`          |

Note that, with this setup, `/mnt/boot` is not encrypted.

To start partitioning

```sh
gdisk /dev/sda
```

To format and mount the new partitions

```sh
curl -sSLO https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/setup.sh
chmod +x setup.sh
```

Edit `setup.sh` to fit the device names and size of swap partition.

If the hard disk involved is `/dev/nvme0n1`, the memory is 16Gb and the ethernet
interface is `eno1`, we can do the following replacements

```sh
sed -i -e 's/sda/nvme0n1p/' setup.sh
sed -i -e 's/12G/24G/' setup.sh
sed -i -e 's/ens3/eno1/' setup.sh
```
Once the editing is done, run the following to complete the setup.

```sh
./setup.sh
```

## Install packages

After reboot, login as a normal user

```sh
./setup.sh
```
