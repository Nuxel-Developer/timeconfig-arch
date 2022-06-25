#!/bin/env bash
TIME_ZONE=$(curl -f -s -S "https://ipapi.co/timezone")

function debug_error {
    echo "Error: $*"
}

if [ "$1" == "--spt" ]; then
    echo "Starting configuration..."
    printf "Do you want to set timezone manually or automatilly? (a/m) "
    read junk
    if [ ${junk} == "a" ]; then
        exec timedatectl set-timezone ${TIME_ZONE}
        echo "Done, Timezone changed to ${TIME_ZONE}"
    elif [ ${junk} == "m" ]; then
        printf "Set timezone (e.g.: America/Chicago): "
        read ans
        if [ ${ans} != "" ]; then
            exec timedatectl set-timezone ${ans}
            echo "Done, Timezone changed to ${ans}"
        fi
    else
        echo "No valid answear, exiting"
        exit 0
    fi
else
    debug_error "No command found"
fi