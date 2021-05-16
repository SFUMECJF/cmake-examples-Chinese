# RoboMaster视觉教程CMake(一)hello-cmake

CMake是一个跨平台的安装（编译）工具，可以用简单的语句来描述所有平台的安装(编译过程)。他能够输出各种各样的makefile或者project文件，能测试编译器所支持的C++特性,类似UNIX下的automake。

CMake的学习资料较少，只能通过github的各种例子进行学习。不过仍然建议在学习之前看一下《CMake实践》这本中文书

本CMake系列是依据github上的cmake-examples进行翻译总结。

[英文github地址](https://github.com/ttroy50/cmake-examples)：https://github.com/ttroy50/cmake-examples

[TOC]

## 文件树

```tree
├── CMakeLists.txt

├── main.cpp
```

## main.cpp

```c
#include <iostream>

int main(int argc, char *argv[])
{
   std::cout << "Hello CMake!" << std::endl;
   return 0;
}
```

## CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.5) #设置CMake最小版本
project (hello_cmake) #设置工程名
add_executable(hello_cmake main.cpp) #生成可执行文件
```

## 解析

### 命令作用解析

```cmake
project (hello_cmake) #设置工程名
```

 CMake构建包含一个项目名称，上面的命令会自动生成一些变量，在使用多个项目时引用某些变量会更加容易。

比如生成了： PROJECT_NAME 这个变量。PROJECT_NAME是变量名，${PROJECT_NAME}是变量值，值为hello_cmake

 ```cmake
add_executable(hello_cmake main.cpp) #生成可执行文件
 ```

 add_executable()命令指定某些源文件生成可执行文件，本例中是main.cpp。 add_executable（）函数的第一个参数是可执行文件名，第二个参数是要编译的源文件列表。 

### 生成与工程同名的二进制文件

```cmake
cmake_minimum_required(VERSION 2.6)
project (hello_cmake)
add_executable(${PROJECT_NAME} main.cpp)
```

 project(hello_cmake)函数执行时会生成一个变量，是PROJECT_NAME，${PROJECT_NAME}表示PROJECT_NAME变量的值为hello_cmake,所以把${PROJECT_NAME}用在add_executable()里可以生成可执行文件名字叫hello_cmake 

### 外部构建与内部构建

变量CMAKE_BINARY_DIR指向 cmake命令的根文件夹，所有二进制文件在这个文件夹里产生。 

#### 外部构建（推荐）

 使用外部构建，我们可以创建一个可以位于文件系统上任何位置的构建文件夹。 所有临时构建和目标文件都位于此目录中，以保持源代码树的整洁。

拿本例子来说：

运行下述代码，新建build构建文件夹，并运行cmake命令

```shell
mkdir build
cd build/
cmake ..
```

文件树如下：

```cmake
├── build
│   ├── CMakeCache.txt
│   ├── CMakeFiles
│   │   ├── 2.8.12.2
│   │   │   ├── CMakeCCompiler.cmake
│   │   │   ├── CMakeCXXCompiler.cmake
│   │   │   ├── CMakeDetermineCompilerABI_C.bin
│   │   │   ├── CMakeDetermineCompilerABI_CXX.bin
│   │   │   ├── CMakeSystem.cmake
│   │   │   ├── CompilerIdC
│   │   │   │   ├── a.out
│   │   │   │   └── CMakeCCompilerId.c
│   │   │   └── CompilerIdCXX
│   │   │       ├── a.out
│   │   │       └── CMakeCXXCompilerId.cpp
│   │   ├── cmake.check_cache
│   │   ├── CMakeDirectoryInformation.cmake
│   │   ├── CMakeOutput.log
│   │   ├── CMakeTmp
│   │   ├── hello_cmake.dir
│   │   │   ├── build.make
│   │   │   ├── cmake_clean.cmake
│   │   │   ├── DependInfo.cmake
│   │   │   ├── depend.make
│   │   │   ├── flags.make
│   │   │   ├── link.txt
│   │   │   └── progress.make
│   │   ├── Makefile2
│   │   ├── Makefile.cmake
│   │   ├── progress.marks
│   │   └── TargetDirectories.txt
│   ├── cmake_install.cmake
│   └── Makefile
├── CMakeLists.txt
├── main.cpp
```

可以看到，build文件夹下生成了许多二进制文件，如果要从头开始重新创建cmake环境，只需删除构建目录build，然后重新运行cmake。 非常方便

以后使用外部构建。

#### 内部构建

 内部构件将所有临时文件和源文件生成到一起，没有build，临时文件会和源代码文件在一起。（不推荐） 

## 微信公众号

欢迎大家关注我的个人公众号，现阶段主要总结Robomaster相关的计算机视觉知识。
公众号名称：三丰杂货铺
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200316110807276.jpg)