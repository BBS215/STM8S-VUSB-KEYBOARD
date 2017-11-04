   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  64                     ; 14 void USB_EP0_RxReady_callback(uint8_t *p_data)
  64                     ; 15 {
  66                     .text:	section	.text,new
  67  0000               _USB_EP0_RxReady_callback:
  69  0000 89            	pushw	x
  70       00000000      OFST:	set	0
  73                     ; 16 	if (p_data[0] == STD_KEYBOARD_REPORT_ID) {
  75  0001 f6            	ld	a,(x)
  76  0002 a129          	cp	a,#41
  77  0004 2635          	jrne	L72
  78                     ; 17 		if (p_data[1] & HID_KEYBOARD_LED_NUMLOCK) // Num Lock
  80  0006 e601          	ld	a,(1,x)
  81  0008 a501          	bcp	a,#1
  82  000a 2705          	jreq	L13
  83                     ; 18 															Led_setmode(LED_0, LED_ON); 
  85  000c ae0001        	ldw	x,#1
  88  000f 2001          	jra	L33
  89  0011               L13:
  90                     ; 19 		else											Led_setmode(LED_0, LED_OFF);
  92  0011 5f            	clrw	x
  94  0012               L33:
  95  0012 cd0000        	call	_Led_setmode
  96                     ; 20 		if (p_data[1] & HID_KEYBOARD_LED_CAPSLOCK) // Caps Lock
  98  0015 1e01          	ldw	x,(OFST+1,sp)
  99  0017 e601          	ld	a,(1,x)
 100  0019 a502          	bcp	a,#2
 101  001b 2705          	jreq	L53
 102                     ; 21 															Led_setmode(LED_1, LED_ON); 
 104  001d ae0101        	ldw	x,#257
 107  0020 2003          	jra	L73
 108  0022               L53:
 109                     ; 22 		else											Led_setmode(LED_1, LED_OFF);
 111  0022 ae0100        	ldw	x,#256
 113  0025               L73:
 114  0025 cd0000        	call	_Led_setmode
 115                     ; 23 		if (p_data[1] & HID_KEYBOARD_LED_SCROLLLOCK) // Scroll lock
 117  0028 1e01          	ldw	x,(OFST+1,sp)
 118  002a e601          	ld	a,(1,x)
 119  002c a504          	bcp	a,#4
 120  002e 2705          	jreq	L14
 121                     ; 24 															Led_setmode(LED_2, LED_ON); 
 123  0030 ae0201        	ldw	x,#513
 126  0033 2003          	jp	LC001
 127  0035               L14:
 128                     ; 25 		else											Led_setmode(LED_2, LED_OFF);
 130  0035 ae0200        	ldw	x,#512
 131  0038               LC001:
 132  0038 cd0000        	call	_Led_setmode
 134  003b               L72:
 135                     ; 27 }
 138  003b 85            	popw	x
 139  003c 81            	ret	
 174                     ; 29 void KEY_changed(uint8_t key_num)
 174                     ; 30 {
 175                     .text:	section	.text,new
 176  0000               _KEY_changed:
 180                     ; 31 	switch(key_num) {
 183                     ; 46 		default:
 183                     ; 47 			break;
 184  0000 4d            	tnz	a
 185  0001 2715          	jreq	L54
 186  0003 4a            	dec	a
 187  0004 2712          	jreq	L54
 188  0006 4a            	dec	a
 189  0007 270f          	jreq	L54
 190  0009 4a            	dec	a
 191  000a 270c          	jreq	L54
 192  000c 4a            	dec	a
 193  000d 2709          	jreq	L54
 194  000f 4a            	dec	a
 195  0010 2706          	jreq	L54
 196  0012 4a            	dec	a
 197  0013 2703          	jreq	L54
 198  0015 4a            	dec	a
 199  0016 2604          	jrne	L17
 200  0018               L54:
 201                     ; 32 		case BTN_0: // used in STD keyboard
 201                     ; 33 		case BTN_1: // used in STD keyboard
 201                     ; 34 		case BTN_2: // used in STD keyboard
 201                     ; 35 		case BTN_3: // used in STD keyboard
 201                     ; 36 		case BTN_4: // used in STD keyboard
 201                     ; 37 		case BTN_5: // used in STD keyboard
 201                     ; 38 		case BTN_6: // used in STD keyboard
 201                     ; 39 		case BTN_7: // used in STD keyboard
 201                     ; 40 			HID_Dev.STD_KB_Report_changed_flag = 1; // STD keyboard
 203  0018 3501000b      	mov	_HID_Dev+11,#1
 204                     ; 41 			break;
 206                     ; 46 		default:
 206                     ; 47 			break;
 208  001c               L17:
 209                     ; 49 }
 212  001c 81            	ret	
 247                     ; 51 void EVENT_KEY_pressed(uint8_t key_num) { KEY_changed(key_num); }
 248                     .text:	section	.text,new
 249  0000               _EVENT_KEY_pressed:
 259  0000 cc0000        	jp	_KEY_changed
 294                     ; 52 void EVENT_KEY_released(uint8_t key_num) { KEY_changed(key_num); }
 295                     .text:	section	.text,new
 296  0000               _EVENT_KEY_released:
 306  0000 cc0000        	jp	_KEY_changed
 362                     ; 54 void BTN_USB_send_Loop(void)
 362                     ; 55 {
 363                     .text:	section	.text,new
 364  0000               _BTN_USB_send_Loop:
 366  0000 5203          	subw	sp,#3
 367       00000003      OFST:	set	3
 370                     ; 45 @inline uint8_t Buttons_get_mask(void) { return g_buttons.pressed; }
 373  0002 b600          	ld	a,_g_buttons
 374  0004 6b01          	ld	(OFST-2,sp),a
 378                     ; 58 	uint8_t UsedKeyCodes = 0;
 380  0006 0f03          	clr	(OFST+0,sp)
 382                     ; 61 	if (HID_Dev.STD_KB_Report_changed_flag) {
 384  0008 b60b          	ld	a,_HID_Dev+11
 385  000a 2603cc00ad    	jreq	L561
 386                     ; 62 		KeyCodesMAX = 5;
 388  000f a605          	ld	a,#5
 389  0011 6b02          	ld	(OFST-1,sp),a
 391                     ; 63 		HID_Dev.STD_KB_Report.Modifier = 0;
 393  0013 3f04          	clr	_HID_Dev+4
 394                     ; 64 		if (key_mask & (1 << BTN_0))
 396  0015 7b01          	ld	a,(OFST-2,sp)
 397  0017 a501          	bcp	a,#1
 398  0019 2704          	jreq	L761
 399                     ; 65 			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTGUI;
 401  001b 72160004      	bset	_HID_Dev+4,#3
 402  001f               L761:
 403                     ; 66 		if (key_mask & (1 << BTN_1))
 405  001f a502          	bcp	a,#2
 406  0021 2704          	jreq	L171
 407                     ; 67 			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTCTRL;
 409  0023 72100004      	bset	_HID_Dev+4,#0
 410  0027               L171:
 411                     ; 68 		if (key_mask & (1 << BTN_6))
 413  0027 a540          	bcp	a,#64
 414  0029 2704          	jreq	L371
 415                     ; 69 			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTSHIFT;
 417  002b 72120004      	bset	_HID_Dev+4,#1
 418  002f               L371:
 419                     ; 70 		if (key_mask & (1 << BTN_7))
 421  002f a580          	bcp	a,#128
 422  0031 2704          	jreq	L571
 423                     ; 71 			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTALT;
 425  0033 72140004      	bset	_HID_Dev+4,#2
 426  0037               L571:
 427                     ; 73 		if (key_mask & (1 << BTN_2)) {
 429  0037 a504          	bcp	a,#4
 430  0039 2710          	jreq	L771
 431                     ; 74 			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_1_AND_EXCLAMATION;
 433  003b 7b03          	ld	a,(OFST+0,sp)
 434  003d 0c03          	inc	(OFST+0,sp)
 436  003f 5f            	clrw	x
 437  0040 97            	ld	xl,a
 438  0041 a61e          	ld	a,#30
 439  0043 e706          	ld	(_HID_Dev+6,x),a
 440                     ; 75 			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send;
 442  0045 7b03          	ld	a,(OFST+0,sp)
 443  0047 1102          	cp	a,(OFST-1,sp)
 444  0049 2450          	jruge	L721
 447  004b               L771:
 448                     ; 77 		if (key_mask & (1 << BTN_3)) {
 450  004b 7b01          	ld	a,(OFST-2,sp)
 451  004d a508          	bcp	a,#8
 452  004f 2712          	jreq	L302
 453                     ; 78 			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_2_AND_AT;
 455  0051 7b03          	ld	a,(OFST+0,sp)
 456  0053 0c03          	inc	(OFST+0,sp)
 458  0055 5f            	clrw	x
 459  0056 97            	ld	xl,a
 460  0057 a61f          	ld	a,#31
 461  0059 e706          	ld	(_HID_Dev+6,x),a
 462                     ; 79 			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send;
 464  005b 7b03          	ld	a,(OFST+0,sp)
 465  005d 1102          	cp	a,(OFST-1,sp)
 466  005f 243a          	jruge	L721
 469  0061 7b01          	ld	a,(OFST-2,sp)
 470  0063               L302:
 471                     ; 81 		if (key_mask & (1 << BTN_4)) {
 473  0063 a510          	bcp	a,#16
 474  0065 2712          	jreq	L702
 475                     ; 82 			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_3_AND_HASHMARK;
 477  0067 7b03          	ld	a,(OFST+0,sp)
 478  0069 0c03          	inc	(OFST+0,sp)
 480  006b 5f            	clrw	x
 481  006c 97            	ld	xl,a
 482  006d a620          	ld	a,#32
 483  006f e706          	ld	(_HID_Dev+6,x),a
 484                     ; 83 			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send;
 486  0071 7b03          	ld	a,(OFST+0,sp)
 487  0073 1102          	cp	a,(OFST-1,sp)
 488  0075 2424          	jruge	L721
 491  0077 7b01          	ld	a,(OFST-2,sp)
 492  0079               L702:
 493                     ; 85 		if (key_mask & (1 << BTN_5)) {
 495  0079 a520          	bcp	a,#32
 496  007b 2718          	jreq	L122
 497                     ; 86 			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_4_AND_DOLLAR;
 499  007d 7b03          	ld	a,(OFST+0,sp)
 500  007f 0c03          	inc	(OFST+0,sp)
 502  0081 5f            	clrw	x
 503  0082 97            	ld	xl,a
 504  0083 a621          	ld	a,#33
 505  0085 e706          	ld	(_HID_Dev+6,x),a
 506                     ; 87 			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send;
 508  0087 7b03          	ld	a,(OFST+0,sp)
 509  0089 1102          	cp	a,(OFST-1,sp)
 510  008b 2508          	jrult	L122
 513  008d 200c          	jra	L721
 514  008f               L712:
 515                     ; 89 		while(UsedKeyCodes < KeyCodesMAX) HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = 0;
 517  008f 0c03          	inc	(OFST+0,sp)
 519  0091 5f            	clrw	x
 520  0092 97            	ld	xl,a
 521  0093 6f06          	clr	(_HID_Dev+6,x)
 522  0095               L122:
 525  0095 7b03          	ld	a,(OFST+0,sp)
 526  0097 1102          	cp	a,(OFST-1,sp)
 527  0099 25f4          	jrult	L712
 528  009b               L721:
 529                     ; 90 	STD_Send:
 529                     ; 91 		if (USB_Send_Data((uint8_t*)&HID_Dev.STD_KB_Report, sizeof(HID_Dev.STD_KB_Report), 1) == 0)
 531  009b 4b01          	push	#1
 532  009d 4b08          	push	#8
 533  009f ae0003        	ldw	x,#_HID_Dev+3
 534  00a2 cd0000        	call	_USB_Send_Data
 536  00a5 4d            	tnz	a
 537  00a6 85            	popw	x
 538  00a7 261c          	jrne	L132
 539                     ; 92 			HID_Dev.STD_KB_Report_changed_flag = 0;
 541  00a9 3f0b          	clr	_HID_Dev+11
 542                     ; 93 		return;
 544  00ab 2018          	jra	L132
 545  00ad               L561:
 546                     ; 97 	if (HID_Dev.EXT1_KB_Report_changed_flag) {
 548  00ad 3d0f          	tnz	_HID_Dev+15
 549  00af 2717          	jreq	L722
 550                     ; 108 		HID_Dev.EXT1_KB_Report.KeyCode_LO = 0;
 552  00b1 b70d          	ld	_HID_Dev+13,a
 553                     ; 109 		HID_Dev.EXT1_KB_Report.KeyCode_HI = 0;
 555  00b3 b70e          	ld	_HID_Dev+14,a
 556                     ; 110 	EXT1_Send:
 556                     ; 111 		if (USB_Send_Data((uint8_t*)&HID_Dev.EXT1_KB_Report, sizeof(HID_Dev.EXT1_KB_Report), 1) == 0)
 558  00b5 4b01          	push	#1
 559  00b7 4b03          	push	#3
 560  00b9 ae000c        	ldw	x,#_HID_Dev+12
 561  00bc cd0000        	call	_USB_Send_Data
 563  00bf 4d            	tnz	a
 564  00c0 85            	popw	x
 565  00c1 2602          	jrne	L132
 566                     ; 112 			HID_Dev.EXT1_KB_Report_changed_flag = 0;
 568  00c3 3f0f          	clr	_HID_Dev+15
 569  00c5               L132:
 570                     ; 113 		return;
 573  00c5 5b03          	addw	sp,#3
 574  00c7 81            	ret	
 575  00c8               L722:
 576                     ; 117 	if (HID_Dev.EXT2_KB_Report_changed_flag) {
 578  00c8 b618          	ld	a,_HID_Dev+24
 579  00ca 27f9          	jreq	L132
 580                     ; 118 		KeyCodesMAX = 7;
 582  00cc a607          	ld	a,#7
 583  00ce 6b02          	ld	(OFST-1,sp),a
 586  00d0 2006          	jra	L142
 587  00d2               L532:
 588                     ; 127 		while(UsedKeyCodes < KeyCodesMAX) HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = 0;
 590  00d2 0c03          	inc	(OFST+0,sp)
 592  00d4 5f            	clrw	x
 593  00d5 97            	ld	xl,a
 594  00d6 6f11          	clr	(_HID_Dev+17,x)
 595  00d8               L142:
 598  00d8 7b03          	ld	a,(OFST+0,sp)
 599  00da 1102          	cp	a,(OFST-1,sp)
 600  00dc 25f4          	jrult	L532
 601                     ; 128 	EXT2_Send:
 601                     ; 129 		if (USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 1) == 0)
 603  00de 4b01          	push	#1
 604  00e0 4b08          	push	#8
 605  00e2 ae0010        	ldw	x,#_HID_Dev+16
 606  00e5 cd0000        	call	_USB_Send_Data
 608  00e8 4d            	tnz	a
 609  00e9 85            	popw	x
 610  00ea 26d9          	jrne	L132
 611                     ; 130 			HID_Dev.EXT2_KB_Report_changed_flag = 0;
 613  00ec 3f18          	clr	_HID_Dev+24
 614                     ; 131 		return;
 616  00ee 20d5          	jra	L132
 617                     ; 45 			//break;
 663                     ; 135 int8_t USB_Class_Init_callback(uint8_t dev_config)
 663                     ; 136 {
 664                     .text:	section	.text,new
 665  0000               _USB_Class_Init_callback:
 667  0000 88            	push	a
 668       00000001      OFST:	set	1
 671                     ; 138 	for(i=0;i<sizeof(HID_Dev);i++) ((uint8_t*)&HID_Dev)[i] = 0;
 673  0001 4f            	clr	a
 674  0002 6b01          	ld	(OFST+0,sp),a
 676  0004               L172:
 679  0004 5f            	clrw	x
 680  0005 97            	ld	xl,a
 681  0006 6f00          	clr	(_HID_Dev,x)
 684  0008 0c01          	inc	(OFST+0,sp)
 688  000a 7b01          	ld	a,(OFST+0,sp)
 689  000c a119          	cp	a,#25
 690  000e 25f4          	jrult	L172
 691                     ; 139 	HID_Dev.STD_KB_Report.ReportID = STD_KEYBOARD_REPORT_ID;
 693  0010 35290003      	mov	_HID_Dev+3,#41
 694                     ; 140 	HID_Dev.EXT1_KB_Report.ReportID = EXT1_KEYBOARD_REPORT_ID;
 696  0014 352a000c      	mov	_HID_Dev+12,#42
 697                     ; 141 	HID_Dev.EXT2_KB_Report.ReportID = EXT2_KEYBOARD_REPORT_ID;
 699  0018 352b0010      	mov	_HID_Dev+16,#43
 700                     ; 142 	HID_Dev.STD_KB_Report_changed_flag = 1;
 702  001c 3501000b      	mov	_HID_Dev+11,#1
 703                     ; 143 	HID_Dev.EXT1_KB_Report_changed_flag = 1;
 705  0020 3501000f      	mov	_HID_Dev+15,#1
 706                     ; 144 	HID_Dev.EXT2_KB_Report_changed_flag = 1;
 708  0024 35010018      	mov	_HID_Dev+24,#1
 709                     ; 145 	return 0;
 711  0028 4f            	clr	a
 714  0029 5b01          	addw	sp,#1
 715  002b 81            	ret	
 739                     ; 148 int8_t USB_Class_DeInit_callback(void)
 739                     ; 149 {
 740                     .text:	section	.text,new
 741  0000               _USB_Class_DeInit_callback:
 745                     ; 150 	return 0;
 747  0000 4f            	clr	a
 750  0001 81            	ret	
 855                     ; 153 int8_t USB_Setup_Request_callback(t_USB_SetupReq *p_req)
 855                     ; 154 {
 856                     .text:	section	.text,new
 857  0000               _USB_Setup_Request_callback:
 859  0000 89            	pushw	x
 860       00000000      OFST:	set	0
 863                     ; 155 	switch (p_req->bmRequest & USB_REQ_TYPE_MASK)
 865  0001 f6            	ld	a,(x)
 866  0002 a460          	and	a,#96
 868                     ; 246 					break;
 869  0004 2603cc00a2    	jreq	L333
 870  0009 a020          	sub	a,#32
 871  000b 2703cc00ff    	jrne	L114
 872                     ; 159 			switch (p_req->bRequest)
 874  0010 e601          	ld	a,(1,x)
 876                     ; 207 				case HID_REQ_GET_IDLE: // 0x02
 876                     ; 208 					return USB_Send_Data(&HID_Dev.IdleState, 1, 0);
 877  0012 4a            	dec	a
 878  0013 2716          	jreq	L113
 879  0015 4a            	dec	a
 880  0016 2603cc0099    	jreq	L133
 881  001b 4a            	dec	a
 882  001c 2767          	jreq	L523
 883  001e a006          	sub	a,#6
 884  0020 2741          	jreq	L123
 885  0022 4a            	dec	a
 886  0023 2769          	jreq	L723
 887  0025 4a            	dec	a
 888  0026 2752          	jreq	L323
 889  0028 cc00ff        	jra	L114
 890  002b               L113:
 891                     ; 163 					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) // HID Device
 893  002b e604          	ld	a,(4,x)
 894  002d 26f9          	jrne	L114
 895                     ; 165 						if (p_req->wValue_HI == HID_REPORT_FEATURE)
 897  002f e603          	ld	a,(3,x)
 898  0031 a103          	cp	a,#3
 899  0033 26f3          	jrne	L114
 900                     ; 167 							switch(p_req->wValue_LO) // ReportID
 902  0035 e602          	ld	a,(2,x)
 904                     ; 173 								case EXT2_KEYBOARD_REPORT_ID: // EXT2 Keyboard
 904                     ; 174 									return USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 0);
 905  0037 a029          	sub	a,#41
 906  0039 2709          	jreq	L313
 907  003b 4a            	dec	a
 908  003c 270f          	jreq	L513
 909  003e 4a            	dec	a
 910  003f 2719          	jreq	L713
 911  0041 cc00ff        	jra	L114
 912  0044               L313:
 913                     ; 169 								case STD_KEYBOARD_REPORT_ID: // STD Keyboard
 913                     ; 170 									return USB_Send_Data((uint8_t*)&HID_Dev.STD_KB_Report, sizeof(HID_Dev.STD_KB_Report), 0);
 915  0044 4b00          	push	#0
 916  0046 4b08          	push	#8
 917  0048 ae0003        	ldw	x,#_HID_Dev+3
 920  004b 2007          	jra	L611
 921  004d               L513:
 922                     ; 171 								case EXT1_KEYBOARD_REPORT_ID: // EXT1 Keyboard
 922                     ; 172 									return USB_Send_Data((uint8_t*)&HID_Dev.EXT1_KB_Report, sizeof(HID_Dev.EXT1_KB_Report), 0);
 924  004d 4b00          	push	#0
 925  004f 4b03          	push	#3
 926  0051 ae000c        	ldw	x,#_HID_Dev+12
 929  0054               L611:
 930  0054 cd0000        	call	_USB_Send_Data
 932  0057 5b04          	addw	sp,#4
 933  0059 81            	ret	
 934  005a               L713:
 935                     ; 173 								case EXT2_KEYBOARD_REPORT_ID: // EXT2 Keyboard
 935                     ; 174 									return USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 0);
 937  005a 4b00          	push	#0
 938  005c 4b08          	push	#8
 939  005e ae0010        	ldw	x,#_HID_Dev+16
 942  0061 20f1          	jra	L611
 943  0063               L123:
 944                     ; 183 					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) // HID Device
 946  0063 e604          	ld	a,(4,x)
 947  0065 26da          	jrne	L114
 948                     ; 185 						if (p_req->wValue_HI == HID_REPORT_OUTPUT)
 950  0067 e603          	ld	a,(3,x)
 951  0069 a102          	cp	a,#2
 952  006b 26d4          	jrne	L114
 953                     ; 187 							if (p_req->wValue_LO == STD_KEYBOARD_REPORT_ID) // ReportID
 955  006d e602          	ld	a,(2,x)
 956  006f a129          	cp	a,#41
 957  0071 26ce          	jrne	L114
 958                     ; 189 								return USB_Send_Data(NULL, 0, 0);
 960  0073 4b00          	push	#0
 961  0075 4b00          	push	#0
 962  0077 5f            	clrw	x
 965  0078 20da          	jra	L611
 966  007a               L323:
 967                     ; 196 				case HID_REQ_SET_PROTOCOL: // 0x0B
 967                     ; 197 					HID_Dev.Protocol = p_req->wValue_LO;
 969  007a e602          	ld	a,(2,x)
 970  007c b700          	ld	_HID_Dev,a
 971                     ; 198 					return USB_Send_Data(NULL, 0, 0);
 973  007e 4b00          	push	#0
 974  0080 4b00          	push	#0
 975  0082 5f            	clrw	x
 978  0083 20cf          	jra	L611
 979  0085               L523:
 980                     ; 200 				case HID_REQ_GET_PROTOCOL: // 0x03
 980                     ; 201 					return USB_Send_Data(&HID_Dev.Protocol, 1, 0);
 982  0085 4b00          	push	#0
 983  0087 4b01          	push	#1
 984  0089 ae0000        	ldw	x,#_HID_Dev
 987  008c 20c6          	jra	L611
 988  008e               L723:
 989                     ; 203 				case HID_REQ_SET_IDLE: // 0x0A
 989                     ; 204 					HID_Dev.IdleState = p_req->wValue_HI;
 991  008e e603          	ld	a,(3,x)
 992  0090 b701          	ld	_HID_Dev+1,a
 993                     ; 205 					return USB_Send_Data(NULL, 0, 0);
 995  0092 4b00          	push	#0
 996  0094 4b00          	push	#0
 997  0096 5f            	clrw	x
1000  0097 20bb          	jra	L611
1001  0099               L133:
1002                     ; 207 				case HID_REQ_GET_IDLE: // 0x02
1002                     ; 208 					return USB_Send_Data(&HID_Dev.IdleState, 1, 0);
1004  0099 4b00          	push	#0
1005  009b 4b01          	push	#1
1006  009d ae0001        	ldw	x,#_HID_Dev+1
1009  00a0 20b2          	jra	L611
1010                     ; 210 			break;
1012  00a2               L333:
1013                     ; 215 			switch (p_req->bRequest)
1015  00a2 e601          	ld	a,(1,x)
1017                     ; 246 					break;
1018  00a4 a006          	sub	a,#6
1019  00a6 2709          	jreq	L533
1020  00a8 a004          	sub	a,#4
1021  00aa 2737          	jreq	L733
1022  00ac 4a            	dec	a
1023  00ad 2741          	jreq	L143
1024  00af 204e          	jra	L114
1025  00b1               L533:
1026                     ; 219 					if (p_req->wValue_HI == TYPE_REPORT_DESCRIPTOR) // 0x22
1028  00b1 e603          	ld	a,(3,x)
1029  00b3 a122          	cp	a,#34
1030  00b5 2614          	jrne	L144
1031                     ; 221 						if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
1033  00b7 e604          	ld	a,(4,x)
1034  00b9 2644          	jrne	L114
1035                     ; 222 							return USB_Send_Data(usb_report_descriptor, (uint8_t)MIN(p_req->wLength_LO, SIZE_REPORT_DESCRIPTOR), 0);
1037  00bb 4b00          	push	#0
1038  00bd e606          	ld	a,(6,x)
1039  00bf a176          	cp	a,#118
1040  00c1 2502          	jrult	L001
1041  00c3 a675          	ld	a,#117
1042  00c5               L001:
1043  00c5 88            	push	a
1044  00c6 ae0000        	ldw	x,#_usb_report_descriptor
1047  00c9 2012          	jp	LC002
1048  00cb               L144:
1049                     ; 225 					if (p_req->wValue_HI == TYPE_HID_DESCRIPTOR) // 0x21
1051  00cb a121          	cp	a,#33
1052  00cd 2630          	jrne	L114
1053                     ; 227 						return USB_Send_Data(USB_HID_descriptor, (uint8_t)MIN(p_req->wLength_LO, SIZE_HID_DESCRIPTOR), 0);
1055  00cf 4b00          	push	#0
1056  00d1 e606          	ld	a,(6,x)
1057  00d3 a10a          	cp	a,#10
1058  00d5 2502          	jrult	L601
1059  00d7 a609          	ld	a,#9
1060  00d9               L601:
1061  00d9 88            	push	a
1062  00da ae0000        	ldw	x,#_USB_HID_descriptor
1064  00dd               LC002:
1065  00dd cd0000        	call	_USB_Send_Data
1066  00e0 85            	popw	x
1068  00e1               L021:
1070  00e1 85            	popw	x
1071  00e2 81            	ret	
1072  00e3               L733:
1073                     ; 234 					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
1075  00e3 e604          	ld	a,(4,x)
1076  00e5 2618          	jrne	L114
1077                     ; 235 						return USB_Send_Data(&HID_Dev.AltSetting, 1, 0);
1079  00e7 4b00          	push	#0
1080  00e9 4b01          	push	#1
1081  00eb ae0002        	ldw	x,#_HID_Dev+2
1084  00ee 20ed          	jp	LC002
1085  00f0               L143:
1086                     ; 242 					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
1088  00f0 e604          	ld	a,(4,x)
1089  00f2 260b          	jrne	L114
1090                     ; 243 						HID_Dev.AltSetting = p_req->wValue_LO;
1092  00f4 e602          	ld	a,(2,x)
1093  00f6 b702          	ld	_HID_Dev+2,a
1094                     ; 244 						return USB_Send_Data(NULL, 0, 0);
1096  00f8 4b00          	push	#0
1097  00fa 4b00          	push	#0
1098  00fc 5f            	clrw	x
1101  00fd 20de          	jp	LC002
1102  00ff               L114:
1103                     ; 251 	return -1;
1105  00ff a6ff          	ld	a,#255
1107  0101 20de          	jra	L021
1143                     ; 254 void USB_EP1_RxReady_callback(uint8_t *p_data)
1143                     ; 255 {
1144                     .text:	section	.text,new
1145  0000               _USB_EP1_RxReady_callback:
1149                     ; 257 }
1152  0000 81            	ret	
1189                     ; 261 void main(void)
1189                     ; 262 {
1190                     .text:	section	.text,new
1191  0000               _main:
1195                     ; 263 	disableInterrupts();
1198  0000 9b            	sim	
1200                     ; 264 	Init_Clock();
1203  0001 cd0000        	call	_Init_Clock
1205                     ; 265 	Init_GPIO();
1207  0004 cd0000        	call	_Init_GPIO
1209                     ; 266 	Leds_init();
1211  0007 cd0000        	call	_Leds_init
1213                     ; 267 	Buttons_init();
1215  000a cd0000        	call	_Buttons_init
1217                     ; 268 	SYSTimer_Init();
1219  000d cd0000        	call	_SYSTimer_Init
1221                     ; 269 	USB_Init();
1223  0010 cd0000        	call	_USB_Init
1225                     ; 270 	enableInterrupts();
1228  0013 9a            	rim	
1230                     ; 271 	USB_connect();
1233  0014 cd0000        	call	_USB_connect
1235  0017               L305:
1236                     ; 275 		USB_loop();
1238  0017 cd0000        	call	_USB_loop
1240                     ; 276 		if (g_systimer_flag) { // 100 Hz call
1242  001a 3d19          	tnz	_g_systimer_flag
1243  001c 27f9          	jreq	L305
1244                     ; 277 			g_systimer_flag = 0;
1246  001e 3f19          	clr	_g_systimer_flag
1247                     ; 278 			Buttons_loop();
1249  0020 cd0000        	call	_Buttons_loop
1251                     ; 279 			BTN_USB_send_Loop();
1253  0023 cd0000        	call	_BTN_USB_send_Loop
1255                     ; 280 			USB_slow_loop();
1257  0026 cd0000        	call	_USB_slow_loop
1259  0029 20ec          	jra	L305
1465                     	xdef	_main
1466                     	xdef	_BTN_USB_send_Loop
1467                     	xdef	_KEY_changed
1468                     	switch	.ubsct
1469  0000               _HID_Dev:
1470  0000 000000000000  	ds.b	25
1471                     	xdef	_HID_Dev
1472  0019               _g_systimer_flag:
1473  0019 00            	ds.b	1
1474                     	xdef	_g_systimer_flag
1475                     	xdef	_EVENT_KEY_released
1476                     	xdef	_EVENT_KEY_pressed
1477                     	xref	_Buttons_loop
1478                     	xref	_Buttons_init
1479                     	xref.b	_g_buttons
1480                     	xref	_Led_setmode
1481                     	xref	_Leds_init
1482                     	xref	_SYSTimer_Init
1483                     	xref	_Init_Clock
1484                     	xref	_Init_GPIO
1485                     	xdef	_USB_Class_DeInit_callback
1486                     	xdef	_USB_Class_Init_callback
1487                     	xdef	_USB_Setup_Request_callback
1488                     	xdef	_USB_EP1_RxReady_callback
1489                     	xdef	_USB_EP0_RxReady_callback
1490                     	xref	_USB_Send_Data
1491                     	xref	_USB_slow_loop
1492                     	xref	_USB_connect
1493                     	xref	_USB_loop
1494                     	xref	_USB_Init
1495                     	xref	_USB_HID_descriptor
1496                     	xref	_usb_report_descriptor
1516                     	end
