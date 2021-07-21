# install AltLinux for any Khadas board

## Start krescue from SD

+ download sd/usb image https://dl.khadas.com/Firmware/Krescue/system/
for your device and bootup Krescue

## Preparation notes

+ device must connected to internet via ethernet or wifi
+ ethernet will be auto connected if cable already was plugged

## WIFI configuration

if u stay already in shell exec `krescue` or `exit` to back into krescue menu

+ krescue main menu -> network -> wifi -> connect /select

## manual install Alt-Lihux into eMMC from shell

+ krescue main menu -> shell

```
# create partitions
echo "label: dos" | sfdisk $(mmc_disk)
echo "part1 : start=16M," | sfdisk $(mmc_disk)

# create rootfs
mkfs.ext4 -L ROOT $(mmc_disk)p1
mkdir -p system && mount $(mmc_disk)p1 system

# download and extract u can chouse any other source from Images variants
SRC=http://nightly.altlinux.org/sisyphus-aarch64/tested/regular-jeos-systemd-latest-aarch64.tar.xz

curl -jkL $SRC | pixz -dc | tar -xf- -C system

# fix dtb paths
for a in system/lib/devicetree/*-alt1; do ln -s . $a/amlogic; ln -s . $a/rockchip; done

# maybe need fix extlinux config
cp system/boot/extlinux/extlinux.conf system/boot/extlinux/extlinux.conf.bak
# sed -i s/console=tty1/earlyprintk/ system/boot/extlinux/extlinux.conf

echo ttyAML0 >> system/etc/securetty
echo ttyFIQ0 >> system/etc/securetty

# install uboot to eMMC
mmc_update_uboot online
# optional to SPI
spi_update_uboot online -k && poweroff # poweron

# DONE

reboot

```
## user/root access

    user: root
    password: altlinux

## Problems

+ not tested
+ serial console not active
+ kernel missed some drivers

## Images variants

+ http://nightly.altlinux.org/sisyphus-aarch64/tested/regular-icewm-sysv-latest-aarch64.tar.xz
+ http://nightly.altlinux.org/sisyphus-aarch64/tested/regular-jeos-sysv-latest-aarch64.tar.xz
+ http://nightly.altlinux.org/sisyphus-aarch64/tested/regular-jeos-systemd-latest-aarch64.tar.xz
+ http://nightly.altlinux.org/sisyphus-aarch64/tested/regular-mate-latest-aarch64.tar.xz
+ http://nightly.altlinux.org/sisyphus-aarch64/tested/regular-xfce-latest-aarch64.tar.xz
+ http://nightly.altlinux.org/sisyphus-aarch64/tested/regular-lxde-latest-aarch64.tar.xz
+ http://nightly.altlinux.org/sisyphus-aarch64/tested/regular-lxqt-latest-aarch64.tar.xz

ENJOY ;-)

## LINKS

+ https://dl.khadas.com/Firmware/Krescue/system
+ https://dl.khadas.com/Firmware/Krescue/#Info
+ https://dl.khadas.com/Firmware/Krescue/system/README-rescue-boot.txt
+ https://dl.khadas.com/Firmware/Krescue/system/README-rescue-access.txt
+ https://altlinux.org
+ http://nightly.altlinux.org/sisyphus-aarch64/tested
+ https://github.com/khadas/krescue/blob/master/docs/README-AltLinux-install.example.md

PS: next time i will write same instruction for ArchLinux and any other distro
