# groups.cmake

# group Application/MDK-ARM
add_library(Group_Application_MDK-ARM OBJECT
  "${SOLUTION_ROOT}/startup_stm32g474xx.s"
)
target_include_directories(Group_Application_MDK-ARM PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
)
target_compile_definitions(Group_Application_MDK-ARM PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
add_library(Group_Application_MDK-ARM_ABSTRACTIONS INTERFACE)
target_link_libraries(Group_Application_MDK-ARM_ABSTRACTIONS INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)
target_compile_options(Group_Application_MDK-ARM PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_OPTIONS>
)
target_link_libraries(Group_Application_MDK-ARM PUBLIC
  Group_Application_MDK-ARM_ABSTRACTIONS
)
set(COMPILE_DEFINITIONS
  STM32G474xx
  _RTE_
)
cbuild_set_defines(AS_ARM COMPILE_DEFINITIONS)
set_source_files_properties("${SOLUTION_ROOT}/startup_stm32g474xx.s" PROPERTIES
  COMPILE_FLAGS "${COMPILE_DEFINITIONS}"
)

# group Application/User
add_library(Group_Application_User OBJECT
  "${SOLUTION_ROOT}/../Src/main.c"
  "${SOLUTION_ROOT}/../Src/stm32g4xx_it.c"
  "${SOLUTION_ROOT}/../Src/stm32g4xx_hal_msp.c"
)
target_include_directories(Group_Application_User PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
)
target_compile_definitions(Group_Application_User PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
add_library(Group_Application_User_ABSTRACTIONS INTERFACE)
target_link_libraries(Group_Application_User_ABSTRACTIONS INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)
target_compile_options(Group_Application_User PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_OPTIONS>
)
target_link_libraries(Group_Application_User PUBLIC
  Group_Application_User_ABSTRACTIONS
)

# group Drivers/STM32G4xx_HAL_Driver
add_library(Group_Drivers_STM32G4xx_HAL_Driver OBJECT
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_adc.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_adc_ex.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_ll_adc.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_rcc.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_rcc_ex.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_flash.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_flash_ex.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_flash_ramfunc.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_gpio.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_exti.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_dma.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_dma_ex.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_pwr.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_pwr_ex.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_cortex.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_fmac.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_hrtim.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_rtc.c"
  "${SOLUTION_ROOT}/../Drivers/STM32G4xx_HAL_Driver/Src/stm32g4xx_hal_rtc_ex.c"
)
target_include_directories(Group_Drivers_STM32G4xx_HAL_Driver PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
)
target_compile_definitions(Group_Drivers_STM32G4xx_HAL_Driver PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
add_library(Group_Drivers_STM32G4xx_HAL_Driver_ABSTRACTIONS INTERFACE)
target_link_libraries(Group_Drivers_STM32G4xx_HAL_Driver_ABSTRACTIONS INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)
target_compile_options(Group_Drivers_STM32G4xx_HAL_Driver PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_OPTIONS>
)
target_link_libraries(Group_Drivers_STM32G4xx_HAL_Driver PUBLIC
  Group_Drivers_STM32G4xx_HAL_Driver_ABSTRACTIONS
)

# group Drivers/CMSIS
add_library(Group_Drivers_CMSIS OBJECT
  "${SOLUTION_ROOT}/../Src/system_stm32g4xx.c"
)
target_include_directories(Group_Drivers_CMSIS PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
)
target_compile_definitions(Group_Drivers_CMSIS PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
add_library(Group_Drivers_CMSIS_ABSTRACTIONS INTERFACE)
target_link_libraries(Group_Drivers_CMSIS_ABSTRACTIONS INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)
target_compile_options(Group_Drivers_CMSIS PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_OPTIONS>
)
target_link_libraries(Group_Drivers_CMSIS PUBLIC
  Group_Drivers_CMSIS_ABSTRACTIONS
)
