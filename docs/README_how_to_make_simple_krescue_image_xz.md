# HOW TO make .xz krescue images

Krescue can accept two types of installation images.

+ raw images compressed with xz/gz/zst/..
+ advanced .kresq container

# WHY .xz file-format for krescue

The .xz format is the most efficient modern compression algorithm in existence, producing the smallest possible compressed file-sizes. 

However in the case of an SBC with limited CPU power, krescue requires the developer to prepare their .xz images for multi-threaded decompression.

.xz images are interoperable with third party decompression tools, retaining our commitment to the open source effort.

## Basic image requirement

+ image must be bootable from EMMC and SD       - REQUIRED
+ free image spaces must zeroed	                - OPTIONAL
+ image size must be minimal and optimal        - OPTIONAL
+ must provide boot-order for other systems
  in this sequence USB -> SD -> EMMC            - OPTIONAL
+ os logo splash - stored on first partition 
  in root / folder as splash.bmp
  a simple raw or gzipped bmp file will do      - OPTIONAL
+ LABEL tag file - stored on first partition 
  in root / folder as LABEL
  a simple .txt file containing the os name     - OPTIONAL
+ use one universal uboot image as bootloader   - OPTIONAL
  https://dl.khadas.com/Firmware/uboot/mainline/README.txt
+ post-write auto resizable image               - OPTIONAL

## Krescue image requirement for .xz image type

+ must have meta description about the
  board name, os name, basic description, etc.  - REQUIRED
+ suitable for multi-threaded decompression     - REQUIRED

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

All of them are easy to make via the `xze` script.

## xze - advanced script for .xz compression, with krescue-padding and meta-description

`xze` - shell script wrapper for generating .xz images for multi-threaded decompression using the xz-standard.

+ https://raw.githubusercontent.com/krescue/krescue/master/tools/xze - script download link
+ https://github.com/krescue/krescue/blob/master/tools/xze - github source page

## HOW TO make .xz krescue images (example)

```
wget https://raw.githubusercontent.com/krescue/krescue/master/tools/xze
chmod 0777 xze

./xze Manjaro-ARM-xfce-vim1-20.08.img -9 --meta LABEL=Manjaro BOARD=VIM1 LINK=manjaro.org DESC="FREE OPERATING SYSTEM FOR EVERYONE"

```
## HOW TO verify .xz krescue images (example)

Last 4kb (4096 bytes) block must contain meta-information about the correct image-size:

```
tail -c4096 VIM1.Manjaro-ARM-xfce-20.08.sd.mmc.img.xz | xz -dc && echo OK
```

Same process carried out via `xze` script:

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
type: xz
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

## .xz image fast decompression

Included in krescue via `pixz`.

`pixz`  decompression example:

```
pixz -dc < *.img.xz > uncompressed.img
```

`pixz` decompression and writing to a block device

```
pixz -dc < *.img.xz | sudo dd of=/dev/sdX
```

## .xz image Krescue online usage

Just upload image to public storage https://dl.khadas.com/Firmware/Krescue/images/ or make a re-direct link to another trusted location.

## .xz image network write with Krescue

Directly write compressed .xz images from your host machine to SBC's EMMC via network:

1) USB-LAN connection - start Krescue on your SBC, and connect it to your PC via the USB-C port.

```
curl -L 172.22.1.1/shell/write | sh -s - *.img.xz
```

2) Ethernet network connection - your SBC device and host machine must stay on the same local network.

```
curl -L krescue.lan/shell/write | sh -s - *.img.xz
```

3) Copy image to Krescue's "dumps" sd-card partition.
