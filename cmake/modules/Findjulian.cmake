# Find julian
# Eventually replace with julian's actual config if using that
# Once found this file will define:
#  julian_FOUND - System has julian
#  julian_INCLUDE_DIRS - The julian include directories
#  julian_LIBRARIES - The libraries needed to use julian
#  julian_DEFINITIONS - Compiler switches required for using julian

# list( REMOVE_ITEM CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR} )
# find_package( julian )
# list( APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR} )

# exit early if we don't even need to be here
if(julian_FOUND)
  return()
endif()

find_library(
  JULIAN_LIBRARY
  NAMES julian
  PATHS ${FVCOM_EXTENAL_LIBRARY_PATH}
)

if(${JULIAN_LIBRARY} MATCHES "-NOTFOUND$")
  message(STATUS "No julian library found in the external library path: ${FVCOM_EXTENAL_LIBRARY_PATH}")
else()
  message(STATUS "Found julian library : ${JULIAN_LIBRARY}")
  set(julian_LIBRARIES
    ${JULIAN_LIBRARY}
  )
  # Because we may need this for in-situ manual preprocessing do not use genex
  set(julian_INCLUDE_DIRS ${FVCOM_EXTENAL_INCLUDE_PATH})

endif()
