#!/bin/bash

set -xeu

echo "Updating apt"
sudo apt-get update -y
echo "Installing dependencies"
sudo apt-get install build-essential python3 python3-pip gcc-10-aarch64-linux-gnu g++-10-aarch64-linux-gnu binutils-aarch64-linux-gnu git -y
echo "Installing qemu support"
sudo apt-get install qemu binfmt-support qemu-user-static
echo "Register qemu support with docker"
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
echo "Testing arm64v8 emulation"
docker run --rm --platform linux/arm64/v8 -t arm64v8/ubuntu uname -m


VERSION=16.14.2
TAG_VERSION=v${VERSION}

rm -rf ./node
echo "Cloning Node.js"
git clone --depth 1 --branch ${TAG_VERSION} https://github.com/nodejs/node.git 
cd node || exit 1

#TARBALL=${TAG_VERSION}.tar.gz
#TARBALL_URL=https://github.com/nodejs/node/archive/refs/tags/${TARBALL}
#rm "./${TARBALL}"
#wget "${TARBALL_URL}"
#rm -rf "./node-${VERSION}"
#tar xvf "${TARBALL}"
#cd "./node-${VERSION}" || exit 1

export CC="aarch64-linux-gnu-gcc-10"
export CXX="aarch64-linux-gnu-g++-10"
export CPP="aarch64-linux-gnu-cpp-10"
export CFLAGS="${CFLAGS-} -march=armv8.3-a -mbranch-protection=pac-ret "
export CXXFLAGS="${CXXFLAGS-} -march=armv8.3-a -mbranch-protection=pac-ret "

echo "Building Node"
./configure --cross-compiling --dest-cpu arm64 --dest-os linux && make -j$(nproc)
echo "Verifying output"
stat ./node
objdump --disassemble-all ./node | grep paciasap && echo PAC build successful && exit 0 || echo No PAC instructions found! && exit 1
