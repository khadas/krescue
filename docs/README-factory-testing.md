# Factory testing suite

## Testing environment

- USB3 flash with configuration file -> connected to USB3 port
- QR scanner -> connected to USB2 port
- HDMI monitor ( with speaker or headphone output )
- SD card krescue image
- any Bluetooth device ( can use smartphone or BT speaker )
- Wifi access point ( can use smartphone )
- 1G Ethernet hub
- USB OTG ? special prepared cable

## USB flash requrement

- USB3.0
- formated as exfat or fat
- `/khadas_test.txt` - configuration file
- `/flash/BOARD.*.spi.*.gz` - spi-flash image

## Configuration file

`khadas_test.txt` is plain text file with shell syntax

## VIM4 factory-test prefered configuration

```
factory_test=Y
```

Notes

- This test profile full factory board testing
- system boot from SD card
- Need pass all test (no FAILs)
- Fan start on begin
- QR scan for MAC address only and write to EFUSE memory after
- QR scan works at any time
- dMIC can be listen by HDMI
- Need press KEY_FN and KEY_POWER for done testing and write EFUSE and SPI
- EFUSE or SPI-Flash or EMMC write only if all test is pass (no FAILs)
- eMMC will be cleaned after all test pass
- MCU reseted to default config after all test pass
- SPI-FLash write image from USB-Flash disk `/flash/BOARD.*.spi.*.gz` after all test pass
- Any FAILs display on HDMI monirors with RED color
- Restart test when is was done by KEY_FN (just refresh is fast)
- Restart test when is was done by KEY_POWER (full testing restart)
- Bluetooth or Wifi scan or other fails can be fixed just by test restart or board reset
- Remove USB-Flash for exit from testing process
- Test PROGRESS indication LED is blink both white and red
- Test PASS indication LED is slow white blink ( 1sec on x 1sec off ) + red off
- Test FAIL indication LED is fast blink white + solid red
- Full Testing Logs stored to USB-Flash disk


## VIM4 write SPI-Flash configuration

```
flash_write=Y
```

Notes

- Just write/update SPI-Flash
- eMMC will be cleaned after all test pass
- Headless usage is possible
- Key press skipped
- MCU reseted to default config after all test pass
- Writing time about 5min-10min
- LED indication is same

## VIM4 write SPI-Flash prepare special SD card

Notes

- Used only SD card
- same as `flash_write=Y` configuration
- Boot from SD and start SPI-Flash writting process without USB-flash disk
- SD card can be removed when process was started check by LED indication

Howto prepare SD image from SDK

```
scripts/build VIM4 -c
BOARD=VIM4 OVERLAY_SPI=flash_write scripts/build.overlays
image2sd.sh kresq-build/krescue-images/VIM4.krescue.sd.overlay.img.gz -a

```

## VIM4 write efuse serial number configuration

```
serial_write=Y
#TEST_KEYS_SKIP=Y
```

Notes

- This test profile just write serial number and display minimal board information
- system boot from SPI-Flash (no need SD card)
- Wait QR scan for serial code
- Need press KEY_FN for efuse write ( if TEST_KEYS_SKIP=Y configuration option not defined)
- Remove USB-Flash for exit from testing process

## VIM4 stress test configuration

```
stress_test=Y
TEST_STRESS_DURATION=60
```

Notes

- This stress test profile (hi-load, 100% system load)
- system boot from SPI-Flash (no need SD card)
- device must be powered by Khadas power adaptor
- no need HDMI
- Fan on maximal speed
- CPU freq is maximal
- Configuration option TEST_STRESS_DURATION test duration in seconds
- if TEST_STRESS_DURATION undefined is endless test duration
- Progress indication LED blink white + red leds
- Test done indication LED solid white only
- USB-Flash disk can be removed after start and test will continue
- Restart testing by USB-Flash disk replug or KEY_FN

## HDMI display notes

- `PASS` - test ok (dark green color)
- `FAIL` - test failed (red color)
- `SKIP` - skiped (gray color)
- `INFO` - just info (gray color)
- `WAIT` - user notify and wait action (green+gray color)

- Test summary will be GREEN color if all tests is pass
- Test summary will be RED color if any test fail

## Connection diagram

Preferred connection

```
  QR-scaner    USB3-Flash (config)
          |    |
          |    |             +- VIM4 ---+
        +-v----v-----+       |    USB2.0| <-- USB2/USB1 device
        |            |       |          | <-- SD (boot) card
        |            |       |          | <-- Ethernet 1Gbit --------->| 1Gbit ethernet HUB |
=POWER=>| USB3.0_HUB |-------> USB3.0   | <-- HDMI display > speaker / headphones
        |            |       |          |
        +---^--------+       +-USB_OTG--+
            |                     |
            |__short_good__cable__|
                ( 10-15 cm )
```

## USB OTG special prepared cable (optional)

```
USB    <  V  >------------+-> type-C -> Khadas Power adapter
otg    <  D+ >------------|-------==> D+ GPIO header usb pins
port   <  D- >------------|-------==> D-
device <  G  >------------'
```

## Configuration file options full list

NOTE: option without `#` works by default
SYNTAX: # commented is not active

```
TEST_WIFI_SSID=Khadas
TEST_WIFI_LEVEL=-55
TEST_WIFI_WAIT=5
TEST_QR_WAIT=30
#TEST_QR_WAIT_FORCE=Y
TEST_BT_SCAN_NAME=*
#TEST_BT_SCAN_NAME=Khadas
TEST_BT_WAIT=20
TEST_DMIC_DURATION=30
TEST_DMIC_PLAY_DELAY=100

#TEST_EMMC_CLEAN=Y
#TEST_FLASH_SPI=Y ## spi-flash image scan auto mode USB/flash/BOARD.*.spi.*.gz
#TEST_FLASH_SPI=blank ## spi-flash blank
#TEST_LOG_SAVE=Y # enable logs save to usb flash
#TEST_WIFI_SKIP=Y
#TEST_BT_SKIP=Y
#TEST_DMIC_SKIP=Y
#TEST_ETH_SKIP=Y
#TEST_SD_SKIP=Y
#TEST_EFUSE_WRITE_SKIP=Y
#TEST_BT_SKIP=Y
#TEST_KEYS_SKIP=Y
#TEST_USB_SKIP=Y
#TEST_USB2_SKIP=Y
#TEST_USB3_SKIP=Y
#TEST_USB_OTG_SKIP=Y
#TEST_QR_SKIP=Y
#TEST_QR_SKIP_MAC=Y
#TEST_QR_SKIP_SERIAL=Y

```
