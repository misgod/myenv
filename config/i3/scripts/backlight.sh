#!/bin/bash


show() {
    xbacklight -get | { read i; printf "%.0f" $i; }
}


case $BLOCK_BUTTON in
    3) sleep 0.5;xset dpms force off ;; # right click, turn off screen
    4) xbacklight -inc 3;; #scroll up
    5) xbacklight -dec 2;; #scroll down
    *) ;;
esac

show

   
