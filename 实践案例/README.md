

[TOC]



## 本案例说明

现有的工程demo都是针对windows的。并且，需要利用cmake提前将库（例如Open CV）的源码按照不同的编译器版本如MSVC2017生成对应的静态库和动态库。

例如我的Open CV安装好后：

`D:\Programs\opencv\opencv\build\x64\vc15\bin`是动态库路径，这个路径需要加到环境变量中。CMake中不需要包含这个路径。

`D:/Programs/opencv/opencv/build/include;D:/Programs/opencv/opencv/build/include/opencv`是我的两个头文件路径。

`D:/Programs/opencv/opencv/build/x64/vc15/lib`是库文件路径。

之后在CMake中使用这三个语句包含库的头文件路径，库文件路径，把程序用的库名加入到可执行程序中。

```cmake
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





##  库包含说明

类似Open CV，dcmtk，qt这样的大库，都有动态库和静态库两种。

工程查看链接：https://github.com/SFUMECJF/cmake-examples-Chinese/tree/main/%E5%AE%9E%E8%B7%B5%E6%A1%88%E4%BE%8B

## 互相交流


读者你好！如果你对本文内容感兴趣，我十分希望能够和你互相学习，可以扫码和我联系！一起进步



![在这里插入图片描述](https://img-blog.csdnimg.cn/20200529103009878.gif#pic_center)

