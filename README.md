# Krescue - tiny fast rescue / installation system for ARM SBCs [![Build Status](https://github.com/khadas/krescue/workflows/Build/badge.svg)](https://github.com/khadas/krescue/actions)

universal rescue / installation system for ARM SBCs

We try to make one simple alternative way for solve common ARM-SBCs users problems!

## Supported Devices

VIM1 VIM2 VIM3 VIM3L / Edge ( amlogic / rockchips )

## related projects

+ https://github.com/khadas/khadas-rescue-sdk		- krescue sdk
+ https://github.com/khadas/khadas-rescue-rootfs	- krescue root fs
+ https://github.com/khadas/khadas-openwrt-feed-extra	- extra packages feed
+ https://github.com/khadas/khadas-openwrt-sdk		- building system for extra packages
+ https://github.com/khadas/khadas-linux-kernel		- linux kernel
+ https://github.com/khadas/khadas-uboot		- uboot

## Building status

+ [khadas openwrt sdk](https://github.com/khadas/khadas-openwrt-sdk) [![Build Status](https://github.com/khadas/khadas-openwrt-sdk/workflows/Build/badge.svg)](https://github.com/khadas/khadas-openwrt-sdk/actions)
+ [khadas openwrt feed extra](https://github.com/khadas/khadas-openwrt-feed-extra) [![Build Status](https://github.com/khadas/khadas-openwrt-feed-extra/workflows/Build/badge.svg)](https://github.com/khadas/khadas-openwrt-feed-extra/actions)
+ [khadas u-boot](https://github.com/khadas/khadas-uboot) [![Build Status](https://github.com/khadas/khadas-uboot/workflows/Build/badge.svg)](https://github.com/khadas/khadas-uboot/actions)
+ [khadas linux kernel](https://github.com/khadas/khadas-linux-kernel) [![Build Status](https://github.com/khadas/khadas-linux-kernel/workflows/Build/badge.svg)](https://github.com/khadas/khadas-linux-kernel/actions)
+ [khadas rescue sdk](https://github.com/khadas/khadas-rescue-sdk) [![Khadas-rescue-sdk](https://github.com/khadas/khadas-rescue-sdk/workflows/Build/badge.svg)](https://github.com/khadas/khadas-rescue-sdk/actions)
+ [khadas rescue rootfs](https://github.com/khadas/khadas-rescue-rootfs) [![Khadas-rescue-rootfs](https://github.com/khadas/khadas-rescue-rootfs/workflows/Build/badge.svg)](https://github.com/khadas/khadas-rescue-rootfs/actions)

## features

+ install any os to internal emmc directly from net
+ can fully located in SPI flash, same as in eMMC or SD card
+ mainline linux kernel
+ all in ram
+ very fast just a 10 sec full boot time
+ flash disks frendly
+ extreme small about ~ 16M
+ can started from SD / USB / eMMC / network PXE / kexec 
+ open source
+ net eth (dhcp client) + wifi (ap + sta)
+ usb gadget modes: usb_net + usb_storage
+ kexec for advanced post boot other os
+ advanced uboot
+ rescue mode for repare install reinstall etc...
+ fully customizations and automations
+ advanced smart boot sequences
+ hot keys
+ read more ...

## what can i get from this 

+ we have always bootable system in anycase
+ its unkillable rescue system 
+ we no need to use special software for updates upgrades rescue system etc.
+ we can install and setup any os to any storages
+ muli bootable os
+ andvanced rescue system with resize move fsck and many other tools 
+ we have access to device via usb_net, wifi_ap, wifi_sta, eth_dhcp, usb_storage, ssh, http ...
+ no need any thing , we can use only usb-C cable or jsut wifi connection, no need uart, ethernet, flash, sd

## AUTHORS

\##hyphop##

