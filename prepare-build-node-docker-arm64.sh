#!/bin/bash

set -xeu

echo "Updating apt"
sudo apt-get update -y

echo "Installing qemu support"
sudo apt-get install qemu binfmt-support qemu-user-static -y

echo "Register qemu support with docker"
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

echo "Testing arm64v8 emulation"
docker run --rm --platform linux/arm64/v8 -t arm64v8/ubuntu uname -m

VERSION=16.14.2
TAG_VERSION=v${VERSION}

rm -rf ./node
echo "Cloning Node.js"
git clone --depth 1 --branch ${TAG_VERSION} https://github.com/nodejs/node.git 

echo "Running configure in container"
timeout 350m docker run --rm -v "$(pwd)":/build --platform linux/arm64/v8 -t arm64v8/ubuntu /build/in-container-configure-node.sh
