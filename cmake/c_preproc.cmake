
macro(fvcom_c_preproc_fortran)
  set(options)
  set(oneValueArgs TARGET_NAME SUFFIX PREFIX EXTENSION OUTPUT_DIR)
  set(multiValueArgs DEPENDENCIES INCLUDES SOURCES DEFINITIONS TARGET_SCOPE)

  cmake_parse_arguments(
                        WRF_PP_F
                        "${options}"  "${oneValueArgs}"  "${multiValueArgs}"
                        ${ARGN}
                        )
endmacro()
