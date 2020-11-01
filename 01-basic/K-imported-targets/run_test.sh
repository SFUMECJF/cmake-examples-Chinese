#!/bin/bash
# Make sure we have the minimum cmake version
cmake_version=`cmake --version | grep version | cut -d" " -f3`

[[ "$cmake_version"  =~ ([3-9][.][5-9.][.][0-9]) ]] || exit 0

echo "correct version of cmake"
mkdir -p build && cd build && cmake .. && make
if [ $? -ne 0 ]; then
    echo "Error running example"
    exit 1
fi
#mkdir -p ：递归创建目录，即使上级目录不存在，会按目录层级自动创建目录