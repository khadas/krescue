#!/bin/sh

## hyphop ##

set -e -o pipefail

BOARD=$(tr -d '\0' < /sys/firmware/devicetree/base/model || echo Khadas)
echo "ArchLinux install for $BOARD"

# checks
pkill -f downloader || true
grep $(mmc_disk) /proc/mounts && umount $(mmc_disk)p1

# create partitions
echo "label: dos" | sfdisk $(mmc_disk)
echo "part1 : start=16M," | sfdisk $(mmc_disk)

# create rootfs
# >/dev/null 2>&1
mkfs.ext4 -L ROOT $(mmc_disk)p1 < /dev/null
mkdir -p system && mount $(mmc_disk)p1 system

# can chouse any other rootfs source
SRC=http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz

echo "download and extract $SRC"
curl -A downloader -jkL $SRC | tar -xzf- -C system

# setup extlinux config
cat <<-END > system/boot/extlinux/extlinux.conf
label ArchLinux
kernel /boot/Image.gz
initrd /boot/initramfs-linux.img
fdtdir /boot/dtbs
append root=LABEL=ROOT
END

# setup rootfs
echo LABEL=ROOT / auto errors=remount-ro 1 1 >> system/etc/fstab

# setup host name
echo $BOARD > system/etc/hostname

# setup dhcp for ethernet
echo dhcpcd eth0 -d > system/etc/rc.local
chmod 0777 system/etc/rc.local

# setup secure tty
echo ttyAML0 >> system/etc/securetty
echo ttyFIQ0 >> system/etc/securetty

# install uboot to eMMC
mmc_update_uboot online
# optional to SPI
spi_update_uboot online -k && poweroff # poweron

echo DONE