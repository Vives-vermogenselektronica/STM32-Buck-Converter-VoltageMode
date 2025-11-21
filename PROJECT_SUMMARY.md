# STM32G474RE Buck Converter - Project Summary

## Board Information
- **Board**: B-G474E-DPOW1 (STM32G4 DPOW Discovery - MB1428)
- **MCU**: STM32G474RET6
- **CPU Frequency**: 170 MHz
- **Project**: Buck Converter Voltage Mode Control with FMAC Hardware Accelerator

## Hardware Configuration

### Buck Converter Specifications
- **Input Voltage (VIN)**: 5V (USB-PD)
- **Output Voltage (VOUT)**: 3.3V (regulated)
- **Target ADC Value (REF)**: 775 (corresponds to 3.3V)
- **Switching Frequency**: 200 kHz
- **PWM Resolution**: 24480 ticks max
- **Controller**: 3P3Z IIR Digital Filter (Direct Form 1)

### Digital Controller Configuration
- **Implementation**: FMAC Hardware Accelerator
- **Filter Type**: IIR Direct Form 1 (3 poles, 3 zeros)
- **Data Format**: Q1.15 Fixed-Point
- **Coefficients**:
  - Feed-forward (B): 4 coefficients (B0-B3)
  - Feedback (A): 3 coefficients (A1-A3)
- **Post-shift**: +5
- **Update Rate**: 200 kHz (synchronous with PWM)

## Critical Pin Assignments

### PWM Output (Duty Cycle Measurement)
| Signal | Pin | Function | Description |
|--------|-----|----------|-------------|
| **BUCKBOOST_P1_DRIVE** | **PB12** | HRTIM1_CHC1 | **Primary PWM output - Measure duty cycle here** |
| BUCKBOOST_N1_DRIVE | PB13 | HRTIM1_CHC2 | Complementary drive |
| BUCKBOOST_N2_DRIVE | PB14 | HRTIM1_CHD1 | Secondary drive |
| BUCKBOOST_P2_DRIVE | PB2 | GPIO | Buck enable (set HIGH) |

### Load Control (Transient Testing)
| Signal | Pin | Function | Description |
|--------|-----|----------|-------------|
| BUCKBOOST_LOAD_50% | PC14 | GPIO Output | 50% load control (toggles during transient) |
| BUCKBOOST_LOAD_100% | PC15 | GPIO Output | 100% load control (toggles during transient) |

**Note**: PC14 or PC15 can be used as oscilloscope trigger for transient response testing.

### Analog Sensing
| Signal | Pin | Function | Description |
|--------|-----|----------|-------------|
| BUCKBOOST_VOUT | PA3 | ADC1_IN4 | Output voltage measurement |
| BUCKBOOST_VIN | PC0 | ADC1_IN6 | Input voltage measurement |
| BUCKBOOST_I_IN_SENSE | PC2 | ADC1_IN8 | Input current sense |

### Timing/Debug Signal
| Signal | Pin | Function | Description |
|--------|-----|----------|-------------|
| GPO1 | PB9 | GPIO Output | ISR timing measurement (200 kHz pulses) |

### User Interface
| Signal | Pin | Function | Description |
|--------|-----|----------|-------------|
| JOY_UP | PC13 | GPIO Input | Enable transient mode |
| JOY_DOWN | PB2 | GPIO Input | Disable transient mode |
| LED_RIGHT_GREEN | PB7 | GPIO Output | Load state indicator |
| LED_LEFT_ORANGE | PB1 | GPIO Output | Load state indicator |
| LED_DOWN_BLUE | PA15 | GPIO Output | Status LED |

## Test Points (from Schematic)
| Test Point | Location | Signal | Status |
|------------|----------|--------|--------|
| TP1 | Sheet 7 | Current sensing section | DNF (pad available) |
| TP2 | Sheet 7 | Current sensing section | DNF (pad available) |
| TP3 | Sheet 6 | RGB LED section | DNF |
| TP4 | Sheet 3 | RC Sinus (PC7) | DNF |

**Note**: TP1 and TP2 are unpopulated pads on the PCB but can be probed if needed.

## CCM-SRAM Implementation

### Memory Configuration
- **CCM-SRAM Base Address**: 0x10000000
- **CCM-SRAM Size**: 32 KB (0x00008000)
- **Access Time**: Zero wait-states at 170 MHz
- **Flash Access Time**: 4-8 wait-states at 170 MHz

### Performance Benefit
Placing time-critical interrupt handlers in CCM-SRAM eliminates Flash wait-states, providing deterministic execution time for the control loop.

### Implementation Files

#### 1. Linker Scatter File: `MDK-ARM/stm32g474xx_flash.sct`
```scatter
RW_IRAM_CCM 0x10000000 0x00008000  {
  *(.ccmram)
}
```

