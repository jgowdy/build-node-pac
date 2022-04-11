#!/bin/bash

echo "Running build in container"

docker ps | grep -v CONTAINER | tail -n 1 | cut -f 1 -d ' ' | xargs docker unpause

sleep 15

docker ps | grep -v CONTAINER | tail -n 1 | cut -f 1 -d ' ' | xargs docker pause

#timeout 350m docker run --rm -v "$(pwd)":/build --platform linux/arm64/v8 -t arm64v8/amazonlinux:2 /build/in-container-build-node-amazon.sh
