#!/bin/bash

USER=${MONGODB_USER:-"guest"}
PASS=${MONGODB_PASS:-"guest"}
_word=$( [ ${MONGODB_PASS} ] && echo "preset" || echo "default" )

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "=> Creating an ${USER} user with a ${_word} password in MongoDB"
mongo admin --eval "db.createUser({user: '$USER', pwd: '$PASS', roles:[{role:'root',db:'admin'}]});"

echo "=> Done!"
touch /data/db/.mongodb_password_set