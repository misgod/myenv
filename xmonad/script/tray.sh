#!/bin/bash

PID=$(pidof stalonetray)
    if [ -z "$PID" ]; then
        stalonetray &
    else
        killall stalonetray
    fi