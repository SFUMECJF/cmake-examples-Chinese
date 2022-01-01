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
#message(${DCMTK_LIBS})
#cmake_minimum_required(VERSION 2.8)
#PROJECT(test1DCMTK)
#
#find_package(DCMTK REQUIRED)
#
#add_executable(${PROJECT_NAME} main.cpp)
#
#SET(DCMTK_DIR "D:\\Programs\\dcmtkdll")
#
#ADD_DEFINITIONS(-D_REENTRANT)
#
## Use the INCLUDE_DIRS variable populated by the DCMTK find module.
#INCLUDE_DIRECTORIES(${DCMTK_INCLUDE_DIRS})
#
## Use the LIBRARIES variable populated by the DCMTK find module.
#TARGET_LINK_LIBRARIES(test1DCMTK ofstd ${DCMTK_LIBRARIES})


#project(readPlaneDoseFromRTDoseFile)
#cmake_minimum_required(VERSION 2.8)
#set(CMAKE_CXX_FLAGS -std=c++11)
#find_package(DCMTK REQUIRED)
##find_package(OpenCV REQUIRED)
##find_package(VTK REQUIRED)
#SET(DCMTK_DIR D:\\Programs\\dcmtk-3.6.6)
#SET(DCMTK_config_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/config)
#SET(DCMTK_dcmdata_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmdata)
#SET(DCMTK_dcmimage_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmimage)
#SET(DCMTK_dcmjpeg_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmjpeg)
#SET(DCMTK_dcmimgle_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmimgle)
#SET(DCMTK_dcmjpls_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmjpls)
#SET(DCMTK_dcmnet_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmnet)
#SET(DCMTK_dcmpstat_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmpstat)
#
#SET(DCMTK_dcmqrdb_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmqrdb)
#SET(DCMTK_dcmsign_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmsign)
#SET(DCMTK_dcmsr_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmsr)
#SET(DCMTK_dcmtls_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmtls)
#SET(DCMTK_ofstd_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/ofstd)
#SET(DCMTK_oflog_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/oflog)
#include_directories(${DCMTK_INCLUDE_DIRS})
#link_directories(${DCMTK_LIB_DIR})
##include_directories(${OpenCV_INCLUDE_DIRS})
##include(${VTK_USE_FILE})
##aux_source_directory(. SRC_LIST)
#add_executable(${PROJECT_NAME} main.cpp)
#target_link_libraries(${PROJECT_NAME} ${DCMTK_LIBS})



#cmake_minimum_required(VERSION 2.6)
#
#project(dcm_segm)
#
#set(CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS} -g -ftest-coverage -fprofile-arcs")
#
##set(Boost_USE_STATIC_LIBS ON)
##set(OpenCV_USE_STATIC_LIBS ON)
#set(DCMTK_USE_STATIC_LIBS ON)
##set(OpenCV_STATIC ON)
#
##find_package( VTK REQUIRED )
##find_package( OpenCV REQUIRED )
##find_package( Boost COMPONENTS system filesystem REQUIRED )
#find_package( DCMTK  REQUIRED )
#
##include(${VTK_USE_FILE} )
#
##link_directories(${OpenCV_LIB_DIR})
#
#add_executable(dcm_seg main.cpp)
#
#target_link_libraries(dcm_seg ${DCMTK_LIBRARIES})


#
## project name
#PROJECT(opencv_test)
## requirement of cmake version
#cmake_minimum_required(VERSION 3.5)
#set(DICOM_USE_DCMTK ON)
## set the directory of executable files
##set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${opencv_test_SOURCE_DIR}/bin)
#
## find required opencv
#find_package(DCMTK REQUIRED)
## directory of opencv headers
#include_directories(${DCMTK_INCLUDE_DIRS})
## name of executable file and path of source file
#add_executable(opencv_test main.cpp)
## directory of opencv library
#link_directories(${DCMTK_LIBRARY_DIRS})
## opencv libraries
#target_link_libraries(opencv_test ${DCMTK_LIBS})


