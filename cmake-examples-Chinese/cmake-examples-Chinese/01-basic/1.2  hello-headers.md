# RoboMaster视觉教程CMake(二)hello-headers



本CMake系列是依据github上的cmake-examples进行翻译总结。同时对于不懂的地方进行总结与标注。希望本系列能节省你学习CMake的时间。

[英文github地址](https://github.com/ttroy50/cmake-examples)：https://github.com/ttroy50/cmake-examples

[TOC]

## 一  文件树

```tree
├── CMakeLists.txt
├── include
│   └── Hello.h
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

#include "Hello.h"

void Hello::print()
{
    std::cout << "Hello Headers!" << std::endl;
}
```

### 1.3  main.cpp

```c
#include "Hello.h"

int main(int argc, char *argv[])
{
    Hello hi;
    hi.print();
    return 0;
}
```

### 1.4  CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.5)#最低CMake版本

project (hello_headers)# 工程名

set(SOURCES
    src/Hello.cpp
    src/main.cpp
)#创建一个变量，名字叫SOURCE。它包含了所有的cpp文件。

add_executable(hello_headers ${SOURCES})#用所有的源文件生成一个可执行文件，因为这里定义了SOURCE变量，所以就不需要罗列cpp文件了
#等价于命令：     add_executable(hello_headers src/Hello.cpp src/main.cpp)

target_include_directories(hello_headers
    PRIVATE 
        ${PROJECT_SOURCE_DIR}/include
)#设置这个可执行文件hello_headers需要包含的库的路径


#PROJECT_SOURCE_DIR指工程顶层目录
#PROJECT_Binary_DIR指编译目录
#PRIVATE指定了库的范围，下一节讲
```

## 二  CMake解析

### 2.1  各种可用变量

CMake语法指定了许多变量，可用于帮助您在项目或源代码树中找到有用的目录。 其中一些包括：

| Variable                 | Info                                                       |
| :----------------------- | :--------------------------------------------------------- |
| CMAKE_SOURCE_DIR         | 根源代码目录，工程顶层目录。暂认为就是PROJECT_SOURCE_DIR   |
| CMAKE_CURRENT_SOURCE_DIR | 当前处理的 CMakeLists.txt 所在的路径                       |
| PROJECT_SOURCE_DIR       | 工程顶层目录                                               |
| CMAKE_BINARY_DIR         | 运行cmake的目录。外部构建时就是build目录                   |
| CMAKE_CURRENT_BINARY_DIR | The build directory you are currently in.当前所在build目录 |
| PROJECT_BINARY_DIR       | 暂认为就是CMAKE_BINARY_DIR                                 |

想仔细体会一下，可以在CMakeLists中，利用message（）命令输出一下这些变量。

另外，这些变量不仅可以在CMakeLists中使用，同样可以在源代码.cpp中使用。

### 2.2  源文件变量(不建议！)

创建一个包含源文件的变量，以便于将其轻松添加到多个命令中，例如add_executable（）函数。

```cmake
set(SOURCES
    src/Hello.cpp
    src/main.cpp
)

add_executable(${PROJECT_NAME} ${SOURCES})
```

在SOURCES变量中设置特定文件名的另一种方法是使用GLOB命令使用通配符模式匹配来查找文件。`file(GLOB SOURCES "src/*.cpp")`使用*这个通配符，表示所有.cpp结尾的文件都会包含到这个SOURCES变量。

对于modern CMake，<mark>不建议对源文件使用变量。</mark> 不建议使用glob。

相反，通常直接在add_xxx函数中声明源文件。 

这对于glob命令尤其重要，如果添加新的源文件，这些命令可能不会始终为您显示正确的结果。在CMake中指定源文件的最佳方法是明确列出它们。



### 2.3  包含目录

当您有其他需要包含的文件夹（文件夹里有头文件）时，可以使用以下命令使编译器知道它们： target_include_directories（）。 编译此目标时，这将使用-I标志将这些目录添加到编译器中，例如 -I /目录/路径

```cmake
target_include_directories(target
    PRIVATE
        ${PROJECT_SOURCE_DIR}/include
)
```

PRIVATE  标识符指定包含的范围。 这对库很重要，将在下一个示例中进行说明。 有关该功能的更多详细信息，请参见以下链接：https：//cmake.org/cmake/help/v3.0/command/target_include_directories.html 

### 2.4  详细输出

在前面的示例中，运行make命令时，输出仅显示构建状态。 要查看用于调试目的的完整输出，可以在运行make时添加VERBOSE = 1标志。

下面的代码是使用VERBOSE的命令

```shell
mkdir build
cd build/
cmake ..
make VERBOSE=1
```

 没有VERBOSE：

```shell
make
Scanning dependencies of target hello_headers
[ 50%] Building CXX object CMakeFiles/hello_headers.dir/src/Hello.cpp.o
[100%] Building CXX object CMakeFiles/hello_headers.dir/src/main.cpp.o
Linking CXX executable hello_headers
[100%] Built target hello_headers
```

有VERBOSE：

```shell
make VERBOSE=1
/usr/bin/cmake -H/home/matrim/workspace/cmake-examples/01-basic/hello_headers -B/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build --check-build-system CMakeFiles/Makefile.cmake 0
/usr/bin/cmake -E cmake_progress_start /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles/progress.marks
make -f CMakeFiles/Makefile2 all
make[1]: Entering directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
make -f CMakeFiles/hello_headers.dir/build.make CMakeFiles/hello_headers.dir/depend
make[2]: Entering directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
cd /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build && /usr/bin/cmake -E cmake_depends "Unix Makefiles" /home/matrim/workspace/cmake-examples/01-basic/hello_headers /home/matrim/workspace/cmake-examples/01-basic/hello_headers /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles/hello_headers.dir/DependInfo.cmake --color=
make[2]: Leaving directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
make -f CMakeFiles/hello_headers.dir/build.make CMakeFiles/hello_headers.dir/build
make[2]: Entering directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
/usr/bin/cmake -E cmake_progress_report /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles 1
[ 50%] Building CXX object CMakeFiles/hello_headers.dir/src/Hello.cpp.o
/usr/bin/c++    -I/home/matrim/workspace/cmake-examples/01-basic/hello_headers/include    -o CMakeFiles/hello_headers.dir/src/Hello.cpp.o -c /home/matrim/workspace/cmake-examples/01-basic/hello_headers/src/Hello.cpp
/usr/bin/cmake -E cmake_progress_report /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles 2
[100%] Building CXX object CMakeFiles/hello_headers.dir/src/main.cpp.o
/usr/bin/c++    -I/home/matrim/workspace/cmake-examples/01-basic/hello_headers/include    -o CMakeFiles/hello_headers.dir/src/main.cpp.o -c /home/matrim/workspace/cmake-examples/01-basic/hello_headers/src/main.cpp
Linking CXX executable hello_headers
/usr/bin/cmake -E cmake_link_script CMakeFiles/hello_headers.dir/link.txt --verbose=1
/usr/bin/c++       CMakeFiles/hello_headers.dir/src/Hello.cpp.o CMakeFiles/hello_headers.dir/src/main.cpp.o  -o hello_headers -rdynamic
make[2]: Leaving directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
/usr/bin/cmake -E cmake_progress_report /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles  1 2
[100%] Built target hello_headers
make[1]: Leaving directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
/usr/bin/cmake -E cmake_progress_start /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles 0
```





## 微信公众号

欢迎大家关注我的个人公众号，现阶段主要总结Robomaster相关的计算机视觉知识。
公众号名称：三丰杂货铺
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200316110807276.jpg)