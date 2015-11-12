#!/bin/bash

toggle_calc(){
    PID=eval "pidof gsimplecal"
    notify-send "$PID"
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


date '+%Y-%m-%d  <span background="yellow" foreground="#303030"><b> %H:%M </b></span>'


