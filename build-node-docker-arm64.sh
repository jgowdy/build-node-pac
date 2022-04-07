#!/bin/bash

set -xeu

echo "Updating apt"
sudo apt-get update -y

echo "Installing qemu support"
sudo apt-get install qemu binfmt-support qemu-user-static

echo "Register qemu support with docker"
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

echo "Testing arm64v8 emulation"
docker run --rm --platform linux/arm64/v8 -t arm64v8/ubuntu uname -m

echo "Running build in container"
docker run --rm --platform linux/arm64/v8 -t arm64v8/ubuntu -v "$(pwd)":/build /build/build-node.sh
