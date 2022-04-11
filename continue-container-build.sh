#!/bin/bash

echo "Resuming container"

export CID=$(docker ps | grep -v CONTAINER | grep Paused | tail -n 1 | cut -f 1 -d ' ')

if [ "${CID}" = "" ]; 
then
    echo "No paused container, exiting"
    exit 0;
fi

docker logs --follow ${CID} &

docker unpause ${CID}

sleep 21000

kill -9 %1 

echo "Pausing container"

docker pause ${CID}
