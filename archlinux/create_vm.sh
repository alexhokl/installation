#! /bin/bash

virt-install \
  --name=arch \
  --ram=8192 \
  --cpu=host \
  --vcpus=4 \
  --os-type=generic \
  --disk path=/var/lib/libvirt/images/arch.qcow2,size=80 \
  --cdrom $HOME/Downloads/archlinux-2021.11.01-x86_64.iso \
  --network network=default \
  --boot=uefi

