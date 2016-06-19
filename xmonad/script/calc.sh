#!/bin/bash

PID=$(pidof gsimplecal)
    if [ -z "$PID" ]; then
        gsimplecal &
    else
        killall gsimplecal
    fi
