# RoboMaster视觉笔记CMake（四）Shared Library



本CMake系列是依据github上的cmake-examples进行翻译总结。同时对于不懂的地方进行总结与标注。希望本系列能节省你学习CMake的时间。

[英文github地址](https://github.com/ttroy50/cmake-examples)：https://github.com/ttroy50/cmake-examples

CMake英文官方教程： https://cmake.org/cmake/help/latest/guide/tutorial/index.html 

[TOC]

本文自己创建动态库的操作，应该暂时用不到。但是关于如何添加路径，链接库的命令，还是需要掌握的。

## 一  文件树

```tree
├── CMakeLists.txt
├── include
│   └── shared
│       └── Hello.h
└── src
    ├── Hello.cpp
    └── main.cpp
```

### 1.1  Hello.h

```c++
/*声明了Hello类，Hello的方法是print(),*/
#ifndef __HELLO_H__
#define __HELLO_H__

class Hello
{
public:
    void print();
};

#endif

```

### 1.2  Hello.cpp

```c++
/*实现了Hello::print()*/
#include <iostream>

#include "shared/Hello.h"

void Hello::print()
{
    std::cout << "Hello Shared Library!" << std::endl;
}


```

### 1.3  main.cpp

```c
#include "shared/Hello.h"

int main(int argc, char *argv[])
{
    Hello hi;
    hi.print();
    return 0;
}

```

### 1.4  CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.5)
project(hello_library)
############################################################
# Create a library
############################################################
#根据Hello.cpp生成动态库
add_library(hello_library SHARED 
    src/Hello.cpp
)
#给动态库hello_library起一个别的名字hello::library
add_library(hello::library ALIAS hello_library)
#为这个库目标，添加头文件路径，PUBLIC表示包含了这个库的目标也会包含这个路径
target_include_directories(hello_library
    PUBLIC 
        ${PROJECT_SOURCE_DIR}/include
)
############################################################
# Create an executable
############################################################
#根据main.cpp生成可执行文件
add_executable(hello_binary
    src/main.cpp
)
#链接库和可执行文件，使用的是这个库的别名。PRIVATE 表示
target_link_libraries( hello_binary
    PRIVATE 
        hello::library
)

```

## 二  CMake解析

### 2.1  创建动态库

add_library（）函数用于从某些源文件创建一个动态库，默认生成在构建文件夹。 写法如下：

```cmake
add_library(hello_library SHARED
    src/Hello.cpp
)
```

在add_library调用中包含了源文件，用于创建名称为libhello_library.so的动态库。

| NOTE | 如前面的示例所述，将源文件直接传递给add_library调用，这是modern CMake的建议。（而不是先把Hello.cpp赋给一个变量） |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

### 2.2  创建别名目标

 顾名思义，别名目标是在只读上下文中可以代替真实目标名称的替代名称。 

```cmake
add_library(hello::library ALIAS hello_library)
```

 如下所示，当您将目标链接到其他目标时，使用别名可以引用目标。 

 链接共享库与链接静态库相同。 创建可执行文件时，请使用target_link_library（）函数指向您的库 。

```cmake
add_executable(hello_binary
    src/main.cpp
)

target_link_libraries(hello_binary
    PRIVATE
        hello::library
)
```

 这告诉CMake使用别名目标名称将hello_library链接到hello_binary可执行文件。 

## 三  构建示例

```bash
$ mkdir build

$ cd build

$ cmake ..
-- The C compiler identification is GNU 4.8.4
-- The CXX compiler identification is GNU 4.8.4
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Configuring done
-- Generating done
-- Build files have been written to: /home/matrim/workspace/cmake-examples/01-basic/D-shared-library/build

$ make
Scanning dependencies of target hello_library
[ 50%] Building CXX object CMakeFiles/hello_library.dir/src/Hello.cpp.o
Linking CXX shared library libhello_library.so
[ 50%] Built target hello_library
Scanning dependencies of target hello_binary
[100%] Building CXX object CMakeFiles/hello_binary.dir/src/main.cpp.o
Linking CXX executable hello_binary
[100%] Built target hello_binary

$ ls
CMakeCache.txt  CMakeFiles  cmake_install.cmake  hello_binary  libhello_library.so  Makefile

$ ./hello_binary
Hello Shared Library!
```



## 微信公众号

欢迎大家关注我的个人公众号，现阶段主要总结Robomaster相关的计算机视觉知识。
公众号名称：三丰杂货铺
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200316110807276.jpg)