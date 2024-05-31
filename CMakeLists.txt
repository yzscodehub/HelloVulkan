cmake_minimum_required (VERSION 3.8)

project(HelloVulkan)

set(CMAKE_CXX_STANDARD 17)

set(THIRD_PARTY_DIR "3rdparty")

option(HELLO_VULKAN_BUILD_THIRDPARTY "Build thirdparty" ON)
if(HELLO_VULKAN_BUILD_THIRDPARTY)
    add_subdirectory(3rdparty)
endif()

# Vulkan SDK设置
if(NOT DEFINED ENV{VK_SDK_PATH})
    message(FATAL_ERROR "VK_SDK_PATH not defined!")
endif()
set(VK_SDK_PATH $ENV{VK_SDK_PATH})
set(VK_SDK_INCLUDE ${VK_SDK_PATH}/Include)
set(VK_SDK_LIB ${VK_SDK_PATH}/Lib/vulkan-1.lib)

option(HELLO_VULKAN_BUILD_ENGINE "Build engine" ON)
if(HELLO_VULKAN_BUILD_ENGINE) 
    add_subdirectory(engine)
endif()



