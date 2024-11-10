#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 [brightness]" 
    exit 1
fi

BRIGHTNESS=$1
DISPLAYS=$(xrandr --listmonitors | awk '/\+/ {print $4}')

for display in $DISPLAYS; do 
    xrandr --output "$display" --brightness "$BRIGHTNESS" 
done

