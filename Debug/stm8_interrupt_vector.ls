   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  21                     .const:	section	.text
  22  0000               __vectab:
  23  0000 82            	dc.b	130
  25  0001 00            	dc.b	page(__stext)
  26  0002 0000          	dc.w	__stext
  27  0004 82            	dc.b	130
  29  0005 00            	dc.b	page(f_TRAP_IRQHandler)
  30  0006 0000          	dc.w	f_TRAP_IRQHandler
  31  0008 82            	dc.b	130
  33  0009 00            	dc.b	page(f_TLI_IRQHandler)
  34  000a 0000          	dc.w	f_TLI_IRQHandler
  35  000c 82            	dc.b	130
  37  000d 00            	dc.b	page(f_AWU_IRQHandler)
  38  000e 0000          	dc.w	f_AWU_IRQHandler
  39  0010 82            	dc.b	130
  41  0011 00            	dc.b	page(f_CLK_IRQHandler)
  42  0012 0000          	dc.w	f_CLK_IRQHandler
  43  0014 82            	dc.b	130
  45  0015 00            	dc.b	page(f_EXTI_PORTA_IRQHandler)
  46  0016 0000          	dc.w	f_EXTI_PORTA_IRQHandler
  47  0018 82            	dc.b	130
  49  0019 00            	dc.b	page(f_EXTI_PORTB_IRQHandler)
  50  001a 0000          	dc.w	f_EXTI_PORTB_IRQHandler
  51  001c 82            	dc.b	130
  53  001d 00            	dc.b	page(f_EXTI_PORTC_IRQHandler)
  54  001e 0000          	dc.w	f_EXTI_PORTC_IRQHandler
  55  0020 82            	dc.b	130
  57  0021 00            	dc.b	page(f_EXTI_PORTD_IRQHandler)
  58  0022 0000          	dc.w	f_EXTI_PORTD_IRQHandler
  59  0024 82            	dc.b	130
  61  0025 00            	dc.b	page(f_EXTI_PORTE_IRQHandler)
  62  0026 0000          	dc.w	f_EXTI_PORTE_IRQHandler
  63  0028 82            	dc.b	130
  65  0029 00            	dc.b	page(f_NonHandledInterrupt)
  66  002a 0000          	dc.w	f_NonHandledInterrupt
  67  002c 82            	dc.b	130
  69  002d 00            	dc.b	page(f_NonHandledInterrupt)
  70  002e 0000          	dc.w	f_NonHandledInterrupt
  71  0030 82            	dc.b	130
  73  0031 00            	dc.b	page(f_SPI_IRQHandler)
  74  0032 0000          	dc.w	f_SPI_IRQHandler
  75  0034 82            	dc.b	130
  77  0035 00            	dc.b	page(f_TIM1_UPD_OVF_TRG_BRK_IRQHandler)
  78  0036 0000          	dc.w	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
  79  0038 82            	dc.b	130
  81  0039 00            	dc.b	page(_ll_usb_rx)
  82  003a 0000          	dc.w	_ll_usb_rx
  83  003c 82            	dc.b	130
  85  003d 00            	dc.b	page(f_TIM2_UPD_OVF_BRK_IRQHandler)
  86  003e 0000          	dc.w	f_TIM2_UPD_OVF_BRK_IRQHandler
  87  0040 82            	dc.b	130
  89  0041 00            	dc.b	page(f_TIM2_CAP_COM_IRQHandler)
  90  0042 0000          	dc.w	f_TIM2_CAP_COM_IRQHandler
  91  0044 82            	dc.b	130
  93  0045 00            	dc.b	page(f_NonHandledInterrupt)
  94  0046 0000          	dc.w	f_NonHandledInterrupt
  95  0048 82            	dc.b	130
  97  0049 00            	dc.b	page(f_NonHandledInterrupt)
  98  004a 0000          	dc.w	f_NonHandledInterrupt
  99  004c 82            	dc.b	130
 101  004d 00            	dc.b	page(f_UART1_TX_IRQHandler)
 102  004e 0000          	dc.w	f_UART1_TX_IRQHandler
 103  0050 82            	dc.b	130
 105  0051 00            	dc.b	page(f_UART1_RX_IRQHandler)
 106  0052 0000          	dc.w	f_UART1_RX_IRQHandler
 107  0054 82            	dc.b	130
 109  0055 00            	dc.b	page(f_I2C_IRQHandler)
 110  0056 0000          	dc.w	f_I2C_IRQHandler
 111  0058 82            	dc.b	130
 113  0059 00            	dc.b	page(f_NonHandledInterrupt)
 114  005a 0000          	dc.w	f_NonHandledInterrupt
 115  005c 82            	dc.b	130
 117  005d 00            	dc.b	page(f_NonHandledInterrupt)
 118  005e 0000          	dc.w	f_NonHandledInterrupt
 119  0060 82            	dc.b	130
 121  0061 00            	dc.b	page(f_ADC1_IRQHandler)
 122  0062 0000          	dc.w	f_ADC1_IRQHandler
 123  0064 82            	dc.b	130
 125  0065 00            	dc.b	page(f_TIM4_UPD_OVF_IRQHandler)
 126  0066 0000          	dc.w	f_TIM4_UPD_OVF_IRQHandler
 127  0068 82            	dc.b	130
 129  0069 00            	dc.b	page(f_EEPROM_EEC_IRQHandler)
 130  006a 0000          	dc.w	f_EEPROM_EEC_IRQHandler
 131  006c 82            	dc.b	130
 133  006d 00            	dc.b	page(f_NonHandledInterrupt)
 134  006e 0000          	dc.w	f_NonHandledInterrupt
 135  0070 82            	dc.b	130
 137  0071 00            	dc.b	page(f_NonHandledInterrupt)
 138  0072 0000          	dc.w	f_NonHandledInterrupt
 139  0074 82            	dc.b	130
 141  0075 00            	dc.b	page(f_NonHandledInterrupt)
 142  0076 0000          	dc.w	f_NonHandledInterrupt
 143  0078 82            	dc.b	130
 145  0079 00            	dc.b	page(f_NonHandledInterrupt)
 146  007a 0000          	dc.w	f_NonHandledInterrupt
 147  007c 82            	dc.b	130
 149  007d 00            	dc.b	page(f_NonHandledInterrupt)
 150  007e 0000          	dc.w	f_NonHandledInterrupt
 210                     	xdef	__vectab
 211                     	xref	f_EEPROM_EEC_IRQHandler
 212                     	xref	f_TIM4_UPD_OVF_IRQHandler
 213                     	xref	f_ADC1_IRQHandler
 214                     	xref	f_I2C_IRQHandler
 215                     	xref	f_UART1_RX_IRQHandler
 216                     	xref	f_UART1_TX_IRQHandler
 217                     	xref	f_TIM2_CAP_COM_IRQHandler
 218                     	xref	f_TIM2_UPD_OVF_BRK_IRQHandler
 219                     	xref	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 220                     	xref	f_SPI_IRQHandler
 221                     	xref	f_EXTI_PORTE_IRQHandler
 222                     	xref	f_EXTI_PORTD_IRQHandler
 223                     	xref	f_EXTI_PORTC_IRQHandler
 224                     	xref	f_EXTI_PORTB_IRQHandler
 225                     	xref	f_EXTI_PORTA_IRQHandler
 226                     	xref	f_CLK_IRQHandler
 227                     	xref	f_AWU_IRQHandler
 228                     	xref	f_TLI_IRQHandler
 229                     	xref	f_TRAP_IRQHandler
 230                     	xref	f_NonHandledInterrupt
 231                     	xref	__stext
 232                     	xref	_ll_usb_rx
 251                     	end
