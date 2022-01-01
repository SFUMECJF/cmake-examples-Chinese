# reconstruction

## 在CMake中包含Open CV库

首先，把动态库的路径包含到环境变量。

其次，在CMake中find package，并且链接头文件路径，库文件路径，以及库文件。

```cmake
find_package(OpenCV CONFIG REQUIRED PATHS)

target_link_directories(reconstruction PUBLIC
    ${OpenCV_LIB_DIRS}
    )
target_link_libraries(reconstruction
    ${OpenCV_LIBS}
    )
target_include_directories(reconstruction PUBLIC
    ${OpenCV_INCLUDE_DIRS}
    )
```



