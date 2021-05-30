这三个属性在不同命令中有不同的含义。
我把它总结为一个表格，如果看不太明白，再看下方的翻译。

![在这里插入图片描述](https://gitee.com/umecjf/figures/raw/master/2020051109320685.png)



下面的内容均来自Cmake英文官方手册。主要是翻译了三处CMake手册的介绍。


对于target_link_libraries（）我认为这三个变量是用来控制库传递过程中，库所包含的依赖是否也能被连接到这个库的其他目标所包含。同时，这个手册建议，根据库的cpp以及库的h(注意不是工程)是否用到依赖，来设置这个依赖的scope范围。

对于target_include_directories()这三个关键词设置了这个目录A会被包含到目标B的哪个属性，同时，在使用target_link_libraries（）将目标B链接给目标C的时候，B所包含的目录也会因为关键字的设置而决定是否能被C包含。

英文原文：

https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#build-specification-and-usage-requirements
英文翻译：

传递用法要求
目标的使用要求可以传递给依赖对象。 target_link_libraries（）命令具有PRIVATE，INTERFACE和PUBLIC关键字来控制传播使用要求。

```c
add_library(archive archive.cpp)
target_compile_definitions(archive INTERFACE USING_ARCHIVE_LIB)

add_library(serialization serialization.cpp)
target_compile_definitions(serialization INTERFACE USING_SERIALIZATION_LIB)

add_library(archiveExtras extras.cpp)
target_link_libraries(archiveExtras PUBLIC archive)
target_link_libraries(archiveExtras PRIVATE serialization)
# archiveExtras is compiled with -DUSING_ARCHIVE_LIB
# and -DUSING_SERIALIZATION_LIB

add_executable(consumer consumer.cpp)
# consumer is compiled with -DUSING_ARCHIVE_LIB
target_link_libraries(consumer archiveExtras)
```

因为`archive`库是目标`archiveExtras`的PUBLIC依赖项，所以它（`archive`）的使用要求也传播到了`consumer`。因为`serialization`是`archiveExtras`的`PRIVATE`依赖项，所以它（`serialization`）的使用要求不会传播到`consumer`。
通常，如果只有库的实现而不是头文件使用了依赖项（生成库的cpp文件中使用依赖项，但是库所包含的头文件没有包含依赖项），则应在使用target_link_libraries（）时用PRIVATE关键字指定依赖项。如果在库的头文件中还使用了依赖项（例如，用于类继承），则应将其指定为PUBLIC依赖项。库的实现不使用依赖项，而是仅由其头文件使用的依赖项应指定为INTERFACE依赖项。

可以通过多次使用每个关键字来调用target_link_libraries（）命令：

```cmake
target_link_libraries(archiveExtras
  PUBLIC archive
  PRIVATE serialization
)
```
英文原文：
https://cmake.org/cmake/help/latest/command/target_include_directories.html 
英文翻译：
target_include_directories
将包含目录添加到目标。

```cmake
target_include_directories(<target> [SYSTEM] [BEFORE]
  <INTERFACE|PUBLIC|PRIVATE> [items1...]
  [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```

在编译给定目标时,要指定包含目录。<target>必须由诸如add_executable（）或add_library（）之类的命令创建，并且不能为ALIAS(别名)目标。

如果指定了BEFORE，则内容将被添加到该属性的前面，而不是被附加。

INTERFACE，PUBLIC和PRIVATE关键字来指定以下参数的范围。 PRIVATE和PUBLIC项目将放到<target>的INCLUDE_DIRECTORIES变量里。 PUBLIC和INTERFACE项目将放到<target>的INTERFACE_INCLUDE_DIRECTORIES变量里。 （导入的目标仅支持INTERFACE项。）以下参数指定包含目录。

指定的包含目录可以是绝对路径或相对路径。对相同<target>的重复调用将按调用顺序追加项目。如果指定了SYSTEM，则会在某些平台上告知编译器目录为系统包含目录（对此设置进行信号化可能会产生效果，例如编译器跳过警告，或者在依赖性计算中不考虑这些固定安装的系统文件-请参阅编译器文档）。如果将SYSTEM与PUBLIC或INTERFACE一起使用，则INTERFACE_SYSTEM_INCLUDE_DIRECTORIES目标属性将使用指定的目录填充。


英文原文：
 https://cmake.org/cmake/help/latest/command/target_link_libraries.html?highlight=target_link_libraries#libraries-for-both-a-target-and-its-dependents 
 英文翻译：
```cmake
target_link_libraries(<target> <item>...)
```

默认情况下，使用这个函数（signature）的库依赖关系是可传递的（我认为默认是PUBLIC关键词）。 当这个目标（假设为库A，我认为不是库无法被链接，所以如果这是一个单纯的可执行文件，那么这个scope关键词就没有意义）被链接到另一个目标（目标B）时，链接到这个目标（库A）的库也可以被另一个目标（目标B）链接上。

这个可传递的“链接接口”存储在INTERFACE_LINK_LIBRARIES目标属性中，可以直接设置该属性。 当CMP0022未设置为NEW时，将建立传递链接，但可被LINK_INTERFACE_LIBRARIES属性覆盖。 调用此命令的其他签名可能会设置该属性，从而使由该签名专有链接的任何库都变为私有。

欢迎关注我的公众号一起交流讨论：
公众号名称：三丰杂货铺
![在这里插入图片描述](https://gitee.com/umecjf/figures/raw/master/2020051109320685.png)