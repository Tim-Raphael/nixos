#!/usr/bin/env bash 

if [ -z "$1" ]; then 
    echo "Usage: $0 [volume]"
    exit 1
fi

VOLUME=$1

wpctl set-volume @DEFAULT_AUDIO_SINK@ "$VOLUME"
