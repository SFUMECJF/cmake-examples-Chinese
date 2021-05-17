# 寻找CMake的最低版本，必须大于3.5
cmake_minimum_required(VERSION 3.5)

# 设置工程名称
project (hello_cmake)

# 生成可执行文件
add_executable(hello_cmake main.cpp)
