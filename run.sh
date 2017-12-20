#!/bin/bash
mongodb_cmd="mongod --dbpath ~/data/db --auth"

$mongodb_cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_credentials.sh
fi

fg