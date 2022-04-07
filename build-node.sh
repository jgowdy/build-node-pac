#!/bin/bash

set -xeu

apt-get update -y
apt-get install build-essential gcc-10 g++-10 git python3 python3-pip -y

cd /build || exit 1

VERSION=16.14.2
TAG_VERSION=v${VERSION}

rm -rf ./node
git clone --depth 1 --branch ${TAG_VERSION} https://github.com/nodejs/node.git 
cd node || exit 1

export CFLAGS="${CFLAGS-} -march=armv8.3-a -mbranch-protection=pac-ret "
export CXXFLAGS="${CXXFLAGS-} -march=armv8.3-a -mbranch-protection=pac-ret "

./configure && make -j8
echo "Verifying output"
stat ./node || echo "Node output not found" && exit 1
objdump --disassemble-all ./node | grep paciasap && echo PAC build successful && exit 0 || echo No PAC instructions found! && exit 1
