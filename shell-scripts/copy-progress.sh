#!/bin/bash

help(){
    echo "You should use this as:"
    echo "  $0 source/path destination/path"
    echo
    echo "This is meant to be used to see the progress of a command like:"
    echo "shell> rsync -av source/path/ dest/path/"
}

progress(){
    # example usage:
    # progress 30G 9G 30
    # 30G [================>.................................] 30% (9G)

    # params:
    # $1 = total value (e.g.: source size)
    # $2 = current value (e.g.: destination size)
    # $3 = percent completed
    [[ -z $1 || -z $2 || -z $3 ]] && exit  # on empty param...

    percent=$3
    completed=$(( $percent / 2 ))
    remaining=$(( 50 - $completed ))

    echo -ne "\r$1 ["
    printf "%0.s=" `seq $completed`
    echo -n ">"
    [[ $remaining != 0 ]] && printf "%0.s." `seq $remaining`
    echo -n "] $percent% ($2)  "
}

SRC=$1
DST=$2

[[ -z $SRC || -z $DST ]] && help && exit

echo -n "Calculating size of '$SRC' -> "
SRC_sizeH=`du -sh $SRC 2> /dev/null | cut -f1 | tr , .`  # human friendly, e.g.: 34G
SRC_size=`du -s $SRC 2> /dev/null | cut -f1`  # math friendly, e.g.: 34889264
echo $SRC_sizeH

while true; do
    DST_sizeH=`du -sh $DST 2> /dev/null | cut -f1 | tr , .`
    DST_size=`du -s $DST 2> /dev/null | cut -f1`
    percent=$(( $DST_size * 100 / $SRC_size ))

    progress $SRC_sizeH $DST_sizeH $percent

    [[ "$percent" == "100" ]] && break  # exit if 100% is reached
    sleep 1
done

echo
