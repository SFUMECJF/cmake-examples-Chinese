#!/bin/bash

#Ubuntu支持同时安装多个版本的clang。
#测试需要在调用cmake之前确定clang二进制文件

#这个脚本找到具体clang编译器路径，并配置cmake使用clang编译器
相当于在shell中执行命令：whilch clang然后将返回的结果也就是路径，赋值给变量clang_bin
clang_bin=`which clang`
clang_xx_bin=`which clang++`
#which语句返回后面命令的路径
#  -z  指如果后面的路径为空则为真

#如果用which没有找到clang的二进制可执行文件，则用dpkg找到clang，并返回版本号
#dpkg –get-selections 罗列出所有包的名字并且给出了他们现在的状态比如已安装（ installed）已经卸载。（ deinstalled）
#grep clang从结果中查找到带有clang名字的
#grep -v   反转，选择不匹配的所有行。
#grep -m1  单纯的-m1表示输出1条匹配的结果之后就会停止
#grep -v -m1 libclang 输出包含clang的命令中，所有不包含libclang的一条介绍
#也就是去掉那些clang的库，找的是clang这个程序的版本。

#cut 命令从文件的每一行剪切字节、字符和字段并将这些字节、字符和字段写至标准输出。
#cut -f1  将这行按照空格？分隔之后选择第1个字段，就是clang-3.6
#cut -d '-' -f2  按照-分隔，选择第2个字段就是3.6   从而得到版本号
# ```shell
# $ dpkg --get-selections | grep clang | grep -v -m1 libclang
# clang-3.6					install
# $ dpkg --get-selections | grep clang | grep -v -m1 libclang | cut -f1
# clang-3.6
# $ dpkg --get-selections | grep clang | grep -v -m1 libclang | cut -f6
# install
# $ dpkg --get-selections | grep clang | grep -v -m1 libclang | cut -f1 | cut -d '-' -f2
# 3.6
# $ dpkg --get-selections | grep clang | grep -v -m1 libclang | cut -f1 | cut -d '-' -f1
# clang
# ```
#把每一步命令都运行一遍就知道用途了。
if [ -z $clang_bin ]; then
    clang_ver=`dpkg --get-selections | grep clang | grep -v -m1 libclang | cut -f1 | cut -d '-' -f2`
    clang_bin="clang-$clang_ver"#把版本号存到变量，把版本号添加到clangC编译器和clang编译器
    clang_xx_bin="clang++-$clang_ver"
fi

echo "Will use clang [$clang_bin] and clang++ [$clang_xx_bin]"
#echo用来输出信息

mkdir -p build.clang && cd build.clang && \
    cmake .. -DCMAKE_C_COMPILER=$clang_bin -DCMAKE_CXX_COMPILER=$clang_xx_bin && make
