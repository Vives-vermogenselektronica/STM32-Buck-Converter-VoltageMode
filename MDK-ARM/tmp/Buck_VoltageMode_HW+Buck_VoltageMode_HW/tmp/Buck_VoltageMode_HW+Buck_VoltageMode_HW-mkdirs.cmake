# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW")
  file(MAKE_DIRECTORY "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW")
endif()
file(MAKE_DIRECTORY
  "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/1"
  "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW"
  "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW/tmp"
  "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW/src/Buck_VoltageMode_HW+Buck_VoltageMode_HW-stamp"
  "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW/src"
  "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW/src/Buck_VoltageMode_HW+Buck_VoltageMode_HW-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW/src/Buck_VoltageMode_HW+Buck_VoltageMode_HW-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM/tmp/Buck_VoltageMode_HW+Buck_VoltageMode_HW/src/Buck_VoltageMode_HW+Buck_VoltageMode_HW-stamp${cfgdir}") # cfgdir has leading slash
endif()
