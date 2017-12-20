#!/bin/bash
set -m
mongodb_cmd="mongod --auth"

$mongodb_cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_credentials.sh
fi

fg