# Krescue kernel args

## Config Krescue

+ config_wifi=[network[:password]]
+ config_firewall=[default|private|disabled]
+ config_samba=[username[:password]@]HOST/share[path]

## Scripts

+ script=[program_path[ args]]
+ script=![shell command line]
+ script=tftp://192.168.100.80/scripts/test

NOTE: script can be used many times

LOGS: tmp/postscript_args/[NUM].log
ERR : tmp/postscript_args/[NUM].err

### Scripts Examples

    script="echo hello"
    script="!echo hello > /dev/ttyAML0"
    script="!(uname -a ; uptime) > /dev/ttyAML0"
    script=reboot
    script="echo hello" script="echo world"
    script=!(uptime; echo reboot after 5 sec; sleep 5;reboot -f) > /dev/ttyAML0
