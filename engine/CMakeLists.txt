cmake_minimum_required (VERSION 3.8)

project(Engine)

set(CMAKE_CXX_STANDARD 17)

message(STATUS ${VK_SDK_INCLUDE})
include_directories(${VK_SDK_INCLUDE})

set(SRC helloTriangle.cpp)

add_executable(${PROJECT_NAME} ${SRC})

target_link_libraries(${PROJECT_NAME}
    PUBLIC
    glfw
    glm
    ${VK_SDK_LIB}
)