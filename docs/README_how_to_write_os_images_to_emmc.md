# HOW TO write os images to emmc

we have many ways write kresq/xz/gz/zst/raw images to emmc

## linux shell + write from host machine to sbc

### write kresq image to emmc via usb net connection

    curl 172.22.1.1/shell/write | sh -s - VIMx*.kresq

### write .xz image to emmc via ethernet connection

    curl krescue.local/shell/write | sh -s - VIMx*.img.xz

### write raw image to emmc via ethernet connection

    curl krescue.local/shell/write | sh -s - VIMx*.img


TBD...
