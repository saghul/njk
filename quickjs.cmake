# QuickJS

set(qjs_cflags -Wall)
if(CMAKE_C_COMPILER_ID MATCHES "AppleClang|Clang")
    list(APPEND qjs_cflags
        -Wextra
        -Wno-sign-compare
        -Wno-missing-field-initializers
        -Wno-unused-parameter
        -Wno-unused-variable
        -Wno-unused-but-set-variable
        -funsigned-char)
else()
    list(APPEND qjs_cflags
        -Wno-array-bounds
        -Wno-unused-variable
        -Wno-unused-but-set-variable)
endif()

file(STRINGS "quickjs/VERSION" QJS_VERSION_STR)

add_library(qjs STATIC
    quickjs/cutils.c
    quickjs/libregexp.c
    quickjs/libunicode.c
    quickjs/quickjs.c
)
set_target_properties(qjs PROPERTIES
    C_STANDARD 11
    C_STANDARD_REQUIRED ON
)
target_compile_options(qjs PRIVATE ${qjs_cflags})
target_compile_definitions(qjs PUBLIC
    QJS_VERSION_STR="${QJS_VERSION_STR}"
)
target_compile_definitions(qjs PRIVATE
    _GNU_SOURCE
    CONFIG_VERSION="${QJS_VERSION_STR}"
)
if (CMAKE_BUILD_TYPE MATCHES Debug)
    target_compile_definitions(qjs PRIVATE
        DUMP_LEAKS
    )
endif()

target_include_directories(qjs PUBLIC quickjs)

add_executable(qjsc
    quickjs/qjsc.c
    quickjs/quickjs-libc.c
)

set_target_properties(qjsc PROPERTIES
    C_STANDARD 11
    C_STANDARD_REQUIRED ON
    EXCLUDE_FROM_ALL TRUE
)

target_compile_definitions(qjsc PRIVATE
    _GNU_SOURCE
    CONFIG_VERSION="${QJS_VERSION_STR}"
)

target_link_libraries(qjsc qjs m pthread dl)
