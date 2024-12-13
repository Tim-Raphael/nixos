#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 [username] [hostname] [client_id]" 
    exit 1
fi

USER=$1
HOST=$2
CLIENT_ID=$3

REMOTE_PATH="/var/DFSWORK/${CLIENT_ID}/work/"
LOCAL_PATH="$HOME/remote/${CLIENT_ID}"

if [ ! -d "$LOCAL_PATH" ]; then
    echo "Creating local directory: $LOCAL_PATH"
    mkdir -p "$LOCAL_PATH"
fi

echo "Mounting ${USER}@${HOST}:${REMOTE_PATH} to ${LOCAL_PATH}..."
sshfs "${USER}@${HOST}:${REMOTE_PATH}" "$LOCAL_PATH" -C

if mountpoint -q "$LOCAL_PATH"; then
    echo "Mounted successfully. Starting neovim..."
    cd $HOME/remote/"$CLIENT_ID"
    nvim 
else
    echo "Failed to mount ${REMOTE_PATH}."
    exit 1
fi

