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

### Setup steps

- update OSX
- open a terminal and run the following
- `curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/setup_initial.sh | /bin/bash`
- `curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/setup.sh | /bin/bash`
- install the following apps from App Store
  - Tailscale
  - Magnet
  - Microsoft Remote Desktop
  - Slack for Desktop
  - Xcode
- set display scaled and choose "more space"
- setup keyboard with UK English and HK Chinese and download dictation
- setup three finger drag in "accessibility" (see
  https://support.apple.com/en-us/HT204609)
- setup "Require password immediately after sleep or screen saver begins" in
  "Security & Privacy"
- change default download directory of chrome to desktop
- customise using the following script

```sh
sudo xcodebuid -license accept

curl https://raw.githubusercontent.com/alexhokl/installation/master/mac/preferences.scpt -o mac-preferences.scpt
osascript mac-preferences.scpt
```
