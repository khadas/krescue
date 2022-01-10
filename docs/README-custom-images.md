How To Create Custom Images
===========================

NOTE: Krescue version 220104_275

# 1. Write Image to eMMC

Write a system into the eMMC using the Amlogic Burning Software, Krescue, or any other preferred method.

# 2. Customization

Install custom software and configure your system as required.

# 3. Use Krescue to Create an Installation Image

## 3.1 Start Krescue from an SD card

## 3.2 Optimize eMMC byte content

    Krescue => Advanced => eMMC storage => Optimize minimize eMMC content

rootfs will be mimimized and maximized when image was writed again by autoinstall

NOTE: tested with Fenix Ubuntu system (eMMC version)

## 3.3 Dump Image from eMMC

    Krescue => Image DUMP from EMMC

## 3.4 Make Auto-Install SD Card

    Krescue => Image WRITE to EMMC => Select image for install => More => autoinstall: .. this image => OK => Continue

Auto-Install SD card is ready.

## 3.5 Auto-Install Your Custom Image

Just insert the Auto-Install SD card, then power-on your device, all processes will be completed automatically. After the writing is completed, simply eject the SD card and reboot your device.

NOTE: Pressing ESC (keyboard) or CONFIGURE within the first 5 seconds will interrupt the auto-installation process

### 3.5.1 VIM3 / VIM3L LED Colours

+ solid white + blinking red   =   writing
+ solid write                  =   done and ready for reboot / eject sd card
+ solid red                    =   error

## 3.6 Configure Auto-Installation Process

### 3.6.1 Configure the Auto-Installer and check status

Krescue => Advanced => Image autoinstall config

    ┌──────────────────────────Autoinstall config────────────────────────────┐
    │                                                                        │
    │ state: activated                                                       │
    │ ---------------------------------------------------------------------- │
    │ image: VIM3.1641270786.2386759680-bytes.emmc.img.zst                   │
    │                                                                        │
    ├────────────────────────────────────────────────────────────────────────┤
    │   <Manual Edit >  < Deactivate >  <  Continue  >  <Select Image>       │
    └─────────────────────────────[F1 - help]────────────────────────────────┘

#### 3.6.1.1 Deactivate Auto-Installer

    < Deactivate >

    ┌──────────────────────────Autoinstall config────────────────────────────┐
    │                                                                        │
    │ state: not active                                                      │
    │                                                                        │
    ├────────────────────────────────────────────────────────────────────────┤
    │   <Manual Edit >  <    Help    >  <  Continue  >  <Select Image>       │
    └─────────────────────────────[F1 - help]────────────────────────────────┘

#### 3.6.1.2 Select Image to Auto-Install

    < Select Image >

    ┌──────────────────────────────────dumps─────────────────────────────────────┐
    │ Autoinstall Select Image                                                   │
    │ ┌────────────────────────────────────────────────────────────────────────┐ │
    │ │ 1  ../                                                                 │ │
    │ │ 2  downloads/                                      32.0K Jan  3 08:21  │ │
    │ │ 3  README.txt                                        569 Jan  4 04:56  │ │
    │ │ 4 >VIM3.1641270786.2386759680-bytes.emmc.img.     526.7M Jan  4 04:34  │ │
    │ └────────────────────────────────────────────────────────────────────────┘ │
    ├────────────────────────────────────────────────────────────────────────────┤
    │                       <  OK  >            <Cancel>                         │
    └────────────────────────────────────────────────────────────────────────────┘

#### 3.6.1.3

    < Manual Edit >

    ┌──────────────────────Auto install manual config────────────────────────┐
    │ Image filename:                                                        │
    │ ┌────────────────────────────────────────────────────────────────────┐ │
    │ │VIM3.1641795435.6562484224-bytes.emmc.img.zst --resize              │ │
    ├─└────────────────────────────────────────────────────────────────────┘─┤
    │                     <  OK  >           <Cancel>                        │
    └─────────────────────────────[F1 - help]────────────────────────────────┘

NOTE: --resize is resize to max size parameter after image was writed

## 3.7 Optimization

+ Create many Auto-Install SD cards and write to many boards at same time
+ Optimize / prepare the dumped-image for quicker eMMC installation
