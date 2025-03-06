# Find metis
# Eventually replace with metis's actual config if using that
# Once found this file will define:
#  metis_FOUND - System has metis
#  metis_INCLUDE_DIRS - The metis include directories
#  metis_LIBRARIES - The libraries needed to use metis
#  metis_DEFINITIONS - Compiler switches required for using metis

# list( REMOVE_ITEM CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR} )
# find_package( metis )
# list( APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR} )

# exit early if we don't even need to be here
if(metis_FOUND)
  return()
endif()

find_library(
  METIS_LIBRARY
  NAMES metis
  PATHS ${FVCOM_EXTENAL_LIBRARY_PATH}
)

if(${METIS_LIBRARY} MATCHES "-NOTFOUND$")
  message(STATUS "No Metis library found in the external library path: ${FVCOM_EXTENAL_LIBRARY_PATH}")
else()
  message(STATUS "Found Metis library : ${METIS_LIBRARY}")
  set(metis_LIBRARIES
    ${METIS_LIBRARY}
  )
  # Because we may need this for in-situ manual preprocessing do not use genex
  set(metis_INCLUDE_DIRS ${FVCOM_EXTENAL_INCLUDE_PATH})

endif()
