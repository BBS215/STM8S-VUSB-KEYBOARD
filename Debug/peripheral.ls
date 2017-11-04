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
 244  0009               _BUTTON_pin:
 245  0009 02            	dc.b	2
 246  000a 08            	dc.b	8
 247  000b 20            	dc.b	32
 248  000c 10            	dc.b	16
 249  000d 40            	dc.b	64
 250  000e 08            	dc.b	8
 251  000f 10            	dc.b	16
 252  0010 20            	dc.b	32
 253  0011               _BUTTON_port:
 254  0011 500f          	dc.w	20495
 255  0013 500f          	dc.w	20495
 256  0015 500f          	dc.w	20495
 257  0017 500f          	dc.w	20495
 258  0019 500f          	dc.w	20495
 259  001b 500a          	dc.w	20490
 260  001d 500a          	dc.w	20490
 261  001f 500a          	dc.w	20490
 297                     ; 41 void Buttons_init(void)
 297                     ; 42 {
 298                     .text:	section	.text,new
 299  0000               _Buttons_init:
 301  0000 88            	push	a
 302       00000001      OFST:	set	1
 305                     ; 44 	for(i=0;i<BTN_CNT;i++)
 307  0001 0f01          	clr	(OFST+0,sp)
 309  0003               L501:
 310                     ; 46 		GPIO_Init(BUTTON_port[i], BUTTON_pin[i], GPIO_MODE_IN_PU_NO_IT);
 312  0003 4b40          	push	#64
 313  0005 7b02          	ld	a,(OFST+1,sp)
 314  0007 5f            	clrw	x
 315  0008 97            	ld	xl,a
 316  0009 d60009        	ld	a,(_BUTTON_pin,x)
 317  000c 88            	push	a
 318  000d 7b03          	ld	a,(OFST+2,sp)
 319  000f 5f            	clrw	x
 320  0010 97            	ld	xl,a
 321  0011 58            	sllw	x
 322  0012 de0011        	ldw	x,(_BUTTON_port,x)
 323  0015 cd0000        	call	_GPIO_Init
 325  0018 85            	popw	x
 326                     ; 47 		g_buttons.holdtime[i] = BTN_TIME_TRESH+1;
 328  0019 7b01          	ld	a,(OFST+0,sp)
 329  001b 5f            	clrw	x
 330  001c 97            	ld	xl,a
 331  001d a604          	ld	a,#4
 332  001f e705          	ld	(_g_buttons+2,x),a
 333                     ; 44 	for(i=0;i<BTN_CNT;i++)
 335  0021 0c01          	inc	(OFST+0,sp)
 339  0023 7b01          	ld	a,(OFST+0,sp)
 340  0025 a108          	cp	a,#8
 341  0027 25da          	jrult	L501
 342                     ; 49 	g_buttons.state = 0;
 344  0029 3f04          	clr	_g_buttons+1
 345                     ; 50 	g_buttons.pressed = 0;
 347  002b 3f03          	clr	_g_buttons
 348                     ; 51 }
 351  002d 84            	pop	a
 352  002e 81            	ret	
 392                     ; 53 void Buttons_loop(void)
 392                     ; 54 {
 393                     .text:	section	.text,new
 394  0000               _Buttons_loop:
 396  0000 5203          	subw	sp,#3
 397       00000003      OFST:	set	3
 400                     ; 56 	for(i=0; i<BTN_CNT; i++)
 402  0002 4f            	clr	a
 403  0003 6b03          	ld	(OFST+0,sp),a
 405  0005               L131:
 406                     ; 58 		if (GPIO_ReadInputPin(BUTTON_port[i], BUTTON_pin[i]) == RESET) // button pressed
 408  0005 5f            	clrw	x
 409  0006 97            	ld	xl,a
 410  0007 d60009        	ld	a,(_BUTTON_pin,x)
 411  000a 88            	push	a
 412  000b 7b04          	ld	a,(OFST+1,sp)
 413  000d 5f            	clrw	x
 414  000e 97            	ld	xl,a
 415  000f 58            	sllw	x
 416  0010 de0011        	ldw	x,(_BUTTON_port,x)
 417  0013 cd0000        	call	_GPIO_ReadInputPin
 419  0016 5b01          	addw	sp,#1
 420  0018 4d            	tnz	a
 421  0019 2675          	jrne	L731
 422                     ; 60 			if (g_buttons.state & (1 << i)) // already pressed
 424  001b b604          	ld	a,_g_buttons+1
 425  001d 5f            	clrw	x
 426  001e 97            	ld	xl,a
 427  001f 1f01          	ldw	(OFST-2,sp),x
 429  0021 ae0001        	ldw	x,#1
 430  0024 7b03          	ld	a,(OFST+0,sp)
 431  0026 2704          	jreq	L23
 432  0028               L43:
 433  0028 58            	sllw	x
 434  0029 4a            	dec	a
 435  002a 26fc          	jrne	L43
 436  002c               L23:
 437  002c 01            	rrwa	x,a
 438  002d 1402          	and	a,(OFST-1,sp)
 439  002f 01            	rrwa	x,a
 440  0030 1401          	and	a,(OFST-2,sp)
 441  0032 01            	rrwa	x,a
 442  0033 5d            	tnzw	x
 443  0034 274b          	jreq	L141
 444                     ; 62 				if ((g_buttons.holdtime[i]) < BTN_TIME_TRESH) {
 446  0036 7b03          	ld	a,(OFST+0,sp)
 447  0038 5f            	clrw	x
 448  0039 97            	ld	xl,a
 449  003a e605          	ld	a,(_g_buttons+2,x)
 450  003c a103          	cp	a,#3
 451  003e 7b03          	ld	a,(OFST+0,sp)
 452  0040 5f            	clrw	x
 453  0041 97            	ld	xl,a
 454                     ; 63 					g_buttons.holdtime[i]++; // increment time
 456  0042 2575          	jrult	LC003
 457                     ; 65 				if ((g_buttons.holdtime[i]) == BTN_TIME_TRESH) { // timeout
 459  0044 e605          	ld	a,(_g_buttons+2,x)
 460  0046 a103          	cp	a,#3
 461  0048 2703cc010d    	jrne	L551
 462                     ; 66 					if ((g_buttons.pressed & (1 << i)) == 0)
 464  004d b603          	ld	a,_g_buttons
 465  004f 5f            	clrw	x
 466  0050 97            	ld	xl,a
 467  0051 1f01          	ldw	(OFST-2,sp),x
 469  0053 ae0001        	ldw	x,#1
 470  0056 7b03          	ld	a,(OFST+0,sp)
 471  0058 2704          	jreq	L63
 472  005a               L04:
 473  005a 58            	sllw	x
 474  005b 4a            	dec	a
 475  005c 26fc          	jrne	L04
 476  005e               L63:
 477  005e 01            	rrwa	x,a
 478  005f 1402          	and	a,(OFST-1,sp)
 479  0061 01            	rrwa	x,a
 480  0062 1401          	and	a,(OFST-2,sp)
 481  0064 01            	rrwa	x,a
 482  0065 5d            	tnzw	x
 483  0066 2703cc00f2    	jrne	L761
 484                     ; 68 						g_buttons.pressed |= (uint8_t)(1 << i);
 486  006b 7b03          	ld	a,(OFST+0,sp)
 487  006d cd011b        	call	LC005
 488  0070 2704          	jreq	L24
 489  0072               L44:
 490  0072 48            	sll	a
 491  0073 5a            	decw	x
 492  0074 26fc          	jrne	L44
 493  0076               L24:
 494  0076 ba03          	or	a,_g_buttons
 495  0078 b703          	ld	_g_buttons,a
 496                     ; 70 						EVENT_KEY_pressed(i);
 498  007a 7b03          	ld	a,(OFST+0,sp)
 499  007c cd0000        	call	_EVENT_KEY_pressed
 501                     ; 72 					g_buttons.holdtime[i]++; // increment time
 502  007f 2071          	jp	L761
 503  0081               L141:
 504                     ; 75 				g_buttons.state |= (uint8_t)(1 << i);
 506  0081 7b03          	ld	a,(OFST+0,sp)
 507  0083 cd011b        	call	LC005
 508  0086 2704          	jreq	L05
 509  0088               L25:
 510  0088 48            	sll	a
 511  0089 5a            	decw	x
 512  008a 26fc          	jrne	L25
 513  008c               L05:
 514  008c ba04          	or	a,_g_buttons+1
 515                     ; 76 				g_buttons.holdtime[i] = 0;
 516  008e 2075          	jp	LC002
 517  0090               L731:
 518                     ; 79 			if ((g_buttons.state & (1 << i))==0) // already released
 520  0090 b604          	ld	a,_g_buttons+1
 521  0092 5f            	clrw	x
 522  0093 97            	ld	xl,a
 523  0094 1f01          	ldw	(OFST-2,sp),x
 525  0096 ae0001        	ldw	x,#1
 526  0099 7b03          	ld	a,(OFST+0,sp)
 527  009b 2704          	jreq	L45
 528  009d               L65:
 529  009d 58            	sllw	x
 530  009e 4a            	dec	a
 531  009f 26fc          	jrne	L65
 532  00a1               L45:
 533  00a1 01            	rrwa	x,a
 534  00a2 1402          	and	a,(OFST-1,sp)
 535  00a4 01            	rrwa	x,a
 536  00a5 1401          	and	a,(OFST-2,sp)
 537  00a7 01            	rrwa	x,a
 538  00a8 5d            	tnzw	x
 539  00a9 264d          	jrne	L751
 540                     ; 81 				if ((g_buttons.holdtime[i]) < BTN_TIME_TRESH) {
 542  00ab 7b03          	ld	a,(OFST+0,sp)
 543  00ad 5f            	clrw	x
 544  00ae 97            	ld	xl,a
 545  00af e605          	ld	a,(_g_buttons+2,x)
 546  00b1 a103          	cp	a,#3
 547  00b3 7b03          	ld	a,(OFST+0,sp)
 548  00b5 5f            	clrw	x
 549  00b6 97            	ld	xl,a
 550  00b7 2404          	jruge	L161
 551                     ; 82 					g_buttons.holdtime[i]++; // increment time
 553  00b9               LC003:
 555  00b9 6c05          	inc	(_g_buttons+2,x)
 557  00bb 2050          	jra	L551
 558  00bd               L161:
 559                     ; 84 				if ((g_buttons.holdtime[i]) == BTN_TIME_TRESH) { // timeout
 561  00bd e605          	ld	a,(_g_buttons+2,x)
 562  00bf a103          	cp	a,#3
 563  00c1 264a          	jrne	L551
 564                     ; 85 					if (g_buttons.pressed & (1 << i)) {
 566  00c3 b603          	ld	a,_g_buttons
 567  00c5 5f            	clrw	x
 568  00c6 97            	ld	xl,a
 569  00c7 1f01          	ldw	(OFST-2,sp),x
 571  00c9 ae0001        	ldw	x,#1
 572  00cc 7b03          	ld	a,(OFST+0,sp)
 573  00ce 2704          	jreq	L06
 574  00d0               L26:
 575  00d0 58            	sllw	x
 576  00d1 4a            	dec	a
 577  00d2 26fc          	jrne	L26
 578  00d4               L06:
 579  00d4 01            	rrwa	x,a
 580  00d5 1402          	and	a,(OFST-1,sp)
 581  00d7 01            	rrwa	x,a
 582  00d8 1401          	and	a,(OFST-2,sp)
 583  00da 01            	rrwa	x,a
 584  00db 5d            	tnzw	x
 585  00dc 2714          	jreq	L761
 586                     ; 86 						g_buttons.pressed &= (uint8_t)~(1 << i);
 588  00de 7b03          	ld	a,(OFST+0,sp)
 589  00e0 ad39          	call	LC005
 590  00e2 2704          	jreq	L46
 591  00e4               L66:
 592  00e4 48            	sll	a
 593  00e5 5a            	decw	x
 594  00e6 26fc          	jrne	L66
 595  00e8               L46:
 596  00e8 43            	cpl	a
 597  00e9 b403          	and	a,_g_buttons
 598  00eb b703          	ld	_g_buttons,a
 599                     ; 88 						EVENT_KEY_released(i);
 601  00ed 7b03          	ld	a,(OFST+0,sp)
 602  00ef cd0000        	call	_EVENT_KEY_released
 604  00f2               L761:
 605                     ; 90 					g_buttons.holdtime[i]++; // increment time
 608  00f2 7b03          	ld	a,(OFST+0,sp)
 609  00f4 5f            	clrw	x
 610  00f5 97            	ld	xl,a
 611  00f6 20c1          	jp	LC003
 612  00f8               L751:
 613                     ; 93 				g_buttons.state &= (uint8_t)~(1 << i);
 615  00f8 7b03          	ld	a,(OFST+0,sp)
 616  00fa ad1f          	call	LC005
 617  00fc 2704          	jreq	L27
 618  00fe               L47:
 619  00fe 48            	sll	a
 620  00ff 5a            	decw	x
 621  0100 26fc          	jrne	L47
 622  0102               L27:
 623  0102 43            	cpl	a
 624  0103 b404          	and	a,_g_buttons+1
 625                     ; 94 				g_buttons.holdtime[i] = 0;
 627  0105               LC002:
 628  0105 b704          	ld	_g_buttons+1,a
 630  0107 5f            	clrw	x
 631  0108 7b03          	ld	a,(OFST+0,sp)
 632  010a 97            	ld	xl,a
 633  010b 6f05          	clr	(_g_buttons+2,x)
 634  010d               L551:
 635                     ; 56 	for(i=0; i<BTN_CNT; i++)
 637  010d 0c03          	inc	(OFST+0,sp)
 641  010f 7b03          	ld	a,(OFST+0,sp)
 642  0111 a108          	cp	a,#8
 643  0113 2403cc0005    	jrult	L131
 644                     ; 98 }
 647  0118 5b03          	addw	sp,#3
 648  011a 81            	ret	
 649  011b               LC005:
 650  011b 5f            	clrw	x
 651  011c 97            	ld	xl,a
 652  011d a601          	ld	a,#1
 653  011f 5d            	tnzw	x
 654  0120 81            	ret	
 905                     	xdef	_BUTTON_port
 906                     	xdef	_BUTTON_pin
 907                     	switch	.ubsct
 908  0000               _g_LEDS_mode:
 909  0000 000000        	ds.b	3
 910                     	xdef	_g_LEDS_mode
 911                     	xdef	_LED_port
 912                     	xdef	_LED_pin
 913                     	xref	_EVENT_KEY_released
 914                     	xref	_EVENT_KEY_pressed
 915                     	xdef	_Buttons_loop
 916                     	xdef	_Buttons_init
 917  0003               _g_buttons:
 918  0003 000000000000  	ds.b	10
 919                     	xdef	_g_buttons
 920                     	xdef	_Led_setmode
 921                     	xdef	_Leds_init
 922                     	xref	_GPIO_ReadInputPin
 923                     	xref	_GPIO_WriteLow
 924                     	xref	_GPIO_WriteHigh
 925                     	xref	_GPIO_Init
 945                     	end
