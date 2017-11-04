   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  50                     ; 53 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  50                     ; 54 {
  51                     .text:	section	.text,new
  52  0000               f_NonHandledInterrupt:
  56                     ; 58 }
  59  0000 80            	iret	
  81                     ; 66 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  81                     ; 67 {
  82                     .text:	section	.text,new
  83  0000               f_TRAP_IRQHandler:
  87                     ; 71 }
  90  0000 80            	iret	
 112                     ; 78 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 112                     ; 79 
 112                     ; 80 {
 113                     .text:	section	.text,new
 114  0000               f_TLI_IRQHandler:
 118                     ; 84 }
 121  0000 80            	iret	
 143                     ; 91 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 143                     ; 92 {
 144                     .text:	section	.text,new
 145  0000               f_AWU_IRQHandler:
 149                     ; 96 }
 152  0000 80            	iret	
 174                     ; 103 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 174                     ; 104 {
 175                     .text:	section	.text,new
 176  0000               f_CLK_IRQHandler:
 180                     ; 108 }
 183  0000 80            	iret	
 206                     ; 115 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 206                     ; 116 {
 207                     .text:	section	.text,new
 208  0000               f_EXTI_PORTA_IRQHandler:
 212                     ; 120 }
 215  0000 80            	iret	
 238                     ; 127 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 238                     ; 128 {
 239                     .text:	section	.text,new
 240  0000               f_EXTI_PORTB_IRQHandler:
 244                     ; 132 }
 247  0000 80            	iret	
 270                     ; 139 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 270                     ; 140 {
 271                     .text:	section	.text,new
 272  0000               f_EXTI_PORTC_IRQHandler:
 276                     ; 144 }
 279  0000 80            	iret	
 302                     ; 151 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 302                     ; 152 {
 303                     .text:	section	.text,new
 304  0000               f_EXTI_PORTD_IRQHandler:
 308                     ; 156 }
 311  0000 80            	iret	
 334                     ; 163 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 334                     ; 164 {
 335                     .text:	section	.text,new
 336  0000               f_EXTI_PORTE_IRQHandler:
 340                     ; 168 }
 343  0000 80            	iret	
 365                     ; 215 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 365                     ; 216 {
 366                     .text:	section	.text,new
 367  0000               f_SPI_IRQHandler:
 371                     ; 220 }
 374  0000 80            	iret	
 397                     ; 227 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 397                     ; 228 {
 398                     .text:	section	.text,new
 399  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 403                     ; 232 }
 406  0000 80            	iret	
 431                     ; 278  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 431                     ; 279  {
 432                     .text:	section	.text,new
 433  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 435  0000 8a            	push	cc
 436  0001 84            	pop	a
 437  0002 a4bf          	and	a,#191
 438  0004 88            	push	a
 439  0005 86            	pop	cc
 440  0006 3b0002        	push	c_x+2
 441  0009 be00          	ldw	x,c_x
 442  000b 89            	pushw	x
 443  000c 3b0002        	push	c_y+2
 444  000f be00          	ldw	x,c_y
 445  0011 89            	pushw	x
 448                     ; 280 		g_systimer_flag = 1;
 450  0012 35010000      	mov	_g_systimer_flag,#1
 451                     ; 281 		TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 453  0016 ae0001        	ldw	x,#1
 454  0019 cd0000        	call	_TIM2_ClearFlag
 456                     ; 282  }
 459  001c 85            	popw	x
 460  001d bf00          	ldw	c_y,x
 461  001f 320002        	pop	c_y+2
 462  0022 85            	popw	x
 463  0023 bf00          	ldw	c_x,x
 464  0025 320002        	pop	c_x+2
 465  0028 80            	iret	
 488                     ; 289  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 488                     ; 290  {
 489                     .text:	section	.text,new
 490  0000               f_TIM2_CAP_COM_IRQHandler:
 494                     ; 294  }
 497  0000 80            	iret	
 520                     ; 331  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 520                     ; 332  {
 521                     .text:	section	.text,new
 522  0000               f_UART1_TX_IRQHandler:
 526                     ; 336  }
 529  0000 80            	iret	
 552                     ; 343  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 552                     ; 344  {
 553                     .text:	section	.text,new
 554  0000               f_UART1_RX_IRQHandler:
 558                     ; 348  }
 561  0000 80            	iret	
 583                     ; 382 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 583                     ; 383 {
 584                     .text:	section	.text,new
 585  0000               f_I2C_IRQHandler:
 589                     ; 387 }
 592  0000 80            	iret	
 614                     ; 461  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 614                     ; 462  {
 615                     .text:	section	.text,new
 616  0000               f_ADC1_IRQHandler:
 620                     ; 466  }
 623  0000 80            	iret	
 646                     ; 487  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 646                     ; 488  {
 647                     .text:	section	.text,new
 648  0000               f_TIM4_UPD_OVF_IRQHandler:
 652                     ; 492  }
 655  0000 80            	iret	
 678                     ; 500 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 678                     ; 501 {
 679                     .text:	section	.text,new
 680  0000               f_EEPROM_EEC_IRQHandler:
 684                     ; 505 }
 687  0000 80            	iret	
 699                     	xref.b	_g_systimer_flag
 700                     	xdef	f_EEPROM_EEC_IRQHandler
 701                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 702                     	xdef	f_ADC1_IRQHandler
 703                     	xdef	f_I2C_IRQHandler
 704                     	xdef	f_UART1_RX_IRQHandler
 705                     	xdef	f_UART1_TX_IRQHandler
 706                     	xdef	f_TIM2_CAP_COM_IRQHandler
 707                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 708                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 709                     	xdef	f_SPI_IRQHandler
 710                     	xdef	f_EXTI_PORTE_IRQHandler
 711                     	xdef	f_EXTI_PORTD_IRQHandler
 712                     	xdef	f_EXTI_PORTC_IRQHandler
 713                     	xdef	f_EXTI_PORTB_IRQHandler
 714                     	xdef	f_EXTI_PORTA_IRQHandler
 715                     	xdef	f_CLK_IRQHandler
 716                     	xdef	f_AWU_IRQHandler
 717                     	xdef	f_TLI_IRQHandler
 718                     	xdef	f_TRAP_IRQHandler
 719                     	xdef	f_NonHandledInterrupt
 720                     	xref	_TIM2_ClearFlag
 721                     	xref.b	c_x
 722                     	xref.b	c_y
 741                     	end
