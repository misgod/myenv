#!/bin/bash

toggle_calc(){
    PID=eval "pidof gsimplecal"
    if [ -z "$PID" ]; then
        gsimplecal &
    else
        killall gsimplecal
    fi
}


case $BLOCK_BUTTON in
    1) toggle_calc ;; # left click, show calendar
    *) ;;
esac


date '+<span size="large" foreground="#44eeff">%H:%M</span>'


