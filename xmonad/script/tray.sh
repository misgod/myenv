#!/bin/bash

PID=$(pidof stalonetray)
    if [ -z "$PID" ]; then
        stalonetray &
        #sleep 10
        #killall stalonetray
    else
        killall stalonetray
    fi