#cmake_minimum_required(VERSION 3.1.0)
#
#if(POLICY CMP0074)
#    # find_package() uses <PackageName>_ROOT variables.
#    # This policy was introduced in CMake version 3.12.
#    cmake_policy(SET CMP0074 NEW)
#endif()
#
#project(dcm)
#
#option(DCM_BUILD_UNITTEST "Build unit test?" OFF)
#option(DCM_BUILD_EXAMPLES "Build examples?" ON)
#option(DCM_BUILD_APPS "Build applications?" ON)
#
#if(WIN32)
#    option(DCM_ENABLE_VLD "Enable VLD (Visual Leak Detector)?" OFF)
#
#    if(DCM_ENABLE_VLD)
#        add_definitions(-DDCM_ENABLE_VLD)
#    endif()
#endif()
#
#set(DCM_ENABLE_LOG 1 CACHE STRING "Enable logging? (1:Yes, 0:No)")
#set(DCM_LOG_LEVEL 2 CACHE STRING "Log level (0:VERB, 1:INFO, 2:USER, 3:WARN, 4:ERRO)")
#
#add_definitions(-DUNICODE -D_UNICODE)
#
#if(MSVC)
#    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
#endif()
#
## C++ standard requirements.
#set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_CXX_EXTENSIONS OFF)
#
## CMake 3.1.0+ required.
## See: https://stackoverflow.com/a/29871891
##set(THREADS_PREFER_PTHREAD_FLAG ON)
##find_package(Threads REQUIRED)
#
##set(Boost_USE_STATIC_LIBS ON)
##set(Boost_USE_MULTITHREADED ON)
##find_package(Boost REQUIRED COMPONENTS system filesystem)
##if(Boost_FOUND)
##    include_directories(${Boost_INCLUDE_DIRS})
##    link_directories(${Boost_LIBRARY_DIRS})
##endif()
#
#if(DCM_BUILD_UNITTEST)
#    enable_testing()
#endif()
#
#include_directories(
#        # For including its own headers as "dcm/xxx.h".
#        ${PROJECT_SOURCE_DIR}
#        # For including config.h as "dcm/config.h".
#        ${PROJECT_BINARY_DIR}
#)
#
#
#
#configure_file(
#        "${CMAKE_CURRENT_SOURCE_DIR}/config.h.in"
#        "${CMAKE_CURRENT_BINARY_DIR}/config.h"
#)
#
## Adhere to GNU filesystem layout conventions.
##include(GNUInstallDirs)
#
#file(GLOB SRCS
#        RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
#        ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
#        ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
#
#set(TARGET dcm)
#
#add_library(${TARGET} STATIC ${SRCS})
#
#target_link_libraries(${TARGET} "${CMAKE_THREAD_LIBS_INIT}")
#
## Install lib and header files.
## On Linux, if CMAKE_INSTALL_PREFIX is ~, the lib (libdcm.a) will be installed
## to ~/lib and header files will be installed to ~/include.
#install(TARGETS ${TARGET} ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
#install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/dcm)
##set(THIRD_PARTY_DIR ${PROJECT_SOURCE_DIR}/third_party)
##
##if(WIN32)
##    include_directories(${THIRD_PARTY_DIR}/win32/include)
##    link_directories(${THIRD_PARTY_DIR}/win32/lib)
##endif()
#
##include_directories(${THIRD_PARTY_DIR}/src)
#
##add_subdirectory(dcm)
#
##if(DCM_BUILD_EXAMPLES)
##    add_subdirectory(${PROJECT_SOURCE_DIR}/examples)
##endif()
##
##if(DCM_BUILD_UNITTEST)
##    add_subdirectory(${THIRD_PARTY_DIR}/src/gtest)
##    add_subdirectory(unittest)
##endif()
##
##if(DCM_BUILD_APPS)
##    add_subdirectory(apps)
##endif()
#
#
##cmake_minimum_required(VERSION 2.8)
##project(hello_dcmtk_cmake)
##
##set(CMAKE_CXX_STANDARD 14)
##
##add_definitions(-DHAVE_CONFIG_H)
##
##
##message(STATUS "${PROJECT_NAME}: Using DCMTK")
##find_package(DCMTK REQUIRED)
##target_include_directories(${DCMTK_INCLUDE_DIRS}/dcmtk)
##set(dcmtk_inc ${DCMTK_INCLUDE_DIRS}/dcmtk)
##target_include_directories(${dcmtk_inc}/config)
##target_include_directories(${dcmtk_inc}/dcmdata)
##target_include_directories(${dcmtk_inc}/dcmimgle)
##target_include_directories(${dcmtk_inc}/oflog)
##target_include_directories(${dcmtk_inc}/ofstd)
##target_include_directories(${dcmtk_inc}/dcmfg)
##target_include_directories(${dcmtk_inc}/dcmimage)
##target_include_directories(${dcmtk_inc}/dcmiod)
##target_include_directories(${dcmtk_inc}/dcmjpls)
##target_include_directories(${dcmtk_inc}/dcmnet)
##target_include_directories(${dcmtk_inc}/dcmpmap)
##target_include_directories(${dcmtk_inc}/dcmpstat)
##target_include_directories(${dcmtk_inc}/dcmqrdb)
##target_include_directories(${dcmtk_inc}/dcmrt)
##target_include_directories(${dcmtk_inc}/dcmseg)
##target_include_directories(${dcmtk_inc}/dcmsign)
##target_include_directories(${dcmtk_inc}/dcmsr)
##target_include_directories(${dcmtk_inc}/dcmtls)
##target_include_directories(${dcmtk_inc}/dcmtract)
##target_include_directories(${dcmtk_inc}/dcmwlm)
##LINK_LIBRARIES(${DCMTK_LIBRARIES})
##
###----------------------------------------------------------------------------
### DICOM configure options
###
##include(CMakeDependentOption)
### this macro checks for environment variable ${VAR} and sets ENV_${VAR} if
### if is a non-empty string. If empty string and ${VAR} is defined in CMake
### cache, then set ENV_${VAR} to it's value
### NOTE: environment variable, if set, overrides cache value
##macro(check_environment VAR)
##    set(ENV_${VAR} "$ENV{${VAR}}")
##    if("${ENV_${VAR}}" STREQUAL "" AND DEFINED ${VAR})
##        set(ENV_${VAR} ${${VAR}})
##    else()
##        set(ENV_${VAR} OFF) # default to off
##    endif()
##endmacro(check_environment VAR)
##
##check_environment(DICOM_USE_DCMTK)
##check_environment(DICOM_USE_HEAD)
### enable option if environment variable set (backwards-compat)
##option(DICOM_USE_DCMTK "DICOM with DCMTK support" ${ENV_DICOM_USE_DCMTK})
##
##add_executable(hello_dcmtk_cmake
##        main.cpp)
##target_link_libraries(hello_dcmtk_cmake ${DCMTK_LIBRARIES})
##
###SET(DCMTK_DIR D:/Programs/dcmtkdll/include/dcmtk)
###SET(DCMTK_config_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/config)
###SET(DCMTK_dcmdata_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmdata)
###SET(DCMTK_dcmimage_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmimage)
###SET(DCMTK_dcmjpeg_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmjpeg)
###SET(DCMTK_dcmimgle_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmimgle)
###SET(DCMTK_dcmjpls_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmjpls)
###SET(DCMTK_dcmnet_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmnet)
###SET(DCMTK_dcmpstat_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmpstat)
###
###SET(DCMTK_dcmqrdb_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmqrdb)
###SET(DCMTK_dcmsign_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmsign)
###SET(DCMTK_dcmsr_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmsr)
###SET(DCMTK_dcmtls_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/dcmtls)
###SET(DCMTK_ofstd_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/ofstd)
###SET(DCMTK_oflog_INCLUDE_DIR D:/Programs/dcmtkdll/include/dcmtk/oflog)
##
##
##
##
###TARGET_LINK_LIBRARIES(test1DCMTK ofstd ${DCMTK_LIBRARIES})
###target_include_directories(hello_dcmtk_cmake
###        PRIVATE
###        D:/Programs/dcmtkdll/include
###        )