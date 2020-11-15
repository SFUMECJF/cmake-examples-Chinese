# RoboMaster视觉教程CMake（三）Static Library



本CMake系列是依据github上的cmake-examples进行翻译总结。同时对于不懂的地方进行总结与标注。希望本系列能节省你学习CMake的时间。

[英文github地址](https://github.com/ttroy50/cmake-examples)：https://github.com/ttroy50/cmake-examples

CMake英文官方教程： https://cmake.org/cmake/help/latest/guide/tutorial/index.html 

[TOC]

本文自己创建库的操作，应该暂时用不到。但是关于如何添加路径，链接库的命令，还是需要掌握的。

## 一  文件树

```tree
├── CMakeLists.txt
├── include
│   └── static
│       └── Hello.h
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

#include "static/Hello.h"

void Hello::print()
{
    std::cout << "Hello Static Library!" << std::endl;
}

```

### 1.3  main.cpp

```c
#include "static/Hello.h"

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
#库的源文件Hello.cpp生成静态库hello_library
add_library(hello_library STATIC 
    src/Hello.cpp
)
target_include_directories(hello_library
    PUBLIC 
        ${PROJECT_SOURCE_DIR}/include
)
# target_include_directories为一个目标（可能是一个库library也可能是可执行文件）添加头文件路径。
############################################################
# Create an executable
############################################################
# Add an executable with the above sources
#指定用哪个源文件生成可执行文件
add_executable(hello_binary 
    src/main.cpp
)
#链接可执行文件和静态库
target_link_libraries( hello_binary
    PRIVATE 
        hello_library
)
#链接库和包含头文件都有关于scope这三个关键字的用法。
```

## 二  CMake解析

### 2.1  创建静态库

add_library（）函数用于从某些源文件创建一个库，默认生成在构建文件夹。 写法如下：

```cmake
add_library(hello_library STATIC
    src/Hello.cpp
)
```

在add_library调用中包含了源文件，用于创建名称为libhello_library.a的静态库。

| NOTE | 如前面的示例所述，将源文件直接传递给add_library调用，这是modern CMake的建议。（而不是先把Hello.cpp赋给一个变量） |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

### 2.2  添加头文件所在的目录

使用target_include_directories（）添加了一个目录，这个目录是库所包含的头文件的目录，并设置库属性为PUBLIC。

```cmake
target_include_directories(hello_library
    PUBLIC
        ${PROJECT_SOURCE_DIR}/include
)
```

This will cause the included directory used in the following places:

使用这个函数后，这个目录会在以下情况被调用：

- 编译这个库的时候

	因为这个库hello_library由Hello.cpp生成，Hello.cpp中函数的定义在Hello.h中，Hello.h在这个include目录下，所以显然编译这个库的时候，这个目录会用到

- 编译链接到这个库hello_library的任何其他目标（库或者可执行文件）

#### 2.2.1  private pubic interface的范围详解

> 大家如果去搜索，会发现解释杂乱无章。大部分解释是这样：
>
> 如果目标的头文件中包含了依赖的头文件(源文件间接包含)，那么这里就是PUBLIC
> 如果目标仅源文件中包含了依赖的头文件，那么这里就是PRIVATE
> 如果目标的头文件包含依赖，但源文件未包含，那么这里就是INTERFACE
>
> 或者是这样：
>
> 当创建动态库时，
>
> 如果源文件(例如CPP)中包含第三方头文件，但是头文件（例如hpp）中不包含该第三方文件头，采用PRIVATE。
> 	如果源文件和头文件中都包含该第三方文件头，采用PUBLIC。
> 	如果头文件中包含该第三方文件头，但是源文件(例如CPP)中不包含，采用 INTERFACE。

<mark>我个人认为上面的说法是错误的。</mark>

正确理解：

- PRIVATE - 目录被添加到目标（库）的包含路径中。
- INTERFACE - 目录没有被添加到目标（库）的包含路径中，而是链接了这个库的其他目标（库或者可执行程序）包含路径中
- PUBLIC - 目录既被添加到目标（库）的包含路径中，同时添加到了链接了这个库的其他目标（库或者可执行程序）的包含路径中

也就是说，根据库是否包含这个路径，以及调用了这个库的其他目标是否包含这个路径，可以分为三种scope。

​                                                                                         <mark>建议！</mark>

**对于公共的头文件，最好在include文件夹下建立子目录。 **

**传递给函数target_include_directories()的目录，应该是所有包含目录的根目录，然后在这个根目录下建立不同的文件夹，分别写头文件。**

**这样使用的时候，不需要写${PROJECT_SOURCE_DIR}/include，而是直接选择对应的文件夹里对应头文件。下面是例子：`#include "static/Hello.h"`而不是`#include "Hello.h"`使用此方法意味着在项目中使用多个库时，头文件名冲突的可能性较小。**

### 2.3  链接库

创建将使用这个库的可执行文件时，必须告知编译器需要用到这个库。 可以使用target_link_library（）函数完成此操作。add_executable()连接源文件，target_link_libraries()连接库文件。

```cmake
add_executable(hello_binary
    src/main.cpp
)

target_link_libraries( hello_binary
    PRIVATE
        hello_library
)
```

这告诉CMake在链接期间将hello_library链接到hello_binary可执行文件。 同时，这个被链接的库如果有INTERFACE或者PUBLIC属性的包含目录，那么，这个包含目录也会被传递（ propagate ）给这个可执行文件。

An example of this being called by the compiler is

```
/usr/bin/c++ CMakeFiles/hello_binary.dir/src/main.cpp.o -o hello_binary -rdynamic libhello_library.a
```

官方英文文档关于这三个范围的理解： https://cmake.org/cmake/help/v3.0/command/target_include_directories.html 

对于target_link_libraries( hello_binary
    PRIVATE
        hello_library
)这个命令中的scope关键字，private，public以及interface

可以举例理解：

public是说，你的这个工程如果被link了，那你的target_link_libraries指定的lib也会被链
private是说，你link的这些libs不会被暴露出去。

比如你的工程B是个dll，public连接了C, D
这个时候你的A.exe要链接B，那么它也会链接C和D
如果B是private链接了C, D
那么A链B的时候，不会链C和D

那么，A.exe链接B的时候，其实也有public和private的选项，但是因为没有其他东西链接A，所以不起作用。
这个主要是针对其它工程链自己的设置

对于hello_binary，它不是库，所以不会被链接。直接private自己用这个库就行。

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
-- Build files have been written to: /home/matrim/workspace/cmake-examples/01-basic/C-static-library/build

$ make
Scanning dependencies of target hello_library
[ 50%] Building CXX object CMakeFiles/hello_library.dir/src/Hello.cpp.o
Linking CXX static library libhello_library.a
[ 50%] Built target hello_library
Scanning dependencies of target hello_binary
[100%] Building CXX object CMakeFiles/hello_binary.dir/src/main.cpp.o
Linking CXX executable hello_binary
[100%] Built target hello_binary

$ ls
CMakeCache.txt  CMakeFiles  cmake_install.cmake  hello_binary  libhello_library.a  Makefile

$ ./hello_binary
Hello Static Library!
```



## 微信公众号

欢迎大家关注我的个人公众号，现阶段主要总结Robomaster相关的计算机视觉知识。
公众号名称：三丰杂货铺
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200316110807276.jpg)