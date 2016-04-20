/* Copyright Statement:
 *
 * @2015 MediaTek Inc. All rights reserved.
 *
 * This software/firmware and related documentation ("MediaTek Software") are
 * protected under relevant copyright laws. The information contained herein
 * is confidential and proprietary to MediaTek Inc. and/or its licensors.
 * Without the prior written permission of MediaTek Inc. and/or its licensors,
 * any reproduction, modification, use or disclosure of MediaTek Software,
 * and information contained herein, in whole or in part, shall be strictly prohibited.
 *
 * BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
 * THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
 * RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
 * AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
 * NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
 * SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
 * SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
 * THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
 * THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
 * CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
 * SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
 * STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
 * CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
 * AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
 * OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
 * MEDIATEK FOR SUCH MEDIATEK SOFTWARE.
 */
    .syntax unified
    .arch armv7-m

/* Memory Model
   The HEAP starts at the end of the DATA section and grows upward.
   
   The STACK starts at the end of the RAM and grows downward.
   
   The HEAP and stack STACK are only checked at compile time:
   (DATA_SIZE + HEAP_SIZE + STACK_SIZE) < RAM_SIZE
   
   This is just a check for the bare minimum for the Heap+Stack area before
   aborting compilation, it is not the run time limit:
   Heap_Size + Stack_Size = 0x80 + 0x80 = 0x100
 */
    .section .stack
    .align 3
#ifdef __STACK_SIZE
    .equ    Stack_Size, __STACK_SIZE
#else
    .equ    Stack_Size, 0xc00
#endif
    .globl    __StackTop
    .globl    __StackLimit
__StackLimit:
    .space    Stack_Size
    .size __StackLimit, . - __StackLimit
__StackTop:
    .size __StackTop, . - __StackTop

    .section .heap
    .align 3
#ifdef __HEAP_SIZE
    .equ    Heap_Size, __HEAP_SIZE
#else
    .equ    Heap_Size, 0x800
#endif
    .globl    __HeapBase
    .globl    __HeapLimit
__HeapBase:
    .space    Heap_Size
    .size __HeapBase, . - __HeapBase
__HeapLimit:
    .size __HeapLimit, . - __HeapLimit
    
    .section .isr_vector
    .align 2
    .globl __isr_vector
