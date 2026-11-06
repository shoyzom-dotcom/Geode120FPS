cmake_minimum_required(VERSION 3.21)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if ("${CMAKE_SYSTEM_NAME}" STREQUAL "iOS" OR IOS)
    set(CMAKE_OSX_ARCHITECTURES "arm64")
else()
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")
endif()

set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_DISABLE_PRECOMPILE_HEADERS ON)

project(ios120fps VERSION 1.0.0)

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS src/*.cpp src/*.mm)
add_library(${PROJECT_NAME} SHARED ${SOURCES})

if (NOT DEFINED ENV{GEODE_SDK})
    message(FATAL_ERROR "Unable to find Geode SDK! GEODE_SDK is not set.")
endif()

add_subdirectory($ENV{GEODE_SDK} ${CMAKE_CURRENT_BINARY_DIR}/geode)

# UIKit / QuartzCore / GLKit are only used by the iOS implementation.
if ("${CMAKE_SYSTEM_NAME}" STREQUAL "iOS" OR IOS)
    target_link_libraries(${PROJECT_NAME}
        "-framework UIKit"
        "-framework QuartzCore"
        "-framework GLKit"
    )
endif()

setup_geode_mod(${PROJECT_NAME})
