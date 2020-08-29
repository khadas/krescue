# HOW TO write os images to emmc

we have many ways write kresq/xz/gz/zst/raw images to emmc

## linux shell + write from host machine to sbc

### write kresq image to emmc via usb net connection

    curl 172.22.1.1/shell/write | sh -s - VIMx*.kresq

### write .xz image to emmc via ethernet connection

    curl krescue.lan/shell/write | sh -s - VIMx*.img.xz

### write raw image to emmc via ethernet connection

    curl krescue.lan/shell/write | sh -s - VIMx*.img


### OUTPUT LOGS EXAMPLES

```
curl vimu/shell/write | sh -s - VIMx*
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1518    0  1518    0     0   296k      0 --:--:-- --:--:-- --:--:--  296k
[i] VIMx.Volumio.last.emmc.kresq (.kresq) write => vimu // mmc
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  457M    0   467  100  457M     10  10.4M  0:00:43  0:00:43 --:--:--   124


# IMAGE WAS WRITED

to       : /dev/mmcblk2
bytes    : 480112640
format   : kresq
duration : 44
status   : 0

# PARTS

/dev/mmcblk2p1: SEC_TYPE="msdos" LABEL_FATBOOT="BOOT" LABEL="BOOT" UUID="0ADF-1F2F" TYPE="vfat" PARTUUID="64411837-01"
/dev/mmcblk2p2: LABEL="volumio" UUID="9d8f215e-5696-4cc3-9e57-2b4445114534" TYPE="ext4" PARTUUID="64411837-02"
/dev/mmcblk2p3: LABEL="volumio_data" UUID="f1582fcd-1632-4dde-9338-f6cdcbeb0116" TYPE="ext4" PARTUUID="64411837-03"

```

TBD...