__isr_vector:
    .long    __StackTop            /* Top of Stack */
    .long    Reset_Handler         /* Reset Handler */
    .long    NMI_Handler           /* NMI Handler */
    .long    HardFault_Handler     /* Hard Fault Handler */
    .long    MemManage_Handler     /* MPU Fault Handler */
    .long    BusFault_Handler      /* Bus Fault Handler */
    .long    UsageFault_Handler    /* Usage Fault Handler */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    SVC_Handler           /* SVCall Handler */
    .long    DebugMon_Handler      /* Debug Monitor Handler */
    .long    0                     /* Reserved */
    .long    PendSV_Handler        /* PendSV Handler */
    .long    SysTick_Handler       /* SysTick Handler */

    /* External interrupts */
    .long   Default_IRQ_Handler         /* 16: UART1  */
    .long   DMA_LISR                    /* 17: DMA */
    .long   Default_IRQ_Handler         /* 18: HIF */   
    .long   hal_i2c_callback            /* 19: I2C1 */
    .long   hal_i2c_callback            /* 20: I2C2 */
    .long   Default_IRQ_Handler         /* 21: UART2 */
    .long   Default_IRQ_Handler         /* 22: MTK_CRYPTO */
    .long   Default_IRQ_Handler         /* 23: SF */
    .long   Default_IRQ_Handler         /* 24: EINT */
    .long   Default_IRQ_Handler         /* 25: BTIF */
    .long   hal_wdt_isr                 /* 26: WDT */
    .long   Default_IRQ_Handler         /* 27: reserved */
    .long   Default_IRQ_Handler         /* 28: SPI_SLAVE */
    .long   Default_IRQ_Handler         /* 29:  WDT_N9 */
    .long   halADC_LISR                 /* 30:  ADC */
    .long   Default_IRQ_Handler         /* 31:  IRDA_TX */
    .long   Default_IRQ_Handler         /* 32:  IRDA_RX */
    .long   Default_IRQ_Handler         /* 33:  USB_VBUS_ON */
    .long   Default_IRQ_Handler         /* 34:  USB_VBUS_OFF */
    .long   Default_IRQ_Handler         /* 35: timer_hit */
    .long   Default_IRQ_Handler         /* 36: GPT3 */
    .long   Default_IRQ_Handler         /* 37: alarm_hit */
    .long   Default_IRQ_Handler         /* 38:  AUDIO */
    .long   Default_IRQ_Handler         /* 39: n9_cm4_sw_irq */
    .long   GPT_INT_Handler             /* 40: GPT4 */
    .long   halADC_COMP_LISR            /* 41: adc_comp_irq */
    .long   Default_IRQ_Handler         /* 42: reserved */
    .long   Default_IRQ_Handler         /* 43: SPIM */
    .long   Default_IRQ_Handler         /* 44:  USB */
    .long   Default_IRQ_Handler         /* 45: UDMA */
    .long   Default_IRQ_Handler         /* 46: TRNG */
    .long   Default_IRQ_Handler         /* 47: reserved */
    
    .long   Default_IRQ_Handler         /* 48: configurable */
    .long   Default_IRQ_Handler         /* 49: configurable */
    .long   Default_IRQ_Handler         /* 50: configurable */
    .long   Default_IRQ_Handler         /* 51: configurable */
    .long   Default_IRQ_Handler         /* 52: configurable */
    .long   Default_IRQ_Handler         /* 53: configurable */
    .long   Default_IRQ_Handler         /* 54: configurable */
    .long   Default_IRQ_Handler         /* 55: configurable */
    .long   Default_IRQ_Handler         /* 56: configurable */
    .long   Default_IRQ_Handler         /* 57: configurable */
    .long   Default_IRQ_Handler         /* 58: configurable */
    .long   Default_IRQ_Handler         /* 59: configurable */
    .long   Default_IRQ_Handler         /* 60: configurable */
    .long   Default_IRQ_Handler         /* 61: configurable */
    .long   Default_IRQ_Handler         /* 62: configurable */
    .long   Default_IRQ_Handler         /* 63: configurable */
    .long   Default_IRQ_Handler         /* 64: configurable */
    .long   Default_IRQ_Handler         /* 65: configurable */
    .long   Default_IRQ_Handler         /* 66: configurable */
    .long   Default_IRQ_Handler         /* 67: configurable */
    .long   Default_IRQ_Handler         /* 68: configurable */
    .long   Default_IRQ_Handler         /* 69: configurable */
    .long   Default_IRQ_Handler         /* 70: configurable */
    .long   Default_IRQ_Handler         /* 71: configurable */
    .long   Default_IRQ_Handler         /* 72: configurable */
    .long   Default_IRQ_Handler         /* 73: configurable */
    .long   Default_IRQ_Handler         /* 74: configurable */
    .long   Default_IRQ_Handler         /* 75: configurable */
    .long   Default_IRQ_Handler         /* 76: configurable */
    .long   Default_IRQ_Handler         /* 77: configurable */
    .long   Default_IRQ_Handler         /* 78: configurable */
    .long   Default_IRQ_Handler         /* 79: configurable */
    .long   Default_IRQ_Handler         /* 80: configurable */
    .long   Default_IRQ_Handler         /* 81: configurable */
    .long   Default_IRQ_Handler         /* 82: configurable */
    .long   Default_IRQ_Handler         /* 83: configurable */
    .long   Default_IRQ_Handler         /* 84: configurable */
    .long   Default_IRQ_Handler         /* 85: configurable */
    .long   Default_IRQ_Handler         /* 86: configurable */
    .long   Default_IRQ_Handler         /* 87: configurable */
    .long   Default_IRQ_Handler         /* 88: configurable */
    .long   Default_IRQ_Handler         /* 89: configurable */
    .long   Default_IRQ_Handler         /* 90: configurable */
    .long   Default_IRQ_Handler         /* 91: configurable */
    .long   Default_IRQ_Handler         /* 92: configurable */
    .long   Default_IRQ_Handler         /* 93: configurable */
    .long   Default_IRQ_Handler         /* 94: configurable */
    .long   Default_IRQ_Handler         /* 95: configurable */
    .long   Default_IRQ_Handler         /* 96: configurable */
    .long   Default_IRQ_Handler         /* 97: configurable */
    .long   Default_IRQ_Handler         /* 98: configurable */
    .long   Default_IRQ_Handler         /* 99: configurable */
    .long   Default_IRQ_Handler         /* 100: configurable */
    .long   Default_IRQ_Handler         /* 101: configurable */
    .long   Default_IRQ_Handler         /* 102: configurable */
    .long   Default_IRQ_Handler         /* 103: configurable */
    .long   Default_IRQ_Handler         /* 104: configurable */
    .long   Default_IRQ_Handler         /* 105: configurable */
    .long   Default_IRQ_Handler         /* 106: configurable */
    .long   Default_IRQ_Handler         /* 107: configurable */
    .long   Default_IRQ_Handler         /* 108: configurable */
    .long   Default_IRQ_Handler         /* 109: configurable */
    .long   Default_IRQ_Handler         /* 110: configurable */
    .long   Default_IRQ_Handler         /* 111: configurable */   

    .size    __isr_vector, . - __isr_vector

    .text
    .thumb
    .thumb_func
    .section .init
    .align 2
    .globl    Reset_Handler
    .type    Reset_Handler, %function
