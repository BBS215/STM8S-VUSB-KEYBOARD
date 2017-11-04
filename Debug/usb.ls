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
 200  002d 85            	popw	x
 201                     ; 52 	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // DEBUG
 203  002e 4be0          	push	#224
 204  0030 4b04          	push	#4
 205  0032 ae500f        	ldw	x,#20495
 206  0035 cd0000        	call	_GPIO_Init
 208  0038 35010004      	mov	_usb+4,#1
 209  003c 85            	popw	x
 210                     ; 53 	usb.dev_state = USB_STATE_DEFAULT;
 212                     ; 54 	USB_Reset();
 214  003d cd0000        	call	_USB_Reset
 216                     ; 56 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 218  0040 ae0701        	ldw	x,#1793
 219  0043 cd0000        	call	_CLK_PeripheralClockConfig
 221                     ; 57 	TIM1_TimeBaseInit(0, TIM1_PSCRELOADMODE_UPDATE, 1000, 0);
 223  0046 4b00          	push	#0
 224  0048 ae03e8        	ldw	x,#1000
 225  004b 89            	pushw	x
 226  004c 4b00          	push	#0
 227  004e 5f            	clrw	x
 228  004f cd0000        	call	_TIM1_TimeBaseInit
 230  0052 5b04          	addw	sp,#4
 231                     ; 58 	TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x02); // захват сигнала по линии USB D-
 233  0054 4b02          	push	#2
 234  0056 4b00          	push	#0
 235  0058 4b01          	push	#1
 236  005a ae0101        	ldw	x,#257
 237  005d cd0000        	call	_TIM1_ICInit
 239  0060 5b03          	addw	sp,#3
 240                     ; 59 	TIM1_SelectInputTrigger(TIM1_TS_TI2FP2);
 242  0062 a660          	ld	a,#96
 243  0064 cd0000        	call	_TIM1_SelectInputTrigger
 245                     ; 60 	TIM1_SelectSlaveMode(TIM1_SLAVEMODE_TRIGGER);
 247  0067 a606          	ld	a,#6
 248  0069 cd0000        	call	_TIM1_SelectSlaveMode
 250                     ; 61 	TIM1_ClearFlag(TIM1_FLAG_CC2);
 252  006c ae0004        	ldw	x,#4
 253  006f cd0000        	call	_TIM1_ClearFlag
 255                     ; 62 	TIM1_ITConfig(TIM1_IT_CC2, ENABLE);
 257  0072 ae0401        	ldw	x,#1025
 259                     ; 63 }
 262  0075 cc0000        	jp	_TIM1_ITConfig
 286                     ; 65 void USB_connect(void)
 286                     ; 66 {
 287                     .text:	section	.text,new
 288  0000               _USB_connect:
 292                     ; 67 	GPIO_WriteHigh(USB_CONNECT_PORT, USB_CONNECT_PIN);
 294  0000 4b08          	push	#8
 295  0002 ae5000        	ldw	x,#20480
 296  0005 cd0000        	call	_GPIO_WriteHigh
 298  0008 84            	pop	a
 299                     ; 68 }
 302  0009 81            	ret	
 326                     ; 70 void USB_disconnect(void)
 326                     ; 71 {
 327                     .text:	section	.text,new
 328  0000               _USB_disconnect:
 332                     ; 72 	GPIO_WriteLow(USB_CONNECT_PORT, USB_CONNECT_PIN);
 334  0000 4b08          	push	#8
 335  0002 ae5000        	ldw	x,#20480
 336  0005 cd0000        	call	_GPIO_WriteLow
 338  0008 84            	pop	a
 339                     ; 73 }
 342  0009 81            	ret	
 345                     .const:	section	.text
 346  0000               L75_data:
 347  0000 80            	dc.b	128
 348  0001 5a            	dc.b	90
 384                     ; 75 void usb_send_nack(void)
 384                     ; 76 {
 385                     .text:	section	.text,new
 386  0000               _usb_send_nack:
 388  0000 89            	pushw	x
 389       00000002      OFST:	set	2
 392                     ; 77 	const uint8_t data[2] = {USB_SYNC_BYTE, USB_PID_NACK};
 394  0001 c60000        	ld	a,L75_data
 395  0004 6b01          	ld	(OFST-1,sp),a
 396  0006 c60001        	ld	a,L75_data+1
 397  0009 6b02          	ld	(OFST+0,sp),a
 398                     ; 79 	GPIOC->ODR |= 0x40; // set PC6
 400  000b 721c500a      	bset	20490,#6
 401                     ; 80 	GPIOC->CR1 |= 0xC0; // PC6, PC7 - PP (PU) mode
 403  000f c6500d        	ld	a,20493
 404  0012 aac0          	or	a,#192
 405  0014 c7500d        	ld	20493,a
 406                     ; 81 	GPIOC->CR2 |= 0xC0; // PC6, PC7 - 10 MHz mode (external INTR enable)
 408  0017 c6500e        	ld	a,20494
 409  001a aac0          	or	a,#192
 410  001c c7500e        	ld	20494,a
 411                     ; 82 	GPIOC->DDR |= 0xC0; // PC6, PC7 - output mode
 413  001f c6500c        	ld	a,20492
 414  0022 aac0          	or	a,#192
 415  0024 c7500c        	ld	20492,a
 416                     ; 84 	ll_usb_tx_count = 2;
 418  0027 3502004b      	mov	_ll_usb_tx_count,#2
 419                     ; 85 	ll_usb_tx_buffer_pointer = data;
 421  002b 96            	ldw	x,sp
 422  002c 5c            	incw	x
 423  002d bf4c          	ldw	_ll_usb_tx_buffer_pointer,x
 424                     ; 86 	ll_usb_tx();
 426  002f cd0000        	call	_ll_usb_tx
 428                     ; 88 	GPIOC->CR2 &= (uint8_t)~0xC0; // PC6, PC7 - disable external INTR (2 MHz)
 430  0032 c6500e        	ld	a,20494
 431  0035 a43f          	and	a,#63
 432  0037 c7500e        	ld	20494,a
 433                     ; 89 	GPIOC->CR1 &= (uint8_t)~0xC0; // PC6, PC7 - disable PU (PP) mode
 435  003a c6500d        	ld	a,20493
 436  003d a43f          	and	a,#63
 437  003f c7500d        	ld	20493,a
 438                     ; 90 	GPIOC->DDR = 0; // PC0..PC7 - input mode
 440  0042 725f500c      	clr	20492
 441                     ; 91 }
 444  0046 85            	popw	x
 445  0047 81            	ret	
 448                     	switch	.const
 449  0002               L77_data:
 450  0002 80            	dc.b	128
 451  0003 d2            	dc.b	210
 452  0004               L311_data:
 453  0004 80            	dc.b	128
 454  0005 d2            	dc.b	210
 515                     ; 140 void usb_rx_ok(void)
 515                     ; 141 {
 516                     .text:	section	.text,new
 517  0000               _usb_rx_ok:
 519  0000 89            	pushw	x
 520       00000002      OFST:	set	2
 523                     ; 142 	switch (ll_usb_rx_buffer[1])
 525  0001 b64f          	ld	a,_ll_usb_rx_buffer+1
 527                     ; 198 		default:
 527                     ; 199 			break;
 528  0003 a02d          	sub	a,#45
 529  0005 2716          	jreq	L101
 530  0007 a01e          	sub	a,#30
 531  0009 2603cc008c    	jreq	L111
 532  000e a01e          	sub	a,#30
 533  0010 2734          	jreq	L501
 534  0012 a05a          	sub	a,#90
 535  0014 2776          	jreq	L111
 536  0016 a01e          	sub	a,#30
 537  0018 2714          	jreq	L301
 538  001a cc00f7        	jra	L351
 539  001d               L101:
 540                     ; 144 		case USB_PID_SETUP:
 540                     ; 145 			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
 542  001d cd013f        	call	LC005
 543  0020 2703cc00f5    	jrne	L771
 544                     ; 147 				usb.stage = USB_STAGE_SETUP;
 546  0025 35010000      	mov	_usb,#1
 547                     ; 148 				usb.active_EP_num = 0;//(usb_rx_buffer[2] & 0x80)?1:0;
 549  0029 3f03          	clr	_usb+3
 551  002b cc00f7        	jra	L351
 552                     ; 149 			} else usb.stage = USB_STAGE_NONE;
 553  002e               L301:
 554                     ; 152 		case USB_PID_OUT:
 554                     ; 153 			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
 556  002e cd013f        	call	LC005
 557  0031 26ef          	jrne	L771
 558                     ; 155 				usb.stage = USB_STAGE_OUT;
 560  0033 35020000      	mov	_usb,#2
 561                     ; 156 				usb.active_EP_num = (uint8_t)((ll_usb_rx_buffer[2] & 0x80)?1:0);
 563  0037 720f005004    	btjf	_ll_usb_rx_buffer+2,#7,L45
 564  003c a601          	ld	a,#1
 565  003e 2001          	jra	L65
 566  0040               L45:
 567  0040 4f            	clr	a
 568  0041               L65:
 569  0041 b703          	ld	_usb+3,a
 571  0043 cc00f7        	jra	L351
 572                     ; 157 			} else usb.stage = USB_STAGE_NONE;
 573  0046               L501:
 574                     ; 160 		case USB_PID_IN:
 574                     ; 161 			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
 576  0046 cd013f        	call	LC005
 577  0049 26d7          	jrne	L771
 578                     ; 163 				usb.active_EP_num = (uint8_t)((ll_usb_rx_buffer[2] & 0x80)?1:0);
 580  004b 720f005004    	btjf	_ll_usb_rx_buffer+2,#7,L06
 581  0050 a601          	ld	a,#1
 582  0052 2001          	jra	L26
 583  0054               L06:
 584  0054 4f            	clr	a
 585  0055               L26:
 586  0055 b703          	ld	_usb+3,a
 587                     ; 164 				if (usb.EP[usb.active_EP_num].tx_state == USB_EP_DATA_READY) {
 589  0057 cd013a        	call	LC004
 590  005a e623          	ld	a,(_usb+35,x)
 591  005c 4a            	dec	a
 592  005d 2628          	jrne	L761
 593                     ; 165 					usb_send_packet(usb.active_EP_num);
 596  005f b603          	ld	a,_usb+3
 597  0061 6b02          	ld	(OFST+0,sp),a
 599                     ; 113 	GPIOC->ODR |= 0x40; // set PC6
 601  0063 cd0101        	call	LC002
 602                     ; 118 	ll_usb_tx_count = usb.EP[EP_num].tx_length;
 604  0066 7b02          	ld	a,(OFST+0,sp)
 605  0068 cd013a        	call	LC004
 606  006b e621          	ld	a,(_usb+33,x)
 607  006d b74b          	ld	_ll_usb_tx_count,a
 608                     ; 119 	ll_usb_tx_buffer_pointer = usb.EP[EP_num].tx_buffer;
 610  006f 01            	rrwa	x,a
 611  0070 ab15          	add	a,#_usb+21
 612  0072 5f            	clrw	x
 613  0073 97            	ld	xl,a
 614  0074 cd011e        	call	LC003
 615  0077 cd013a        	call	LC004
 616  007a 6f23          	clr	(_usb+35,x)
 617                     ; 167 					if (usb.setup_address) {
 619  007c b602          	ld	a,_usb+2
 620  007e 2775          	jreq	L771
 621                     ; 168 						usb.device_address = usb.setup_address;
 623  0080 450201        	mov	_usb+1,_usb+2
 624                     ; 169 						usb.setup_address = 0;
 626  0083 3f02          	clr	_usb+2
 627  0085 206e          	jra	L771
 628  0087               L761:
 629                     ; 172 					usb_send_nack();
 631  0087 cd0000        	call	_usb_send_nack
 633                     ; 175 			usb.stage = USB_STAGE_NONE;
 634                     ; 176 			break;
 636  008a 2069          	jp	L771
 637  008c               L111:
 638                     ; 178 		case USB_PID_DATA0: // Data received
 638                     ; 179 		case USB_PID_DATA1: // Data received
 638                     ; 180 			if (usb.stage != USB_STAGE_NONE) {
 640  008c 3d00          	tnz	_usb
 641  008e 2767          	jreq	L351
 642                     ; 181 				if (usb.EP[usb.active_EP_num].rx_state == USB_EP_NO_DATA) // if EP ready
 644  0090 b603          	ld	a,_usb+3
 645  0092 cd013a        	call	LC004
 646  0095 6d14          	tnz	(_usb+20,x)
 647  0097 265c          	jrne	L771
 648                     ; 183 					usb.EP[usb.active_EP_num].rx_state = USB_EP_DATA_READY;
 650  0099 a601          	ld	a,#1
 651  009b e714          	ld	(_usb+20,x),a
 652                     ; 95 	const uint8_t data[2] = {USB_SYNC_BYTE, USB_PID_ACK};
 655  009d c60004        	ld	a,L311_data
 656  00a0 6b01          	ld	(OFST-1,sp),a
 657  00a2 c60005        	ld	a,L311_data+1
 658  00a5 6b02          	ld	(OFST+0,sp),a
 659                     ; 97 	GPIOC->ODR |= 0x40; // set PC6
 661  00a7 ad58          	call	LC002
 662                     ; 102 	ll_usb_tx_count = 2;
 664  00a9 3502004b      	mov	_ll_usb_tx_count,#2
 665                     ; 103 	ll_usb_tx_buffer_pointer = data;
 667  00ad 96            	ldw	x,sp
 668  00ae 5c            	incw	x
 669  00af ad6d          	call	LC003
 670  00b1 2603          	jrne	L102
 671                     ; 185 					if (usb.active_EP_num == 0) usb.EP0_data_stage = usb.stage; // USB_STAGE_SETUP or USB_STAGE_OUT
 673  00b3 450006        	mov	_usb+6,_usb
 674  00b6               L102:
 675                     ; 186 					usb.EP[usb.active_EP_num].rx_length = (uint8_t)(14 - ll_usb_rx_count);
 677  00b6 cd013a        	call	LC004
 678  00b9 a60e          	ld	a,#14
 679  00bb b04a          	sub	a,_ll_usb_rx_count
 680  00bd e713          	ld	(_usb+19,x),a
 681                     ; 187 					if (usb.EP[usb.active_EP_num].rx_length > 3) {
 683  00bf b603          	ld	a,_usb+3
 684  00c1 ad77          	call	LC004
 685  00c3 e613          	ld	a,(_usb+19,x)
 686  00c5 a104          	cp	a,#4
 687  00c7 252a          	jrult	L302
 688                     ; 188 						usb.EP[usb.active_EP_num].rx_length -= 3;
 690  00c9 a003          	sub	a,#3
 691  00cb e713          	ld	(_usb+19,x),a
 692                     ; 189 						usb_copy_rx_packet(usb.active_EP_num);
 696                     ; 129 	usb.EP[EP_num].rx_buffer[0] = ll_usb_rx_buffer[2];
 698  00cd b650          	ld	a,_ll_usb_rx_buffer+2
 699  00cf e707          	ld	(_usb+7,x),a
 700                     ; 130 	usb.EP[EP_num].rx_buffer[1] = ll_usb_rx_buffer[3];
 702  00d1 b651          	ld	a,_ll_usb_rx_buffer+3
 703  00d3 e708          	ld	(_usb+8,x),a
 704                     ; 131 	usb.EP[EP_num].rx_buffer[2] = ll_usb_rx_buffer[4];
 706  00d5 b652          	ld	a,_ll_usb_rx_buffer+4
 707  00d7 e709          	ld	(_usb+9,x),a
 708                     ; 132 	usb.EP[EP_num].rx_buffer[3] = ll_usb_rx_buffer[5];
 710  00d9 b653          	ld	a,_ll_usb_rx_buffer+5
 711  00db e70a          	ld	(_usb+10,x),a
 712                     ; 133 	usb.EP[EP_num].rx_buffer[4] = ll_usb_rx_buffer[6];
 714  00dd b654          	ld	a,_ll_usb_rx_buffer+6
 715  00df e70b          	ld	(_usb+11,x),a
 716                     ; 134 	usb.EP[EP_num].rx_buffer[5] = ll_usb_rx_buffer[7];
 718  00e1 b655          	ld	a,_ll_usb_rx_buffer+7
 719  00e3 e70c          	ld	(_usb+12,x),a
 720                     ; 135 	usb.EP[EP_num].rx_buffer[6] = ll_usb_rx_buffer[8];
 722  00e5 b656          	ld	a,_ll_usb_rx_buffer+8
 723  00e7 e70d          	ld	(_usb+13,x),a
 724                     ; 136 	usb.EP[EP_num].rx_buffer[7] = ll_usb_rx_buffer[9];
 726  00e9 b657          	ld	a,_ll_usb_rx_buffer+9
 727  00eb e70e          	ld	(_usb+14,x),a
 728                     ; 137 	usb.EP[EP_num].rx_buffer[8] = ll_usb_rx_buffer[10];
 730  00ed b658          	ld	a,_ll_usb_rx_buffer+10
 731  00ef e70f          	ld	(_usb+15,x),a
 732  00f1 2002          	jra	L771
 733  00f3               L302:
 734                     ; 190 					} else usb.EP[usb.active_EP_num].rx_length = 0;
 736  00f3 6f13          	clr	(_usb+19,x)
 737  00f5               L771:
 738                     ; 192 				usb.stage = USB_STAGE_NONE;
 743  00f5 3f00          	clr	_usb
 744                     ; 198 		default:
 744                     ; 199 			break;
 746  00f7               L351:
 747                     ; 202 	if (usb.trimming_stage == HSI_TRIMMER_ENABLE)
 749  00f7 b646          	ld	a,_usb+70
 750  00f9 2604          	jrne	L702
 751                     ; 203 		usb.trimming_stage = HSI_TRIMMER_STARTED;
 753  00fb 35010046      	mov	_usb+70,#1
 754  00ff               L702:
 755                     ; 205 }
 758  00ff 85            	popw	x
 759  0100 81            	ret	
 760  0101               LC002:
 761  0101 721c500a      	bset	20490,#6
 762                     ; 114 	GPIOC->CR1 |= 0xC0; // PC6, PC7 - PP (PU) mode
 764  0105 c6500d        	ld	a,20493
 765  0108 aac0          	or	a,#192
 766  010a c7500d        	ld	20493,a
 767                     ; 115 	GPIOC->CR2 |= 0xC0; // PC6, PC7 - 10 MHz mode (external INTR enable)
 769  010d c6500e        	ld	a,20494
 770  0110 aac0          	or	a,#192
 771  0112 c7500e        	ld	20494,a
 772                     ; 116 	GPIOC->DDR |= 0xC0; // PC6, PC7 - output mode
 774  0115 c6500c        	ld	a,20492
 775  0118 aac0          	or	a,#192
 776  011a c7500c        	ld	20492,a
 777  011d 81            	ret	
 778  011e               LC003:
 779  011e bf4c          	ldw	_ll_usb_tx_buffer_pointer,x
 780                     ; 120 	ll_usb_tx();
 782  0120 cd0000        	call	_ll_usb_tx
 784                     ; 122 	GPIOC->CR2 &= (uint8_t)~0xC0; // PC6, PC7 - disable external INTR (2 MHz)
 786  0123 c6500e        	ld	a,20494
 787  0126 a43f          	and	a,#63
 788  0128 c7500e        	ld	20494,a
 789                     ; 123 	GPIOC->CR1 &= (uint8_t)~0xC0; // PC6, PC7 - disable PU (PP) mode
 791  012b c6500d        	ld	a,20493
 792  012e a43f          	and	a,#63
 793  0130 c7500d        	ld	20493,a
 794                     ; 124 	GPIOC->DDR = 0; // PC0..PC7 - input mode
 796  0133 725f500c      	clr	20492
 797                     ; 166 					usb.EP[usb.active_EP_num].tx_state = USB_EP_NO_DATA;
 799  0137 b603          	ld	a,_usb+3
 800  0139 81            	ret	
 801  013a               LC004:
 802  013a 97            	ld	xl,a
 803  013b a61d          	ld	a,#29
 804  013d 42            	mul	x,a
 805  013e 81            	ret	
 806  013f               LC005:
 807  013f b650          	ld	a,_ll_usb_rx_buffer+2
 808  0141 a47f          	and	a,#127
 809  0143 b101          	cp	a,_usb+1
 810  0145 81            	ret	
 881                     ; 207 void usb_calc_crc16(uint8_t * buffer, uint8_t length)
 881                     ; 208 {
 882                     .text:	section	.text,new
 883  0000               _usb_calc_crc16:
 885  0000 89            	pushw	x
 886  0001 5204          	subw	sp,#4
 887       00000004      OFST:	set	4
 890                     ; 209 	uint16_t crc = 0xFFFF;
 892  0003 aeffff        	ldw	x,#65535
 893  0006 1f03          	ldw	(OFST-1,sp),x
 895                     ; 213 	for (index = 0; index < length; index++)
 897  0008 0f01          	clr	(OFST-3,sp)
 900  000a 203c          	jra	L352
 901  000c               L742:
 902                     ; 215 		crc ^= *buffer++;
 904  000c 1e05          	ldw	x,(OFST+1,sp)
 905  000e f6            	ld	a,(x)
 906  000f 5c            	incw	x
 907  0010 1f05          	ldw	(OFST+1,sp),x
 908  0012 5f            	clrw	x
 909  0013 97            	ld	xl,a
 910  0014 01            	rrwa	x,a
 911  0015 1804          	xor	a,(OFST+0,sp)
 912  0017 01            	rrwa	x,a
 913  0018 1803          	xor	a,(OFST-1,sp)
 914  001a 01            	rrwa	x,a
 915  001b 1f03          	ldw	(OFST-1,sp),x
 917                     ; 217 		for (i = 8; i--;)
 919  001d a608          	ld	a,#8
 920  001f 6b02          	ld	(OFST-2,sp),a
 923  0021 201c          	jra	L362
 924  0023               L752:
 925                     ; 219 			if ((crc & BIT(0)) != 0)
 927  0023 7b04          	ld	a,(OFST+0,sp)
 928  0025 a501          	bcp	a,#1
 929  0027 2712          	jreq	L762
 930                     ; 221 				crc >>= 1;
 932  0029 0403          	srl	(OFST-1,sp)
 933  002b 0604          	rrc	(OFST+0,sp)
 935                     ; 222 				crc ^= 0xA001;
 937  002d 7b04          	ld	a,(OFST+0,sp)
 938  002f a801          	xor	a,#1
 939  0031 6b04          	ld	(OFST+0,sp),a
 940  0033 7b03          	ld	a,(OFST-1,sp)
 941  0035 a8a0          	xor	a,#160
 942  0037 6b03          	ld	(OFST-1,sp),a
 945  0039 2004          	jra	L362
 946  003b               L762:
 947                     ; 224 				crc >>= 1;
 949  003b 0403          	srl	(OFST-1,sp)
 950  003d 0604          	rrc	(OFST+0,sp)
 952  003f               L362:
 953                     ; 217 		for (i = 8; i--;)
 955  003f 7b02          	ld	a,(OFST-2,sp)
 956  0041 0a02          	dec	(OFST-2,sp)
 958  0043 4d            	tnz	a
 959  0044 26dd          	jrne	L752
 960                     ; 213 	for (index = 0; index < length; index++)
 962  0046 0c01          	inc	(OFST-3,sp)
 964  0048               L352:
 967  0048 7b01          	ld	a,(OFST-3,sp)
 968  004a 1109          	cp	a,(OFST+5,sp)
 969  004c 25be          	jrult	L742
 970                     ; 229 	crc = ~crc;
 972  004e 1e03          	ldw	x,(OFST-1,sp)
 973  0050 53            	cplw	x
 974  0051 1f03          	ldw	(OFST-1,sp),x
 976                     ; 231 	*buffer++ = (uint8_t) crc;
 978  0053 1e05          	ldw	x,(OFST+1,sp)
 979  0055 7b04          	ld	a,(OFST+0,sp)
 980  0057 f7            	ld	(x),a
 981  0058 5c            	incw	x
 982  0059 1f05          	ldw	(OFST+1,sp),x
 983                     ; 232 	*buffer = (uint8_t) (crc >> 8);
 985  005b 7b03          	ld	a,(OFST-1,sp)
 986  005d f7            	ld	(x),a
 987                     ; 233 }
 990  005e 5b06          	addw	sp,#6
 991  0060 81            	ret	
1064                     ; 235 int8_t USB_Send_Data(uint8_t * buffer, uint8_t length, uint8_t EP_num)
1064                     ; 236 {
1065                     .text:	section	.text,new
1066  0000               _USB_Send_Data:
1068  0000 89            	pushw	x
1069  0001 89            	pushw	x
1070       00000002      OFST:	set	2
1073                     ; 238 	uint8_t flag = 0;
1075  0002 0f01          	clr	(OFST-1,sp)
1077                     ; 240 	if (EP_num == 0) { // EP 0 - CONTROL
1079  0004 7b08          	ld	a,(OFST+6,sp)
1080  0006 260b          	jrne	L133
1082  0008               L533:
1083                     ; 241 		while (usb.EP[0].tx_state == USB_EP_DATA_READY) {} // wait for prev transmission
1085  0008 b623          	ld	a,_usb+35
1086  000a 4a            	dec	a
1087  000b 27fb          	jreq	L533
1088                     ; 242 		usb.EP[0].tx_data_sync = USB_PID_DATA1;
1090  000d 354b0022      	mov	_usb+34,#75
1092  0011 2017          	jra	L143
1093  0013               L133:
1094                     ; 244 		if (usb.dev_state != USB_STATE_CONFIGURED) return -2;
1096  0013 b604          	ld	a,_usb+4
1097  0015 a103          	cp	a,#3
1098  0017 2704          	jreq	L343
1101  0019 a6fe          	ld	a,#254
1103  001b 2008          	jra	L011
1104  001d               L343:
1105                     ; 245 		if (length > 8) return -3; // 8 bytes max for INTR EP
1107  001d 7b07          	ld	a,(OFST+5,sp)
1108  001f a109          	cp	a,#9
1109  0021 2505          	jrult	L543
1112  0023 a6fd          	ld	a,#253
1114  0025               L011:
1116  0025 5b04          	addw	sp,#4
1117  0027 81            	ret	
1118  0028               L543:
1119                     ; 246 		usb.EP[1].tx_state = USB_EP_NO_DATA; // drop old packet
1121  0028 3f40          	clr	_usb+64
1122  002a               L143:
1123                     ; 249 	if (length == 0) flag = 1;	// Just send an empty packet
1125  002a 7b07          	ld	a,(OFST+5,sp)
1126  002c 2703cc00fe    	jrne	L553
1129  0031 4c            	inc	a
1130  0032 6b01          	ld	(OFST-1,sp),a
1133  0034 cc0105        	jra	L153
1134  0037               L353:
1135                     ; 253 		usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
1137  0037 7b08          	ld	a,(OFST+6,sp)
1138  0039 cd0135        	call	LC006
1139  003c a680          	ld	a,#128
1140  003e e715          	ld	(_usb+21,x),a
1141                     ; 254 		usb.EP[EP_num].tx_buffer[1] = usb.EP[EP_num].tx_data_sync;
1143  0040 e622          	ld	a,(_usb+34,x)
1144  0042 e716          	ld	(_usb+22,x),a
1145                     ; 256 		if ((length == 8)&&(EP_num == 0)) flag = 1;	// If the length of last DATA packet is 8, then finialize the transcation by an empty packet
1147  0044 7b07          	ld	a,(OFST+5,sp)
1148  0046 a108          	cp	a,#8
1149  0048 260a          	jrne	L163
1151  004a 0d08          	tnz	(OFST+6,sp)
1152  004c 2606          	jrne	L163
1155  004e a601          	ld	a,#1
1156  0050 6b01          	ld	(OFST-1,sp),a
1158  0052 7b07          	ld	a,(OFST+5,sp)
1159  0054               L163:
1160                     ; 258 		if (length > 8)
1162  0054 a109          	cp	a,#9
1163  0056 2553          	jrult	L363
1164                     ; 260 			usb.EP[EP_num].tx_length = 12; // 2+8+2
1166  0058 a60c          	ld	a,#12
1167  005a e721          	ld	(_usb+33,x),a
1168                     ; 262 			for (i = 2; i < 10; i++)
1170  005c a602          	ld	a,#2
1171  005e 6b02          	ld	(OFST+0,sp),a
1173  0060               L563:
1174                     ; 263 				usb.EP[EP_num].tx_buffer[i] = *buffer++;
1176  0060 7b08          	ld	a,(OFST+6,sp)
1177  0062 cd0135        	call	LC006
1178  0065 01            	rrwa	x,a
1179  0066 1b02          	add	a,(OFST+0,sp)
1180  0068 2401          	jrnc	L001
1181  006a 5c            	incw	x
1182  006b               L001:
1183  006b 1603          	ldw	y,(OFST+1,sp)
1184  006d 02            	rlwa	x,a
1185  006e 90f6          	ld	a,(y)
1186  0070 905c          	incw	y
1187  0072 1703          	ldw	(OFST+1,sp),y
1188  0074 e715          	ld	(_usb+21,x),a
1189                     ; 262 			for (i = 2; i < 10; i++)
1191  0076 0c02          	inc	(OFST+0,sp)
1195  0078 7b02          	ld	a,(OFST+0,sp)
1196  007a a10a          	cp	a,#10
1197  007c 25e2          	jrult	L563
1198                     ; 264 			length -= 8;
1200  007e 7b07          	ld	a,(OFST+5,sp)
1201  0080 a008          	sub	a,#8
1202  0082 6b07          	ld	(OFST+5,sp),a
1204  0084               L373:
1205                     ; 273 		usb_calc_crc16(&usb.EP[EP_num].tx_buffer[2], (uint8_t) (usb.EP[EP_num].tx_length - 4));
1207  0084 7b08          	ld	a,(OFST+6,sp)
1208  0086 cd0135        	call	LC006
1209  0089 e621          	ld	a,(_usb+33,x)
1210  008b a004          	sub	a,#4
1211  008d 88            	push	a
1212  008e 7b09          	ld	a,(OFST+7,sp)
1213  0090 cd0135        	call	LC006
1214  0093 01            	rrwa	x,a
1215  0094 ab17          	add	a,#_usb+23
1216  0096 5f            	clrw	x
1217  0097 97            	ld	xl,a
1218  0098 cd0000        	call	_usb_calc_crc16
1220  009b 84            	pop	a
1221                     ; 276 		if (usb.EP[EP_num].tx_data_sync == USB_PID_DATA1) 
1223  009c 7b08          	ld	a,(OFST+6,sp)
1224  009e cd0135        	call	LC006
1225  00a1 e622          	ld	a,(_usb+34,x)
1226  00a3 a14b          	cp	a,#75
1227  00a5 263e          	jrne	L504
1228                     ; 277 			usb.EP[EP_num].tx_data_sync = USB_PID_DATA0;
1230  00a7 a6c3          	ld	a,#195
1232  00a9 203c          	jra	L704
1233  00ab               L363:
1234                     ; 266 			usb.EP[EP_num].tx_length = (uint8_t)(4 + length);
1236  00ab ab04          	add	a,#4
1237  00ad e721          	ld	(_usb+33,x),a
1238                     ; 267 			for (i = 2; i < 2 + length; i++)
1240  00af a602          	ld	a,#2
1241  00b1 6b02          	ld	(OFST+0,sp),a
1244  00b3 2019          	jra	L104
1245  00b5               L573:
1246                     ; 268 				usb.EP[EP_num].tx_buffer[i] = *buffer++;
1248  00b5 7b08          	ld	a,(OFST+6,sp)
1249  00b7 ad7c          	call	LC006
1250  00b9 01            	rrwa	x,a
1251  00ba 1b02          	add	a,(OFST+0,sp)
1252  00bc 2401          	jrnc	L201
1253  00be 5c            	incw	x
1254  00bf               L201:
1255  00bf 1603          	ldw	y,(OFST+1,sp)
1256  00c1 02            	rlwa	x,a
1257  00c2 90f6          	ld	a,(y)
1258  00c4 905c          	incw	y
1259  00c6 1703          	ldw	(OFST+1,sp),y
1260  00c8 e715          	ld	(_usb+21,x),a
1261                     ; 267 			for (i = 2; i < 2 + length; i++)
1263  00ca 0c02          	inc	(OFST+0,sp)
1265  00cc 7b02          	ld	a,(OFST+0,sp)
1266  00ce               L104:
1269  00ce 5f            	clrw	x
1270  00cf 97            	ld	xl,a
1271  00d0 7b07          	ld	a,(OFST+5,sp)
1272  00d2 905f          	clrw	y
1273  00d4 9097          	ld	yl,a
1274  00d6 bf00          	ldw	c_x,x
1275  00d8 72a90002      	addw	y,#2
1276  00dc 90b300        	cpw	y,c_x
1277  00df 2cd4          	jrsgt	L573
1278                     ; 269 			length = 0;
1280  00e1 0f07          	clr	(OFST+5,sp)
1281  00e3 209f          	jra	L373
1282  00e5               L504:
1283                     ; 279 			usb.EP[EP_num].tx_data_sync = USB_PID_DATA1;
1285  00e5 a64b          	ld	a,#75
1286  00e7               L704:
1287  00e7 e722          	ld	(_usb+34,x),a
1288                     ; 282 		usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
1290  00e9 7b08          	ld	a,(OFST+6,sp)
1291  00eb ad48          	call	LC006
1292  00ed a601          	ld	a,#1
1293  00ef e723          	ld	(_usb+35,x),a
1294                     ; 284 		if (EP_num == 0)
1296  00f1 7b08          	ld	a,(OFST+6,sp)
1297  00f3 2609          	jrne	L553
1299  00f5               L514:
1300                     ; 286 			while (usb.EP[EP_num].tx_state == USB_EP_DATA_READY) {}
1302  00f5 7b08          	ld	a,(OFST+6,sp)
1303  00f7 ad3c          	call	LC006
1304  00f9 e623          	ld	a,(_usb+35,x)
1305  00fb 4a            	dec	a
1306  00fc 27f7          	jreq	L514
1307  00fe               L553:
1308                     ; 251 	while (length > 0)
1310  00fe 7b07          	ld	a,(OFST+5,sp)
1311  0100 2703cc0037    	jrne	L353
1312  0105               L153:
1313                     ; 290 	if (flag) { // Send an empty packet
1315  0105 7b01          	ld	a,(OFST-1,sp)
1316  0107 2728          	jreq	L124
1317                     ; 291 		usb.EP[EP_num].tx_length = 4;
1319  0109 7b08          	ld	a,(OFST+6,sp)
1320  010b ad28          	call	LC006
1321  010d a604          	ld	a,#4
1322  010f e721          	ld	(_usb+33,x),a
1323                     ; 292 		usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
1325  0111 a680          	ld	a,#128
1326  0113 e715          	ld	(_usb+21,x),a
1327                     ; 293 		usb.EP[EP_num].tx_buffer[1] = usb.EP[EP_num].tx_data_sync;
1329  0115 e622          	ld	a,(_usb+34,x)
1330  0117 e716          	ld	(_usb+22,x),a
1331                     ; 294 		usb.EP[EP_num].tx_buffer[2] = 0;
1333  0119 6f17          	clr	(_usb+23,x)
1334                     ; 295 		usb.EP[EP_num].tx_buffer[3] = 0;
1336  011b 6f18          	clr	(_usb+24,x)
1337                     ; 297 		if (usb.EP[EP_num].tx_data_sync == USB_PID_DATA1)
1339  011d a14b          	cp	a,#75
1340  011f 2604          	jrne	L324
1341                     ; 298 			usb.EP[EP_num].tx_data_sync = USB_PID_DATA0;
1343  0121 a6c3          	ld	a,#195
1345  0123 2002          	jra	L524
1346  0125               L324:
1347                     ; 300 			usb.EP[EP_num].tx_data_sync = USB_PID_DATA1;
1349  0125 a64b          	ld	a,#75
1350  0127               L524:
1351  0127 e722          	ld	(_usb+34,x),a
1352                     ; 302 		usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
1354  0129 7b08          	ld	a,(OFST+6,sp)
1355  012b ad08          	call	LC006
1356  012d a601          	ld	a,#1
1357  012f e723          	ld	(_usb+35,x),a
1358  0131               L124:
1359                     ; 304 	return 0;
1361  0131 4f            	clr	a
1363  0132 cc0025        	jra	L011
1364  0135               LC006:
1365  0135 97            	ld	xl,a
1366  0136 a61d          	ld	a,#29
1367  0138 42            	mul	x,a
1368  0139 81            	ret	
1403                     ; 307 void USB_Send_STALL(uint8_t EP_num)
1403                     ; 308 {
1404                     .text:	section	.text,new
1405  0000               _USB_Send_STALL:
1407  0000 88            	push	a
1408       00000000      OFST:	set	0
1411                     ; 309 	usb.EP[EP_num].tx_length = 2;
1413  0001 97            	ld	xl,a
1414  0002 a61d          	ld	a,#29
1415  0004 42            	mul	x,a
1416  0005 a602          	ld	a,#2
1417  0007 e721          	ld	(_usb+33,x),a
1418                     ; 310 	usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
1420  0009 7b01          	ld	a,(OFST+1,sp)
1421  000b 97            	ld	xl,a
1422  000c a61d          	ld	a,#29
1423  000e 42            	mul	x,a
1424  000f a680          	ld	a,#128
1425  0011 e715          	ld	(_usb+21,x),a
1426                     ; 311 	usb.EP[EP_num].tx_buffer[1] = USB_PID_STALL;
1428  0013 a61e          	ld	a,#30
1429  0015 e716          	ld	(_usb+22,x),a
1430                     ; 312 	usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
1432  0017 a601          	ld	a,#1
1433  0019 e723          	ld	(_usb+35,x),a
1434                     ; 313 }
1437  001b 84            	pop	a
1438  001c 81            	ret	
1552                     ; 320 void USB_loop(void)
1552                     ; 321 {
1553                     .text:	section	.text,new
1554  0000               _USB_loop:
1556  0000 89            	pushw	x
1557       00000002      OFST:	set	2
1560                     ; 322 	if ((GPIOC->IDR & 0xC0) == 0) {
1562  0001 c6500b        	ld	a,20491
1563  0004 a5c0          	bcp	a,#192
1564  0006 260f          	jrne	L536
1565                     ; 323 		usb.reset_counter++;
1567  0008 be41          	ldw	x,_usb+65
1568  000a 5c            	incw	x
1569  000b bf41          	ldw	_usb+65,x
1570                     ; 324 		if (usb.reset_counter > USB_RESET_DELAY) {
1572  000d a30bb9        	cpw	x,#3001
1573  0010 2508          	jrult	L146
1574                     ; 325 			USB_Reset();
1576  0012 cd0000        	call	_USB_Reset
1578                     ; 326 			return;
1581  0015 85            	popw	x
1582  0016 81            	ret	
1583  0017               L536:
1584                     ; 328 	} else usb.reset_counter = 0;
1586  0017 5f            	clrw	x
1587  0018 bf41          	ldw	_usb+65,x
1588  001a               L146:
1589                     ; 330 	if (usb.EP[0].rx_state == USB_EP_DATA_READY)
1591  001a b614          	ld	a,_usb+20
1592  001c 4a            	dec	a
1593  001d 2703cc01f7    	jrne	L346
1594                     ; 332 		if (usb.EP0_data_stage == USB_STAGE_SETUP) // EP0 Setup stage
1596  0022 b606          	ld	a,_usb+6
1597  0024 4a            	dec	a
1598  0025 2703cc01ef    	jrne	L546
1599                     ; 334 			t_USB_SetupReq *p_USB_SetupReq = (t_USB_SetupReq*)(usb.EP[0].rx_buffer);
1601  002a ae0007        	ldw	x,#_usb+7
1602  002d 1f01          	ldw	(OFST-1,sp),x
1604                     ; 335 			switch (p_USB_SetupReq->bmRequest & 0x1F)
1606  002f b607          	ld	a,_usb+7
1607  0031 a41f          	and	a,#31
1609                     ; 646 					break;
1610  0033 270f          	jreq	L544
1611  0035 4a            	dec	a
1612  0036 2603cc01cb    	jreq	L355
1613  003b 4a            	dec	a
1614  003c 2603cc01e3    	jreq	L365
1615                     ; 317 	USB_Send_STALL(0);
1618  0041 cc01dd        	jp	L177
1619  0044               L544:
1620                     ; 339 					switch (p_USB_SetupReq->bRequest)
1622  0044 e601          	ld	a,(1,x)
1624                     ; 521 							break;
1625  0046 2603cc0185    	jreq	L525
1626  004b 4a            	dec	a
1627  004c 2603cc01ad    	jreq	L735
1628  0051 a002          	sub	a,#2
1629  0053 2603cc01a2    	jreq	L535
1630  0058 a002          	sub	a,#2
1631  005a 277a          	jreq	L564
1632  005c 4a            	dec	a
1633  005d 2710          	jreq	L744
1634  005f a002          	sub	a,#2
1635  0061 2603cc016e    	jreq	L315
1636  0066 4a            	dec	a
1637  0067 2603cc0105    	jreq	L374
1638                     ; 317 	USB_Send_STALL(0);
1641  006c cc01dd        	jp	L177
1642  006f               L744:
1643                     ; 343 							switch (p_USB_SetupReq->wValue_HI)
1645  006f e603          	ld	a,(3,x)
1647                     ; 368 									break;
1648  0071 4a            	dec	a
1649  0072 2709          	jreq	L154
1650  0074 4a            	dec	a
1651  0075 2719          	jreq	L354
1652  0077 4a            	dec	a
1653  0078 2729          	jreq	L554
1654                     ; 317 	USB_Send_STALL(0);
1657  007a cc01dd        	jp	L177
1658  007d               L154:
1659                     ; 347 									USB_Send_Data(usb_device_descriptor, (uint8_t)MIN(p_USB_SetupReq->wLength_LO, SIZE_DEVICE_DESCRIPTOR), 0);
1661  007d 4b00          	push	#0
1662  007f 1e02          	ldw	x,(OFST+0,sp)
1663  0081 e606          	ld	a,(6,x)
1664  0083 a113          	cp	a,#19
1665  0085 2502          	jrult	L421
1666  0087 a612          	ld	a,#18
1667  0089               L421:
1668  0089 88            	push	a
1669  008a ae0000        	ldw	x,#_usb_device_descriptor
1671                     ; 348 									break;
1673  008d cc01c5        	jp	LC007
1674  0090               L354:
1675                     ; 352 									USB_Send_Data(usb_configuration_descriptor, (uint8_t)MIN(p_USB_SetupReq->wLength_LO, SIZE_CONFIGURATION_DESCRIPTOR), 0);
1677  0090 4b00          	push	#0
1678  0092 1e02          	ldw	x,(OFST+0,sp)
1679  0094 e606          	ld	a,(6,x)
1680  0096 a123          	cp	a,#35
1681  0098 2502          	jrult	L231
1682  009a a622          	ld	a,#34
1683  009c               L231:
1684  009c 88            	push	a
1685  009d ae0000        	ldw	x,#_usb_configuration_descriptor
1687                     ; 353 									break;
1689  00a0 cc01c5        	jp	LC007
1690  00a3               L554:
1691                     ; 357 									if (p_USB_SetupReq->wValue_LO < LENGTH_STRING_DESCRIPTOR) {
1693  00a3 e602          	ld	a,(2,x)
1694  00a5 a104          	cp	a,#4
1695  00a7 24d1          	jruge	L177
1696                     ; 358 										USB_Send_Data(USB_String_Descriptors[p_USB_SetupReq->wValue_LO], 
1696                     ; 359 												(uint8_t)MIN(p_USB_SetupReq->wLength_LO, USB_String_Descriptors_Length[p_USB_SetupReq->wValue_LO]), 0);
1698  00a9 4b00          	push	#0
1699  00ab 1e02          	ldw	x,(OFST+0,sp)
1700  00ad e602          	ld	a,(2,x)
1701  00af 5f            	clrw	x
1702  00b0 1602          	ldw	y,(OFST+0,sp)
1703  00b2 97            	ld	xl,a
1704  00b3 90e606        	ld	a,(6,y)
1705  00b6 d10000        	cp	a,(_USB_String_Descriptors_Length,x)
1706  00b9 2205          	jrugt	L631
1707  00bb 93            	ldw	x,y
1708  00bc e606          	ld	a,(6,x)
1709  00be 2009          	jra	L041
1710  00c0               L631:
1711  00c0 1e02          	ldw	x,(OFST+0,sp)
1712  00c2 e602          	ld	a,(2,x)
1713  00c4 5f            	clrw	x
1714  00c5 97            	ld	xl,a
1715  00c6 d60000        	ld	a,(_USB_String_Descriptors_Length,x)
1716  00c9               L041:
1717  00c9 88            	push	a
1718  00ca 1e03          	ldw	x,(OFST+1,sp)
1719  00cc e602          	ld	a,(2,x)
1720  00ce 5f            	clrw	x
1721  00cf 97            	ld	xl,a
1722  00d0 58            	sllw	x
1723  00d1 ee00          	ldw	x,(_USB_String_Descriptors,x)
1726  00d3 cc01c5        	jp	LC007
1727                     ; 317 	USB_Send_STALL(0);
1730                     ; 371 							break;
1732  00d6               L564:
1733                     ; 375 							if ((p_USB_SetupReq->wIndex_LO == 0) && (p_USB_SetupReq->wLength_LO == 0)) {
1735  00d6 e604          	ld	a,(4,x)
1736  00d8 26a0          	jrne	L177
1738  00da e606          	ld	a,(6,x)
1739  00dc 269c          	jrne	L177
1740                     ; 376 								if (usb.dev_state == USB_STATE_CONFIGURED) {
1742  00de b604          	ld	a,_usb+4
1743  00e0 a103          	cp	a,#3
1744                     ; 317 	USB_Send_STALL(0);
1747  00e2 2796          	jreq	L177
1748                     ; 379 									usb.setup_address = (uint8_t)(p_USB_SetupReq->wValue_LO & 0x7F);
1750  00e4 e602          	ld	a,(2,x)
1751  00e6 a47f          	and	a,#127
1752  00e8 b702          	ld	_usb+2,a
1753                     ; 380 									USB_Send_Data(NULL, 0, 0);
1755  00ea 4b00          	push	#0
1756  00ec 4b00          	push	#0
1757  00ee 5f            	clrw	x
1758  00ef cd0000        	call	_USB_Send_Data
1760  00f2 3d02          	tnz	_usb+2
1761  00f4 85            	popw	x
1762                     ; 381 									if (usb.setup_address) 	usb.dev_state  = USB_STATE_ADDRESSED;
1764  00f5 2707          	jreq	L576
1767  00f7 35020004      	mov	_usb+4,#2
1769  00fb cc01f5        	jra	LC011
1770  00fe               L576:
1771                     ; 382 									else 										usb.dev_state  = USB_STATE_DEFAULT; 
1773  00fe 35010004      	mov	_usb+4,#1
1774  0102 cc01f5        	jra	LC011
1775                     ; 317 	USB_Send_STALL(0);
1778  0105               L374:
1779                     ; 391 							if (p_USB_SetupReq->wValue_LO <= USB_MAX_NUM_CONFIGURATION)
1781  0105 e602          	ld	a,(2,x)
1782  0107 a102          	cp	a,#2
1783  0109 2503cc01dd    	jruge	L177
1784                     ; 393 								switch (usb.dev_state)
1786  010e b604          	ld	a,_usb+4
1788                     ; 435 										break;
1789  0110 a002          	sub	a,#2
1790  0112 2706          	jreq	L574
1791  0114 4a            	dec	a
1792  0115 2731          	jreq	L105
1793                     ; 317 	USB_Send_STALL(0);
1796  0117 cc01dd        	jp	L177
1797  011a               L574:
1798                     ; 397 										if (p_USB_SetupReq->wValue_LO) 
1800  011a e602          	ld	a,(2,x)
1801  011c 2603cc01c0    	jreq	LC008
1802                     ; 399 											usb.dev_config = p_USB_SetupReq->wValue_LO; // set new configuration
1804  0121 b705          	ld	_usb+5,a
1805                     ; 400 											usb.dev_state = USB_STATE_CONFIGURED;
1807  0123 35030004      	mov	_usb+4,#3
1808                     ; 401 											if (USB_Class_Init_callback(usb.dev_config) < 0) usb_control_error();
1810  0127 cd0000        	call	_USB_Class_Init_callback
1812  012a 4d            	tnz	a
1813  012b 2a06          	jrpl	L317
1814                     ; 317 	USB_Send_STALL(0);
1817  012d 4f            	clr	a
1818  012e cd0000        	call	_USB_Send_STALL
1820  0131 2009          	jra	L517
1821  0133               L317:
1822                     ; 402 											else USB_Send_Data(NULL, 0, 0);
1824  0133 4b00          	push	#0
1825  0135 4b00          	push	#0
1826  0137 5f            	clrw	x
1827  0138 cd0000        	call	_USB_Send_Data
1829  013b 85            	popw	x
1830  013c               L517:
1831                     ; 404 											if (usb.trimming_stage == HSI_TRIMMER_STARTED) 
1833  013c b646          	ld	a,_usb+70
1834  013e 4a            	dec	a
1835  013f 26c1          	jrne	LC011
1836                     ; 405 												usb.trimming_stage = HSI_TRIMMER_WRITE_TRIM_VAL;
1838  0141 35030046      	mov	_usb+70,#3
1839  0145 cc01f5        	jra	LC011
1840                     ; 408 											USB_Send_Data(NULL, 0, 0);
1842  0148               L105:
1843                     ; 414 										if (p_USB_SetupReq->wValue_LO == 0) 
1845  0148 6d02          	tnz	(2,x)
1846  014a 260b          	jrne	L327
1847                     ; 416 											usb.dev_state = USB_STATE_ADDRESSED;
1849  014c 35020004      	mov	_usb+4,#2
1850                     ; 417 											usb.dev_config = 0;
1852  0150 b705          	ld	_usb+5,a
1853                     ; 418 											USB_Class_DeInit_callback();
1855  0152 cd0000        	call	_USB_Class_DeInit_callback
1857                     ; 419 											USB_Send_Data(NULL, 0, 0);
1860  0155 2069          	jp	LC008
1861  0157               L327:
1862                     ; 421 										if (p_USB_SetupReq->wValue_LO != usb.dev_config) 
1864  0157 e602          	ld	a,(2,x)
1865  0159 b105          	cp	a,_usb+5
1866  015b 2763          	jreq	LC008
1867                     ; 423 											USB_Class_DeInit_callback();
1869  015d cd0000        	call	_USB_Class_DeInit_callback
1871                     ; 424 											usb.dev_config = p_USB_SetupReq->wValue_LO; // set new configuration
1873  0160 1e01          	ldw	x,(OFST-1,sp)
1874  0162 e602          	ld	a,(2,x)
1875  0164 b705          	ld	_usb+5,a
1876                     ; 425 											if (USB_Class_Init_callback(usb.dev_config) < 0) usb_control_error();
1878  0166 cd0000        	call	_USB_Class_Init_callback
1880  0169 4d            	tnz	a
1881  016a 2a54          	jrpl	LC008
1882                     ; 317 	USB_Send_STALL(0);
1885  016c 206f          	jp	L177
1886                     ; 426 											else USB_Send_Data(NULL, 0, 0);
1888                     ; 428 											USB_Send_Data(NULL, 0, 0);
1890                     ; 435 										break;
1891                     ; 317 	USB_Send_STALL(0);
1894  016e               L315:
1895                     ; 445 							if (p_USB_SetupReq->wLength_LO == 1) 
1897  016e e606          	ld	a,(6,x)
1898  0170 4a            	dec	a
1899  0171 266a          	jrne	L177
1900                     ; 447 								switch (usb.dev_state)  
1902  0173 b604          	ld	a,_usb+4
1904                     ; 458 										break;
1905  0175 a002          	sub	a,#2
1906  0177 2703          	jreq	L515
1907  0179 4a            	dec	a
1908                     ; 317 	USB_Send_STALL(0);
1911  017a 2661          	jrne	L177
1912  017c               L515:
1913                     ; 452 										USB_Send_Data(&usb.dev_config, 1, 0);
1915  017c 4b00          	push	#0
1916  017e 4b01          	push	#1
1917  0180 ae0005        	ldw	x,#_usb+5
1919                     ; 453 										break;
1921  0183 2040          	jp	LC007
1922                     ; 458 										break;
1923                     ; 317 	USB_Send_STALL(0);
1926  0185               L525:
1927                     ; 467 							switch (usb.dev_state) 
1929  0185 b604          	ld	a,_usb+4
1931                     ; 484 									break;
1932  0187 a002          	sub	a,#2
1933  0189 2703          	jreq	L725
1934  018b 4a            	dec	a
1935                     ; 317 	USB_Send_STALL(0);
1938  018c 264f          	jrne	L177
1939  018e               L725:
1940                     ; 472 									usb.dev_config_status = 0;
1942  018e 5f            	clrw	x
1943  018f bf43          	ldw	_usb+67,x
1944                     ; 476 									if (usb.dev_remote_wakeup)
1946  0191 b645          	ld	a,_usb+69
1947  0193 2704          	jreq	L557
1948                     ; 477 										usb.dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;
1950  0195 72120044      	bset	_usb+68,#1
1951  0199               L557:
1952                     ; 478 									USB_Send_Data((uint8_t*)&usb.dev_config_status, 2, 0);
1954  0199 4b00          	push	#0
1955  019b 4b02          	push	#2
1956  019d ae0043        	ldw	x,#_usb+67
1958                     ; 479 									break;
1960  01a0 2023          	jp	LC007
1961                     ; 486 							break;
1963  01a2               L535:
1964                     ; 490 							if (p_USB_SetupReq->wValue_LO == USB_FEATURE_REMOTE_WAKEUP)
1966  01a2 e602          	ld	a,(2,x)
1967  01a4 4a            	dec	a
1968  01a5 264e          	jrne	LC011
1969                     ; 492 								usb.dev_remote_wakeup = 1;  
1971  01a7 35010045      	mov	_usb+69,#1
1972                     ; 493 								USB_Setup_Request_callback(p_USB_SetupReq);
1974                     ; 494 								USB_Send_Data(NULL, 0, 0);
1976  01ab 2010          	jp	LC009
1977  01ad               L735:
1978                     ; 500 							switch (usb.dev_state)
1980  01ad b604          	ld	a,_usb+4
1982                     ; 514 									break;
1983  01af a002          	sub	a,#2
1984  01b1 2703          	jreq	L145
1985  01b3 4a            	dec	a
1986                     ; 317 	USB_Send_STALL(0);
1989  01b4 2627          	jrne	L177
1990  01b6               L145:
1991                     ; 502 								case USB_STATE_ADDRESSED:
1991                     ; 503 								case USB_STATE_CONFIGURED:
1991                     ; 504 									if (p_USB_SetupReq->wValue_LO == USB_FEATURE_REMOTE_WAKEUP) 
1993  01b6 e602          	ld	a,(2,x)
1994  01b8 4a            	dec	a
1995  01b9 263a          	jrne	LC011
1996                     ; 506 										usb.dev_remote_wakeup = 0; 
1998  01bb b745          	ld	_usb+69,a
1999                     ; 507 										USB_Setup_Request_callback(p_USB_SetupReq);
2001  01bd               LC009:
2003  01bd cd0000        	call	_USB_Setup_Request_callback
2005                     ; 508 										USB_Send_Data(NULL, 0, 0);
2007  01c0               LC008:
2013  01c0 4b00          	push	#0
2014  01c2 4b00          	push	#0
2015  01c4 5f            	clrw	x
2017  01c5               LC007:
2018  01c5 cd0000        	call	_USB_Send_Data
2019  01c8 85            	popw	x
2020  01c9 202a          	jra	LC011
2021                     ; 516 							break;
2023                     ; 524 					break;
2025  01cb               L355:
2026                     ; 529 					if (usb.dev_state == USB_STATE_CONFIGURED)
2028  01cb b604          	ld	a,_usb+4
2029  01cd a103          	cp	a,#3
2030  01cf 260c          	jrne	L177
2031                     ; 531 						if (p_USB_SetupReq->wIndex_LO <= USB_MAX_NUM_INTERFACES) 
2033  01d1 e604          	ld	a,(4,x)
2034  01d3 a102          	cp	a,#2
2035  01d5 2406          	jruge	L177
2036                     ; 533 							if (USB_Setup_Request_callback(p_USB_SetupReq) < 0) usb_control_error();
2038  01d7 cd0000        	call	_USB_Setup_Request_callback
2040  01da 4d            	tnz	a
2041  01db 2a18          	jrpl	LC011
2042                     ; 317 	USB_Send_STALL(0);
2045  01dd               L177:
2064  01dd 4f            	clr	a
2065  01de cd0000        	call	_USB_Send_STALL
2067  01e1 2012          	jra	LC011
2071  01e3               L365:
2072                     ; 541 					if ((p_USB_SetupReq->bmRequest & 0x60) == 0x20) // Check if it is a class request
2074  01e3 f6            	ld	a,(x)
2075  01e4 a460          	and	a,#96
2076  01e6 a120          	cp	a,#32
2077  01e8 260b          	jrne	LC011
2078                     ; 543 						USB_Setup_Request_callback(p_USB_SetupReq);
2080  01ea cd0000        	call	_USB_Setup_Request_callback
2082                     ; 648 			usb.EP[0].rx_state = USB_EP_NO_DATA;
2084  01ed 2006          	jp	LC011
2085  01ef               L546:
2086                     ; 650 			USB_EP0_RxReady_callback(usb.EP[0].rx_buffer);
2088  01ef ae0007        	ldw	x,#_usb+7
2089  01f2 cd0000        	call	_USB_EP0_RxReady_callback
2091                     ; 651 			usb.EP[0].rx_state = USB_EP_NO_DATA;
2093  01f5               LC011:
2095  01f5 3f14          	clr	_usb+20
2096  01f7               L346:
2097                     ; 655 	if (usb.EP[1].rx_state == USB_EP_DATA_READY) {
2099  01f7 b631          	ld	a,_usb+49
2100  01f9 4a            	dec	a
2101  01fa 2608          	jrne	L5001
2102                     ; 656 		USB_EP1_RxReady_callback(usb.EP[1].rx_buffer);
2104  01fc ae0024        	ldw	x,#_usb+36
2105  01ff cd0000        	call	_USB_EP1_RxReady_callback
2107                     ; 657 		usb.EP[1].rx_state = USB_EP_NO_DATA;
2109  0202 3f31          	clr	_usb+49
2110  0204               L5001:
2111                     ; 659 }
2114  0204 85            	popw	x
2115  0205 81            	ret	
2145                     ; 661 void USB_slow_loop(void)
2145                     ; 662 {
2146                     .text:	section	.text,new
2147  0000               _USB_slow_loop:
2151                     ; 664 	if (usb.trimming_stage == HSI_TRIMMER_DISABLE) return;
2153  0000 b646          	ld	a,_usb+70
2154  0002 a104          	cp	a,#4
2155  0004 2601          	jrne	L7101
2159  0006 81            	ret	
2160  0007               L7101:
2161                     ; 665 	if (usb.trimming_stage == HSI_TRIMMER_STARTED)
2163  0007 a101          	cp	a,#1
2164  0009 262a          	jrne	L1201
2165                     ; 667 		usb.delay_counter++;
2167  000b be47          	ldw	x,_usb+71
2168  000d 5c            	incw	x
2169  000e bf47          	ldw	_usb+71,x
2170                     ; 668 		if (usb.delay_counter == USB_CONNECT_TIMEOUT)
2172  0010 a302bc        	cpw	x,#700
2173  0013 264d          	jrne	L5201
2174                     ; 670 			usb.delay_counter = 0;
2176  0015 5f            	clrw	x
2177  0016 bf47          	ldw	_usb+71,x
2178                     ; 671 			usb.HSI_Trim_val++;
2180  0018 3c49          	inc	_usb+73
2181                     ; 672 			usb.HSI_Trim_val &= 0x0F;
2183  001a b649          	ld	a,_usb+73
2184  001c a40f          	and	a,#15
2185  001e b749          	ld	_usb+73,a
2186                     ; 673 			CLK->HSITRIMR = (uint8_t)((CLK->HSITRIMR & (~0x0F)) | usb.HSI_Trim_val);
2188  0020 c650cc        	ld	a,20684
2189  0023 a4f0          	and	a,#240
2190  0025 ba49          	or	a,_usb+73
2191  0027 c750cc        	ld	20684,a
2192                     ; 674 			USB_disconnect();
2194  002a cd0000        	call	_USB_disconnect
2196                     ; 675 			USB_Reset();
2198  002d cd0000        	call	_USB_Reset
2200                     ; 676 			usb.trimming_stage = HSI_TRIMMER_RECONNECT_DELAY;
2202  0030 35020046      	mov	_usb+70,#2
2204  0034 81            	ret	
2205  0035               L1201:
2206                     ; 679 	if (usb.trimming_stage == HSI_TRIMMER_RECONNECT_DELAY)
2208  0035 a102          	cp	a,#2
2209  0037 2612          	jrne	L7201
2210                     ; 681 		usb.delay_counter++;
2212  0039 be47          	ldw	x,_usb+71
2213  003b 5c            	incw	x
2214  003c bf47          	ldw	_usb+71,x
2215                     ; 682 		if (usb.delay_counter == USB_RECONNECT_DELAY)
2217  003e a30064        	cpw	x,#100
2218  0041 261f          	jrne	L5201
2219                     ; 684 			usb.delay_counter = 0;
2221  0043 5f            	clrw	x
2222  0044 bf47          	ldw	_usb+71,x
2223                     ; 685 			usb.trimming_stage = HSI_TRIMMER_ENABLE;
2225  0046 3f46          	clr	_usb+70
2226                     ; 686 			USB_connect();
2230  0048 cc0000        	jp	_USB_connect
2231  004b               L7201:
2232                     ; 689 	if (usb.trimming_stage == HSI_TRIMMER_WRITE_TRIM_VAL)
2234  004b a103          	cp	a,#3
2235  004d 2613          	jrne	L5201
2236                     ; 691 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
2238  004f a6f7          	ld	a,#247
2239  0051 cd0000        	call	_FLASH_Unlock
2241                     ; 692 		*p_HSI_TRIM_VAL = usb.HSI_Trim_val;
2243  0054 b649          	ld	a,_usb+73
2244  0056 92c700        	ld	[_p_HSI_TRIM_VAL.w],a
2245                     ; 693 		*p_HSI_TRIMING_DONE = MAGIC_VAL;
2247  0059 a611          	ld	a,#17
2248  005b 92c702        	ld	[_p_HSI_TRIMING_DONE.w],a
2249                     ; 694 		usb.trimming_stage = HSI_TRIMMER_DISABLE;
2251  005e 35040046      	mov	_usb+70,#4
2252  0062               L5201:
2253                     ; 697 }
2256  0062 81            	ret	
2591                     	xdef	_USB_Send_STALL
2592                     	xdef	_usb_calc_crc16
2593                     	xdef	_usb_rx_ok
2594                     	xdef	_usb_send_nack
2595                     	xdef	_USB_Reset
2596                     	xref	_ll_usb_tx
2597                     	xdef	_p_HSI_TRIMING_DONE
2598                     	xdef	_p_HSI_TRIM_VAL
2599                     	switch	.ubsct
2600  0000               _usb:
2601  0000 000000000000  	ds.b	74
2602                     	xdef	_usb
2603  004a               _ll_usb_rx_count:
2604  004a 00            	ds.b	1
2605                     	xdef	_ll_usb_rx_count
2606  004b               _ll_usb_tx_count:
2607  004b 00            	ds.b	1
2608                     	xdef	_ll_usb_tx_count
2609  004c               _ll_usb_tx_buffer_pointer:
2610  004c 0000          	ds.b	2
2611                     	xdef	_ll_usb_tx_buffer_pointer
2612  004e               _ll_usb_rx_buffer:
2613  004e 000000000000  	ds.b	16
2614                     	xdef	_ll_usb_rx_buffer
2615                     	xref	_USB_Class_DeInit_callback
2616                     	xref	_USB_Class_Init_callback
2617                     	xref	_USB_Setup_Request_callback
2618                     	xref	_USB_EP1_RxReady_callback
2619                     	xref	_USB_EP0_RxReady_callback
2620                     	xdef	_USB_Send_Data
2621                     	xdef	_USB_slow_loop
2622                     	xdef	_USB_disconnect
2623                     	xdef	_USB_connect
2624                     	xdef	_USB_loop
2625                     	xdef	_USB_Init
2626                     	xref	_USB_String_Descriptors_Length
2627                     	xref.b	_USB_String_Descriptors
2628                     	xref	_usb_configuration_descriptor
2629                     	xref	_usb_device_descriptor
2630                     	xref	_TIM1_ClearFlag
2631                     	xref	_TIM1_SelectSlaveMode
2632                     	xref	_TIM1_SelectInputTrigger
2633                     	xref	_TIM1_ITConfig
2634                     	xref	_TIM1_ICInit
2635                     	xref	_TIM1_TimeBaseInit
2636                     	xref	_GPIO_WriteLow
2637                     	xref	_GPIO_WriteHigh
2638                     	xref	_GPIO_Init
2639                     	xref	_FLASH_Unlock
2640                     	xref	_CLK_PeripheralClockConfig
2641                     	xref.b	c_x
2661                     	end
