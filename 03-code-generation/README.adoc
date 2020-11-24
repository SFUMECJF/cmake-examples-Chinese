= Code Generation - 代码生成

 Code generation can be useful to create source code in different languages from a common description file. This can reduce the amount of manual code to write and increase interoperability.

代码生成是一个很好用的功能，它可以使用一份公共的描述文件，生成不同语言下的源代码。这个功能使得需要人工编写的代码大幅减少，同时也增加了互操作性。


 Examples showing code generation using variables from CMake and also using some common tools.

下面的例子展示了如何使用CMake变量和其他常用的工具进行代码生成。

  * link:configure-files[configure-file]
    ** Using the CMake configure_file function to inject CMake variables.
    ** 使用CMake中的configure_file函数注入CMake变量
  * link:protobuf[Protocol Buffers]
    ** Using Google Protocol Buffers to generate C++ source.
    ** 使用Google Protocol Buffers来生成C++源码
