#!/bin/bash

echo "Running build in container"
timeout 350m docker run --rm -v "$(pwd)":/build --platform linux/arm64/v8 -t arm64v8/ubuntu /build/in-container-build-node.sh