Reset_Handler:
/*     Loop to copy data from read only memory to RAM. The ranges
 *      of copy from/to are specified by following symbols evaluated in 
 *      linker script.
 *      _etext: End of code section, i.e., begin of data sections to copy from.
 *      __data_start__/__data_end__: RAM address range that data should be
 *      copied to. Both must be aligned to 4 bytes boundary.  */
    ldr    sp, =__StackTop    		 /* set stack pointer */
    ldr    r1, =__etext
    ldr    r2, =__data_start__
    ldr    r3, =__data_end__

.Lflash_to_ram_loop:
    cmp     r2, r3
    ittt    lt
    ldrlt   r0, [r1], #4
    strlt   r0, [r2], #4
    blt    .Lflash_to_ram_loop

    ldr    r2, =__ramtext_start__
    ldr    r3, =__ramtext_end__

.Lflash_to_tcm_loop:
    cmp     r2, r3
    ittt    lt
    ldrlt   r0, [r1], #4
    strlt   r0, [r2], #4
    blt    .Lflash_to_tcm_loop


    ldr    r2, =__tcmbss_start__
    ldr    r3, =__tcmbss_end__

.Lbss_to_tcm_loop:
    cmp     r2, r3
    ittt    lt
    movlt   r0, #0
    strlt   r0, [r2], #4
    blt    .Lbss_to_tcm_loop

    ldr    r2, =__bss_start__
    ldr    r3, =__bss_end__

.Lbss_to_ram_loop:
    cmp     r2, r3
    ittt    lt
    movlt   r0, #0
    strlt   r0, [r2], #4
    blt    .Lbss_to_ram_loop

    ldr    r0, =SystemInit
    blx    r0
    /* ldr    r0, =_start*/
    ldr    r0, =main
    bx    r0
    .pool
    .size Reset_Handler, . - Reset_Handler
    
    .text
/*    Macro to define default handlers. Default handler
 *    will be weak symbol and just dead loops. They can be
 *    overwritten by other handlers */
    .macro    def_default_handler    handler_name
    .align 1
    .thumb_func
    .weak    \handler_name
    .type    \handler_name, %function
\handler_name :
    b    .
    .size    \handler_name, . - \handler_name
    .endm

    def_default_handler    NMI_Handler
    def_default_handler    HardFault_Handler
    def_default_handler    MemManage_Handler
    def_default_handler    BusFault_Handler
    def_default_handler    UsageFault_Handler
    def_default_handler    SVC_Handler
    def_default_handler    DebugMon_Handler
    def_default_handler    PendSV_Handler
    def_default_handler    SysTick_Handler
    def_default_handler    Default_Handler

    .macro    def_irq_default_handler    handler_name
    .weak     \handler_name
    .set      \handler_name, Default_Handler
    .endm
    
    def_irq_default_handler     DMA_LISR
    def_irq_default_handler     hal_i2c_callback
    def_irq_default_handler     hal_wdt_isr
    def_irq_default_handler     halADC_LISR
    def_irq_default_handler     GPT_INT_Handler
    def_irq_default_handler     halADC_COMP_LISR
    
    
    .text
    .thumb
    .thumb_func
    .align 2
    .type    Default_IRQ_Handler, %function
 Default_IRQ_Handler:
     b    .
    .size Default_IRQ_Handler, . - Default_IRQ_Handler

    .end


