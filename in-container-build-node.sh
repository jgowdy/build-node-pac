#!/bin/bash

set -xeu

apt-get update -y
apt-get install build-essential gcc-10 g++-10 git python3 python3-pip -y

cd /build || exit 1

export CFLAGS="${CFLAGS-} -march=armv8.3-a -mbranch-protection=pac-ret "
export CXXFLAGS="${CXXFLAGS-} -march=armv8.3-a -mbranch-protection=pac-ret "

make -j8
