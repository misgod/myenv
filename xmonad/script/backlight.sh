#!/bin/bash


show() {
	template="%.0f"
    for i in 3 4 5; do
       template="<action=\`$0 $i\` button=$i>$template</action>"
    done

    xbacklight -get | { read i; printf "$template" $i; }
}


case $1 in
    3) sleep 0.5;xset dpms force off ;; # right click, turn off screen
    4) xbacklight -inc 3;; #scroll up
    5) xbacklight -dec 2;; #scroll down
    *) ;;
esac

show

   
