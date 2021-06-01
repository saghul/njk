cmake_minimum_required(VERSION 3.4)

project(njk LANGUAGES C)

include(GNUInstallDirs)

if (NOT CMAKE_BUILD_TYPE)
    message(STATUS "No build type selected, default to Release")
    set(CMAKE_BUILD_TYPE "Release")
endif()
message(STATUS "Building in ${CMAKE_BUILD_TYPE} mode")
message(STATUS "Building with ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION} on ${CMAKE_SYSTEM}")

include(${CMAKE_SOURCE_DIR}/CMakeLists.quickjs.txt)

add_executable(njk
    quickjs/quickjs-libc.c
    main.c
    main-js.c
    nunjucks.c
)

set_target_properties(njk PROPERTIES
    C_STANDARD 11
    C_STANDARD_REQUIRED ON
)

target_link_libraries(njk qjs m)
