# 视觉笔记CMake（七） **Including Third Party Library**



本CMake系列是依据github上的cmake-examples进行翻译总结。同时对于不懂的地方进行总结与标注。希望本系列能节省你学习CMake的时间。

学习方式是在实践中利用github上的example学习，同时对于不懂的地方主要通过翻译官方手册学习，其次是查找博客上的私人理解。

因为每一个example都是一个工程，所以讲解时会利用文件树解释每一个文件里的语法。

[英文github地址](https://github.com/ttroy50/cmake-examples)：https://github.com/ttroy50/cmake-examples

CMake英文官方教程： https://cmake.org/cmake/help/latest/guide/tutorial/index.html 

[TOC]

## 一  文件树

```tree
├── CMakeLists.txt
├── main.cpp
```

### 1.1  main.cpp

```c++
#include <iostream>
#include <boost/shared_ptr.hpp>
#include <boost/filesystem.hpp>
/*Boost库是为C++语言标准库提供扩展的一些C++程序库的总称，由Boost社区组织开发、
维护。Boost库可以与C++标准库完美共同工作，并且为其提供扩展功能。
*/
int main(int argc, char *argv[])
{
    std::cout << "Hello Third Party Include!" << std::endl;

    // use a shared ptr
    boost::shared_ptr<int> isp(new int(4));

    // trivial use of boost filesystem
    boost::filesystem::path path = "/usr/share/cmake/modules";
    if(path.is_relative())
    {
        std::cout << "Path is relative" << std::endl;
    }
    else
    {
        std::cout << "Path is not relative" << std::endl;
    }

   return 0;
}


```

### 1.2  CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.5)

# Set the project name
project (third_party_include)
# find a boost install with the libraries filesystem and system
#使用库文件系统和系统查找boost install
find_package(Boost 1.46.1 REQUIRED COMPONENTS filesystem system)
#这是第三方库，而不是自己生成的静态动态库
# check if boost was found
if(Boost_FOUND)
    message ("boost found")
else()
    message (FATAL_ERROR "Cannot find Boost")
endif()

# Add an executable
add_executable(third_party_include main.cpp)

# link against the boost libraries
target_link_libraries( third_party_include
    PRIVATE
        Boost::filesystem
)

```

## 二  CMake解析

 几乎所有不平凡的项目都将要求包含第三方库，头文件或程序。 CMake支持使用find_package（）函数查找这些工具的路径。 这将从CMAKE_MODULE_PATH中的文件夹列表中搜索格式为“ FindXXX.cmake”的CMake模块。 在linux上，默认搜索路径将是/ usr / share / cmake / Modules。 在我的系统上，这包括对大约142个通用第三方库的支持。 

 此示例要求将Boost库安装在默认系统位置。 

### 2.1  Finding a Package

 如上所述，find_package（）函数将从CMAKE_MODULE_PATH中的文件夹列表中搜索“ FindXXX.cmake”中的CMake模块。 find_package参数的确切格式取决于要查找的模块。 这通常记录在FindXXX.cmake文件的顶部。 

```cmake
find_package(Boost 1.46.1 REQUIRED COMPONENTS filesystem system)
```

参数：

 Boost-库名称。 这是用于查找模块文件FindBoost.cmake的一部分 

 1.46.1 - 需要的boost库最低版本 

 REQUIRED - 告诉模块这是必需的，如果找不到会报错

 COMPONENTS - 要查找的库列表。从后面的参数代表的库里找boost 

 可以使用更多参数，也可以使用其他变量。 在后面的示例中提供了更复杂的设置。 

### 2.2 Checking if the package is found

大多数被包含的包将设置变量XXX_FOUND，该变量可用于检查软件包在系统上是否可用。

在此示例中，变量为Boost_FOUND：

```cmake
if(Boost_FOUND)
    message ("boost found")
    include_directories(${Boost_INCLUDE_DIRS})
else()
    message (FATAL_ERROR "Cannot find Boost")
endif()
```

###  2.3  Exported Variables

  找到包后，它会自动导出变量，这些变量可以通知用户在哪里可以找到库，头文件或可执行文件。 与XXX_FOUND变量类似，它们与包绑定在一起，通常记录在FindXXX.cmake文件的顶部。 

 本例中的变量 

	Boost_INCLUDE_DIRS - boost头文件的路径

 在某些情况下，您还可以通过使用ccmake或cmake-gui检查缓存来检查这些变量。 

###  2.4  Alias / Imported targets别名/导入目标

 大多数modern CMake库在其模块文件中导出别名目标。  导入目标的好处是它们也可以填充包含目录和链接的库。  例如，从CMake v3.5开始，Boost模块支持此功能。 与使用自己的别名目标相似，模块中的别名可以使引用找到的目标变得更加容易。  对于Boost，所有目标均使用Boost ::标识符，然后使用子系统名称导出。 例如，您可以使用： 

- `Boost::boost` for header only libraries
- `Boost::system` for the boost system library.
- `Boost::filesystem` for filesystem library.

 与您自己的目标一样，这些目标包括它们的依赖关系，因此与Boost :: filesystem链接将自动添加Boost :: boost和Boost :: system依赖关系。 

 要链接到导入的目标，可以使用以下命令： 

```cmake
target_link_libraries( third_party_include
      PRIVATE
          Boost::filesystem
  )
```

###  2.5  Non-alias targets

 尽管大多数现代库都使用导入的目标，但并非所有模块都已更新。 如果未更新库，则通常会发现以下可用变量： 

- xxx_INCLUDE_DIRS - 指向库的包含目录的变量。

- xxx_LIBRARY - 指向库路径的变量。

	 然后可以将它们添加到您的target_include_directories和target_link_libraries中，如下所示： 

	```cmake
	# Include the boost headers
	target_include_directories( third_party_include
	    PRIVATE ${Boost_INCLUDE_DIRS}
	)
	
	# link against the boost libraries
	target_link_libraries( third_party_include
	    PRIVATE
	    ${Boost_SYSTEM_LIBRARY}
	    ${Boost_FILESYSTEM_LIBRARY}
	)
	```

	

## 三  构建示例

```bash
$ mkdir build

$ cd build/

$ cmake .. — The C compiler identification is GNU 4.8.4 — The CXX compiler identification is GNU 4.8.4 — Check for working C compiler: /usr/bin/cc — Check for working C compiler: /usr/bin/cc — works — Detecting C compiler ABI info — Detecting C compiler ABI info - done — Check for working CXX compiler: /usr/bin/c -- Check for working CXX compiler: /usr/bin/c — works — Detecting CXX compiler ABI info — Detecting CXX compiler ABI info - done — Boost version: 1.54.0 — Found the following Boost libraries: —  filesystem —  system boost found — Configuring done — Generating done — Build files have been written to: /home/matrim/workspace/cmake-examples/01-basic/H-third-party-library/build

$ make Scanning dependencies of target third_party_include [100%] Building CXX object CMakeFiles/third_party_include.dir/main.cpp.o Linking CXX executable third_party_include [100%] Built target third_party_include matrim@freyr:~/workspace/cmake-examples/01-basic/H-third-party-library/build$ ./ CMakeFiles/ third_party_include matrim@freyr:~/workspace/cmake-examples/01-basic/H-third-party-library/build$ ./third_party_include Hello Third Party Include! Path is not relative $ cmake .. — The C compiler identification is GNU 4.8.4 — The CXX compiler identification is GNU 4.8.4 — Check for working C compiler: /usr/bin/cc — Check for working C compiler: /usr/bin/cc — works — Detecting C compiler ABI info — Detecting C compiler ABI info - done — Check for working CXX compiler: /usr/bin/c -- Check for working CXX compiler: /usr/bin/c — works — Detecting CXX compiler ABI info — Detecting CXX compiler ABI info - done — Boost version: 1.54.0 — Found the following Boost libraries: —  filesystem —  system boost found — Configuring done — Generating done — Build files have been written to: /home/matrim/workspace/cmake-examples/01-basic/H-third-party-library/build

$ make Scanning dependencies of target third_party_include [100%] Building CXX object CMakeFiles/third_party_include.dir/main.cpp.o Linking CXX executable third_party_include [100%] Built target third_party_include

$ ./third_party_include Hello Third Party Include! Path is not relative
```



## 微信公众号

欢迎大家关注我的个人公众号，现阶段主要总结Robomaster相关的计算机视觉知识：Qt，C++，CMake,OpenCV等等
公众号名称：三丰杂货铺



![在这里插入图片描述](https://img-blog.csdnimg.cn/20200529103009878.gif#pic_center)

