# How-to make simple krescue image xz format

Krescue can accept two types of installation image

+ first way is simple raw image compressed by xz/gz/zst/..
+ another one is advanced kresq container

XZ format its simplest and easiest way if u need make image just for special board

## Basic image requirement

+ image must works same from EMMC and SD        - REQUIRED
+ free image spaces must zeroed	                - OPTIONAL
+ image size must me minimal and optimal        - OPTIONAL
+ must provide next bootup for other systems by
  this sequence USB -> SD -> EMMC               - OPTIONAL
+ os logo splash - stored on first partition 
  at root / folder as splash.bmp
  its just simple raw or gzipped bmp file       - OPTIONAL
+ use one universal uboot images as bootloader  - OPTIONAL
  https://dl.khadas.com/Firmware/uboot/mainline/README.txt
+ post write auto resizable image               - OPTIONAL

## Krescue image requirement for XZ image type

+ must have meta description	about
  board name , os name, basic description, etc. - REQUIRED
+ suitable for mt decompression                 - REQUIRED

## Krescue image name requirement

    BOARD.Label.name.type.img.xz

+ BOARD - VIM1 | VIM2 | VIM3 | VIM3L | Edge
+ Label - os name ( examples: Ubuntu | Manjaro | FreeBSD | OpenWRT | ... )
+ name  - more detailed name
+ type  - sd.emmc | sd | emmc | sd.emmc.usb

## Krescue image name examples

+ VIM1.Manjaro.ARM-xfce-20.08.sd.mmc.img.xz
+ Edge.FreeBSD.aarch64-13.0-CURRENT-20200620.sd.mmc.img.xz
+ Edge.Ubuntu.server-focal_Linux-5.7_arm64_V0.9.1-20200602.sd.mmc.usb.img.xz

both of them easy to make via XZE script

## XZE - advanced xz suitable for mt decompression padding and meta

xze - just a shell script wrapper for xz which generate same
xz standart - same suitable for normal xz decompress usage
and for krescue online installation

+ https://raw.githubusercontent.com/krescue/krescue/master/tools/xze - download link
+ https://github.com/krescue/krescue/blob/master/tools/xze - source page

## HOW TO make xz krescue image EXAMPLE

```
wget https://raw.githubusercontent.com/krescue/krescue/master/tools/xze
chmod 0777 xze

./xze Manjaro-ARM-xfce-vim1-20.08.img -9 --meta LABEL=Manjaro BOARD=VIM1 LINK=manjaro.org DESC="FREE OPERATING SYSTEM FOR EVERYONE"

```
## HOW TO check xz krescue image example


```
./xze Manjaro-ARM-xfce-vim1-20.08.img.xz && echo ok
```

```
./xze VIM1.Manjaro-ARM-xfce-20.08.sd.mmc.img.xz && echo OK
Strms  Blocks   Compressed Uncompressed  Ratio  Check   Filename
    2      53    856.0 MiB  4,615.0 MiB  0.185  CRC64   VIM1.Manjaro-ARM-xfce-20.08.sd.mmc.img.xz
[i] blocks: 53 // 856.0*MiB // 4,615.0*MiB
##META_FILE##
FILE: Manjaro-ARM-xfce-vim1-20.08.img.xz
UNPACKED_SIZE: 4839181469
PACKED_SIZE: 897560576
FILE_SIZE: 897564672
##META-FILE##

##KRESCUE_META##
type:xz
label: Manjaro
match: BOARD=VIM1
link: manjaro.org
desc: FREE OPERATING SYSTEM FOR EVERYONE
duration: 60
builder: universe
date: Fri 21 Aug 2020 01:06:11 PM UTC
image: VIM1.Manjaro-ARM-xfce-20.08.sd.mmc.img
##KRESCUE-META##
##KRESCUE##END
OK
```

## XZ image fast decomression

provided by krescue out of box and same by `pixz`

pixz decompress example

```
pixz -dc < *.img.xz > uncompressed.img
```

pixz decompress and write example to block device

```
pixz -dc < *.img.xz | sudo dd of=/dev/sdX
```

## XZ images Krescue online usage

just upload image to public storage https://dl.khadas.com/Firmware/Krescue/images/
or make redirect link to other trusted location

## XZ images local usage with Krescue

fast direct write from host machine to emmc sbc by network

linux USB connection - just start krescue on your sbc with usb otg connection

```
curl -L 172.22.1.1/shell/write | sh -s - *.img.xz
```

ethernet network connection - your sbc device and host machine must stay in same local network

```
curl -L krescue.lan/shell/write | sh -s - *.img.xz
```

simple copy image to dump krescue disk partition
