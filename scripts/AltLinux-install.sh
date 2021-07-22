#!/bin/sh

## hyphop ##

#= AltLinux-install

## USAGE examples

#  curl -jkL https://raw.githubusercontent.com/khadas/krescue/master/scripts/AltLinux-install.sh | sh -s -
#  or local usage
#  ssh root@krescue.local < AltLinux-install.sh

set -e -o pipefail

BOARD=$(tr -d '\0' < /sys/firmware/devicetree/base/model || echo Khadas)
echo "ArchLinux installation for $BOARD ..."

# checks 
echo "check network connection..."
ping -c1 -w2 1.1.1.1 || (echo plz check or setup network connection; exit 1)
# stop prev session
pkill -f downloader || true
sleep 1
grep $(mmc_disk) /proc/mounts && umount $(mmc_disk)p1

# create partitions
echo "label: dos" | sfdisk $(mmc_disk)
echo "part1 : start=16M," | sfdisk $(mmc_disk)

# create rootfs
mkfs.ext4 -L ROOT $(mmc_disk)p1 < /dev/null
mkdir -p system && mount $(mmc_disk)p1 system

# can chouse any other rootfs source
SRC=http://nightly.altlinux.org/p9-aarch64/release/alt-p9-jeos-sysv-20210612-aarch64.tar.xz
SRC=http://nightly.altlinux.org/p9-aarch64/release/alt-p9-xfce-20210612-aarch64.tar.xz

echo "download and extract $SRC"
curl -A downloader -jkL $SRC | pixz -dc | tar -xf- -C system

# setup host name
echo ${BOARD// /-} > system/etc/hostname

# fix dtb paths
for a in system/lib/devicetree/*-alt1; do ln -s . $a/amlogic; ln -s . $a/rockchip; done

# maybe need fix extlinux config
cp system/boot/extlinux/extlinux.conf system/boot/extlinux/extlinux.conf.bak
# sed -i s/console=tty1/earlyprintk/ system/boot/extlinux/extlinux.conf

# setup secure tty
echo ttyAML0 >> system/etc/securetty
echo ttyFIQ0 >> system/etc/securetty

umount system

echo "install uboot to eMMC"
mmc_update_uboot online

echo "optional install uboot to SPI flash"
case $BOARD in
*vim|*VIM) echo "skipped for $BOARD";;
*)
spi_update_uboot online -k && echo need poweroff and poweron device again
esac

# DONE
echo "AltLinux installation for $BOARD : DONE"
echo "plz reboot device"
