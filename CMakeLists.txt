cmake_minimum_required(VERSION 3.12)
project(FSFVCOM Fortran C)

enable_language(Fortran)
enable_language(C)

# Set default build type
if("${CMAKE_BUILD_TYPE}" STREQUAL "")
   set(CMAKE_BUILD_TYPE Release)
   message(STATUS "Set default build type to ${CMAKE_BUILD_TYPE}")
endif()

# Define the executable name
set(MAIN_NAME fsfvcom)

list(APPEND CMAKE_MODULE_PATH
   ${PROJECT_SOURCE_DIR}/cmake/
   ${PROJECT_SOURCE_DIR}/cmake/modules
)

# Use link paths as rpaths
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
set(CMAKE_Fortran_PREPROCESS ON)

# Set preprocess flags
# this is only used for the x86_64 architecture
# list(APPEND CMAKE_C_PREPROCESSOR_FLAGS -P -traditional -march=x86-64-v4)

include(compiler_arch)

# maybe add solver selection here
set(FSFVCOM_CORE "FVCOM" CACHE STRING "FSFVCOM_CORE")
set_property(
   CACHE FSFVCOM_CORE
   PROPERTY STRINGS "FVCOM"
)

# include(fvcom_config)
add_subdirectory(src)

