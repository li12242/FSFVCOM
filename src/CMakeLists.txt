# add subdirectories according to the value of FSFVCOM_CORE
if(${FSFVCOM_CORE} STREQUAL "FVCOM")
  add_subdirectory(fvcom)
endif()
