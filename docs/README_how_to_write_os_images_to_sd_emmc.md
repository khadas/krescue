# HOW TO write os images to sd or emmc

we have many ways write xz/gz/zst/raw images to sd

## linux shell + write from host machine to sbc

### write .gz image to sd via ethernet connection

    curl krescue.lan/shell/write | sh -s - -sd VIM3L.krescue.sd.img.gz

same as via usb device

    gzip -dc VIM3L.krescue.sd.img.gz | sudo dd of=/dev/sdX bs=1M

where /dev/sdX - is sd disk


## SYNTAX

    curl krescue.lan/shell/write | sh -s - IMAGE_FILE [-sd|-mmc] [/dev/...]
