#!/bin/bash

set -xeu

yum update -y
yum install gcc10 gcc10-c++ gcc10-binutils python3 python3-pip make tar xz git -y 

cd /build/node || exit 1

export CC=gcc10-gcc
export CXX=gcc10-g++
export AR=gcc10-ar

export CFLAGS="${CFLAGS-} -march=armv8.3-a -mbranch-protection=pac-ret "
export CXXFLAGS="${CXXFLAGS-} -march=armv8.3-a -mbranch-protection=pac-ret "

make -j$(nproc) binary

