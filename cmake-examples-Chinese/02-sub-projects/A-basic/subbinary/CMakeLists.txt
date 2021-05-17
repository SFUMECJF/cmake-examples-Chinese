project(subbinary)

# Create the executable
add_executable(${PROJECT_NAME} main.cpp)

# Link the static library from subproject1 using it's alias sub::lib1
# Link the header only library from subproject2 using it's alias sub::lib2
# This will cause the include directories for that target to be added to this project
#使用别名sub :: lib1从subproject1链接静态库
#使用别名sub :: lib2从subproject2链接仅标头的库
#这将导致该目标的包含目录添加到该项目中
target_link_libraries(${PROJECT_NAME}
    sub::lib1
    sub::lib2
)
