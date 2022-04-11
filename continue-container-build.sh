#!/bin/bash

echo "Resuming container"

docker logs --follow ${CID} &

docker ps | grep -v CONTAINER | tail -n 1 | cut -f 1 -d ' ' | xargs docker unpause

sleep 21000

kill -9 %1 

echo "Pausing container"

docker ps | grep -v CONTAINER | tail -n 1 | cut -f 1 -d ' ' | xargs docker pause
