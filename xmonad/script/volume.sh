#!/bin/sh

case $1 in
     4) /usr/bin/amixer -q sset Master 3%+;;
     5) /usr/bin/amixer -q sset Master 3%-;;
     3) /usr/bin/amixer -q sset Master toggle;;
     *) ;;
esac

CURVOL=`amixer get Master |grep % |awk '{print $5}'|sed 's/[^0-9\%]//g' | head -n1`

#notify-send "Volume: $CURVOL"

show() {
	template="%s"
    for i in 3 4 5; do
       template="<action=\`$0 $i\` button=$i>$template</action>"
    done

    CURVOL=`amixer get Master |grep % |awk '{print $6=="[off]"?$6:$5}' | sed 's/[^0-9ONFonf]//g' | head -n1`
    printf "$template" $CURVOL
    
   # xbacklight -get | { read i; printf "$template" $i; }
}

show

