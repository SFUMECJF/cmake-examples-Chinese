# Set the minimum version of CMake that can be used
#设置CMake最小版本
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.5)

# Set the project name
#设置工程名
project (reconstruction)



#注意，在一个大工程里，这几个开关一定要尽量放在前面打开，否则有可能会报无法生成ui文件的错误
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
#注意，在一个大工程里，这几个开关一定要尽量放在前面打开，否则有可能会报无法生成ui文件的错误
#set(CMAKE_PREFIX_PATH "~/Qt5.9.9/5.9.9/gcc_64/")#为了不在Qt creator这个软件中也能CMake找到Qt的库

# 1 find qt
find_package(Qt5 COMPONENTS Widgets Gui REQUIRED)
#get_target_property(QtCore_location Qt5::Widgets LOCATION)
find_package(Qt5 COMPONENTS Core REQUIRED)
#get_target_property(QtCore_location Qt5::Core LOCATION)
#find_package(pthread REQUIRED)
# Add an executable
#生成可执行文件

# 2 find open cv
#FIND_PACKAGE( OpenCV REQUIRED )
find_package(OpenCV CONFIG REQUIRED PATHS)
MESSAGE("OpenCV version : ${OpenCV_VERSION}")
include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIB_DIR})
MESSAGE("OpenCV_LIB_DIR : ${OpenCV_LIB_DIR}")
MESSAGE("OpenCV_LIBS : ${OpenCV_LIBS}")

# add exe
add_executable(reconstruction main.cpp mainwindow.cpp mainwindow.h mainwindow.ui)
#
target_link_libraries(reconstruction Qt5::Core Qt5::Widgets Qt5::Gui)

target_link_directories(reconstruction PUBLIC
    ${OpenCV_LIB_DIRS}
    )
target_link_libraries(reconstruction
    ${OpenCV_LIBS}
    )
target_include_directories(reconstruction PUBLIC
    ${OpenCV_INCLUDE_DIRS}
    )
MESSAGE("OpenCV_INCLUDE_DIRS : ${OpenCV_INCLUDE_DIRS}")

#在这里，为目标链接了/usr/lib/x86_64-linux-gnu/libpthread.so
#如果不链接就会报错，这是系统里的库，直接链接就行。
#如果是用的.pro文件，则在里面加上LIBS+=/usr/lib/x86_64-linux-gnu/libpthread.so
#target_link_libraries(hello_cmake pthread)
