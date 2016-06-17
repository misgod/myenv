#!/bin/bash

 PID=eval "pidof gsimplecal"
    if [ -z "$PID" ]; then
        gsimplecal &
    else
        killall gsimplecal
    fi