#### 2. Header File: `Inc/ccm_ram.h`
Defines cross-compiler macros for CCM-SRAM placement:
- `CCMRAM_FUNCTION` - Places function in CCM-SRAM
- `CCMRAM_DATA` - Places data in CCM-SRAM

#### 3. Interrupt Handler: `Src/stm32g4xx_it.c`
```c
CCMRAM_FUNCTION
void FMAC_IRQHandler(void)
{
  extern HRTIM_HandleTypeDef hhrtim1;
  uint32_t tmp;

  /* Set GPO1 to high for timing purposes */
  LL_GPIO_SetOutputPin(GPO1_GPIO_Port, GPO1_Pin);

  /* Read result from FMAC and perform bounds checking */
  tmp = READ_REG(hfmac.Instance->RDATA);
  tmp = (tmp > 0x00007FFF ? 0 : tmp); // Q1.15 format check

  /* Update PWM compare register to update duty cycle */
  __HAL_HRTIM_SETCOMPARE(&hhrtim1, HRTIM_TIMERINDEX_TIMER_C, HRTIM_COMPAREUNIT_1, tmp);

  /* Set GPO1 to low for timing purposes */
  LL_GPIO_ResetOutputPin(GPO1_GPIO_Port, GPO1_Pin);
}
```

### Verification
Map file confirms placement at CCM-SRAM address:
```
FMAC_IRQHandler: 0x10000001 (CCM-SRAM region)
```

## FMAC Data Flow

```
ADC1 → DMA → FMAC.WDATA (automatic)
           ↓
    FMAC 3P3Z Filter
    (Hardware Accelerator)
           ↓
    FMAC.RDATA → FMAC_IRQHandler → HRTIM Compare Register → PWM Output (PB12)
```

## Transient Response Testing

### Setup
1. **Enable Transient Mode**: Press UP on joystick
2. **Trigger Signal**: Use PC14 or PC15 (load control pins)
3. **Measurement Points**:
   - Output voltage: VOUT test point on board
   - PWM duty cycle: PB12 (BUCKBOOST_P1_DRIVE)
   - ISR timing: PB9 (GPO1) - 200 kHz pulses

### Oscilloscope Configuration
- **Trigger**: Edge trigger on PC14 or PC15 (falling or rising edge)
- **Timebase**: 100 µs/div (or appropriate for settling time observation)
- **Channel 1**: VOUT (AC coupled, 20-50 mV/div)
- **Channel 2**: PWM duty cycle on PB12 (optional)
- **Transient Period**: 500 ms between load steps

### Expected Behavior
- Load toggles between 50% and 100% every 500 ms
- LEDs (GREEN/ORANGE) toggle with load changes
- Output voltage maintains regulation at 3.3V
- Transient response visible as voltage dip/spike before settling

## Key Features Implemented

✅ **CCM-SRAM Execution**: FMAC ISR running in zero wait-state memory
✅ **Hardware FMAC**: 3P3Z digital compensator in hardware
✅ **200 kHz Control Loop**: Synchronous with PWM switching
✅ **Stable Regulation**: Output maintains 3.3V ± tolerance
✅ **Transient Testing**: Automated load step testing capability
✅ **Debug Signals**: GPO1 pulse for ISR timing measurement

## Important Notes

### Warnings from Code
1. **TP1 Enable**: Buck converter P2 drive must be HIGH (PB2)
   ```c
   HAL_GPIO_WritePin(GPIOB, BUCKBOOST_P2_DRIVE_Pin, GPIO_PIN_SET);
   ```

2. **Load Limits**: Embedded loads rated for 5V maximum VOUT
   - For higher voltages, external loads required

3. **FMAC Configuration**: Uses interrupt-based output access
   - InputAccess: NONE (DMA handles input)
   - OutputAccess: IT (interrupt-driven output read)
   - Clipping: ENABLED

### Build Configuration
- **Toolchain**: MDK-ARM (Keil)
- **Optimization**: Check project settings for optimization level
- **Git**: Long paths enabled (`git config core.longpaths true`)

## References

- **Schematic**: `mb1428-g474re-b01_schematic.pdf`
- **Application Note**: AN4296 (CCM-SRAM usage with STM32)
- **Board User Manual**: UM2397 (B-G474E-DPOW1 Discovery kit)

## Measurement Quick Reference

| What to Measure | Where to Probe | Expected Result |
|----------------|----------------|-----------------|
| Output Voltage | VOUT test point | 3.3V ± regulation tolerance |
| Duty Cycle | PB12 | Variable PWM ~27% nominal for 5V→3.3V |
| Switching Frequency | PB12 | 200 kHz |
| ISR Execution Time | PB9 (GPO1) | Pulse width at 200 kHz rate |
| Transient Trigger | PC14 or PC15 | Edge every 500ms in transient mode |
| Load Step | VOUT during transient | Voltage dip/overshoot + settling |

---

**Document Version**: 1.0
**Last Updated**: 2025-11-18
**Project Status**: Working - 3.3V regulation achieved with FMAC in CCM-SRAM
