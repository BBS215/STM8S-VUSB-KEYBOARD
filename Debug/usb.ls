   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  21                     	bsct
  22  0000               _p_HSI_TRIM_VAL:
  23  0000 4000          	dc.w	16384
  24  0002               _p_HSI_TRIMING_DONE:
  25  0002 4001          	dc.w	16385
  56                     ; 18 void USB_Reset(void)
  56                     ; 19 {
  58                     .text:	section	.text,new
  59  0000               _USB_Reset:
  63                     ; 20 	if (usb.dev_state == USB_STATE_CONFIGURED) USB_Class_DeInit_callback();
  65  0000 b604          	ld	a,_usb+4
  66  0002 a103          	cp	a,#3
  67  0004 2603          	jrne	L12
  70  0006 cd0000        	call	_USB_Class_DeInit_callback
  72  0009               L12:
  73                     ; 21 	usb.device_address = 0;
  75  0009 3f01          	clr	_usb+1
  76                     ; 22 	usb.setup_address  = 0;
  78  000b 3f02          	clr	_usb+2
  79                     ; 23 	usb.dev_state = USB_STATE_DEFAULT;
  81  000d 35010004      	mov	_usb+4,#1
  82                     ; 24 	usb.stage = USB_STAGE_NONE;
  84  0011 3f00          	clr	_usb
  85                     ; 25 	usb.dev_config = 0;
  87  0013 3f05          	clr	_usb+5
  88                     ; 26 	usb.active_EP_num = 0;
  90  0015 3f03          	clr	_usb+3
  91                     ; 27 	usb.reset_counter = 0;
  93  0017 5f            	clrw	x
  94  0018 bf41          	ldw	_usb+65,x
  95                     ; 28 	usb.EP[0].tx_length = 0;
  97  001a 3f21          	clr	_usb+33
  98                     ; 29 	usb.EP[0].rx_length = 0;
 100  001c 3f13          	clr	_usb+19
 101                     ; 30 	usb.EP[0].rx_state = USB_EP_NO_DATA;
 103  001e 3f14          	clr	_usb+20
 104                     ; 31 	usb.EP[0].tx_state = USB_EP_NO_DATA;
 106  0020 3f23          	clr	_usb+35
 107                     ; 32 	usb.EP[1].tx_length = 0;
 109  0022 3f3e          	clr	_usb+62
 110                     ; 33 	usb.EP[1].rx_length = 0;
 112  0024 3f30          	clr	_usb+48
 113                     ; 34 	usb.EP[1].rx_state = USB_EP_NO_DATA;
 115  0026 3f31          	clr	_usb+49
 116                     ; 35 	usb.EP[1].tx_state = USB_EP_NO_DATA;
 118  0028 3f40          	clr	_usb+64
 119                     ; 36 }
 122  002a 81            	ret	
 157                     ; 38 void USB_Init(void)
 157                     ; 39 {
 158                     .text:	section	.text,new
 159  0000               _USB_Init:
 163                     ; 41 	usb.delay_counter = 0;
 165  0000 5f            	clrw	x
 166  0001 bf47          	ldw	_usb+71,x
 167                     ; 42 	if (*p_HSI_TRIMING_DONE == MAGIC_VAL)
 169  0003 92c602        	ld	a,[_p_HSI_TRIMING_DONE.w]
 170  0006 a111          	cp	a,#17
 171  0008 2606          	jrne	L33
 172                     ; 43 		usb.trimming_stage = HSI_TRIMMER_DISABLE;
 174  000a 35040046      	mov	_usb+70,#4
 176  000e 2002          	jra	L53
 177  0010               L33:
 178                     ; 45 		usb.trimming_stage = HSI_TRIMMER_ENABLE;
 180  0010 3f46          	clr	_usb+70
 181  0012               L53:
 182                     ; 46 	usb.HSI_Trim_val = (uint8_t)(*p_HSI_TRIM_VAL & 0x0F);
 184  0012 92c600        	ld	a,[_p_HSI_TRIM_VAL.w]
 185  0015 a40f          	and	a,#15
 186  0017 b749          	ld	_usb+73,a
 187                     ; 47 	CLK->HSITRIMR = (uint8_t)((CLK->HSITRIMR & (~0x0F)) | usb.HSI_Trim_val);
 189  0019 c650cc        	ld	a,20684
 190  001c a4f0          	and	a,#240
 191  001e ba49          	or	a,_usb+73
 192  0020 c750cc        	ld	20684,a
 193                     ; 51 	GPIO_Init(USB_CONNECT_PORT, USB_CONNECT_PIN, GPIO_MODE_OUT_PP_LOW_SLOW); // USB_CONNECT
 195  0023 4bc0          	push	#192
 196  0025 4b08          	push	#8
 197  0027 ae5000        	ldw	x,#20480
 198  002a cd0000        	call	_GPIO_Init
 200  002d 35010004      	mov	_usb+4,#1
 201  0031 85            	popw	x
 202                     ; 53 	usb.dev_state = USB_STATE_DEFAULT;
 204                     ; 55 	usb.WDG_EP_timeout = USB_EP_WATCHDOG_TIMEOUT+1;
 206  0032 ae012d        	ldw	x,#301
 207  0035 bf4a          	ldw	_usb+74,x
 208                     ; 57 	USB_Reset();
 210  0037 cd0000        	call	_USB_Reset
 212                     ; 59 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 214  003a ae0701        	ldw	x,#1793
 215  003d cd0000        	call	_CLK_PeripheralClockConfig
 217                     ; 60 	TIM1_TimeBaseInit(0, TIM1_PSCRELOADMODE_UPDATE, 1000, 0);
 219  0040 4b00          	push	#0
 220  0042 ae03e8        	ldw	x,#1000
 221  0045 89            	pushw	x
 222  0046 4b00          	push	#0
 223  0048 5f            	clrw	x
 224  0049 cd0000        	call	_TIM1_TimeBaseInit
 226  004c 5b04          	addw	sp,#4
 227                     ; 61 	TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x02); // захват сигнала по линии USB D-
 229  004e 4b02          	push	#2
 230  0050 4b00          	push	#0
 231  0052 4b01          	push	#1
 232  0054 ae0101        	ldw	x,#257
 233  0057 cd0000        	call	_TIM1_ICInit
 235  005a 5b03          	addw	sp,#3
 236                     ; 62 	TIM1_SelectInputTrigger(TIM1_TS_TI2FP2);
 238  005c a660          	ld	a,#96
 239  005e cd0000        	call	_TIM1_SelectInputTrigger
 241                     ; 63 	TIM1_SelectSlaveMode(TIM1_SLAVEMODE_TRIGGER);
 243  0061 a606          	ld	a,#6
 244  0063 cd0000        	call	_TIM1_SelectSlaveMode
 246                     ; 64 	TIM1_ClearFlag(TIM1_FLAG_CC2);
 248  0066 ae0004        	ldw	x,#4
 249  0069 cd0000        	call	_TIM1_ClearFlag
 251                     ; 65 	TIM1_ITConfig(TIM1_IT_CC2, ENABLE);
 253  006c ae0401        	ldw	x,#1025
 255                     ; 66 }
 258  006f cc0000        	jp	_TIM1_ITConfig
 282                     ; 68 void USB_connect(void)
 282                     ; 69 {
 283                     .text:	section	.text,new
 284  0000               _USB_connect:
 288                     ; 70 	GPIO_WriteHigh(USB_CONNECT_PORT, USB_CONNECT_PIN);
 290  0000 4b08          	push	#8
 291  0002 ae5000        	ldw	x,#20480
 292  0005 cd0000        	call	_GPIO_WriteHigh
 294  0008 84            	pop	a
 295                     ; 71 }
 298  0009 81            	ret	
 322                     ; 73 void USB_disconnect(void)
 322                     ; 74 {
 323                     .text:	section	.text,new
 324  0000               _USB_disconnect:
 328                     ; 75 	GPIO_WriteLow(USB_CONNECT_PORT, USB_CONNECT_PIN);
 330  0000 4b08          	push	#8
 331  0002 ae5000        	ldw	x,#20480
 332  0005 cd0000        	call	_GPIO_WriteLow
 334  0008 84            	pop	a
 335                     ; 76 }
 338  0009 81            	ret	
 341                     .const:	section	.text
 342  0000               L75_data:
 343  0000 80            	dc.b	128
 344  0001 5a            	dc.b	90
 380                     ; 78 void usb_send_nack(void)
 380                     ; 79 {
 381                     .text:	section	.text,new
 382  0000               _usb_send_nack:
 384  0000 89            	pushw	x
 385       00000002      OFST:	set	2
 388                     ; 80 	const uint8_t data[2] = {USB_SYNC_BYTE, USB_PID_NACK};
 390  0001 c60000        	ld	a,L75_data
 391  0004 6b01          	ld	(OFST-1,sp),a
 392  0006 c60001        	ld	a,L75_data+1
 393  0009 6b02          	ld	(OFST+0,sp),a
 394                     ; 82 	GPIOC->ODR |= 0x40; // set PC6
 396  000b 721c500a      	bset	20490,#6
 397                     ; 83 	GPIOC->CR1 |= 0xC0; // PC6, PC7 - PP (PU) mode
 399  000f c6500d        	ld	a,20493
 400  0012 aac0          	or	a,#192
 401  0014 c7500d        	ld	20493,a
 402                     ; 84 	GPIOC->CR2 |= 0xC0; // PC6, PC7 - 10 MHz mode (external INTR enable)
 404  0017 c6500e        	ld	a,20494
 405  001a aac0          	or	a,#192
 406  001c c7500e        	ld	20494,a
 407                     ; 85 	GPIOC->DDR |= 0xC0; // PC6, PC7 - output mode
 409  001f c6500c        	ld	a,20492
 410  0022 aac0          	or	a,#192
 411  0024 c7500c        	ld	20492,a
 412                     ; 87 	ll_usb_tx_count = 2;
 414  0027 3502004d      	mov	_ll_usb_tx_count,#2
 415                     ; 88 	ll_usb_tx_buffer_pointer = data;
 417  002b 96            	ldw	x,sp
 418  002c 5c            	incw	x
 419  002d bf4e          	ldw	_ll_usb_tx_buffer_pointer,x
 420                     ; 89 	ll_usb_tx();
 422  002f cd0000        	call	_ll_usb_tx
 424                     ; 91 	GPIOC->CR2 &= (uint8_t)~0xC0; // PC6, PC7 - disable external INTR (2 MHz)
 426  0032 c6500e        	ld	a,20494
 427  0035 a43f          	and	a,#63
 428  0037 c7500e        	ld	20494,a
 429                     ; 92 	GPIOC->CR1 &= (uint8_t)~0xC0; // PC6, PC7 - disable PU (PP) mode
 431  003a c6500d        	ld	a,20493
 432  003d a43f          	and	a,#63
 433  003f c7500d        	ld	20493,a
 434                     ; 93 	GPIOC->DDR = 0; // PC0..PC7 - input mode
 436  0042 725f500c      	clr	20492
 437                     ; 94 }
 440  0046 85            	popw	x
 441  0047 81            	ret	
 444                     	switch	.const
 445  0002               L77_data:
 446  0002 80            	dc.b	128
 447  0003 d2            	dc.b	210
 448  0004               L311_data:
 449  0004 80            	dc.b	128
 450  0005 d2            	dc.b	210
 511                     ; 143 void usb_rx_ok(void)
 511                     ; 144 {
 512                     .text:	section	.text,new
 513  0000               _usb_rx_ok:
 515  0000 89            	pushw	x
 516       00000002      OFST:	set	2
 519                     ; 145 	switch (ll_usb_rx_buffer[1])
 521  0001 b651          	ld	a,_ll_usb_rx_buffer+1
 523                     ; 204 		default:
 523                     ; 205 			break;
 524  0003 a02d          	sub	a,#45
 525  0005 2716          	jreq	L101
 526  0007 a01e          	sub	a,#30
 527  0009 2603cc0094    	jreq	L111
 528  000e a01e          	sub	a,#30
 529  0010 2734          	jreq	L501
 530  0012 a05a          	sub	a,#90
 531  0014 277e          	jreq	L111
 532  0016 a01e          	sub	a,#30
 533  0018 2714          	jreq	L301
 534  001a cc00ff        	jra	L351
 535  001d               L101:
 536                     ; 147 		case USB_PID_SETUP:
 536                     ; 148 			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
 538  001d cd0147        	call	LC005
 539  0020 2703cc00fd    	jrne	L102
 540                     ; 150 				usb.stage = USB_STAGE_SETUP;
 542  0025 35010000      	mov	_usb,#1
 543                     ; 151 				usb.active_EP_num = 0;//(usb_rx_buffer[2] & 0x80)?1:0;
 545  0029 3f03          	clr	_usb+3
 547  002b cc00ff        	jra	L351
 548                     ; 152 			} else usb.stage = USB_STAGE_NONE;
 549  002e               L301:
 550                     ; 155 		case USB_PID_OUT:
 550                     ; 156 			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
 552  002e cd0147        	call	LC005
 553  0031 26ef          	jrne	L102
 554                     ; 158 				usb.stage = USB_STAGE_OUT;
 556  0033 35020000      	mov	_usb,#2
 557                     ; 159 				usb.active_EP_num = (uint8_t)((ll_usb_rx_buffer[2] & 0x80)?1:0);
 559  0037 720f005204    	btjf	_ll_usb_rx_buffer+2,#7,L25
 560  003c a601          	ld	a,#1
 561  003e 2001          	jra	L45
 562  0040               L25:
 563  0040 4f            	clr	a
 564  0041               L45:
 565  0041 b703          	ld	_usb+3,a
 567  0043 cc00ff        	jra	L351
 568                     ; 160 			} else usb.stage = USB_STAGE_NONE;
 569  0046               L501:
 570                     ; 163 		case USB_PID_IN:
 570                     ; 164 			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
 572  0046 cd0147        	call	LC005
 573  0049 26d7          	jrne	L102
 574                     ; 166 				usb.active_EP_num = (uint8_t)((ll_usb_rx_buffer[2] & 0x80)?1:0);
 576  004b 720f005204    	btjf	_ll_usb_rx_buffer+2,#7,L65
 577  0050 a601          	ld	a,#1
 578  0052 2001          	jra	L06
 579  0054               L65:
 580  0054 4f            	clr	a
 581  0055               L06:
 582  0055 b703          	ld	_usb+3,a
 583                     ; 167 				if (usb.EP[usb.active_EP_num].tx_state == USB_EP_DATA_READY) {
 585  0057 cd0142        	call	LC004
 586  005a e623          	ld	a,(_usb+35,x)
 587  005c 4a            	dec	a
 588  005d 2628          	jrne	L761
 589                     ; 168 					usb_send_packet(usb.active_EP_num);
 592  005f b603          	ld	a,_usb+3
 593  0061 6b02          	ld	(OFST+0,sp),a
 595                     ; 116 	GPIOC->ODR |= 0x40; // set PC6
 597  0063 cd0109        	call	LC002
 598                     ; 121 	ll_usb_tx_count = usb.EP[EP_num].tx_length;
 600  0066 7b02          	ld	a,(OFST+0,sp)
 601  0068 cd0142        	call	LC004
 602  006b e621          	ld	a,(_usb+33,x)
 603  006d b74d          	ld	_ll_usb_tx_count,a
 604                     ; 122 	ll_usb_tx_buffer_pointer = usb.EP[EP_num].tx_buffer;
 606  006f 01            	rrwa	x,a
 607  0070 ab15          	add	a,#_usb+21
 608  0072 5f            	clrw	x
 609  0073 97            	ld	xl,a
 610  0074 cd0126        	call	LC003
 611  0077 cd0142        	call	LC004
 612  007a 6f23          	clr	(_usb+35,x)
 613                     ; 170 					if (usb.setup_address) {
 615  007c b602          	ld	a,_usb+2
 616  007e 270a          	jreq	L371
 617                     ; 171 						usb.device_address = usb.setup_address;
 619  0080 450201        	mov	_usb+1,_usb+2
 620                     ; 172 						usb.setup_address = 0;
 622  0083 3f02          	clr	_usb+2
 623  0085 2003          	jra	L371
 624  0087               L761:
 625                     ; 175 					usb_send_nack();
 627  0087 cd0000        	call	_usb_send_nack
 629  008a               L371:
 630                     ; 178 				if (usb.WDG_EP_timeout > 0) usb.WDG_EP_timeout = 0;
 632  008a 9c            	rvf	
 633  008b be4a          	ldw	x,_usb+74
 634  008d 2d6e          	jrsle	L102
 637  008f 5f            	clrw	x
 638  0090 bf4a          	ldw	_usb+74,x
 639                     ; 181 			usb.stage = USB_STAGE_NONE;
 640                     ; 182 			break;
 642  0092 2069          	jp	L102
 643  0094               L111:
 644                     ; 184 		case USB_PID_DATA0: // Data received
 644                     ; 185 		case USB_PID_DATA1: // Data received
 644                     ; 186 			if (usb.stage != USB_STAGE_NONE) {
 646  0094 3d00          	tnz	_usb
 647  0096 2767          	jreq	L351
 648                     ; 187 				if (usb.EP[usb.active_EP_num].rx_state == USB_EP_NO_DATA) // if EP ready
 650  0098 b603          	ld	a,_usb+3
 651  009a cd0142        	call	LC004
 652  009d 6d14          	tnz	(_usb+20,x)
 653  009f 265c          	jrne	L102
 654                     ; 189 					usb.EP[usb.active_EP_num].rx_state = USB_EP_DATA_READY;
 656  00a1 a601          	ld	a,#1
 657  00a3 e714          	ld	(_usb+20,x),a
 658                     ; 98 	const uint8_t data[2] = {USB_SYNC_BYTE, USB_PID_ACK};
 661  00a5 c60004        	ld	a,L311_data
 662  00a8 6b01          	ld	(OFST-1,sp),a
 663  00aa c60005        	ld	a,L311_data+1
 664  00ad 6b02          	ld	(OFST+0,sp),a
 665                     ; 100 	GPIOC->ODR |= 0x40; // set PC6
 667  00af ad58          	call	LC002
 668                     ; 105 	ll_usb_tx_count = 2;
 670  00b1 3502004d      	mov	_ll_usb_tx_count,#2
 671                     ; 106 	ll_usb_tx_buffer_pointer = data;
 673  00b5 96            	ldw	x,sp
 674  00b6 5c            	incw	x
 675  00b7 ad6d          	call	LC003
 676  00b9 2603          	jrne	L302
 677                     ; 191 					if (usb.active_EP_num == 0) usb.EP0_data_stage = usb.stage; // USB_STAGE_SETUP or USB_STAGE_OUT
 679  00bb 450006        	mov	_usb+6,_usb
 680  00be               L302:
 681                     ; 192 					usb.EP[usb.active_EP_num].rx_length = (uint8_t)(14 - ll_usb_rx_count);
 683  00be cd0142        	call	LC004
 684  00c1 a60e          	ld	a,#14
 685  00c3 b04c          	sub	a,_ll_usb_rx_count
 686  00c5 e713          	ld	(_usb+19,x),a
 687                     ; 193 					if (usb.EP[usb.active_EP_num].rx_length > 3) {
 689  00c7 b603          	ld	a,_usb+3
 690  00c9 ad77          	call	LC004
 691  00cb e613          	ld	a,(_usb+19,x)
 692  00cd a104          	cp	a,#4
 693  00cf 252a          	jrult	L502
 694                     ; 194 						usb.EP[usb.active_EP_num].rx_length -= 3; // 1..9
 696  00d1 a003          	sub	a,#3
 697  00d3 e713          	ld	(_usb+19,x),a
 698                     ; 195 						usb_copy_rx_packet(usb.active_EP_num);
 702                     ; 132 	usb.EP[EP_num].rx_buffer[0] = ll_usb_rx_buffer[2];
 704  00d5 b652          	ld	a,_ll_usb_rx_buffer+2
 705  00d7 e707          	ld	(_usb+7,x),a
 706                     ; 133 	usb.EP[EP_num].rx_buffer[1] = ll_usb_rx_buffer[3];
 708  00d9 b653          	ld	a,_ll_usb_rx_buffer+3
 709  00db e708          	ld	(_usb+8,x),a
 710                     ; 134 	usb.EP[EP_num].rx_buffer[2] = ll_usb_rx_buffer[4];
 712  00dd b654          	ld	a,_ll_usb_rx_buffer+4
 713  00df e709          	ld	(_usb+9,x),a
 714                     ; 135 	usb.EP[EP_num].rx_buffer[3] = ll_usb_rx_buffer[5];
 716  00e1 b655          	ld	a,_ll_usb_rx_buffer+5
 717  00e3 e70a          	ld	(_usb+10,x),a
 718                     ; 136 	usb.EP[EP_num].rx_buffer[4] = ll_usb_rx_buffer[6];
 720  00e5 b656          	ld	a,_ll_usb_rx_buffer+6
 721  00e7 e70b          	ld	(_usb+11,x),a
 722                     ; 137 	usb.EP[EP_num].rx_buffer[5] = ll_usb_rx_buffer[7];
 724  00e9 b657          	ld	a,_ll_usb_rx_buffer+7
 725  00eb e70c          	ld	(_usb+12,x),a
 726                     ; 138 	usb.EP[EP_num].rx_buffer[6] = ll_usb_rx_buffer[8];
 728  00ed b658          	ld	a,_ll_usb_rx_buffer+8
 729  00ef e70d          	ld	(_usb+13,x),a
 730                     ; 139 	usb.EP[EP_num].rx_buffer[7] = ll_usb_rx_buffer[9];
 732  00f1 b659          	ld	a,_ll_usb_rx_buffer+9
 733  00f3 e70e          	ld	(_usb+14,x),a
 734                     ; 140 	usb.EP[EP_num].rx_buffer[8] = ll_usb_rx_buffer[10];
 736  00f5 b65a          	ld	a,_ll_usb_rx_buffer+10
 737  00f7 e70f          	ld	(_usb+15,x),a
 738  00f9 2002          	jra	L102
 739  00fb               L502:
 740                     ; 196 					} else usb.EP[usb.active_EP_num].rx_length = 0;
 742  00fb 6f13          	clr	(_usb+19,x)
 743  00fd               L102:
 744                     ; 198 				usb.stage = USB_STAGE_NONE;
 749  00fd 3f00          	clr	_usb
 750                     ; 204 		default:
 750                     ; 205 			break;
 752  00ff               L351:
 753                     ; 208 	if (usb.trimming_stage == HSI_TRIMMER_ENABLE)
 755  00ff b646          	ld	a,_usb+70
 756  0101 2604          	jrne	L112
 757                     ; 209 		usb.trimming_stage = HSI_TRIMMER_STARTED;
 759  0103 35010046      	mov	_usb+70,#1
 760  0107               L112:
 761                     ; 211 }
 764  0107 85            	popw	x
 765  0108 81            	ret	
 766  0109               LC002:
 767  0109 721c500a      	bset	20490,#6
 768                     ; 117 	GPIOC->CR1 |= 0xC0; // PC6, PC7 - PP (PU) mode
 770  010d c6500d        	ld	a,20493
 771  0110 aac0          	or	a,#192
 772  0112 c7500d        	ld	20493,a
 773                     ; 118 	GPIOC->CR2 |= 0xC0; // PC6, PC7 - 10 MHz mode (external INTR enable)
 775  0115 c6500e        	ld	a,20494
 776  0118 aac0          	or	a,#192
 777  011a c7500e        	ld	20494,a
 778                     ; 119 	GPIOC->DDR |= 0xC0; // PC6, PC7 - output mode
 780  011d c6500c        	ld	a,20492
 781  0120 aac0          	or	a,#192
 782  0122 c7500c        	ld	20492,a
 783  0125 81            	ret	
 784  0126               LC003:
 785  0126 bf4e          	ldw	_ll_usb_tx_buffer_pointer,x
 786                     ; 123 	ll_usb_tx();
 788  0128 cd0000        	call	_ll_usb_tx
 790                     ; 125 	GPIOC->CR2 &= (uint8_t)~0xC0; // PC6, PC7 - disable external INTR (2 MHz)
 792  012b c6500e        	ld	a,20494
 793  012e a43f          	and	a,#63
 794  0130 c7500e        	ld	20494,a
 795                     ; 126 	GPIOC->CR1 &= (uint8_t)~0xC0; // PC6, PC7 - disable PU (PP) mode
 797  0133 c6500d        	ld	a,20493
 798  0136 a43f          	and	a,#63
 799  0138 c7500d        	ld	20493,a
 800                     ; 127 	GPIOC->DDR = 0; // PC0..PC7 - input mode
 802  013b 725f500c      	clr	20492
 803                     ; 169 					usb.EP[usb.active_EP_num].tx_state = USB_EP_NO_DATA;
 805  013f b603          	ld	a,_usb+3
 806  0141 81            	ret	
 807  0142               LC004:
 808  0142 97            	ld	xl,a
 809  0143 a61d          	ld	a,#29
 810  0145 42            	mul	x,a
 811  0146 81            	ret	
 812  0147               LC005:
 813  0147 b652          	ld	a,_ll_usb_rx_buffer+2
 814  0149 a47f          	and	a,#127
 815  014b b101          	cp	a,_usb+1
 816  014d 81            	ret	
 887                     ; 213 void usb_calc_crc16(uint8_t * buffer, uint8_t length)
 887                     ; 214 {
 888                     .text:	section	.text,new
 889  0000               _usb_calc_crc16:
 891  0000 89            	pushw	x
 892  0001 5204          	subw	sp,#4
 893       00000004      OFST:	set	4
 896                     ; 215 	uint16_t crc = 0xFFFF;
 898  0003 aeffff        	ldw	x,#65535
 899  0006 1f03          	ldw	(OFST-1,sp),x
 901                     ; 219 	for (index = 0; index < length; index++)
 903  0008 0f01          	clr	(OFST-3,sp)
 906  000a 203c          	jra	L552
 907  000c               L152:
 908                     ; 221 		crc ^= *buffer++;
 910  000c 1e05          	ldw	x,(OFST+1,sp)
 911  000e f6            	ld	a,(x)
 912  000f 5c            	incw	x
 913  0010 1f05          	ldw	(OFST+1,sp),x
 914  0012 5f            	clrw	x
 915  0013 97            	ld	xl,a
 916  0014 01            	rrwa	x,a
 917  0015 1804          	xor	a,(OFST+0,sp)
 918  0017 01            	rrwa	x,a
 919  0018 1803          	xor	a,(OFST-1,sp)
 920  001a 01            	rrwa	x,a
 921  001b 1f03          	ldw	(OFST-1,sp),x
 923                     ; 223 		for (i = 8; i--;)
 925  001d a608          	ld	a,#8
 926  001f 6b02          	ld	(OFST-2,sp),a
 929  0021 201c          	jra	L562
 930  0023               L162:
 931                     ; 225 			if ((crc & BIT(0)) != 0)
 933  0023 7b04          	ld	a,(OFST+0,sp)
 934  0025 a501          	bcp	a,#1
 935  0027 2712          	jreq	L172
 936                     ; 227 				crc >>= 1;
 938  0029 0403          	srl	(OFST-1,sp)
 939  002b 0604          	rrc	(OFST+0,sp)
 941                     ; 228 				crc ^= 0xA001;
 943  002d 7b04          	ld	a,(OFST+0,sp)
 944  002f a801          	xor	a,#1
 945  0031 6b04          	ld	(OFST+0,sp),a
 946  0033 7b03          	ld	a,(OFST-1,sp)
 947  0035 a8a0          	xor	a,#160
 948  0037 6b03          	ld	(OFST-1,sp),a
 951  0039 2004          	jra	L562
 952  003b               L172:
 953                     ; 230 				crc >>= 1;
 955  003b 0403          	srl	(OFST-1,sp)
 956  003d 0604          	rrc	(OFST+0,sp)
 958  003f               L562:
 959                     ; 223 		for (i = 8; i--;)
 961  003f 7b02          	ld	a,(OFST-2,sp)
 962  0041 0a02          	dec	(OFST-2,sp)
 964  0043 4d            	tnz	a
 965  0044 26dd          	jrne	L162
 966                     ; 219 	for (index = 0; index < length; index++)
 968  0046 0c01          	inc	(OFST-3,sp)
 970  0048               L552:
 973  0048 7b01          	ld	a,(OFST-3,sp)
 974  004a 1109          	cp	a,(OFST+5,sp)
 975  004c 25be          	jrult	L152
 976                     ; 235 	crc = ~crc;
 978  004e 1e03          	ldw	x,(OFST-1,sp)
 979  0050 53            	cplw	x
 980  0051 1f03          	ldw	(OFST-1,sp),x
 982                     ; 237 	*buffer++ = (uint8_t) crc;
 984  0053 1e05          	ldw	x,(OFST+1,sp)
 985  0055 7b04          	ld	a,(OFST+0,sp)
 986  0057 f7            	ld	(x),a
 987  0058 5c            	incw	x
 988  0059 1f05          	ldw	(OFST+1,sp),x
 989                     ; 238 	*buffer = (uint8_t) (crc >> 8);
 991  005b 7b03          	ld	a,(OFST-1,sp)
 992  005d f7            	ld	(x),a
 993                     ; 239 }
 996  005e 5b06          	addw	sp,#6
 997  0060 81            	ret	
1081                     ; 241 int8_t USB_Send_Data(uint8_t * buffer, uint8_t length, uint8_t EP_num)
1081                     ; 242 {
1082                     .text:	section	.text,new
1083  0000               _USB_Send_Data:
1085  0000 89            	pushw	x
1086  0001 5204          	subw	sp,#4
1087       00000004      OFST:	set	4
1090                     ; 244 	uint8_t flag = 0;
1092  0003 0f01          	clr	(OFST-3,sp)
1094                     ; 245 	uint16_t timeout = 30000;
1096  0005 ae7530        	ldw	x,#30000
1097  0008 1f02          	ldw	(OFST-2,sp),x
1099                     ; 247 	if (EP_num == 0) { // EP 0 - CONTROL
1101  000a 7b0a          	ld	a,(OFST+6,sp)
1102  000c 2625          	jrne	L733
1104  000e 2003          	jra	L343
1105  0010               L143:
1106                     ; 250 		{ timeout--; }
1108  0010 5a            	decw	x
1109  0011 1f02          	ldw	(OFST-2,sp),x
1111  0013               L343:
1112                     ; 249 		while ((usb.EP[0].tx_state == USB_EP_DATA_READY)&&(timeout)) // wait for prev transmission 
1114  0013 b623          	ld	a,_usb+35
1115  0015 4a            	dec	a
1116  0016 2604          	jrne	L743
1118  0018 1e02          	ldw	x,(OFST-2,sp)
1119  001a 26f4          	jrne	L143
1120  001c               L743:
1121                     ; 251 		if (timeout == 0) {
1123  001c 1e02          	ldw	x,(OFST-2,sp)
1124  001e 260d          	jrne	L153
1125                     ; 252 			usb.EP[0].tx_state = USB_EP_NO_DATA; // drop old packet
1127  0020 3f23          	clr	_usb+35
1128                     ; 254 			USB_disconnect();
1130  0022 cd0000        	call	_USB_disconnect
1132                     ; 255 			USB_Reset();
1134  0025 cd0000        	call	_USB_Reset
1136                     ; 256 			usb.WDG_EP_timeout = -USB_EP_WATCHDOG_RECONNECT_DELAY;
1138  0028 aeff9c        	ldw	x,#65436
1139  002b bf4a          	ldw	_usb+74,x
1140  002d               L153:
1141                     ; 259 		usb.EP[0].tx_data_sync = USB_PID_DATA1;
1143  002d 354b0022      	mov	_usb+34,#75
1145  0031 2017          	jra	L353
1146  0033               L733:
1147                     ; 261 		if (usb.dev_state != USB_STATE_CONFIGURED) return -2;
1149  0033 b604          	ld	a,_usb+4
1150  0035 a103          	cp	a,#3
1151  0037 2704          	jreq	L553
1154  0039 a6fe          	ld	a,#254
1156  003b 2008          	jra	L211
1157  003d               L553:
1158                     ; 262 		if (length > 8) return -3; // 8 bytes max for INTR EP
1160  003d 7b09          	ld	a,(OFST+5,sp)
1161  003f a109          	cp	a,#9
1162  0041 2505          	jrult	L753
1165  0043 a6fd          	ld	a,#253
1167  0045               L211:
1169  0045 5b06          	addw	sp,#6
1170  0047 81            	ret	
1171  0048               L753:
1172                     ; 263 		usb.EP[1].tx_state = USB_EP_NO_DATA; // drop old packet
1174  0048 3f40          	clr	_usb+64
1175  004a               L353:
1176                     ; 266 	if (length == 0) flag = 1;	// Just send an empty packet
1178  004a 7b09          	ld	a,(OFST+5,sp)
1179  004c 2703cc011e    	jrne	L763
1182  0051 4c            	inc	a
1183  0052 6b01          	ld	(OFST-3,sp),a
1186  0054 cc0125        	jra	L363
1187  0057               L563:
1188                     ; 270 		usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
1190  0057 7b0a          	ld	a,(OFST+6,sp)
1191  0059 cd0155        	call	LC006
1192  005c a680          	ld	a,#128
1193  005e e715          	ld	(_usb+21,x),a
1194                     ; 271 		usb.EP[EP_num].tx_buffer[1] = usb.EP[EP_num].tx_data_sync;
1196  0060 e622          	ld	a,(_usb+34,x)
1197  0062 e716          	ld	(_usb+22,x),a
1198                     ; 273 		if ((length == 8)&&(EP_num == 0)) flag = 1;	// If the length of last DATA packet is 8, then finialize the transcation by an empty packet
1200  0064 7b09          	ld	a,(OFST+5,sp)
1201  0066 a108          	cp	a,#8
1202  0068 260a          	jrne	L373
1204  006a 0d0a          	tnz	(OFST+6,sp)
1205  006c 2606          	jrne	L373
1208  006e a601          	ld	a,#1
1209  0070 6b01          	ld	(OFST-3,sp),a
1211  0072 7b09          	ld	a,(OFST+5,sp)
1212  0074               L373:
1213                     ; 275 		if (length > 8)
1215  0074 a109          	cp	a,#9
1216  0076 2553          	jrult	L573
1217                     ; 277 			usb.EP[EP_num].tx_length = 12; // 2+8+2
1219  0078 a60c          	ld	a,#12
1220  007a e721          	ld	(_usb+33,x),a
1221                     ; 279 			for (i = 2; i < 10; i++)
1223  007c a602          	ld	a,#2
1224  007e 6b04          	ld	(OFST+0,sp),a
1226  0080               L773:
1227                     ; 280 				usb.EP[EP_num].tx_buffer[i] = *buffer++;
1229  0080 7b0a          	ld	a,(OFST+6,sp)
1230  0082 cd0155        	call	LC006
1231  0085 01            	rrwa	x,a
1232  0086 1b04          	add	a,(OFST+0,sp)
1233  0088 2401          	jrnc	L201
1234  008a 5c            	incw	x
1235  008b               L201:
1236  008b 1605          	ldw	y,(OFST+1,sp)
1237  008d 02            	rlwa	x,a
1238  008e 90f6          	ld	a,(y)
1239  0090 905c          	incw	y
1240  0092 1705          	ldw	(OFST+1,sp),y
1241  0094 e715          	ld	(_usb+21,x),a
1242                     ; 279 			for (i = 2; i < 10; i++)
1244  0096 0c04          	inc	(OFST+0,sp)
1248  0098 7b04          	ld	a,(OFST+0,sp)
1249  009a a10a          	cp	a,#10
1250  009c 25e2          	jrult	L773
1251                     ; 281 			length -= 8;
1253  009e 7b09          	ld	a,(OFST+5,sp)
1254  00a0 a008          	sub	a,#8
1255  00a2 6b09          	ld	(OFST+5,sp),a
1257  00a4               L504:
1258                     ; 290 		usb_calc_crc16(&usb.EP[EP_num].tx_buffer[2], (uint8_t) (usb.EP[EP_num].tx_length - 4));
1260  00a4 7b0a          	ld	a,(OFST+6,sp)
1261  00a6 cd0155        	call	LC006
1262  00a9 e621          	ld	a,(_usb+33,x)
1263  00ab a004          	sub	a,#4
1264  00ad 88            	push	a
1265  00ae 7b0b          	ld	a,(OFST+7,sp)
1266  00b0 cd0155        	call	LC006
1267  00b3 01            	rrwa	x,a
1268  00b4 ab17          	add	a,#_usb+23
1269  00b6 5f            	clrw	x
1270  00b7 97            	ld	xl,a
1271  00b8 cd0000        	call	_usb_calc_crc16
1273  00bb 84            	pop	a
1274                     ; 293 		if (usb.EP[EP_num].tx_data_sync == USB_PID_DATA1) 
1276  00bc 7b0a          	ld	a,(OFST+6,sp)
1277  00be cd0155        	call	LC006
1278  00c1 e622          	ld	a,(_usb+34,x)
1279  00c3 a14b          	cp	a,#75
1280  00c5 263e          	jrne	L714
1281                     ; 294 			usb.EP[EP_num].tx_data_sync = USB_PID_DATA0;
1283  00c7 a6c3          	ld	a,#195
1285  00c9 203c          	jra	L124
1286  00cb               L573:
1287                     ; 283 			usb.EP[EP_num].tx_length = (uint8_t)(4 + length);
1289  00cb ab04          	add	a,#4
1290  00cd e721          	ld	(_usb+33,x),a
1291                     ; 284 			for (i = 2; i < 2 + length; i++)
1293  00cf a602          	ld	a,#2
1294  00d1 6b04          	ld	(OFST+0,sp),a
1297  00d3 2019          	jra	L314
1298  00d5               L704:
1299                     ; 285 				usb.EP[EP_num].tx_buffer[i] = *buffer++;
1301  00d5 7b0a          	ld	a,(OFST+6,sp)
1302  00d7 ad7c          	call	LC006
1303  00d9 01            	rrwa	x,a
1304  00da 1b04          	add	a,(OFST+0,sp)
1305  00dc 2401          	jrnc	L401
1306  00de 5c            	incw	x
1307  00df               L401:
1308  00df 1605          	ldw	y,(OFST+1,sp)
1309  00e1 02            	rlwa	x,a
1310  00e2 90f6          	ld	a,(y)
1311  00e4 905c          	incw	y
1312  00e6 1705          	ldw	(OFST+1,sp),y
1313  00e8 e715          	ld	(_usb+21,x),a
1314                     ; 284 			for (i = 2; i < 2 + length; i++)
1316  00ea 0c04          	inc	(OFST+0,sp)
1318  00ec 7b04          	ld	a,(OFST+0,sp)
1319  00ee               L314:
1322  00ee 5f            	clrw	x
1323  00ef 97            	ld	xl,a
1324  00f0 7b09          	ld	a,(OFST+5,sp)
1325  00f2 905f          	clrw	y
1326  00f4 9097          	ld	yl,a
1327  00f6 bf00          	ldw	c_x,x
1328  00f8 72a90002      	addw	y,#2
1329  00fc 90b300        	cpw	y,c_x
1330  00ff 2cd4          	jrsgt	L704
1331                     ; 286 			length = 0;
1333  0101 0f09          	clr	(OFST+5,sp)
1334  0103 209f          	jra	L504
1335  0105               L714:
1336                     ; 296 			usb.EP[EP_num].tx_data_sync = USB_PID_DATA1;
1338  0105 a64b          	ld	a,#75
1339  0107               L124:
1340  0107 e722          	ld	(_usb+34,x),a
1341                     ; 299 		usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
1343  0109 7b0a          	ld	a,(OFST+6,sp)
1344  010b ad48          	call	LC006
1345  010d a601          	ld	a,#1
1346  010f e723          	ld	(_usb+35,x),a
1347                     ; 301 		if (EP_num == 0)
1349  0111 7b0a          	ld	a,(OFST+6,sp)
1350  0113 2609          	jrne	L763
1352  0115               L724:
1353                     ; 303 			while (usb.EP[EP_num].tx_state == USB_EP_DATA_READY) {}
1355  0115 7b0a          	ld	a,(OFST+6,sp)
1356  0117 ad3c          	call	LC006
1357  0119 e623          	ld	a,(_usb+35,x)
1358  011b 4a            	dec	a
1359  011c 27f7          	jreq	L724
1360  011e               L763:
1361                     ; 268 	while (length > 0)
1363  011e 7b09          	ld	a,(OFST+5,sp)
1364  0120 2703cc0057    	jrne	L563
1365  0125               L363:
1366                     ; 307 	if (flag) { // Send an empty packet
1368  0125 7b01          	ld	a,(OFST-3,sp)
1369  0127 2728          	jreq	L334
1370                     ; 308 		usb.EP[EP_num].tx_length = 4;
1372  0129 7b0a          	ld	a,(OFST+6,sp)
1373  012b ad28          	call	LC006
1374  012d a604          	ld	a,#4
1375  012f e721          	ld	(_usb+33,x),a
1376                     ; 309 		usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
1378  0131 a680          	ld	a,#128
1379  0133 e715          	ld	(_usb+21,x),a
1380                     ; 310 		usb.EP[EP_num].tx_buffer[1] = usb.EP[EP_num].tx_data_sync;
1382  0135 e622          	ld	a,(_usb+34,x)
1383  0137 e716          	ld	(_usb+22,x),a
1384                     ; 311 		usb.EP[EP_num].tx_buffer[2] = 0;
1386  0139 6f17          	clr	(_usb+23,x)
1387                     ; 312 		usb.EP[EP_num].tx_buffer[3] = 0;
1389  013b 6f18          	clr	(_usb+24,x)
1390                     ; 314 		if (usb.EP[EP_num].tx_data_sync == USB_PID_DATA1)
1392  013d a14b          	cp	a,#75
1393  013f 2604          	jrne	L534
1394                     ; 315 			usb.EP[EP_num].tx_data_sync = USB_PID_DATA0;
1396  0141 a6c3          	ld	a,#195
1398  0143 2002          	jra	L734
1399  0145               L534:
1400                     ; 317 			usb.EP[EP_num].tx_data_sync = USB_PID_DATA1;
1402  0145 a64b          	ld	a,#75
1403  0147               L734:
1404  0147 e722          	ld	(_usb+34,x),a
1405                     ; 319 		usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
1407  0149 7b0a          	ld	a,(OFST+6,sp)
1408  014b ad08          	call	LC006
1409  014d a601          	ld	a,#1
1410  014f e723          	ld	(_usb+35,x),a
1411  0151               L334:
1412                     ; 321 	return 0;
1414  0151 4f            	clr	a
1416  0152 cc0045        	jra	L211
1417  0155               LC006:
1418  0155 97            	ld	xl,a
1419  0156 a61d          	ld	a,#29
1420  0158 42            	mul	x,a
1421  0159 81            	ret	
1456                     ; 324 void USB_Send_STALL(uint8_t EP_num)
1456                     ; 325 {
1457                     .text:	section	.text,new
1458  0000               _USB_Send_STALL:
1460  0000 88            	push	a
1461       00000000      OFST:	set	0
1464                     ; 326 	usb.EP[EP_num].tx_length = 2;
1466  0001 97            	ld	xl,a
1467  0002 a61d          	ld	a,#29
1468  0004 42            	mul	x,a
1469  0005 a602          	ld	a,#2
1470  0007 e721          	ld	(_usb+33,x),a
1471                     ; 327 	usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
1473  0009 7b01          	ld	a,(OFST+1,sp)
1474  000b 97            	ld	xl,a
1475  000c a61d          	ld	a,#29
1476  000e 42            	mul	x,a
1477  000f a680          	ld	a,#128
1478  0011 e715          	ld	(_usb+21,x),a
1479                     ; 328 	usb.EP[EP_num].tx_buffer[1] = USB_PID_STALL;
1481  0013 a61e          	ld	a,#30
1482  0015 e716          	ld	(_usb+22,x),a
1483                     ; 329 	usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
1485  0017 a601          	ld	a,#1
1486  0019 e723          	ld	(_usb+35,x),a
1487                     ; 330 }
1490  001b 84            	pop	a
1491  001c 81            	ret	
1590                     ; 337 void USB_NRZI_RX_Decode(uint8_t *p_data, uint8_t length)
1590                     ; 338 {
1591                     .text:	section	.text,new
1592  0000               _USB_NRZI_RX_Decode:
1594  0000 89            	pushw	x
1595  0001 5207          	subw	sp,#7
1596       00000007      OFST:	set	7
1599                     ; 341 	uint16_t word = p_data[0] << 8;
1601  0003 f6            	ld	a,(x)
1602  0004 97            	ld	xl,a
1603  0005 4f            	clr	a
1604  0006 02            	rlwa	x,a
1605  0007 1f03          	ldw	(OFST-4,sp),x
1607                     ; 342 	uint8_t offset = 0;
1609  0009 0f02          	clr	(OFST-5,sp)
1611                     ; 343 	uint8_t cnt = 0;
1613  000b 0f06          	clr	(OFST-1,sp)
1615                     ; 344 	for(i=0; i<length; i++) {
1617  000d 0f05          	clr	(OFST-2,sp)
1620  000f 2068          	jra	L535
1621  0011               L135:
1622                     ; 345 		word >>=8;
1624  0011 7b03          	ld	a,(OFST-4,sp)
1625  0013 6b04          	ld	(OFST-3,sp),a
1626  0015 0f03          	clr	(OFST-4,sp)
1628                     ; 346 		word |= (p_data[i+1] << 8);
1630  0017 5f            	clrw	x
1631  0018 7b05          	ld	a,(OFST-2,sp)
1632  001a 97            	ld	xl,a
1633  001b 72fb08        	addw	x,(OFST+1,sp)
1634  001e e601          	ld	a,(1,x)
1635  0020 5f            	clrw	x
1636  0021 97            	ld	xl,a
1637  0022 7b04          	ld	a,(OFST-3,sp)
1638  0024 01            	rrwa	x,a
1639  0025 1a03          	or	a,(OFST-4,sp)
1640  0027 01            	rrwa	x,a
1641  0028 1f03          	ldw	(OFST-4,sp),x
1643                     ; 347 		byte = 0;
1645  002a 0f01          	clr	(OFST-6,sp)
1647                     ; 348 		j=0;
1649                     ; 349 		for(j=0;j<8;j++) {
1651  002c 4f            	clr	a
1652  002d 6b07          	ld	(OFST+0,sp),a
1654  002f               L145:
1655                     ; 350 			if (word & (1 << (j+offset))) {
1657  002f ae0001        	ldw	x,#1
1658  0032 1b02          	add	a,(OFST-5,sp)
1659  0034 2704          	jreq	L021
1660  0036               L221:
1661  0036 58            	sllw	x
1662  0037 4a            	dec	a
1663  0038 26fc          	jrne	L221
1664  003a               L021:
1665  003a 01            	rrwa	x,a
1666  003b 1404          	and	a,(OFST-3,sp)
1667  003d 01            	rrwa	x,a
1668  003e 1403          	and	a,(OFST-4,sp)
1669  0040 01            	rrwa	x,a
1670  0041 5d            	tnzw	x
1671  0042 271b          	jreq	L745
1672                     ; 351 				byte |= (uint8_t)(1 << j);
1674  0044 7b07          	ld	a,(OFST+0,sp)
1675  0046 5f            	clrw	x
1676  0047 97            	ld	xl,a
1677  0048 a601          	ld	a,#1
1678  004a 5d            	tnzw	x
1679  004b 2704          	jreq	L421
1680  004d               L621:
1681  004d 48            	sll	a
1682  004e 5a            	decw	x
1683  004f 26fc          	jrne	L621
1684  0051               L421:
1685  0051 1a01          	or	a,(OFST-6,sp)
1686  0053 6b01          	ld	(OFST-6,sp),a
1688                     ; 352 				cnt++;
1690  0055 0c06          	inc	(OFST-1,sp)
1692                     ; 353 				if (cnt == 6) {
1694  0057 7b06          	ld	a,(OFST-1,sp)
1695  0059 a106          	cp	a,#6
1696  005b 2604          	jrne	L355
1697                     ; 354 					offset++;
1699  005d 0c02          	inc	(OFST-5,sp)
1701                     ; 355 					cnt=0;
1702  005f               L745:
1703                     ; 358 				cnt=0;
1706  005f 0f06          	clr	(OFST-1,sp)
1708  0061               L355:
1709                     ; 349 		for(j=0;j<8;j++) {
1711  0061 0c07          	inc	(OFST+0,sp)
1715  0063 7b07          	ld	a,(OFST+0,sp)
1716  0065 a108          	cp	a,#8
1717  0067 25c6          	jrult	L145
1718                     ; 361 		p_data[i] = byte;
1720  0069 7b08          	ld	a,(OFST+1,sp)
1721  006b 97            	ld	xl,a
1722  006c 7b09          	ld	a,(OFST+2,sp)
1723  006e 1b05          	add	a,(OFST-2,sp)
1724  0070 2401          	jrnc	L031
1725  0072 5c            	incw	x
1726  0073               L031:
1727  0073 02            	rlwa	x,a
1728  0074 7b01          	ld	a,(OFST-6,sp)
1729  0076 f7            	ld	(x),a
1730                     ; 344 	for(i=0; i<length; i++) {
1732  0077 0c05          	inc	(OFST-2,sp)
1734  0079               L535:
1737  0079 7b05          	ld	a,(OFST-2,sp)
1738  007b 110c          	cp	a,(OFST+5,sp)
1739  007d 2592          	jrult	L135
1740                     ; 363 }
1743  007f 5b09          	addw	sp,#9
1744  0081 81            	ret	
1868                     ; 365 void USB_loop(void)
1868                     ; 366 {
1869                     .text:	section	.text,new
1870  0000               _USB_loop:
1872  0000 5206          	subw	sp,#6
1873       00000006      OFST:	set	6
1876                     ; 367 	if ((GPIOC->IDR & 0xC0) == 0) {
1878  0002 c6500b        	ld	a,20491
1879  0005 a5c0          	bcp	a,#192
1880  0007 2610          	jrne	L177
1881                     ; 368 		usb.reset_counter++;
1883  0009 be41          	ldw	x,_usb+65
1884  000b 5c            	incw	x
1885  000c bf41          	ldw	_usb+65,x
1886                     ; 369 		if (usb.reset_counter > USB_RESET_DELAY) {
1888  000e a307d1        	cpw	x,#2001
1889  0011 2509          	jrult	L577
1890                     ; 370 			USB_Reset();
1892  0013 cd0000        	call	_USB_Reset
1894                     ; 371 			return;
1896  0016 cc0265        	jra	L1611
1897  0019               L177:
1898                     ; 373 	} else usb.reset_counter = 0;
1900  0019 5f            	clrw	x
1901  001a bf41          	ldw	_usb+65,x
1902  001c               L577:
1903                     ; 375 	if (usb.EP[0].rx_state == USB_EP_DATA_READY)
1905  001c b614          	ld	a,_usb+20
1906  001e 4a            	dec	a
1907  001f 2703cc024a    	jrne	L777
1908                     ; 377 		if (usb.EP0_data_stage == USB_STAGE_SETUP) // EP0 Setup stage
1910  0024 b606          	ld	a,_usb+6
1911  0026 4a            	dec	a
1912  0027 2703cc0234    	jrne	L1001
1913                     ; 379 			t_USB_SetupReq *p_USB_SetupReq = (t_USB_SetupReq*)(usb.EP[0].rx_buffer);
1915  002c ae0007        	ldw	x,#_usb+7
1916  002f 1f05          	ldw	(OFST-1,sp),x
1918                     ; 381 			switch (p_USB_SetupReq->bmRequest & 0x1F)
1920  0031 b607          	ld	a,_usb+7
1921  0033 a41f          	and	a,#31
1923                     ; 732 					break;
1924  0035 270f          	jreq	L555
1925  0037 4a            	dec	a
1926  0038 2603cc01e8    	jreq	L166
1927  003d 4a            	dec	a
1928  003e 2603cc01fc    	jreq	L176
1929                     ; 334 	USB_Send_STALL(0);
1932  0043 cc022c        	jp	L1511
1933  0046               L555:
1934                     ; 385 					switch (p_USB_SetupReq->bRequest)
1936  0046 e601          	ld	a,(1,x)
1938                     ; 568 							break;
1939  0048 2603cc01a6    	jreq	L336
1940  004d 4a            	dec	a
1941  004e 2603cc01d6    	jreq	L546
1942  0053 a002          	sub	a,#2
1943  0055 2603cc01c3    	jreq	L346
1944  005a a002          	sub	a,#2
1945  005c 2603cc00f1    	jreq	L375
1946  0061 4a            	dec	a
1947  0062 2710          	jreq	L755
1948  0064 a002          	sub	a,#2
1949  0066 2603cc018a    	jreq	L126
1950  006b 4a            	dec	a
1951  006c 2603cc0120    	jreq	L106
1952                     ; 334 	USB_Send_STALL(0);
1955  0071 cc022c        	jp	L1511
1956  0074               L755:
1957                     ; 389 							uint16_t wLength = (uint16_t)p_USB_SetupReq->wLength_LO | (uint16_t)((uint16_t)p_USB_SetupReq->wLength_HI << 8);
1959  0074 e607          	ld	a,(7,x)
1960  0076 97            	ld	xl,a
1961  0077 4f            	clr	a
1962  0078 02            	rlwa	x,a
1963  0079 1f01          	ldw	(OFST-5,sp),x
1965  007b 1e05          	ldw	x,(OFST-1,sp)
1966  007d e606          	ld	a,(6,x)
1967  007f 5f            	clrw	x
1968  0080 97            	ld	xl,a
1969  0081 01            	rrwa	x,a
1970  0082 1a02          	or	a,(OFST-4,sp)
1971  0084 01            	rrwa	x,a
1972  0085 1a01          	or	a,(OFST-5,sp)
1973  0087 01            	rrwa	x,a
1974  0088 1f03          	ldw	(OFST-3,sp),x
1976                     ; 390 							switch (p_USB_SetupReq->wValue_HI)
1978  008a 1e05          	ldw	x,(OFST-1,sp)
1979  008c e603          	ld	a,(3,x)
1981                     ; 415 									break;
1982  008e 4a            	dec	a
1983  008f 2709          	jreq	L165
1984  0091 4a            	dec	a
1985  0092 271c          	jreq	L365
1986  0094 4a            	dec	a
1987  0095 272f          	jreq	L565
1988                     ; 334 	USB_Send_STALL(0);
1991  0097 cc022c        	jp	L1511
1992  009a               L165:
1993                     ; 394 									USB_Send_Data(usb_device_descriptor, 
1993                     ; 395 									(uint8_t)MIN(wLength, SIZE_DEVICE_DESCRIPTOR), 0);
1995  009a 4b00          	push	#0
1996  009c 1e04          	ldw	x,(OFST-2,sp)
1997  009e a30013        	cpw	x,#19
1998  00a1 2404          	jruge	L041
1999  00a3 7b05          	ld	a,(OFST-1,sp)
2000  00a5 2002          	jra	L241
2001  00a7               L041:
2002  00a7 a612          	ld	a,#18
2003  00a9               L241:
2004  00a9 88            	push	a
2005  00aa ae0000        	ldw	x,#_usb_device_descriptor
2007                     ; 396 									break;
2009  00ad cc019f        	jp	LC009
2010  00b0               L365:
2011                     ; 400 									USB_Send_Data(usb_configuration_descriptor, 
2011                     ; 401 										(uint8_t)MIN(wLength, SIZE_CONFIGURATION_DESCRIPTOR), 0);
2013  00b0 4b00          	push	#0
2014  00b2 1e04          	ldw	x,(OFST-2,sp)
2015  00b4 a30023        	cpw	x,#35
2016  00b7 2404          	jruge	L641
2017  00b9 7b05          	ld	a,(OFST-1,sp)
2018  00bb 2002          	jra	L051
2019  00bd               L641:
2020  00bd a622          	ld	a,#34
2021  00bf               L051:
2022  00bf 88            	push	a
2023  00c0 ae0000        	ldw	x,#_usb_configuration_descriptor
2025                     ; 402 									break;
2027  00c3 cc019f        	jp	LC009
2028  00c6               L565:
2029                     ; 407 										USB_Send_Data(USB_String_Descriptors[p_USB_SetupReq->wValue_LO], 
2029                     ; 408 												(uint8_t)MIN(wLength, USB_String_Descriptors_Length[p_USB_SetupReq->wValue_LO]), 0);
2031  00c6 4b00          	push	#0
2032  00c8 1e06          	ldw	x,(OFST+0,sp)
2033  00ca e602          	ld	a,(2,x)
2034  00cc 5f            	clrw	x
2035  00cd 97            	ld	xl,a
2036  00ce d60000        	ld	a,(_USB_String_Descriptors_Length,x)
2037  00d1 5f            	clrw	x
2038  00d2 97            	ld	xl,a
2039  00d3 1304          	cpw	x,(OFST-2,sp)
2040  00d5 2504          	jrult	L451
2041  00d7 7b05          	ld	a,(OFST-1,sp)
2042  00d9 2009          	jra	L651
2043  00db               L451:
2044  00db 1e06          	ldw	x,(OFST+0,sp)
2045  00dd e602          	ld	a,(2,x)
2046  00df 5f            	clrw	x
2047  00e0 97            	ld	xl,a
2048  00e1 d60000        	ld	a,(_USB_String_Descriptors_Length,x)
2049  00e4               L651:
2050  00e4 88            	push	a
2051  00e5 1e07          	ldw	x,(OFST+1,sp)
2052  00e7 e602          	ld	a,(2,x)
2053  00e9 5f            	clrw	x
2054  00ea 97            	ld	xl,a
2055  00eb 58            	sllw	x
2056  00ec ee00          	ldw	x,(_USB_String_Descriptors,x)
2058                     ; 410 									break;
2060  00ee cc019f        	jp	LC009
2061                     ; 418 							break;
2063  00f1               L375:
2064                     ; 422 							if ((p_USB_SetupReq->wIndex_LO == 0) && (p_USB_SetupReq->wLength_LO == 0)) {
2066  00f1 e604          	ld	a,(4,x)
2067  00f3 26a2          	jrne	L1511
2069  00f5 e606          	ld	a,(6,x)
2070  00f7 269e          	jrne	L1511
2071                     ; 423 								if (usb.dev_state == USB_STATE_CONFIGURED) {
2073  00f9 b604          	ld	a,_usb+4
2074  00fb a103          	cp	a,#3
2075                     ; 334 	USB_Send_STALL(0);
2078  00fd 2798          	jreq	L1511
2079                     ; 426 									usb.setup_address = (uint8_t)(p_USB_SetupReq->wValue_LO & 0x7F);
2081  00ff e602          	ld	a,(2,x)
2082  0101 a47f          	and	a,#127
2083  0103 b702          	ld	_usb+2,a
2084                     ; 427 									USB_Send_Data(NULL, 0, 0);
2086  0105 4b00          	push	#0
2087  0107 4b00          	push	#0
2088  0109 5f            	clrw	x
2089  010a cd0000        	call	_USB_Send_Data
2091  010d 3d02          	tnz	_usb+2
2092  010f 85            	popw	x
2093                     ; 428 									if (usb.setup_address) 	usb.dev_state  = USB_STATE_ADDRESSED;
2095  0110 2707          	jreq	L5201
2098  0112 35020004      	mov	_usb+4,#2
2100  0116 cc0230        	jra	L5001
2101  0119               L5201:
2102                     ; 429 									else 										usb.dev_state  = USB_STATE_DEFAULT; 
2104  0119 35010004      	mov	_usb+4,#1
2105  011d cc0230        	jra	L5001
2106                     ; 334 	USB_Send_STALL(0);
2109  0120               L106:
2110                     ; 438 							if (p_USB_SetupReq->wValue_LO <= USB_MAX_NUM_CONFIGURATION)
2112  0120 e602          	ld	a,(2,x)
2113  0122 a102          	cp	a,#2
2114  0124 2503cc022c    	jruge	L1511
2115                     ; 440 								switch (usb.dev_state)
2117  0129 b604          	ld	a,_usb+4
2119                     ; 482 										break;
2120  012b a002          	sub	a,#2
2121  012d 2706          	jreq	L306
2122  012f 4a            	dec	a
2123  0130 2731          	jreq	L706
2124                     ; 334 	USB_Send_STALL(0);
2127  0132 cc022c        	jp	L1511
2128  0135               L306:
2129                     ; 444 										if (p_USB_SetupReq->wValue_LO) 
2131  0135 e602          	ld	a,(2,x)
2132  0137 2603cc01cf    	jreq	LC010
2133                     ; 446 											usb.dev_config = p_USB_SetupReq->wValue_LO; // set new configuration
2135  013c b705          	ld	_usb+5,a
2136                     ; 447 											usb.dev_state = USB_STATE_CONFIGURED;
2138  013e 35030004      	mov	_usb+4,#3
2139                     ; 448 											if (USB_Class_Init_callback(usb.dev_config) < 0) usb_control_error();
2141  0142 cd0000        	call	_USB_Class_Init_callback
2143  0145 4d            	tnz	a
2144  0146 2a06          	jrpl	L3401
2145                     ; 334 	USB_Send_STALL(0);
2148  0148 4f            	clr	a
2149  0149 cd0000        	call	_USB_Send_STALL
2151  014c 2009          	jra	L5401
2152  014e               L3401:
2153                     ; 449 											else USB_Send_Data(NULL, 0, 0);
2155  014e 4b00          	push	#0
2156  0150 4b00          	push	#0
2157  0152 5f            	clrw	x
2158  0153 cd0000        	call	_USB_Send_Data
2160  0156 85            	popw	x
2161  0157               L5401:
2162                     ; 451 											if (usb.trimming_stage == HSI_TRIMMER_STARTED) 
2164  0157 b646          	ld	a,_usb+70
2165  0159 4a            	dec	a
2166  015a 26c1          	jrne	L5001
2167                     ; 452 												usb.trimming_stage = HSI_TRIMMER_WRITE_TRIM_VAL;
2169  015c 35030046      	mov	_usb+70,#3
2170  0160 cc0230        	jra	L5001
2171                     ; 455 											USB_Send_Data(NULL, 0, 0);
2173  0163               L706:
2174                     ; 461 										if (p_USB_SetupReq->wValue_LO == 0) 
2176  0163 6d02          	tnz	(2,x)
2177  0165 260b          	jrne	L3501
2178                     ; 463 											usb.dev_state = USB_STATE_ADDRESSED;
2180  0167 35020004      	mov	_usb+4,#2
2181                     ; 464 											usb.dev_config = 0;
2183  016b b705          	ld	_usb+5,a
2184                     ; 465 											USB_Class_DeInit_callback();
2186  016d cd0000        	call	_USB_Class_DeInit_callback
2188                     ; 466 											USB_Send_Data(NULL, 0, 0);
2191  0170 205d          	jp	LC010
2192  0172               L3501:
2193                     ; 468 										if (p_USB_SetupReq->wValue_LO != usb.dev_config) 
2195  0172 e602          	ld	a,(2,x)
2196  0174 b105          	cp	a,_usb+5
2197  0176 2757          	jreq	LC010
2198                     ; 470 											USB_Class_DeInit_callback();
2200  0178 cd0000        	call	_USB_Class_DeInit_callback
2202                     ; 471 											usb.dev_config = p_USB_SetupReq->wValue_LO; // set new configuration
2204  017b 1e05          	ldw	x,(OFST-1,sp)
2205  017d e602          	ld	a,(2,x)
2206  017f b705          	ld	_usb+5,a
2207                     ; 472 											if (USB_Class_Init_callback(usb.dev_config) < 0) usb_control_error();
2209  0181 cd0000        	call	_USB_Class_Init_callback
2211  0184 4d            	tnz	a
2212  0185 2a48          	jrpl	LC010
2213                     ; 334 	USB_Send_STALL(0);
2216  0187 cc022c        	jp	L1511
2217                     ; 473 											else USB_Send_Data(NULL, 0, 0);
2219                     ; 475 											USB_Send_Data(NULL, 0, 0);
2221                     ; 482 										break;
2222                     ; 334 	USB_Send_STALL(0);
2225  018a               L126:
2226                     ; 492 							if (p_USB_SetupReq->wLength_LO == 1) 
2228  018a e606          	ld	a,(6,x)
2229  018c 4a            	dec	a
2230  018d 26f8          	jrne	L1511
2231                     ; 494 								switch (usb.dev_state)  
2233  018f b604          	ld	a,_usb+4
2235                     ; 505 										break;
2236  0191 a002          	sub	a,#2
2237  0193 2703          	jreq	L326
2238  0195 4a            	dec	a
2239                     ; 334 	USB_Send_STALL(0);
2242  0196 26ef          	jrne	L1511
2243  0198               L326:
2244                     ; 499 										USB_Send_Data(&usb.dev_config, 1, 0);
2246  0198 4b00          	push	#0
2247  019a 4b01          	push	#1
2248  019c ae0005        	ldw	x,#_usb+5
2250  019f               LC009:
2251  019f cd0000        	call	_USB_Send_Data
2252  01a2 85            	popw	x
2253                     ; 500 										break;
2255  01a3 cc0230        	jra	L5001
2256                     ; 505 										break;
2257                     ; 334 	USB_Send_STALL(0);
2260  01a6               L336:
2261                     ; 514 							switch (usb.dev_state) 
2263  01a6 b604          	ld	a,_usb+4
2265                     ; 531 									break;
2266  01a8 a002          	sub	a,#2
2267  01aa 2703          	jreq	L536
2268  01ac 4a            	dec	a
2269                     ; 334 	USB_Send_STALL(0);
2272  01ad 267d          	jrne	L1511
2273  01af               L536:
2274                     ; 519 									usb.dev_config_status = 0;
2276  01af 5f            	clrw	x
2277  01b0 bf43          	ldw	_usb+67,x
2278                     ; 523 									if (usb.dev_remote_wakeup)
2280  01b2 b645          	ld	a,_usb+69
2281  01b4 2704          	jreq	L5011
2282                     ; 524 										usb.dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;
2284  01b6 72120044      	bset	_usb+68,#1
2285  01ba               L5011:
2286                     ; 525 									USB_Send_Data((uint8_t*)&usb.dev_config_status, 2, 0);
2288  01ba 4b00          	push	#0
2289  01bc 4b02          	push	#2
2290  01be ae0043        	ldw	x,#_usb+67
2292                     ; 526 									break;
2294  01c1 20dc          	jp	LC009
2295                     ; 533 							break;
2297  01c3               L346:
2298                     ; 537 							if (p_USB_SetupReq->wValue_LO == USB_FEATURE_REMOTE_WAKEUP)
2300  01c3 e602          	ld	a,(2,x)
2301  01c5 4a            	dec	a
2302  01c6 2668          	jrne	L5001
2303                     ; 539 								usb.dev_remote_wakeup = 1;  
2305  01c8 35010045      	mov	_usb+69,#1
2306                     ; 540 								USB_Setup_Request_callback(p_USB_SetupReq);
2308  01cc               LC011:
2310  01cc cd0000        	call	_USB_Setup_Request_callback
2312                     ; 541 								USB_Send_Data(NULL, 0, 0);
2314  01cf               LC010:
2322  01cf 4b00          	push	#0
2323  01d1 4b00          	push	#0
2324  01d3 5f            	clrw	x
2326  01d4 20c9          	jp	LC009
2327  01d6               L546:
2328                     ; 547 							switch (usb.dev_state)
2330  01d6 b604          	ld	a,_usb+4
2332                     ; 561 									break;
2333  01d8 a002          	sub	a,#2
2334  01da 2703          	jreq	L746
2335  01dc 4a            	dec	a
2336                     ; 334 	USB_Send_STALL(0);
2339  01dd 264d          	jrne	L1511
2340  01df               L746:
2341                     ; 549 								case USB_STATE_ADDRESSED:
2341                     ; 550 								case USB_STATE_CONFIGURED:
2341                     ; 551 									if (p_USB_SetupReq->wValue_LO == USB_FEATURE_REMOTE_WAKEUP) 
2343  01df e602          	ld	a,(2,x)
2344  01e1 4a            	dec	a
2345  01e2 264c          	jrne	L5001
2346                     ; 553 										usb.dev_remote_wakeup = 0; 
2348  01e4 b745          	ld	_usb+69,a
2349                     ; 554 										USB_Setup_Request_callback(p_USB_SetupReq);
2351                     ; 555 										USB_Send_Data(NULL, 0, 0);
2353  01e6 20e4          	jp	LC011
2354                     ; 563 							break;
2356                     ; 571 					break;
2358  01e8               L166:
2359                     ; 576 					if (usb.dev_state == USB_STATE_CONFIGURED)
2361  01e8 b604          	ld	a,_usb+4
2362  01ea a103          	cp	a,#3
2363  01ec 263e          	jrne	L1511
2364                     ; 578 						if (p_USB_SetupReq->wIndex_LO <= USB_MAX_NUM_INTERFACES) 
2366  01ee e604          	ld	a,(4,x)
2367  01f0 a102          	cp	a,#2
2368  01f2 2438          	jruge	L1511
2369                     ; 580 							if (USB_Setup_Request_callback(p_USB_SetupReq) < 0) usb_control_error();
2371  01f4 cd0000        	call	_USB_Setup_Request_callback
2373  01f7 4d            	tnz	a
2374  01f8 2a36          	jrpl	L5001
2375                     ; 334 	USB_Send_STALL(0);
2378  01fa 2030          	jp	L1511
2385  01fc               L176:
2386                     ; 588 					if ((p_USB_SetupReq->bmRequest & 0x60) == 0x20) // Check if it is a class request
2388  01fc f6            	ld	a,(x)
2389  01fd a460          	and	a,#96
2390  01ff a120          	cp	a,#32
2391  0201 2605          	jrne	L1311
2392                     ; 590 						USB_Setup_Request_callback(p_USB_SetupReq);
2394  0203 cd0000        	call	_USB_Setup_Request_callback
2396  0206 1e05          	ldw	x,(OFST-1,sp)
2397  0208               L1311:
2398                     ; 592 					switch (p_USB_SetupReq->bRequest) 
2400  0208 e601          	ld	a,(1,x)
2401  020a 4a            	dec	a
2402  020b 261f          	jrne	L1511
2405                     ; 596 							switch (usb.dev_state) 
2407  020d b604          	ld	a,_usb+4
2409                     ; 622 									break;    
2410  020f a002          	sub	a,#2
2411  0211 2705          	jreq	L576
2412  0213 4a            	dec	a
2413  0214 270b          	jreq	L107
2414                     ; 334 	USB_Send_STALL(0);
2417  0216 2014          	jp	L1511
2418  0218               L576:
2419                     ; 598 								case USB_STATE_ADDRESSED:          
2419                     ; 599 									//if ((p_USB_SetupReq->wIndex_LO != 0x00) && (p_USB_SetupReq->wIndex_LO != 0x80))
2419                     ; 600 									if ((p_USB_SetupReq->wIndex_LO & 0x7F) == 0x1) // EP 1 
2421  0218 e604          	ld	a,(4,x)
2422  021a a47f          	and	a,#127
2423  021c 4a            	dec	a
2424  021d 260d          	jrne	L1511
2425                     ; 603 										USB_Send_Data(NULL, 0, 0);
2428  021f 20ae          	jp	LC010
2429                     ; 334 	USB_Send_STALL(0);
2432  0221               L107:
2433                     ; 607 								case USB_STATE_CONFIGURED:   
2433                     ; 608 									if (p_USB_SetupReq->wValue_LO == USB_FEATURE_EP_HALT)
2435  0221 e602          	ld	a,(2,x)
2436  0223 260b          	jrne	L5001
2437                     ; 611 										if ((p_USB_SetupReq->wIndex_LO & 0x7F) == 0x1) // EP 1 
2439  0225 e604          	ld	a,(4,x)
2440  0227 a47f          	and	a,#127
2441  0229 4a            	dec	a
2442                     ; 615 											USB_Send_Data(NULL, 0, 0);
2445  022a 27a3          	jreq	LC010
2446  022c               L1511:
2447                     ; 334 	USB_Send_STALL(0);
2450                     ; 624 							break;
2452                     ; 334 	USB_Send_STALL(0);
2473  022c 4f            	clr	a
2474  022d cd0000        	call	_USB_Send_STALL
2476  0230               L5001:
2477                     ; 734 			usb.EP[0].rx_state = USB_EP_NO_DATA;
2479  0230 3f14          	clr	_usb+20
2481  0232 2016          	jra	L777
2482  0234               L1001:
2483                     ; 736 			USB_NRZI_RX_Decode(usb.EP[0].rx_buffer, usb.EP[0].rx_length);
2485  0234 3b0013        	push	_usb+19
2486  0237 ae0007        	ldw	x,#_usb+7
2487  023a cd0000        	call	_USB_NRZI_RX_Decode
2489  023d 84            	pop	a
2490                     ; 737 			USB_EP0_RxReady_callback(usb.EP[0].rx_buffer, usb.EP[0].rx_length);
2492  023e 3b0013        	push	_usb+19
2493  0241 ae0007        	ldw	x,#_usb+7
2494  0244 cd0000        	call	_USB_EP0_RxReady_callback
2496  0247 3f14          	clr	_usb+20
2497  0249 84            	pop	a
2498                     ; 738 			usb.EP[0].rx_state = USB_EP_NO_DATA;
2500  024a               L777:
2501                     ; 742 	if (usb.EP[1].rx_state == USB_EP_DATA_READY) {
2503  024a b631          	ld	a,_usb+49
2504  024c 4a            	dec	a
2505  024d 2616          	jrne	L1611
2506                     ; 743 		USB_NRZI_RX_Decode(usb.EP[1].rx_buffer, usb.EP[1].rx_length);
2508  024f 3b0030        	push	_usb+48
2509  0252 ae0024        	ldw	x,#_usb+36
2510  0255 cd0000        	call	_USB_NRZI_RX_Decode
2512  0258 84            	pop	a
2513                     ; 744 		USB_EP1_RxReady_callback(usb.EP[1].rx_buffer, usb.EP[1].rx_length);
2515  0259 3b0030        	push	_usb+48
2516  025c ae0024        	ldw	x,#_usb+36
2517  025f cd0000        	call	_USB_EP1_RxReady_callback
2519  0262 3f31          	clr	_usb+49
2520  0264 84            	pop	a
2521                     ; 745 		usb.EP[1].rx_state = USB_EP_NO_DATA;
2523  0265               L1611:
2524                     ; 747 }
2527  0265 5b06          	addw	sp,#6
2528  0267 81            	ret	
2558                     ; 749 void USB_slow_loop(void)
2558                     ; 750 {
2559                     .text:	section	.text,new
2560  0000               _USB_slow_loop:
2564                     ; 752 	if (usb.trimming_stage != HSI_TRIMMER_DISABLE) {
2566  0000 b646          	ld	a,_usb+70
2567  0002 a104          	cp	a,#4
2568  0004 275e          	jreq	L3711
2569                     ; 753 		if (usb.trimming_stage == HSI_TRIMMER_STARTED)
2571  0006 a101          	cp	a,#1
2572  0008 262b          	jrne	L5711
2573                     ; 755 			usb.delay_counter++;
2575  000a be47          	ldw	x,_usb+71
2576  000c 5c            	incw	x
2577  000d bf47          	ldw	_usb+71,x
2578                     ; 756 			if (usb.delay_counter == USB_CONNECT_TIMEOUT)
2580  000f a302bc        	cpw	x,#700
2581  0012 2650          	jrne	L3711
2582                     ; 758 				usb.delay_counter = 0;
2584  0014 5f            	clrw	x
2585  0015 bf47          	ldw	_usb+71,x
2586                     ; 759 				usb.HSI_Trim_val++;
2588  0017 3c49          	inc	_usb+73
2589                     ; 760 				usb.HSI_Trim_val &= 0x0F;
2591  0019 b649          	ld	a,_usb+73
2592  001b a40f          	and	a,#15
2593  001d b749          	ld	_usb+73,a
2594                     ; 761 				CLK->HSITRIMR = (uint8_t)((CLK->HSITRIMR & (~0x0F)) | usb.HSI_Trim_val);
2596  001f c650cc        	ld	a,20684
2597  0022 a4f0          	and	a,#240
2598  0024 ba49          	or	a,_usb+73
2599  0026 c750cc        	ld	20684,a
2600                     ; 762 				USB_disconnect();
2602  0029 cd0000        	call	_USB_disconnect
2604                     ; 763 				USB_Reset();
2606  002c cd0000        	call	_USB_Reset
2608                     ; 764 				usb.trimming_stage = HSI_TRIMMER_RECONNECT_DELAY;
2610  002f 35020046      	mov	_usb+70,#2
2611  0033 202f          	jra	L3711
2612  0035               L5711:
2613                     ; 767 		if (usb.trimming_stage == HSI_TRIMMER_RECONNECT_DELAY)
2615  0035 a102          	cp	a,#2
2616  0037 2614          	jrne	L3021
2617                     ; 769 			usb.delay_counter++;
2619  0039 be47          	ldw	x,_usb+71
2620  003b 5c            	incw	x
2621  003c bf47          	ldw	_usb+71,x
2622                     ; 770 			if (usb.delay_counter == USB_RECONNECT_DELAY)
2624  003e a30064        	cpw	x,#100
2625  0041 2621          	jrne	L3711
2626                     ; 772 				usb.delay_counter = 0;
2628  0043 5f            	clrw	x
2629  0044 bf47          	ldw	_usb+71,x
2630                     ; 773 				usb.trimming_stage = HSI_TRIMMER_ENABLE;
2632  0046 3f46          	clr	_usb+70
2633                     ; 774 				USB_connect();
2635  0048 cd0000        	call	_USB_connect
2637  004b 2017          	jra	L3711
2638  004d               L3021:
2639                     ; 777 		if (usb.trimming_stage == HSI_TRIMMER_WRITE_TRIM_VAL)
2641  004d a103          	cp	a,#3
2642  004f 2613          	jrne	L3711
2643                     ; 779 			FLASH_Unlock(FLASH_MEMTYPE_DATA);
2645  0051 a6f7          	ld	a,#247
2646  0053 cd0000        	call	_FLASH_Unlock
2648                     ; 780 			*p_HSI_TRIM_VAL = usb.HSI_Trim_val;
2650  0056 b649          	ld	a,_usb+73
2651  0058 92c700        	ld	[_p_HSI_TRIM_VAL.w],a
2652                     ; 781 			*p_HSI_TRIMING_DONE = MAGIC_VAL;
2654  005b a611          	ld	a,#17
2655  005d 92c702        	ld	[_p_HSI_TRIMING_DONE.w],a
2656                     ; 782 			usb.trimming_stage = HSI_TRIMMER_DISABLE;
2658  0060 35040046      	mov	_usb+70,#4
2659  0064               L3711:
2660                     ; 788 	if ((usb.dev_state != USB_STATE_DEFAULT)||(usb.WDG_EP_timeout < 0)) {
2662  0064 b604          	ld	a,_usb+4
2663  0066 4a            	dec	a
2664  0067 2604          	jrne	L5121
2666  0069 be4a          	ldw	x,_usb+74
2667  006b 2a22          	jrpl	L3121
2668  006d               L5121:
2669                     ; 789 		if (usb.WDG_EP_timeout < USB_EP_WATCHDOG_TIMEOUT) usb.WDG_EP_timeout++;
2671  006d be4a          	ldw	x,_usb+74
2672  006f a3012c        	cpw	x,#300
2673  0072 2e03          	jrsge	L7121
2676  0074 5c            	incw	x
2677  0075 bf4a          	ldw	_usb+74,x
2678  0077               L7121:
2679                     ; 790 		if (usb.WDG_EP_timeout == USB_EP_WATCHDOG_TIMEOUT) {
2681  0077 a3012c        	cpw	x,#300
2682  007a 260c          	jrne	L1221
2683                     ; 791 			USB_disconnect();
2685  007c cd0000        	call	_USB_disconnect
2687                     ; 792 			USB_Reset();
2689  007f cd0000        	call	_USB_Reset
2691                     ; 793 			usb.WDG_EP_timeout = -USB_EP_WATCHDOG_RECONNECT_DELAY;
2693  0082 aeff9c        	ldw	x,#65436
2694  0085 bf4a          	ldw	_usb+74,x
2697  0087 81            	ret	
2698  0088               L1221:
2699                     ; 795 		if (usb.WDG_EP_timeout == 0) { // Connect
2701  0088 be4a          	ldw	x,_usb+74
2702  008a 2603          	jrne	L3121
2703                     ; 796 			USB_connect();
2705  008c cd0000        	call	_USB_connect
2707  008f               L3121:
2708                     ; 800 }
2711  008f 81            	ret	
3053                     	xdef	_USB_NRZI_RX_Decode
3054                     	xdef	_USB_Send_STALL
3055                     	xdef	_usb_calc_crc16
3056                     	xdef	_usb_rx_ok
3057                     	xdef	_usb_send_nack
3058                     	xdef	_USB_Reset
3059                     	xref	_ll_usb_tx
3060                     	xdef	_p_HSI_TRIMING_DONE
3061                     	xdef	_p_HSI_TRIM_VAL
3062                     	switch	.ubsct
3063  0000               _usb:
3064  0000 000000000000  	ds.b	76
3065                     	xdef	_usb
3066  004c               _ll_usb_rx_count:
3067  004c 00            	ds.b	1
3068                     	xdef	_ll_usb_rx_count
3069  004d               _ll_usb_tx_count:
3070  004d 00            	ds.b	1
3071                     	xdef	_ll_usb_tx_count
3072  004e               _ll_usb_tx_buffer_pointer:
3073  004e 0000          	ds.b	2
3074                     	xdef	_ll_usb_tx_buffer_pointer
3075  0050               _ll_usb_rx_buffer:
3076  0050 000000000000  	ds.b	16
3077                     	xdef	_ll_usb_rx_buffer
3078                     	xref	_USB_Class_DeInit_callback
3079                     	xref	_USB_Class_Init_callback
3080                     	xref	_USB_Setup_Request_callback
3081                     	xref	_USB_EP1_RxReady_callback
3082                     	xref	_USB_EP0_RxReady_callback
3083                     	xdef	_USB_Send_Data
3084                     	xdef	_USB_slow_loop
3085                     	xdef	_USB_disconnect
3086                     	xdef	_USB_connect
3087                     	xdef	_USB_loop
3088                     	xdef	_USB_Init
3089                     	xref	_USB_String_Descriptors_Length
3090                     	xref.b	_USB_String_Descriptors
3091                     	xref	_usb_configuration_descriptor
3092                     	xref	_usb_device_descriptor
3093                     	xref	_TIM1_ClearFlag
3094                     	xref	_TIM1_SelectSlaveMode
3095                     	xref	_TIM1_SelectInputTrigger
3096                     	xref	_TIM1_ITConfig
3097                     	xref	_TIM1_ICInit
3098                     	xref	_TIM1_TimeBaseInit
3099                     	xref	_GPIO_WriteLow
3100                     	xref	_GPIO_WriteHigh
3101                     	xref	_GPIO_Init
3102                     	xref	_FLASH_Unlock
3103                     	xref	_CLK_PeripheralClockConfig
3104                     	xref.b	c_x
3124                     	end
