# Set the minimum version of CMake that can be used
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.1)

# Set the project name
project (hello_cpp11)

# Add an executable
add_executable(hello_cpp11 main.cpp)

# set the C++ standard to the appropriate standard for using auto
#将C ++标准设置为使用auto的适当标准
target_compile_features(hello_cpp11 PUBLIC cxx_auto_type)

# Print the list of known compile features for this version of CMake
#打印此版本CMake的已知编译功能列表
message("List of compile features: ${CMAKE_CXX_COMPILE_FEATURES}")
