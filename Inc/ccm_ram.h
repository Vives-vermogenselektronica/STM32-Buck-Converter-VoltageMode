/**
  ******************************************************************************
  * @file    ccm_ram.h
  * @brief   CCM-SRAM configuration and macros for STM32G474
  ******************************************************************************
  * @attention
  *
  * This file defines macros for placing code in CCM-SRAM (Core Coupled Memory)
  * The CCM-SRAM on STM32G474 is 32KB at address 0x10000000
  * Code placed in CCM-SRAM executes without wait-states at maximum speed
  * Ideal for time-critical interrupt handlers and control loops
  *
  ******************************************************************************
  */

#ifndef __CCM_RAM_H
#define __CCM_RAM_H

#ifdef __cplusplus
extern "C" {
#endif

/* CCM-SRAM placement macros for ARM Compiler (Keil MDK-ARM) */
#if defined(__ARMCC_VERSION)
  /* Place function in CCM-SRAM using section attribute */
  #define CCMRAM_FUNCTION __attribute__((section(".ccmram")))
  /* Place data in CCM-SRAM using section attribute */
  #define CCMRAM_DATA __attribute__((section(".ccmram")))

#elif defined(__GNUC__)
  /* Place function in CCM-SRAM for GCC */
  #define CCMRAM_FUNCTION __attribute__((section(".ccmram")))
  #define CCMRAM_DATA __attribute__((section(".ccmram")))

#elif defined(__ICCARM__)
  /* Place function in CCM-SRAM for IAR */
  #define CCMRAM_FUNCTION _Pragma("location=\".ccmram\"")
  #define CCMRAM_DATA _Pragma("location=\".ccmram\"")

#else
  #warning "Unknown compiler - CCM-SRAM placement not supported"
  #define CCMRAM_FUNCTION
  #define CCMRAM_DATA
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CCM_RAM_H */
