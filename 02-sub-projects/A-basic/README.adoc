= 子项目
:toc:
:toc-placement!:

toc::[]

## Introduction

本示例说明如何包含子项目。 顶级CMakeLists.txt调用子目录中的CMakeLists.txt来创建以下内容：

  * sublibrary1 - 一个静态库
  * sublibrary2 - 只有头文件的库
  * subbinary - 一个可执行文件

文件树如下:

```
$ tree
.
├── CMakeLists.txt
├── subbinary
│   ├── CMakeLists.txt
│   └── main.cpp
├── sublibrary1
│   ├── CMakeLists.txt
│   ├── include
│   │   └── sublib1
│   │       └── sublib1.h
│   └── src
│       └── sublib1.cpp
└── sublibrary2
    ├── CMakeLists.txt
    └── include
        └── sublib2
            └── sublib2.h
```

  * link:CMakeLists.txt[] - 最高层的CMakeLists.txt
  * link:subbinary/CMakeLists.txt[] - 生成可执行文件的CMakeLists.txt
  * link:subbinary/main.cpp[] - 可执行文件的源文件
  * link:sublibrary1/CMakeLists.txt[] - 生成静态库的CMakeLists.txt
  * link:sublibrary1/include/sublib1/sublib1.h[]
  * link:sublibrary1/src/sublib1.cpp[]
  * link:sublibrary2/CMakeLists.txt[] - 生成仅有头文件的库的CMakeLists.txt
  * link:sublibrary2/include/sublib2/sublib2.h[]

[提示]
====
在此示例中，我已将头文件移至每个项目include目录下的子文件夹，而将目标include保留为根include文件夹。 这是防止文件名冲突的一个好主意，因为您必须包括以下文件：
[source,cpp]
----
#include "sublib1/sublib1.h"
----

如果您为其他用户安装库，则默认安装位置为/usr/local/include/sublib1/sublib1.h。
====

## 概念

## 添加子目录

CMakeLists.txt文件可以包含和调用包含CMakeLists.txt文件的子目录。

[source,cmake]
----
add_subdirectory(sublibrary1)
add_subdirectory(sublibrary2)
add_subdirectory(subbinary)
----

## 引用子项目目录

使用project（）命令创建项目时，CMake将自动创建许多变量，这些变量可用于引用有关该项目的详细信息。 这些变量然后可以由其他子项目或主项目使用。 例如，要引用您可以使用的其他项目的源目录。

[source,cmake]
----
    ${sublibrary1_SOURCE_DIR}
    ${sublibrary2_SOURCE_DIR}
----
CMake中有一些变量会自动创建:

[cols=",",options="header",]
|=======================================================================
|Variable |Info
|PROJECT_NAME | 当前project（）设置的项目的名称。

|CMAKE_PROJECT_NAME |由project（）命令设置的第一个项目的名称，即顶层项目。

|PROJECT_SOURCE_DIR |当前项目的源文件目录。

|PROJECT_BINARY_DIR |当前项目的构建目录。

|name_SOURCE_DIR |在此示例中，创建的源目录为
`sublibrary1_SOURCE_DIR`,
`sublibrary2_SOURCE_DIR`, and `subbinary_SOURCE_DIR`

|name_BINARY_DIR | 本工程的二进制目录是`sublibrary1_BINARY_DIR`,
`sublibrary2_BINARY_DIR`,和 `subbinary_BINARY_DIR`

|=======================================================================

## Header only Libraries

如果您有一个库被创建为仅头文件的库，则cmake支持INTERFACE目标，以允许创建没有任何构建输出的目标。 可以从link:https://cmake.org/cmake/help/v3.4/command/add_library.html#interface-libraries[here]找到更多详细信息

[source,cmake]
----
add_library(${PROJECT_NAME} INTERFACE)
----
创建目标时，您还可以使用INTERFACE范围包含该目标的目录。 INTERFACE范围用于制定在链接此目标的任何库中使用的目标需求，但在目标本身的编译中不使用。

[source,cmake]
----
target_include_directories(${PROJECT_NAME}
    INTERFACE
        ${PROJECT_SOURCE_DIR}/include
)
----

## 引用子项目中的库

如果子项目创建了一个库，则其他项目可以通过在target_link_libraries（）命令中调用该项目的名称来引用该库。 这意味着您不必引用新库的完整路径，而是将其添加为依赖项。

[source,cmake]
----
target_link_libraries(subbinary
    PUBLIC
        sublibrary1
)
----
或者，您可以创建一个别名目标，该目标允许您在上下文（其实就是某个目标的绰号）中引用该目标。


[source,cmake]
----
add_library(sublibrary2)
add_library(sub::lib2 ALIAS sublibrary2)
----

To reference the alias, just it as follows:
[source,cmake]
----
target_link_libraries(subbinary
    sub::lib2
)
----

## 包含子项目中的目录

从cmake v3开始从子项目添加库时，无需将项目include目录添加到二进制文件的include目录中。


创建库时，这由target_include_directories（）命令中的作用域控制。 在此示例中，因为子二进制可执行文件链接了sublibrary1和sublibrary2库，所以当它们与库的PUBLIC和INTERFACE范围一起导出时，它将自动包含$ {sublibrary1_SOURCE_DIR} / inc和$ {sublibrary2_SOURCE_DIR} / inc文件夹。（这个地方设及到了PUBLIC和INTERFACE的使用，本电子书的CMake-scope是讲这个的）

## 构建示例

[source,bash]
----
$ mkdir build

$ cd build/

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
-- Build files have been written to: /home/matrim/workspace/cmake-examples/02-sub-projects/A-basic/build

$ make
Scanning dependencies of target sublibrary1
[ 50%] Building CXX object sublibrary1/CMakeFiles/sublibrary1.dir/src/sublib1.cpp.o
Linking CXX static library libsublibrary1.a
[ 50%] Built target sublibrary1
Scanning dependencies of target subbinary
[100%] Building CXX object subbinary/CMakeFiles/subbinary.dir/main.cpp.o
Linking CXX executable subbinary
[100%] Built target subbinary

----
