开发环境：

<p align="center">
  <a href="https://github.com/vuejs/vue">
    <img src="https://img.shields.io/badge/Windows-10-brightgreen.svg" alt="ubuntu">
  </a>
  <a href="https://github.com/vuejs/vue-router">
    <img src="https://img.shields.io/badge/IDE-VS2017--VS2019-brightred.svg" alt="vue-router">
  </a>
  <a href="https://github.com/vuejs/vuex">
    <img src="https://img.shields.io/badge/CMake-3.14.3-brightgreen.svg" alt="vuex">
  </a>
</p>  

[toc]


[TOC]

## 0  前言

前面记录了编译好VS库之后，利用Visual Studio来构建工程，也就是说有一个很大的.vs文件夹以及.sln文件来储存工程的配置。

但是，CMake更为轻量，笔者不否认VS的强大，VS本身就可以打开CMake的工程。因此，本文，笔者使用CMake构建工程。可以利用CLIon或者还是VS来打开CMake的工程。

##  1  构建CMake工程步骤

[一个很有用的英文参考资料](https://stackoverflow.com/questions/5052148/how-to-use-dcmtk-in-qt)

事实上，网络关于利用CMake导入dcmtk库的代码相当少，基本没有。也找到一些资料，但是过于复杂。

###  文件树

```tree

-CMakeLists.txt
-main.cpp
-README.md
─out
    └─build
        └─x64-Debug
            │  dcmdata.dll
            │  oflog.dll
            │  ofstd.dll
            │  testapp.exe
```

其实只需要`CMakeLists.txt`和`main.cpp`就可以，Readme.md就是你看到的这篇文章，而out是我用VS生成的，最终的testapp.exe就是可执行文件，然后我们要把            `dcmdata.dll`和  `oflog.dll`和  `ofstd.dll`放到和可执行文件同一个目录。

###  CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 2.8)
PROJECT(testapp)

SET(DCMTK_INCLUDE_DIRS "D:\\Programs\\dcmtkdll\\include")
SET(DCMTK_LIBRARIES "D:\\Programs\\dcmtkdll\\lib")
SET(DCMTK_DIR "D:\\Programs\\dcmtkdll")
#an example: SET(DCMTK_DIR "C:\\Users\\test\\test_dcmtk\\DCMTK")
#set(CMAKE_CXX_FLAGS -std=c++11)
# settings for Microsoft Visual C++ 6
SET(CMAKE_C_FLAGS "/nologo /W3 /GX /Gy /YX")
SET(CMAKE_C_FLAGS_DEBUG "/MTd /Z7 /Od")
SET(CMAKE_C_FLAGS_RELEASE "/MT /O2")
SET(CMAKE_CXX_FLAGS "/nologo /W3 /GX /Gy /YX")
SET(CMAKE_CXX_FLAGS_DEBUG "/MTd /Z7 /Od")
SET(CMAKE_CXX_FLAGS_RELEASE "/MT /O2")

ADD_DEFINITIONS(-D_REENTRANT)

INCLUDE_DIRECTORIES(${DCMTK_DIR}/include)
LINK_DIRECTORIES(${DCMTK_DIR}/lib)

ADD_EXECUTABLE(testapp main.cpp)
TARGET_LINK_LIBRARIES(testapp netapi32 wsock32 ofstd dcmdata)
message("-------------\n")
message("${DCMTK_INCLUDE_DIRS}")
message("${DCMTK_LIBRARIES}")
message(STATUS "${DCMTK_FOUND}")
#message("${DCMTK_INCLUDE_DIRS}")
message("${DCMTK_DIR}")
message(STATUS "-------------\n")
```



###  main.cpp

```c++
// C++_Dicom_Sample.cpp : Defines the entry point for the console application.
//

//#include "stdafx.h"
//C++中stdafx.h的英文全称为：standard application fram extend，中文名为：头文件预编译。
//
//stdafx.h在c++中起到的作用是：把C++工程中使用的MFC头文件预先编译，以后该工程编译时，直接使用预编译的结果，这样可以加快编译速度。

//#include "dcmtk/config/osconfig.h"
#include "dcmtk/dcmdata/dctk.h"
#include <iostream>


bool ReadPatientName(DcmFileFormat& fileformat, std::string& filePath)
{
    OFCondition status = fileformat.loadFile(filePath.c_str());
    if (!status.good())
    {
        std::cout << "Load Dimcom File Error: " << status.text() << std::endl;
        return false;
    }
    OFString PatientName;
    status = fileformat.getDataset()->findAndGetOFString(DCM_PatientName, PatientName);
    if (status.good())
    {
        std::cout << "Get PatientName:" << PatientName << std::endl;
    }
    else
    {
        std::cout << "Get PatientName Error:" << status.text() << std::endl;
        return false;
    }
    return true;
}

bool SavePatientName(DcmFileFormat& fileformat, std::string& filePath, const std::string& info)
{
    OFCondition status = fileformat.getDataset()->putAndInsertString(DCM_PatientName, info.c_str());
    if (status.good())
    {
        std::cout << "Save PatientName:" << info.c_str() << std::endl;
    }
    else
    {
        std::cout << "Save PatientName Error: " << status.text() << std::endl;
        return false;
    }

    status = fileformat.saveFile(filePath.c_str());
    if (!status.good())
    {
        std::cout << "Save Dimcom File Error: " << status.text() << std::endl;
        return false;
    }
    return true;
}

int main()
{
    DcmFileFormat dicomFileformat;

    std::string dicomFile = "image-00000.dcm";

    ReadPatientName(dicomFileformat, dicomFile);

    //SavePatientName(dicomFileformat, dicomFile, "John Snow");

    //ReadPatientName(dicomFileformat, dicomFile);

    system("pause");

    return 0;
}
```





###  使用

其实只需要`CMakeLists.txt`和`main.cpp`就可以，直接用VIsual Studio打开`CMakeLists.txt`，会生成out，然后复制那三个文件。注意，现在因为我写的CMakeLists的原因，只能使用VS默认的编译器，CLion默认打开运行会报错。可能需要设置一下。

之后进行优化。

## 2  资料

从网上找的各种cmake工程的资料：

总感觉是我需要先把dcmtk编译成一个可以用cmake调用的版本，然后CMake使用正确的代码？



[gitee](https://gitee.com/qiangge_666/t_dcmtk/tree/master#https://github.com/Geant4/geant4/tree/master/examples/extended/medical/DICOM)

[微信文章](https://mp.weixin.qq.com/s/EEJIwGRUqXPhuSFDs4Scgw)

[2](https://gitee.com/QQ975150313/vtk-dicom)

[3](https://gitee.com/lspKK/dcmtkDemo)

[4](https://github.com/sprinfall/dcm/blob/master/dcm/CMakeLists.txt)

[5](https://github.com/marcinwol/dcmtk-basic-example/blob/master/CMakeLists.txt)

###  使用其他基于dcmtk的库

比如CTk就是对dcmtk的再利用，一个很好的轮子。可以从最基础版本学？或者添加到我的代码中？

[CTK](http://commontk.org/index.php/Main_Page)

[slicer](https://www.slicer.org/)

[MITK](http://mitk.org/wiki/MITK)

[ITKSNAP]

###  论坛

论坛不用vpn才能顺畅地浏览：

总感觉这里会有想要的答案，可惜无法搜索。建个dcmtk群？

## 互相交流


读者你好！如果你对本文内容感兴趣，我十分希望能够和你互相学习，可以扫码和我联系！一起进步



![在这里插入图片描述](https://img-blog.csdnimg.cn/20200529103009878.gif#pic_center)

