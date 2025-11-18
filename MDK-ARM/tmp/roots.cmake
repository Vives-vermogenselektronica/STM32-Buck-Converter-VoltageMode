# roots.cmake
set(CMSIS_PACK_ROOT "C:/Users/u0173601/AppData/Local/Arm/Packs" CACHE PATH "CMSIS pack root")
cmake_path(ABSOLUTE_PATH CMSIS_PACK_ROOT NORMALIZE OUTPUT_VARIABLE CMSIS_PACK_ROOT)
set(CMSIS_COMPILER_ROOT "C:/Users/u0173601/.vcpkg/artifacts/2139c4c6/tools.open.cmsis.pack.cmsis.toolbox/2.12.0/etc" CACHE PATH "CMSIS compiler root")
cmake_path(ABSOLUTE_PATH CMSIS_COMPILER_ROOT NORMALIZE OUTPUT_VARIABLE CMSIS_COMPILER_ROOT)
set(SOLUTION_ROOT "C:/Users/u0173601/OneDrive - Hogeschool VIVES/Vermogenselektronica/vermogenselektronica 3/b-g474e-dpow1/STM32-Buck-Repo-Temp/MDK-ARM" CACHE PATH "CMSIS solution root")
cmake_path(ABSOLUTE_PATH SOLUTION_ROOT NORMALIZE OUTPUT_VARIABLE SOLUTION_ROOT)
