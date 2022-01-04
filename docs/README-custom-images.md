Create Custom images
====================

# Write base image

Write some system to eMMC via Amlogic burn software or Krescue or any other way.

# Customization

Install custom software and configure system.

# Create installation image via Krescue

start Krescue from SD card

## Optimize emmc byte content

    Krescue => Advanced => eMMC storage => Optimize minimize eMMC content

NOTE: tested with fenix ubuntu emmc system

## Make eMMC dump image

    Krescue => Image DUMP from EMMC

## Make autoinstall sd card

    Krescue => Image WRITE to EMMC => Select image for install => More =>  autoinstall: .. this image => OK => Continue

Autoinstall sd image is ready

## Autoinstallation process from prepeared card

Just plug SD card and power-on device, all process will be done automaticly

We can interrput autoinstall process during fist 5 sec by keyboard ESC or press CONFIGURE button

wait write process will be complited and eject sd card (device is ready)

### LED indication VIM3 / VIM3L

+ solid white + blinked red  = writing
+ solid write + disabled red = done and ready for reboot / eject sd card
+ solid red = error

## Autoinstall configure

### Autoinstall check status and configure

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

#### Autoinstall deactivate

    < Deactivate >

    ┌──────────────────────────Autoinstall config────────────────────────────┐
    │                                                                        │
    │ state: not active                                                      │
    │                                                                        │
    ├────────────────────────────────────────────────────────────────────────┤
    │   <Manual Edit >  <    Help    >  <  Continue  >  <Select Image>       │
    └─────────────────────────────[F1 - help]────────────────────────────────┘

#### Autoinstall select image

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

## how to write quickly many system +100

1) create many autoinstall sd cards and write many boards at same times
2) optimize minimize dump image
