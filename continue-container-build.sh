#!/bin/bash

echo "Resuming container"

export CID=$(docker ps | grep -v CONTAINER | tail -n 1 | cut -f 1 -d ' ')

docker logs --follow ${CID} &

docker unpause ${CID}

sleep 21000

kill -9 %1 

echo "Pausing container"

docker pause ${CID}
