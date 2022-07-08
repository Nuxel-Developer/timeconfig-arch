#!/bin/env bash
TIME_ZONE=$(curl -f -s -S "https://ipapi.co/timezone")
OS_NAME=""

function debug_error {
    echo "Error: $*"
}

source <(cat /etc/os-release)

OS_NAME=${NAME}

if [ "${OS_NAME}" == "Arch Linux" ]; then
  if [ "$1" == "--spt" ]; then
    echo "Starting configuration..."
    printf "Do you want to set timezone manually or automatically? (a/m) "
    read junk
    if [ ${junk} == "a" ]; then
        exec timedatectl set-timezone ${TIME_ZONE}
        echo -e "Done, Timezone changed to ${TIME_ZONE}"
    elif [ ${junk} == "m" ]; then
        printf "Set timezone (e.g.: America/Chicago): "
        read ans
        if [ ${ans} != "" ]; then
            exec timedatectl set-timezone ${ans}
            echo -e "Done, Timezone changed to ${ans}"
        fi
    else
        echo "No valid answear, exiting"
        exit 0
    fi
 else
    debug_error "No command found"
 fi
else
    echo "The OS $OS_NAME is not compatible with timeconfig"
fi
