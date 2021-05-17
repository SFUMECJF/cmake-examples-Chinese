#!/bin/bash
pre_test脚本删除之前配置的build文件，run_test运行clang，生成这次的build.clang文件
#这个脚本的作用是如果存在build.clang这个文件夹，就把它删除掉


ROOT_DIR=`pwd`#shell脚本的语法，pwd输出文件当前所在路径,赋值给ROOT_DIR这个变量
dir="01-basic/I-compiling-with-clang"



#if then fi是shell脚本里的判断语句，如果[]里的条件为真，则执行then后面的语句
#基本格式：
#       if [判断语句]; then
#           执行语句
#       fi
#-d与路径配合，路径存在则为真
#单纯的dir等价于ls -C -b; 也就是说，默认情况下，文件在列中列出，并垂直排序，特殊字符由反斜杠转义序列表示。
#也就是说只要当前历经下存在build.clang就删除掉
本文dir是一个变量
if [ -d "$ROOT_DIR/$dir/build.clang" ]; then
    echo "deleting $dir/build.clang"
    rm -r $dir/build.clang
fi
