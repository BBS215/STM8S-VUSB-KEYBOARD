   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  50                     ; 3 void Init_GPIO(void)
  50                     ; 4 {
  52                     .text:	section	.text,new
  53  0000               _Init_GPIO:
  57                     ; 5 	GPIO_DeInit(GPIOA);
  59  0000 ae5000        	ldw	x,#20480
  60  0003 cd0000        	call	_GPIO_DeInit
  62                     ; 6 	GPIO_DeInit(GPIOB);
  64  0006 ae5005        	ldw	x,#20485
  65  0009 cd0000        	call	_GPIO_DeInit
  67                     ; 7 	GPIO_DeInit(GPIOC);
  69  000c ae500a        	ldw	x,#20490
  70  000f cd0000        	call	_GPIO_DeInit
  72                     ; 8 	GPIO_DeInit(GPIOD);
  74  0012 ae500f        	ldw	x,#20495
  76                     ; 9 }
  79  0015 cc0000        	jp	_GPIO_DeInit
 102                     ; 11 void Init_Clock(void)
 102                     ; 12 {
 103                     .text:	section	.text,new
 104  0000               _Init_Clock:
 108                     ; 13 	CLK->CKDIVR = 0; // HSIDIV = 0; CPUDIV = 0
 110  0000 725f50c6      	clr	20678
 111                     ; 14 }
 114  0004 81            	ret	
 143                     ; 16 void SYSTimer_Init(void)
 143                     ; 17 {
 144                     .text:	section	.text,new
 145  0000               _SYSTimer_Init:
 149                     ; 18 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 151  0000 ae0501        	ldw	x,#1281
 152  0003 cd0000        	call	_CLK_PeripheralClockConfig
 154                     ; 19 	TIM2_DeInit();
 156  0006 cd0000        	call	_TIM2_DeInit
 158                     ; 20 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, 10000); // 16 MHz / 16 / 10000 = 100 Hz
 160  0009 ae2710        	ldw	x,#10000
 161  000c 89            	pushw	x
 162  000d a604          	ld	a,#4
 163  000f cd0000        	call	_TIM2_TimeBaseInit
 165  0012 85            	popw	x
 166                     ; 21 	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 168  0013 ae0001        	ldw	x,#1
 169  0016 cd0000        	call	_TIM2_ClearFlag
 171                     ; 22 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 173  0019 ae0101        	ldw	x,#257
 174  001c cd0000        	call	_TIM2_ITConfig
 176                     ; 23 	TIM2_Cmd(ENABLE);
 178  001f a601          	ld	a,#1
 180                     ; 24 }
 183  0021 cc0000        	jp	_TIM2_Cmd
 196                     	xdef	_SYSTimer_Init
 197                     	xdef	_Init_Clock
 198                     	xdef	_Init_GPIO
 199                     	xref	_TIM2_ClearFlag
 200                     	xref	_TIM2_ITConfig
 201                     	xref	_TIM2_Cmd
 202                     	xref	_TIM2_TimeBaseInit
 203                     	xref	_TIM2_DeInit
 204                     	xref	_GPIO_DeInit
 205                     	xref	_CLK_PeripheralClockConfig
 224                     	end
