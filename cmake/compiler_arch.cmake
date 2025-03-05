# todo: select compiler automatically
set( CMAKE_Fortran_COMPILER "ifx" )
set( CMAKE_C_COMPILER       "icx" )

# Our own addition
set( CMAKE_C_PREPROCESSOR       "/lib/cpp" )
set( CMAKE_C_PREPROCESSOR_FLAGS   )

# https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_FLAGS_INIT.html
# set( CMAKE_Fortran_FLAGS_INIT    " -ip -w -ftz -align all -fno-alias   -xCORE-AVX2 -fp-model fast=2 -fimf-use-svml=true -convert big_endian" )
# set( CMAKE_C_FLAGS_INIT          " -w -O3 -ip -xCORE-AVX2 -fp-model fast=2 -fimf-use-svml=true" )
set(CMAKE_Fortran_FLAGS "-g -traceback")
if(CMAKE_Fortran_COMPILER_ID MATCHES "IntelLLVM")
   set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS} -O0")
   set(CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS_RELEASE} -align array64byte -mprefer-vector-width=512 -xcore-avx512")
   set( CMAKE_Fortran_FLAGS_INIT    " -ip -w -ftz -align all -fno-alias   -xCORE-AVX2 -fp-model fast=2 -fimf-use-svml=true -convert big_endian" )
   set( CMAKE_C_FLAGS_INIT          " -w -O3 -ip -xCORE-AVX2 -fp-model fast=2 -fimf-use-svml=true" )
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
   set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS} -O0")
   set(CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS_RELEASE} -march=native -O3")
endif()

# https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_FLAGS_CONFIG_INIT.html
set( CMAKE_Fortran_FLAGS_DEBUG_INIT    "" )
set( CMAKE_Fortran_FLAGS_RELEASE_INIT  "" )
set( CMAKE_C_FLAGS_DEBUG_INIT    "" )
set( CMAKE_C_FLAGS_RELEASE_INIT  "" )