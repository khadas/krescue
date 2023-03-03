#!/bin/sh

## hyphop ##

#= repack images script

IN=${IN-$1}

lowcase(){ echo "$@" | tr '[:upper:]' '[:lower:]'; }
DIE() { echo "[e] $@" ; exit 1 ; }


[ "$IN" ] || DIE "undefined input image"
[ -e "$IN" ] || DIE "not found input image"

echo "< $IN"
case $IN in

    LibreELEC*)
    name=libreelec
    Name=LibreELEC
    echo "[i] $Name detected">&2
    #LibreELEC-RK3399.arm-10.95.1-khadas-edge.img.gz
    VER=${IN##*arm-}
    VER=${VER%%-*}
    board=${IN##*-}
    board=$(lowcase ${board%%.*})
    LINK=https://libreelec.tv/downloads/
    POST="-arm"
    DURATION=20
    ;;

    Lakka*)
    name=lakka
    Name=Lakka
    echo "[i] $Name detected">&2
    #Lakka-RK3399.aarch64-4.3-khadas-edge.img.gz
    VER=${IN##*aarch64-}
    VER=${VER%%-*}
    board=${IN##*-}
    board=$(lowcase ${board%%.*})
    LINK=https://lakka.tv/get/linux/
    POST="-aarch64"
    ;;

esac

IMAGE=$(basename $IN)

case $board in
    edge) BOARD=Edge ;;
esac

[ "$BOARD" ] || DIE "undefined board >$board<"

OUT="$board-$name-$VER$POST.img"
OUTX="$OUT".xz

echo "> $OUT"

export PATH=$(pwd):~/bin:$PATH

CMD(){
    echo "# $@" >&2
    "$@"
}

case $IN in
    *.gz)
    INR=${IN%.*}

    CMD pigz -dc <$IN > $OUT
    
    ;;
esac


BUILDER=${BUILDER-khadas}
DATE=${DATE-$(LANG=C TZ= date)}
DURATION=${DURATION-60}
DESC=${DESC-$Name $VER for khadas $BOARD repack from original $IMAGE}

CMD xze "$OUT" \
    --meta \
    label="$Name" \
    builder="$BUILDER" \
    date="$DATE" \
    match=BOARD=$BOARD \
    link="$LINK" \
    duration="$DURATION" \
    desc="$DESC" \
