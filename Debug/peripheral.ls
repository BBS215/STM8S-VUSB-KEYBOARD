   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  21                     .const:	section	.text
  22  0000               _LED_pin:
  23  0000 20            	dc.b	32
  24  0001 10            	dc.b	16
  25  0002 04            	dc.b	4
  26  0003               _LED_port:
  27  0003 5005          	dc.w	20485
  28  0005 5005          	dc.w	20485
  29  0007 500f          	dc.w	20495
  74                     ; 11 void Leds_init(void)
  74                     ; 12 {
  76                     .text:	section	.text,new
  77  0000               _Leds_init:
  79  0000 88            	push	a
  80       00000001      OFST:	set	1
  83                     ; 14 	for(i=0;i<LEDS_CNT;i++)
  85  0001 0f01          	clr	(OFST+0,sp)
  87  0003               L72:
  88                     ; 16 		GPIO_Init(LED_port[i], LED_pin[i], GPIO_MODE_OUT_PP_HIGH_SLOW);
  90  0003 4bd0          	push	#208
  91  0005 7b02          	ld	a,(OFST+1,sp)
  92  0007 5f            	clrw	x
  93  0008 97            	ld	xl,a
  94  0009 d60000        	ld	a,(_LED_pin,x)
  95  000c 88            	push	a
  96  000d 7b03          	ld	a,(OFST+2,sp)
  97  000f 5f            	clrw	x
  98  0010 97            	ld	xl,a
  99  0011 58            	sllw	x
 100  0012 de0003        	ldw	x,(_LED_port,x)
 101  0015 cd0000        	call	_GPIO_Init
 103  0018 85            	popw	x
 104                     ; 17 		Led_setmode(i, LED_OFF);
 106  0019 7b01          	ld	a,(OFST+0,sp)
 107  001b 5f            	clrw	x
 108  001c 95            	ld	xh,a
 109  001d cd0000        	call	_Led_setmode
 111                     ; 14 	for(i=0;i<LEDS_CNT;i++)
 113  0020 0c01          	inc	(OFST+0,sp)
 117  0022 7b01          	ld	a,(OFST+0,sp)
 118  0024 a103          	cp	a,#3
 119  0026 25db          	jrult	L72
 120                     ; 19 }
 123  0028 84            	pop	a
 124  0029 81            	ret	
 172                     ; 21 void Led_setmode(uint8_t num, uint8_t mode)
 172                     ; 22 {
 173                     .text:	section	.text,new
 174  0000               _Led_setmode:
 176  0000 89            	pushw	x
 177       00000000      OFST:	set	0
 180                     ; 23 	if (num >= LEDS_CNT) return;
 182  0001 9e            	ld	a,xh
 183  0002 a103          	cp	a,#3
 184  0004 2438          	jruge	L36
 187                     ; 24 	g_LEDS_mode[num] = mode;
 189  0006 7b01          	ld	a,(OFST+1,sp)
 190  0008 5f            	clrw	x
 191  0009 97            	ld	xl,a
 192  000a 7b02          	ld	a,(OFST+2,sp)
 193  000c e700          	ld	(_g_LEDS_mode,x),a
 194                     ; 25 	if (mode == LED_ON) {
 196  000e 4a            	dec	a
 197  000f 2615          	jrne	L16
 198                     ; 26 		GPIO_WriteLow(LED_port[num], LED_pin[num]);
 200  0011 7b01          	ld	a,(OFST+1,sp)
 201  0013 5f            	clrw	x
 202  0014 97            	ld	xl,a
 203  0015 d60000        	ld	a,(_LED_pin,x)
 204  0018 88            	push	a
 205  0019 7b02          	ld	a,(OFST+2,sp)
 206  001b 5f            	clrw	x
 207  001c 97            	ld	xl,a
 208  001d 58            	sllw	x
 209  001e de0003        	ldw	x,(_LED_port,x)
 210  0021 cd0000        	call	_GPIO_WriteLow
 213  0024 2017          	jp	LC001
 214  0026               L16:
 215                     ; 28 	if (mode == LED_OFF) {
 217  0026 7b02          	ld	a,(OFST+2,sp)
 218  0028 2614          	jrne	L36
 219                     ; 29 		GPIO_WriteHigh(LED_port[num], LED_pin[num]);
 221  002a 7b01          	ld	a,(OFST+1,sp)
 222  002c 5f            	clrw	x
 223  002d 97            	ld	xl,a
 224  002e d60000        	ld	a,(_LED_pin,x)
 225  0031 88            	push	a
 226  0032 7b02          	ld	a,(OFST+2,sp)
 227  0034 5f            	clrw	x
 228  0035 97            	ld	xl,a
 229  0036 58            	sllw	x
 230  0037 de0003        	ldw	x,(_LED_port,x)
 231  003a cd0000        	call	_GPIO_WriteHigh
 233  003d               LC001:
 234  003d 84            	pop	a
 235  003e               L36:
 236                     ; 31 }
 239  003e 85            	popw	x
 240  003f 81            	ret	
 243                     	switch	.const
 244  0009               _BUTTON_ROW_port:
 245  0009 500f          	dc.w	20495
 246  000b 500f          	dc.w	20495
 247  000d 500f          	dc.w	20495
 248  000f 500f          	dc.w	20495
 249  0011               _BUTTON_ROW_pin:
 250  0011 08            	dc.b	8
 251  0012 10            	dc.b	16
 252  0013 20            	dc.b	32
 253  0014 40            	dc.b	64
 254  0015               _BUTTON_COL_port:
 255  0015 500a          	dc.w	20490
 256  0017 500a          	dc.w	20490
 257  0019 500a          	dc.w	20490
 258  001b 500f          	dc.w	20495
 259  001d               _BUTTON_COL_pin:
 260  001d 20            	dc.b	32
 261  001e 10            	dc.b	16
 262  001f 08            	dc.b	8
 263  0020 02            	dc.b	2
 301                     ; 44 void Buttons_init(void)
 301                     ; 45 {
 302                     .text:	section	.text,new
 303  0000               _Buttons_init:
 305  0000 88            	push	a
 306       00000001      OFST:	set	1
 309                     ; 47 	for(i=0;i<BTN_ROW_CNT;i++)
 311  0001 0f01          	clr	(OFST+0,sp)
 313  0003               L501:
 314                     ; 48 		GPIO_Init(BUTTON_ROW_port[i], BUTTON_ROW_pin[i], GPIO_MODE_IN_PU_NO_IT);
 316  0003 4b40          	push	#64
 317  0005 7b02          	ld	a,(OFST+1,sp)
 318  0007 5f            	clrw	x
 319  0008 97            	ld	xl,a
 320  0009 d60011        	ld	a,(_BUTTON_ROW_pin,x)
 321  000c 88            	push	a
 322  000d 7b03          	ld	a,(OFST+2,sp)
 323  000f 5f            	clrw	x
 324  0010 97            	ld	xl,a
 325  0011 58            	sllw	x
 326  0012 de0009        	ldw	x,(_BUTTON_ROW_port,x)
 327  0015 cd0000        	call	_GPIO_Init
 329  0018 85            	popw	x
 330                     ; 47 	for(i=0;i<BTN_ROW_CNT;i++)
 332  0019 0c01          	inc	(OFST+0,sp)
 336  001b 7b01          	ld	a,(OFST+0,sp)
 337  001d a104          	cp	a,#4
 338  001f 25e2          	jrult	L501
 339                     ; 49 	for(i=0;i<BTN_COL_CNT;i++)
 341  0021 0f01          	clr	(OFST+0,sp)
 343  0023               L311:
 344                     ; 50 		GPIO_Init(BUTTON_COL_port[i], BUTTON_COL_pin[i], GPIO_MODE_IN_PU_NO_IT);
 346  0023 4b40          	push	#64
 347  0025 7b02          	ld	a,(OFST+1,sp)
 348  0027 5f            	clrw	x
 349  0028 97            	ld	xl,a
 350  0029 d6001d        	ld	a,(_BUTTON_COL_pin,x)
 351  002c 88            	push	a
 352  002d 7b03          	ld	a,(OFST+2,sp)
 353  002f 5f            	clrw	x
 354  0030 97            	ld	xl,a
 355  0031 58            	sllw	x
 356  0032 de0015        	ldw	x,(_BUTTON_COL_port,x)
 357  0035 cd0000        	call	_GPIO_Init
 359  0038 85            	popw	x
 360                     ; 49 	for(i=0;i<BTN_COL_CNT;i++)
 362  0039 0c01          	inc	(OFST+0,sp)
 366  003b 7b01          	ld	a,(OFST+0,sp)
 367  003d a104          	cp	a,#4
 368  003f 25e2          	jrult	L311
 369                     ; 51 	for(i=0;i<BTN_CNT;i++)
 371  0041 4f            	clr	a
 372  0042 6b01          	ld	(OFST+0,sp),a
 374  0044               L121:
 375                     ; 52 		g_buttons.holdtime[i] = BTN_TIME_TRESH+1;
 377  0044 5f            	clrw	x
 378  0045 97            	ld	xl,a
 379  0046 a603          	ld	a,#3
 380  0048 e708          	ld	(_g_buttons+5,x),a
 381                     ; 51 	for(i=0;i<BTN_CNT;i++)
 383  004a 0c01          	inc	(OFST+0,sp)
 387  004c 7b01          	ld	a,(OFST+0,sp)
 388  004e a110          	cp	a,#16
 389  0050 25f2          	jrult	L121
 390                     ; 53 	g_buttons.state = 0;
 392  0052 5f            	clrw	x
 393  0053 bf06          	ldw	_g_buttons+3,x
 394                     ; 54 	g_buttons.pressed = 0;
 396  0055 bf04          	ldw	_g_buttons+1,x
 397                     ; 55 	g_buttons.active_row = 0;
 399  0057 3f03          	clr	_g_buttons
 400                     ; 56 	GPIO_Init(BUTTON_ROW_port[0], BUTTON_ROW_pin[0], GPIO_MODE_OUT_PP_LOW_SLOW);
 402  0059 4bc0          	push	#192
 403  005b 4b08          	push	#8
 404  005d ae500f        	ldw	x,#20495
 405  0060 cd0000        	call	_GPIO_Init
 407                     ; 57 }
 410  0063 5b03          	addw	sp,#3
 411  0065 81            	ret	
 472                     ; 59 void Buttons_loop(void)
 472                     ; 60 {
 473                     .text:	section	.text,new
 474  0000               _Buttons_loop:
 476  0000 5204          	subw	sp,#4
 477       00000004      OFST:	set	4
 480                     ; 64 	for(i=0; i<BTN_COL_CNT; i++)
 482  0002 4f            	clr	a
 483  0003 6b01          	ld	(OFST-3,sp),a
 485  0005               L551:
 486                     ; 66 		btn_num = (uint8_t)((i*BTN_ROW_CNT)+g_buttons.active_row);
 488  0005 48            	sll	a
 489  0006 48            	sll	a
 490  0007 bb03          	add	a,_g_buttons
 491  0009 6b04          	ld	(OFST+0,sp),a
 493                     ; 67 		btn_mask = (uint16_t)(1 << btn_num);
 495  000b ae0001        	ldw	x,#1
 496  000e 4d            	tnz	a
 497  000f 2704          	jreq	L43
 498  0011               L63:
 499  0011 58            	sllw	x
 500  0012 4a            	dec	a
 501  0013 26fc          	jrne	L63
 502  0015               L43:
 503  0015 1f02          	ldw	(OFST-2,sp),x
 505                     ; 68 		if (GPIO_ReadInputPin(BUTTON_COL_port[i], BUTTON_COL_pin[i]) == RESET) // button pressed
 507  0017 5f            	clrw	x
 508  0018 7b01          	ld	a,(OFST-3,sp)
 509  001a 97            	ld	xl,a
 510  001b d6001d        	ld	a,(_BUTTON_COL_pin,x)
 511  001e 88            	push	a
 512  001f 7b02          	ld	a,(OFST-2,sp)
 513  0021 5f            	clrw	x
 514  0022 97            	ld	xl,a
 515  0023 58            	sllw	x
 516  0024 de0015        	ldw	x,(_BUTTON_COL_port,x)
 517  0027 cd0000        	call	_GPIO_ReadInputPin
 519  002a 5b01          	addw	sp,#1
 520  002c 4d            	tnz	a
 521  002d 264b          	jrne	L361
 522                     ; 70 			if (g_buttons.state & btn_mask) // already pressed
 524  002f be06          	ldw	x,_g_buttons+3
 525  0031 01            	rrwa	x,a
 526  0032 1403          	and	a,(OFST-1,sp)
 527  0034 01            	rrwa	x,a
 528  0035 1402          	and	a,(OFST-2,sp)
 529  0037 01            	rrwa	x,a
 530  0038 5d            	tnzw	x
 531  0039 2735          	jreq	L561
 532                     ; 72 				if ((g_buttons.holdtime[btn_num]) < BTN_TIME_TRESH) {
 534  003b 7b04          	ld	a,(OFST+0,sp)
 535  003d 5f            	clrw	x
 536  003e 97            	ld	xl,a
 537  003f e608          	ld	a,(_g_buttons+5,x)
 538  0041 a102          	cp	a,#2
 539  0043 7b04          	ld	a,(OFST+0,sp)
 540  0045 5f            	clrw	x
 541  0046 97            	ld	xl,a
 542                     ; 73 					g_buttons.holdtime[btn_num]++; // increment time
 544  0047 254b          	jrult	LC003
 545                     ; 75 				if ((g_buttons.holdtime[btn_num]) == BTN_TIME_TRESH) { // timeout
 547  0049 e608          	ld	a,(_g_buttons+5,x)
 548  004b a102          	cp	a,#2
 549  004d 2703cc00d3    	jrne	L102
 550                     ; 76 					if ((g_buttons.pressed & btn_mask) == 0)
 552  0052 be04          	ldw	x,_g_buttons+1
 553  0054 01            	rrwa	x,a
 554  0055 1403          	and	a,(OFST-1,sp)
 555  0057 01            	rrwa	x,a
 556  0058 1402          	and	a,(OFST-2,sp)
 557  005a 01            	rrwa	x,a
 558  005b 5d            	tnzw	x
 559  005c 265d          	jrne	L312
 560                     ; 78 						g_buttons.pressed |= btn_mask;
 562  005e 1e02          	ldw	x,(OFST-2,sp)
 563  0060 01            	rrwa	x,a
 564  0061 ba05          	or	a,_g_buttons+2
 565  0063 01            	rrwa	x,a
 566  0064 ba04          	or	a,_g_buttons+1
 567  0066 01            	rrwa	x,a
 568  0067 bf04          	ldw	_g_buttons+1,x
 569                     ; 80 						EVENT_KEY_pressed(btn_num);
 571  0069 7b04          	ld	a,(OFST+0,sp)
 572  006b cd0000        	call	_EVENT_KEY_pressed
 574                     ; 82 					g_buttons.holdtime[btn_num]++; // increment time
 575  006e 204b          	jp	L312
 576  0070               L561:
 577                     ; 85 				g_buttons.state |= btn_mask;
 579  0070 1e02          	ldw	x,(OFST-2,sp)
 580  0072 01            	rrwa	x,a
 581  0073 ba07          	or	a,_g_buttons+4
 582  0075 01            	rrwa	x,a
 583  0076 ba06          	or	a,_g_buttons+3
 584                     ; 86 				g_buttons.holdtime[btn_num] = 0;
 585  0078 2050          	jp	LC002
 586  007a               L361:
 587                     ; 89 			if ((g_buttons.state & btn_mask) == 0) // already released
 589  007a be06          	ldw	x,_g_buttons+3
 590  007c 01            	rrwa	x,a
 591  007d 1403          	and	a,(OFST-1,sp)
 592  007f 01            	rrwa	x,a
 593  0080 1402          	and	a,(OFST-2,sp)
 594  0082 01            	rrwa	x,a
 595  0083 5d            	tnzw	x
 596  0084 263b          	jrne	L302
 597                     ; 91 				if ((g_buttons.holdtime[btn_num]) < BTN_TIME_TRESH) {
 599  0086 7b04          	ld	a,(OFST+0,sp)
 600  0088 5f            	clrw	x
 601  0089 97            	ld	xl,a
 602  008a e608          	ld	a,(_g_buttons+5,x)
 603  008c a102          	cp	a,#2
 604  008e 7b04          	ld	a,(OFST+0,sp)
 605  0090 5f            	clrw	x
 606  0091 97            	ld	xl,a
 607  0092 2404          	jruge	L502
 608                     ; 92 					g_buttons.holdtime[btn_num]++; // increment time
 610  0094               LC003:
 612  0094 6c08          	inc	(_g_buttons+5,x)
 614  0096 203b          	jra	L102
 615  0098               L502:
 616                     ; 94 				if ((g_buttons.holdtime[btn_num]) == BTN_TIME_TRESH) { // timeout
 618  0098 e608          	ld	a,(_g_buttons+5,x)
 619  009a a102          	cp	a,#2
 620  009c 2635          	jrne	L102
 621                     ; 95 					if (g_buttons.pressed & btn_mask) {
 623  009e be04          	ldw	x,_g_buttons+1
 624  00a0 01            	rrwa	x,a
 625  00a1 1403          	and	a,(OFST-1,sp)
 626  00a3 01            	rrwa	x,a
 627  00a4 1402          	and	a,(OFST-2,sp)
 628  00a6 01            	rrwa	x,a
 629  00a7 5d            	tnzw	x
 630  00a8 2711          	jreq	L312
 631                     ; 96 						g_buttons.pressed &= ~btn_mask;
 633  00aa 1e02          	ldw	x,(OFST-2,sp)
 634  00ac 53            	cplw	x
 635  00ad 01            	rrwa	x,a
 636  00ae b405          	and	a,_g_buttons+2
 637  00b0 01            	rrwa	x,a
 638  00b1 b404          	and	a,_g_buttons+1
 639  00b3 01            	rrwa	x,a
 640  00b4 bf04          	ldw	_g_buttons+1,x
 641                     ; 98 						EVENT_KEY_released(btn_num);
 643  00b6 7b04          	ld	a,(OFST+0,sp)
 644  00b8 cd0000        	call	_EVENT_KEY_released
 646  00bb               L312:
 647                     ; 100 					g_buttons.holdtime[btn_num]++; // increment time
 650  00bb 7b04          	ld	a,(OFST+0,sp)
 651  00bd 5f            	clrw	x
 652  00be 97            	ld	xl,a
 653  00bf 20d3          	jp	LC003
 654  00c1               L302:
 655                     ; 103 				g_buttons.state &= ~btn_mask;
 657  00c1 1e02          	ldw	x,(OFST-2,sp)
 658  00c3 53            	cplw	x
 659  00c4 01            	rrwa	x,a
 660  00c5 b407          	and	a,_g_buttons+4
 661  00c7 01            	rrwa	x,a
 662  00c8 b406          	and	a,_g_buttons+3
 663                     ; 104 				g_buttons.holdtime[btn_num] = 0;
 665  00ca               LC002:
 666  00ca 01            	rrwa	x,a
 667  00cb bf06          	ldw	_g_buttons+3,x
 669  00cd 5f            	clrw	x
 670  00ce 7b04          	ld	a,(OFST+0,sp)
 671  00d0 97            	ld	xl,a
 672  00d1 6f08          	clr	(_g_buttons+5,x)
 673  00d3               L102:
 674                     ; 64 	for(i=0; i<BTN_COL_CNT; i++)
 676  00d3 0c01          	inc	(OFST-3,sp)
 680  00d5 7b01          	ld	a,(OFST-3,sp)
 681  00d7 a104          	cp	a,#4
 682  00d9 2403cc0005    	jrult	L551
 683                     ; 108 	GPIO_Init(BUTTON_ROW_port[g_buttons.active_row], BUTTON_ROW_pin[g_buttons.active_row], GPIO_MODE_IN_PU_NO_IT);
 685  00de 4b40          	push	#64
 686  00e0 b603          	ld	a,_g_buttons
 687  00e2 5f            	clrw	x
 688  00e3 97            	ld	xl,a
 689  00e4 d60011        	ld	a,(_BUTTON_ROW_pin,x)
 690  00e7 88            	push	a
 691  00e8 b603          	ld	a,_g_buttons
 692  00ea 5f            	clrw	x
 693  00eb 97            	ld	xl,a
 694  00ec 58            	sllw	x
 695  00ed de0009        	ldw	x,(_BUTTON_ROW_port,x)
 696  00f0 cd0000        	call	_GPIO_Init
 698  00f3 3c03          	inc	_g_buttons
 699  00f5 b603          	ld	a,_g_buttons
 700  00f7 a104          	cp	a,#4
 701  00f9 85            	popw	x
 702                     ; 109 	g_buttons.active_row++;
 704                     ; 110 	if (g_buttons.active_row >= BTN_ROW_CNT) g_buttons.active_row = 0;
 706  00fa 2503          	jrult	L712
 709  00fc 4f            	clr	a
 710  00fd b703          	ld	_g_buttons,a
 711  00ff               L712:
 712                     ; 111 	GPIO_Init(BUTTON_ROW_port[g_buttons.active_row], BUTTON_ROW_pin[g_buttons.active_row], GPIO_MODE_OUT_PP_LOW_SLOW);
 714  00ff 4bc0          	push	#192
 715  0101 5f            	clrw	x
 716  0102 97            	ld	xl,a
 717  0103 d60011        	ld	a,(_BUTTON_ROW_pin,x)
 718  0106 88            	push	a
 719  0107 b603          	ld	a,_g_buttons
 720  0109 5f            	clrw	x
 721  010a 97            	ld	xl,a
 722  010b 58            	sllw	x
 723  010c de0009        	ldw	x,(_BUTTON_ROW_port,x)
 724  010f cd0000        	call	_GPIO_Init
 726  0112 85            	popw	x
 727                     ; 112 }
 730  0113 5b04          	addw	sp,#4
 731  0115 81            	ret	
1014                     	xdef	_BUTTON_COL_pin
1015                     	xdef	_BUTTON_COL_port
1016                     	xdef	_BUTTON_ROW_pin
1017                     	xdef	_BUTTON_ROW_port
1018                     	switch	.ubsct
1019  0000               _g_LEDS_mode:
1020  0000 000000        	ds.b	3
1021                     	xdef	_g_LEDS_mode
1022                     	xdef	_LED_port
1023                     	xdef	_LED_pin
1024                     	xref	_EVENT_KEY_released
1025                     	xref	_EVENT_KEY_pressed
1026                     	xdef	_Buttons_loop
1027                     	xdef	_Buttons_init
1028  0003               _g_buttons:
1029  0003 000000000000  	ds.b	21
1030                     	xdef	_g_buttons
1031                     	xdef	_Led_setmode
1032                     	xdef	_Leds_init
1033                     	xref	_GPIO_ReadInputPin
1034                     	xref	_GPIO_WriteLow
1035                     	xref	_GPIO_WriteHigh
1036                     	xref	_GPIO_Init
1056                     	end
