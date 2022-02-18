# Set the minimum version of CMake that can be used
# 设置CMake最小版本
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.19.1)

# Set the project name
# 设置工程名
project(qui)


# 如果设置了环境变量可以省略以下步奏,若没有设置则参照如下路径设置自己的
set(Qt5_DIR "D:/Qt/Qt5.13.2/5.13.2/msvc2017_64/lib/cmake/Qt5")
set(OpenCV_DIR "D:/opencv452/build")
set(Torch_DIR "D:/LibTorch_1.8.2.R/share/cmake/Torch")
# In ubuntu
# set(Qt5_DIR "/home/jedi/Qt5.14.2/5.14.2/gcc_64/lib/cmake/Qt5")
# set(Torch_DIR "/home/jedi/libtorch/share/cmake/Torch")


#注意，在一个大工程里，这几个开关一定要尽量放在前面打开，否则有可能会报无法生成ui文件的错误
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#FIND_PACKAGE(Qt5 COMPONENTS Core Gui Qml Quick Widgets REQUIRED)
FIND_PACKAGE(Qt5 COMPONENTS Core Widgets REQUIRED)


# 2 find open cv
#FIND_PACKAGE( OpenCV REQUIRED )
find_package(OpenCV CONFIG REQUIRED PATHS)
MESSAGE("OpenCV version : ${OpenCV_VERSION}")
include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIB_DIR})
MESSAGE("OpenCV_LIB_DIR : ${OpenCV_LIB_DIR}")
MESSAGE("OpenCV_LIBS : ${OpenCV_LIBS}")

# 3 find libtorch
find_package(Torch REQUIRED)



SET(qui_SOURCES 
	src/main.cpp 
	src/mainwindow.cpp 
)

SET(qui_HEADERS 
	src/mainwindow.h
)

SET(qui_FORMS 
	src/mainwindow.ui
)

#SET(qui_RESOURCES 
#	img.qrc
#)

#调用预编译器moc，需要使用 QT5_WRAP_CPP宏
QT5_WRAP_CPP(qui_HEADERS_MOC ${qui_HEADERS})

#使用uic处理.ui文件
QT5_WRAP_UI(qui_FORMS_HEADERS ${qui_FORMS})

#使用rcc处理.qrc文件
#QT5_ADD_RESOURCES(qui_RESOURCES_RCC ${qui_RESOURCES})

#这些生成的中间文件都会在build目录下，这样的话，编译器则不能定位由uic程序产生的诸如_ui_mainwindow.h等文件。所以，我们需要把build目录添加到包含目录中
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR})

#生成可执行文件
ADD_EXECUTABLE(${PROJECT_NAME} 
	${qui_SOURCES} 
	${qui_HEADERS_MOC} 
    ${qui_FORMS_HEADERS}
	#${qui_RESOURCES_RCC} 
)

#为target添加需要链接的共享库
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} Qt5::Core Qt5::Gui Qt5::Qml Qt5::Quick ${Qt5Widgets_LIBRARIES})
TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${Qt5Widgets_LIBRARIES})
INSTALL(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION lib
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

# Link your application with OpenCV libraries
target_link_directories(${PROJECT_NAME} PUBLIC
    ${OpenCV_LIB_DIRS}
    )
target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})
target_include_directories(${PROJECT_NAME} PUBLIC
    ${OpenCV_INCLUDE_DIRS}
    )
MESSAGE("OpenCV_INCLUDE_DIRS : ${OpenCV_INCLUDE_DIRS}")


# Link your application with LibTorch libraries
target_link_libraries(${PROJECT_NAME} "${TORCH_LIBRARIES}")
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 14)
