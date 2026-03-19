## Creating installation media

### References

- [How to create a bootable installer for
  macOS](https://support.apple.com/en-hk/HT201372)
- [Revive or restore a Mac with Apple silicon using Apple
  Configurator](https://support.apple.com/en-gb/guide/apple-configurator-mac/apdd5f3c75ad/mac)

### Steps

1. Insert USB storage to a Mac
2. Use `diskutil list` to find the USB device
3. Assuming the USB storage is `/dev/disk9`, earse the disk by
   `diskutil eraseDisk FAT32 MAC_OS_X /dev/disk9`
4. Download the latest version of MacOS from App Store
5. Directory `Applications/Install*` should contain a version of macOS
6. Assuming the version involved is `High Sierra`, the command to create a USB
   installation media is `sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Name`
7. Eject the USB storage and insert the USB storage to the Mac requires
   re-installation
8. For Intel CPU, press `options` key upon starting a machine; for Apple
    Silicon, long press power button until selection screen appears

Note: In case the machine shows `No bootable device`, try to clean the BIOS
(NVRAM) by holding keys <kbd>cmd</kbd><kbd>alt</kbd><kbd>P</kbd><kbd>R</kbd>.
See [How to Reset NVRAM on your Mac](https://support.apple.com/en-hk/HT204063)
for more information.

## Setup a new Mac

1. update OSX
2. sign in to App Store (required before running `setup.sh` so `mas` can install apps)
3. open a terminal and run the following

```
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/setup_initial.sh | /bin/bash
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/setup.sh | /bin/bash
```

4. change default download directory of chrome to desktop
