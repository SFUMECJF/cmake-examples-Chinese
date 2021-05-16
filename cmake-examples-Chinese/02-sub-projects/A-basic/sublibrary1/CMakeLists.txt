# Set the project name
project (sublibrary1)

# Add a library with the above sources
#此处${PROJECT_NAME}是当前project的名字，sublibrary1
add_library(${PROJECT_NAME} src/sublib1.cpp)
add_library(sub::lib1 ALIAS ${PROJECT_NAME})

target_include_directories( ${PROJECT_NAME}
    PUBLIC ${PROJECT_SOURCE_DIR}/include
)
