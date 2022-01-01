cmake_minimum_required (VERSION 2.6)

cmake_policy(SET CMP0012 NEW)

PROJECT(opencv_demo)
set(CMAKE_MODULE_PATH )
message("${CMAKE_MODULE_PATH}")
# Requires OpenCV
FIND_PACKAGE( OpenCV REQUIRED )
MESSAGE("OpenCV version : ${OpenCV_VERSION}")
#SET(OpenCV_INCLUDE_DIRS "D:\\Programs\\opencvsolution\\install\\include\\")
#SET(OpenCV_LIB_DIR "D:\\Programs\\opencvsolution\\install\\x64\\vc16\\lib\\")

include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIB_DIR})
MESSAGE("OpenCV version : ${OpenCV_LIB_DIR}")
MESSAGE("OpenCV version : ${OpenCV_LIBS}")
ADD_EXECUTABLE( opencv_demo ${PROJECT_SOURCE_DIR}/main.cpp )
#TARGET_LINK_LIBRARIES( opencv_demo ${OpenCV_LIBS} )

#TARGET_LINK_LIBRARIES( opencv_demo opencv_world3414.lib opencv_img_hash3414.lib )