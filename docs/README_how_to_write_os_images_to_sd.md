# HOW TO write os images to sd

we have many ways write xz/gz/zst/raw images to sd

## linux shell + write from host machine to sbc

### write .gz image to sd via ethernet connection

    curl krescue.lan/shell/write | sh -s - -sd VIMx*.img.gz

same as 

    gzip -dc VIM3L.krescue.sd.img.gz | sudo dd of=/dev/sdX bs=1M
