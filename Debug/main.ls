   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  21                     	bsct
  22  0000               _g_KeyCode:
  23  0000 4002          	dc.w	16386
  58                     ; 18 void Write_key_settings(void)
  58                     ; 19 {
  60                     .text:	section	.text,new
  61  0000               _Write_key_settings:
  65                     ; 20 	if (HID_Dev.Key_settings_to_write.write_flag) { // если флаг выставлен
  67  0000 b61f          	ld	a,_HID_Dev+31
  68  0002 2734          	jreq	L12
  69                     ; 21 		if (HID_Dev.Key_settings_to_write.key_num < BTN_CNT) { // и номер правильный
  71  0004 b620          	ld	a,_HID_Dev+32
  72  0006 a110          	cp	a,#16
  73  0008 242c          	jruge	L32
  74                     ; 22 			FLASH_Unlock(FLASH_MEMTYPE_DATA); // пишем в EEPROM
  76  000a a6f7          	ld	a,#247
  77  000c cd0000        	call	_FLASH_Unlock
  79                     ; 23 			g_KeyCode[HID_Dev.Key_settings_to_write.key_num].UsagePage = HID_Dev.Key_settings_to_write.KeyCode.UsagePage;
  81  000f b620          	ld	a,_HID_Dev+32
  82  0011 97            	ld	xl,a
  83  0012 a604          	ld	a,#4
  84  0014 42            	mul	x,a
  85  0015 b621          	ld	a,_HID_Dev+33
  86  0017 92d700        	ld	([_g_KeyCode.w],x),a
  87                     ; 24 			FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
  89  001a ad1d          	call	LC001
  90  001c b622          	ld	a,_HID_Dev+34
  91  001e e701          	ld	(1,x),a
  92                     ; 26 			FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
  94  0020 ad17          	call	LC001
  95  0022 b623          	ld	a,_HID_Dev+35
  96  0024 e702          	ld	(2,x),a
  97                     ; 28 			FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
  99  0026 ad11          	call	LC001
 100  0028 b624          	ld	a,_HID_Dev+36
 101  002a e703          	ld	(3,x),a
 102                     ; 30 			FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
 104  002c a6f7          	ld	a,#247
 105  002e cd0000        	call	_FLASH_WaitForLastOperation
 107                     ; 31 			FLASH_Lock(FLASH_MEMTYPE_DATA);
 109  0031 a6f7          	ld	a,#247
 110  0033 cd0000        	call	_FLASH_Lock
 112  0036               L32:
 113                     ; 33 		HID_Dev.Key_settings_to_write.write_flag = 0; // сброс флага
 115  0036 3f1f          	clr	_HID_Dev+31
 116  0038               L12:
 117                     ; 35 }
 120  0038 81            	ret	
 121  0039               LC001:
 122  0039 a6f7          	ld	a,#247
 123  003b cd0000        	call	_FLASH_WaitForLastOperation
 125                     ; 29 			g_KeyCode[HID_Dev.Key_settings_to_write.key_num].KeyCode_HI = HID_Dev.Key_settings_to_write.KeyCode.KeyCode_HI;
 127  003e b620          	ld	a,_HID_Dev+32
 128  0040 97            	ld	xl,a
 129  0041 a604          	ld	a,#4
 130  0043 42            	mul	x,a
 131  0044 72bb0000      	addw	x,_g_KeyCode
 132  0048 81            	ret	
 180                     ; 48 void USB_EP0_RxReady_callback(uint8_t *p_data, uint8_t length)
 180                     ; 49 {
 181                     .text:	section	.text,new
 182  0000               _USB_EP0_RxReady_callback:
 184  0000 89            	pushw	x
 185       00000000      OFST:	set	0
 188                     ; 50 	if (length == 0) return;
 190  0001 7b05          	ld	a,(OFST+5,sp)
 191  0003 2602          	jrne	L55
 195  0005 85            	popw	x
 196  0006 81            	ret	
 197  0007               L55:
 198                     ; 51 	switch(p_data[0]) // ReportID
 200  0007 f6            	ld	a,(x)
 202                     ; 84 			break;
 203  0008 a003          	sub	a,#3
 204  000a 274a          	jreq	L72
 205  000c 4a            	dec	a
 206  000d 276f          	jreq	L13
 207  000f a025          	sub	a,#37
 208  0011 2703cc00a0    	jrne	L16
 209                     ; 53 		case STD_KEYBOARD_REPORT_ID: // установка состояний светодиодов
 209                     ; 54 			if (length < 2) break;
 211  0016 7b05          	ld	a,(OFST+5,sp)
 212  0018 a102          	cp	a,#2
 213  001a 25f7          	jrult	L16
 216                     ; 55 			if (p_data[1] & HID_KEYBOARD_LED_NUMLOCK) // если бит Num Lock выставлен
 218  001c e601          	ld	a,(1,x)
 219  001e a501          	bcp	a,#1
 220  0020 2705          	jreq	L56
 221                     ; 56 																Led_setmode(LED_0, LED_ON); // зажигаем светодиод LED_0
 223  0022 ae0001        	ldw	x,#1
 226  0025 2001          	jra	L76
 227  0027               L56:
 228                     ; 57 			else											Led_setmode(LED_0, LED_OFF); // иначе гасим
 230  0027 5f            	clrw	x
 232  0028               L76:
 233  0028 cd0000        	call	_Led_setmode
 234                     ; 58 			if (p_data[1] & HID_KEYBOARD_LED_CAPSLOCK) // если бит Caps Lock выставлен
 236  002b 1e01          	ldw	x,(OFST+1,sp)
 237  002d e601          	ld	a,(1,x)
 238  002f a502          	bcp	a,#2
 239  0031 2705          	jreq	L17
 240                     ; 59 																Led_setmode(LED_1, LED_ON); // зажигаем светодиод LED_1
 242  0033 ae0101        	ldw	x,#257
 245  0036 2003          	jra	L37
 246  0038               L17:
 247                     ; 60 			else											Led_setmode(LED_1, LED_OFF); // иначе гасим
 249  0038 ae0100        	ldw	x,#256
 251  003b               L37:
 252  003b cd0000        	call	_Led_setmode
 253                     ; 61 			if (p_data[1] & HID_KEYBOARD_LED_SCROLLLOCK) // если бит Scroll lock выставлен
 255  003e 1e01          	ldw	x,(OFST+1,sp)
 256  0040 e601          	ld	a,(1,x)
 257  0042 a504          	bcp	a,#4
 258  0044 2708          	jreq	L57
 259                     ; 62 																Led_setmode(LED_2, LED_ON); // зажигаем светодиод LED_2
 261  0046 ae0201        	ldw	x,#513
 262  0049 cd0000        	call	_Led_setmode
 265  004c 2052          	jra	L16
 266  004e               L57:
 267                     ; 63 			else											Led_setmode(LED_2, LED_OFF); // иначе гасим
 269  004e ae0200        	ldw	x,#512
 270  0051 cd0000        	call	_Led_setmode
 272  0054 204a          	jra	L16
 273  0056               L72:
 274                     ; 65 		case CONFIGURE_KEYS_REPORT_ID: // запись настроек клавиши в EEPROM
 274                     ; 66 			if (length < 6) break;
 276  0056 7b05          	ld	a,(OFST+5,sp)
 277  0058 a106          	cp	a,#6
 278  005a 2544          	jrult	L16
 281                     ; 67 			if (p_data[1] < BTN_CNT) {
 283  005c e601          	ld	a,(1,x)
 284  005e a110          	cp	a,#16
 285  0060 243e          	jruge	L16
 286                     ; 68 				if (HID_Dev.Key_settings_to_write.write_flag == 0) {
 288  0062 3d1f          	tnz	_HID_Dev+31
 289  0064 263a          	jrne	L16
 290                     ; 69 					HID_Dev.Key_settings_to_write.key_num = p_data[1];
 292  0066 b720          	ld	_HID_Dev+32,a
 293                     ; 70 					HID_Dev.Key_settings_to_write.KeyCode.UsagePage = p_data[2];
 295  0068 e602          	ld	a,(2,x)
 296  006a b721          	ld	_HID_Dev+33,a
 297                     ; 71 					HID_Dev.Key_settings_to_write.KeyCode.Modifiers = p_data[3];
 299  006c e603          	ld	a,(3,x)
 300  006e b722          	ld	_HID_Dev+34,a
 301                     ; 72 					HID_Dev.Key_settings_to_write.KeyCode.KeyCode_LO = p_data[4];
 303  0070 e604          	ld	a,(4,x)
 304  0072 b723          	ld	_HID_Dev+35,a
 305                     ; 73 					HID_Dev.Key_settings_to_write.KeyCode.KeyCode_HI = p_data[5];
 307  0074 e605          	ld	a,(5,x)
 308  0076 b724          	ld	_HID_Dev+36,a
 309                     ; 74 					HID_Dev.Key_settings_to_write.write_flag = 6;
 311  0078 3506001f      	mov	_HID_Dev+31,#6
 312  007c 2022          	jra	L16
 313  007e               L13:
 314                     ; 78 		case READ_KEYS_REPORT_ID: // установка номера активной клавиши для чтения настроек
 314                     ; 79 			if (length < 2) break;
 316  007e 7b05          	ld	a,(OFST+5,sp)
 317  0080 a102          	cp	a,#2
 318  0082 251c          	jrult	L16
 321                     ; 80 			if (p_data[1] < BTN_CNT) {
 323  0084 e601          	ld	a,(1,x)
 324  0086 a110          	cp	a,#16
 325  0088 2416          	jruge	L16
 326                     ; 81 				HID_Dev.Key_settings.key_num = p_data[1];
 328  008a b71a          	ld	_HID_Dev+26,a
 329                     ; 82 				HID_Dev.Key_settings.KeyCode = g_KeyCode[HID_Dev.Key_settings.key_num];
 331  008c ae001b        	ldw	x,#_HID_Dev+27
 332  008f 905f          	clrw	y
 333  0091 9097          	ld	yl,a
 334  0093 9058          	sllw	y
 335  0095 9058          	sllw	y
 336  0097 72b90000      	addw	y,_g_KeyCode
 337  009b a604          	ld	a,#4
 338  009d cd0000        	call	c_xymvx
 340  00a0               L16:
 341                     ; 86 }
 344  00a0 85            	popw	x
 345  00a1 81            	ret	
 379                     ; 92 void EVENT_KEY_pressed(uint8_t key_num) { }
 380                     .text:	section	.text,new
 381  0000               _EVENT_KEY_pressed:
 388  0000 81            	ret	
 422                     ; 93 void EVENT_KEY_released(uint8_t key_num) { }
 423                     .text:	section	.text,new
 424  0000               _EVENT_KEY_released:
 431  0000 81            	ret	
 497                     ; 147 void BTN_USB_send_Loop(void)
 497                     ; 148 {
 498                     .text:	section	.text,new
 499  0000               _BTN_USB_send_Loop:
 501  0000 5207          	subw	sp,#7
 502       00000007      OFST:	set	7
 505                     ; 41 @inline uint16_t Buttons_get_mask(void) { return g_buttons.pressed; }
 508  0002 be01          	ldw	x,_g_buttons+1
 509  0004 1f04          	ldw	(OFST-3,sp),x
 513                     ; 152 	uint8_t UsedKeyCodes = 0; // счётчик использованных скан-кодов
 515  0006 0f06          	clr	(OFST-1,sp)
 517                     ; 154 	if (HID_Dev.prev_key_mask != key_mask) { // если состояние кнопок изменилось
 519  0008 be25          	ldw	x,_HID_Dev+37
 520  000a 1304          	cpw	x,(OFST-3,sp)
 521  000c 274f          	jreq	L712
 522                     ; 155 		for(i=0;i<BTN_CNT;i++) { // ищем изменившиеся клавиши и выставляем нужные флаги
 524  000e 0f07          	clr	(OFST+0,sp)
 526  0010               L122:
 527                     ; 156 			if ((HID_Dev.prev_key_mask ^ key_mask) & (1 << i)) {
 529  0010 ae0001        	ldw	x,#1
 530  0013 7b07          	ld	a,(OFST+0,sp)
 531  0015 2704          	jreq	L64
 532  0017               L05:
 533  0017 58            	sllw	x
 534  0018 4a            	dec	a
 535  0019 26fc          	jrne	L05
 536  001b               L64:
 537  001b 1f01          	ldw	(OFST-6,sp),x
 539  001d be25          	ldw	x,_HID_Dev+37
 540  001f 01            	rrwa	x,a
 541  0020 1805          	xor	a,(OFST-2,sp)
 542  0022 01            	rrwa	x,a
 543  0023 1804          	xor	a,(OFST-3,sp)
 544  0025 02            	rlwa	x,a
 545  0026 1402          	and	a,(OFST-5,sp)
 546  0028 01            	rrwa	x,a
 547  0029 1401          	and	a,(OFST-6,sp)
 548  002b 01            	rrwa	x,a
 549  002c 5d            	tnzw	x
 550  002d 2722          	jreq	L722
 551                     ; 157 				switch(g_KeyCode[i].UsagePage)
 553  002f 7b07          	ld	a,(OFST+0,sp)
 554  0031 cd01b6        	call	LC002
 556                     ; 167 						break;
 557  0034 4a            	dec	a
 558  0035 2716          	jreq	L351
 559  0037 a006          	sub	a,#6
 560  0039 2706          	jreq	L741
 561  003b a005          	sub	a,#5
 562  003d 2708          	jreq	L151
 563  003f 2010          	jra	L722
 564  0041               L741:
 565                     ; 159 					case STD_KEYBOARD_USAGE_PAGE: // UsagePage клавиши соответствует первой клавиатуре
 565                     ; 160 						HID_Dev.STD_KB_Report_changed_flag = 1; // состояние клавиш первой клавиатуры изменилось
 567  0041 3501000b      	mov	_HID_Dev+11,#1
 568                     ; 161 						break;
 570  0045 200a          	jra	L722
 571  0047               L151:
 572                     ; 162 					case EXT1_KEYBOARD_USAGE_PAGE: // UsagePage клавиши соответствует второй клавиатуре
 572                     ; 163 						HID_Dev.EXT1_KB_Report_changed_flag = 1; // состояние клавиш второй клавиатуры изменилось
 574  0047 3501000f      	mov	_HID_Dev+15,#1
 575                     ; 164 						break;
 577  004b 2004          	jra	L722
 578  004d               L351:
 579                     ; 165 					case EXT2_KEYBOARD_USAGE_PAGE: // UsagePage клавиши соответствует третьей клавиатуре
 579                     ; 166 						HID_Dev.EXT2_KB_Report_changed_flag = 1; // состояние клавиш третьей клавиатуры изменилось
 581  004d 35010018      	mov	_HID_Dev+24,#1
 582                     ; 167 						break;
 584  0051               L722:
 585                     ; 155 		for(i=0;i<BTN_CNT;i++) { // ищем изменившиеся клавиши и выставляем нужные флаги
 587  0051 0c07          	inc	(OFST+0,sp)
 591  0053 7b07          	ld	a,(OFST+0,sp)
 592  0055 a110          	cp	a,#16
 593  0057 25b7          	jrult	L122
 594                     ; 171 		HID_Dev.prev_key_mask = key_mask; // сохраняем состояние кнопок
 596  0059 1e04          	ldw	x,(OFST-3,sp)
 597  005b bf25          	ldw	_HID_Dev+37,x
 598  005d               L712:
 599                     ; 175 	if (HID_Dev.STD_KB_Report_changed_flag) { // если состояние клавиш данной клавиатуры изменилось - формируем и отправляем USB пакет
 601  005d b60b          	ld	a,_HID_Dev+11
 602  005f 2603cc00f9    	jreq	L532
 603                     ; 176 		KeyCodesMAX = 5; // в данной клавиатуре одновременно могут быть нажаты до 5 клавиш (без учёта модификаторов)
 605  0064 a605          	ld	a,#5
 606  0066 6b03          	ld	(OFST-4,sp),a
 608                     ; 177 		HID_Dev.STD_KB_Report.Modifier = 0; // сбрасываем байт модификаторов
 610  0068 3f04          	clr	_HID_Dev+4
 611                     ; 178 		for(i=0;i<BTN_CNT;i++) { // формируем байт модификаторов
 613  006a 0f07          	clr	(OFST+0,sp)
 615  006c               L732:
 616                     ; 179 			if (key_mask & (1 << i)) { // если нажата клавиша i
 618  006c ae0001        	ldw	x,#1
 619  006f 7b07          	ld	a,(OFST+0,sp)
 620  0071 2704          	jreq	L25
 621  0073               L45:
 622  0073 58            	sllw	x
 623  0074 4a            	dec	a
 624  0075 26fc          	jrne	L45
 625  0077               L25:
 626  0077 01            	rrwa	x,a
 627  0078 1405          	and	a,(OFST-2,sp)
 628  007a 01            	rrwa	x,a
 629  007b 1404          	and	a,(OFST-3,sp)
 630  007d 01            	rrwa	x,a
 631  007e 5d            	tnzw	x
 632  007f 2713          	jreq	L542
 633                     ; 180 				if (g_KeyCode[i].UsagePage == STD_KEYBOARD_USAGE_PAGE) { // и UsagePage клавиши соответствует первой клавиатуре
 635  0081 7b07          	ld	a,(OFST+0,sp)
 636  0083 cd01b6        	call	LC002
 637  0086 a107          	cp	a,#7
 638  0088 260a          	jrne	L542
 639                     ; 181 					HID_Dev.STD_KB_Report.Modifier |= g_KeyCode[i].Modifiers; // применяем маску модификаторов данной клавиши
 641  008a 72bb0000      	addw	x,_g_KeyCode
 642  008e b604          	ld	a,_HID_Dev+4
 643  0090 ea01          	or	a,(1,x)
 644  0092 b704          	ld	_HID_Dev+4,a
 645  0094               L542:
 646                     ; 178 		for(i=0;i<BTN_CNT;i++) { // формируем байт модификаторов
 648  0094 0c07          	inc	(OFST+0,sp)
 652  0096 7b07          	ld	a,(OFST+0,sp)
 653  0098 a110          	cp	a,#16
 654  009a 25d0          	jrult	L732
 655                     ; 186 		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
 657  009c 0f07          	clr	(OFST+0,sp)
 659  009e               L152:
 660                     ; 187 			if (key_mask & (1 << i)) { // если нажата клавиша i
 662  009e ae0001        	ldw	x,#1
 663  00a1 7b07          	ld	a,(OFST+0,sp)
 664  00a3 2704          	jreq	L65
 665  00a5               L06:
 666  00a5 58            	sllw	x
 667  00a6 4a            	dec	a
 668  00a7 26fc          	jrne	L06
 669  00a9               L65:
 670  00a9 01            	rrwa	x,a
 671  00aa 1405          	and	a,(OFST-2,sp)
 672  00ac 01            	rrwa	x,a
 673  00ad 1404          	and	a,(OFST-3,sp)
 674  00af 01            	rrwa	x,a
 675  00b0 5d            	tnzw	x
 676  00b1 272e          	jreq	L752
 677                     ; 188 				if (g_KeyCode[i].UsagePage == STD_KEYBOARD_USAGE_PAGE) { // и UsagePage клавиши соответствует первой клавиатуре
 679  00b3 7b07          	ld	a,(OFST+0,sp)
 680  00b5 cd01b6        	call	LC002
 681  00b8 a107          	cp	a,#7
 682  00ba 2625          	jrne	L752
 683                     ; 189 					HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = g_KeyCode[i].KeyCode_LO; // записываем в пакет скан-код кнопки
 685  00bc 7b06          	ld	a,(OFST-1,sp)
 686  00be 0c06          	inc	(OFST-1,sp)
 688  00c0 5f            	clrw	x
 689  00c1 97            	ld	xl,a
 690  00c2 7b07          	ld	a,(OFST+0,sp)
 691  00c4 cd01be        	call	LC003
 692  00c7 e706          	ld	(_HID_Dev+6,x),a
 693                     ; 190 					if (UsedKeyCodes >= KeyCodesMAX) // если все 5 байт под скан-коды уже использованы
 695  00c9 7b06          	ld	a,(OFST-1,sp)
 696  00cb 1103          	cp	a,(OFST-4,sp)
 697  00cd 2512          	jrult	L752
 698                     ; 191 						goto STD_Send;	// пропускаем остальные клавиши и переходим к отправке пакета
 699  00cf               L551:
 700                     ; 197 	STD_Send:
 700                     ; 198 		// отправка USB пакета и сброс флага изменения клавиатуры при успешной отправке
 700                     ; 199 		if (USB_Send_Data((uint8_t*)&HID_Dev.STD_KB_Report, sizeof(HID_Dev.STD_KB_Report), 1) == 0)
 702  00cf 4b01          	push	#1
 703  00d1 4b08          	push	#8
 704  00d3 ae0003        	ldw	x,#_HID_Dev+3
 705  00d6 cd0000        	call	_USB_Send_Data
 707  00d9 4d            	tnz	a
 708  00da 85            	popw	x
 709  00db 2674          	jrne	L113
 710                     ; 200 			HID_Dev.STD_KB_Report_changed_flag = 0;
 712  00dd 3f0b          	clr	_HID_Dev+11
 713  00df 2070          	jra	L113
 714  00e1               L752:
 715                     ; 186 		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
 717  00e1 0c07          	inc	(OFST+0,sp)
 721  00e3 7b07          	ld	a,(OFST+0,sp)
 722  00e5 a110          	cp	a,#16
 723  00e7 25b5          	jrult	L152
 725  00e9 2006          	jra	L762
 726  00eb               L562:
 727                     ; 196 		while(UsedKeyCodes < KeyCodesMAX) HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = 0;
 729  00eb 0c06          	inc	(OFST-1,sp)
 731  00ed 5f            	clrw	x
 732  00ee 97            	ld	xl,a
 733  00ef 6f06          	clr	(_HID_Dev+6,x)
 734  00f1               L762:
 737  00f1 7b06          	ld	a,(OFST-1,sp)
 738  00f3 1103          	cp	a,(OFST-4,sp)
 739  00f5 25f4          	jrult	L562
 740  00f7 20d6          	jra	L551
 741                     ; 201 		return;
 743  00f9               L532:
 744                     ; 206 	if (HID_Dev.EXT1_KB_Report_changed_flag) {
 746  00f9 3d0f          	tnz	_HID_Dev+15
 747  00fb 2757          	jreq	L572
 748                     ; 207 		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
 750  00fd 6b07          	ld	(OFST+0,sp),a
 752  00ff               L772:
 753                     ; 208 			if (key_mask & (1 << i)) { // если нажата клавиша i
 755  00ff ae0001        	ldw	x,#1
 756  0102 7b07          	ld	a,(OFST+0,sp)
 757  0104 2704          	jreq	L46
 758  0106               L66:
 759  0106 58            	sllw	x
 760  0107 4a            	dec	a
 761  0108 26fc          	jrne	L66
 762  010a               L46:
 763  010a 01            	rrwa	x,a
 764  010b 1405          	and	a,(OFST-2,sp)
 765  010d 01            	rrwa	x,a
 766  010e 1404          	and	a,(OFST-3,sp)
 767  0110 01            	rrwa	x,a
 768  0111 5d            	tnzw	x
 769  0112 2721          	jreq	L503
 770                     ; 209 				if (g_KeyCode[i].UsagePage == EXT1_KEYBOARD_USAGE_PAGE) { // UsagePage клавиши соответствует второй клавиатуре
 772  0114 7b07          	ld	a,(OFST+0,sp)
 773  0116 cd01b6        	call	LC002
 774  0119 a10c          	cp	a,#12
 775  011b 2618          	jrne	L503
 776                     ; 210 					HID_Dev.EXT1_KB_Report.KeyCode_LO = g_KeyCode[i].KeyCode_LO; // записываем в пакет младший байт скан-кода
 778  011d 72bb0000      	addw	x,_g_KeyCode
 779  0121 e602          	ld	a,(2,x)
 780  0123 b70d          	ld	_HID_Dev+13,a
 781                     ; 211 					HID_Dev.EXT1_KB_Report.KeyCode_HI = g_KeyCode[i].KeyCode_HI; // записываем в пакет старший байт скан-кода
 783  0125 7b07          	ld	a,(OFST+0,sp)
 784  0127 97            	ld	xl,a
 785  0128 a604          	ld	a,#4
 786  012a 42            	mul	x,a
 787  012b 72bb0000      	addw	x,_g_KeyCode
 788  012f e603          	ld	a,(3,x)
 789  0131 b70e          	ld	_HID_Dev+14,a
 790                     ; 212 					goto EXT1_Send; // сразу переходим к отправке
 792  0133 200c          	jra	L751
 793  0135               L503:
 794                     ; 207 		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
 796  0135 0c07          	inc	(OFST+0,sp)
 800  0137 7b07          	ld	a,(OFST+0,sp)
 801  0139 a110          	cp	a,#16
 802  013b 25c2          	jrult	L772
 803                     ; 217 		HID_Dev.EXT1_KB_Report.KeyCode_LO = 0;
 805  013d 3f0d          	clr	_HID_Dev+13
 806                     ; 218 		HID_Dev.EXT1_KB_Report.KeyCode_HI = 0;
 808  013f 3f0e          	clr	_HID_Dev+14
 809  0141               L751:
 810                     ; 219 	EXT1_Send:
 810                     ; 220 		// отправка USB пакета и сброс флага изменения клавиатуры при успешной отправке
 810                     ; 221 		if (USB_Send_Data((uint8_t*)&HID_Dev.EXT1_KB_Report, sizeof(HID_Dev.EXT1_KB_Report), 1) == 0)
 812  0141 4b01          	push	#1
 813  0143 4b03          	push	#3
 814  0145 ae000c        	ldw	x,#_HID_Dev+12
 815  0148 cd0000        	call	_USB_Send_Data
 817  014b 4d            	tnz	a
 818  014c 85            	popw	x
 819  014d 2602          	jrne	L113
 820                     ; 222 			HID_Dev.EXT1_KB_Report_changed_flag = 0;
 822  014f 3f0f          	clr	_HID_Dev+15
 823  0151               L113:
 824                     ; 223 		return;
 827  0151 5b07          	addw	sp,#7
 828  0153 81            	ret	
 829  0154               L572:
 830                     ; 227 	if (HID_Dev.EXT2_KB_Report_changed_flag) {
 832  0154 b618          	ld	a,_HID_Dev+24
 833  0156 27f9          	jreq	L113
 834                     ; 228 		KeyCodesMAX = 7; // в данной клавиатуре одновременно могут быть нажаты до 7 клавиш
 836  0158 a607          	ld	a,#7
 837  015a 6b03          	ld	(OFST-4,sp),a
 839                     ; 229 		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
 841  015c 0f07          	clr	(OFST+0,sp)
 843  015e               L513:
 844                     ; 230 			if (key_mask & (1 << i)) { // если нажата клавиша i
 846  015e ae0001        	ldw	x,#1
 847  0161 7b07          	ld	a,(OFST+0,sp)
 848  0163 2704          	jreq	L27
 849  0165               L47:
 850  0165 58            	sllw	x
 851  0166 4a            	dec	a
 852  0167 26fc          	jrne	L47
 853  0169               L27:
 854  0169 01            	rrwa	x,a
 855  016a 1405          	and	a,(OFST-2,sp)
 856  016c 01            	rrwa	x,a
 857  016d 1404          	and	a,(OFST-3,sp)
 858  016f 01            	rrwa	x,a
 859  0170 5d            	tnzw	x
 860  0171 272b          	jreq	L323
 861                     ; 231 				if (g_KeyCode[i].UsagePage == EXT2_KEYBOARD_USAGE_PAGE) { // UsagePage клавиши соответствует третьей клавиатуре
 863  0173 7b07          	ld	a,(OFST+0,sp)
 864  0175 ad3f          	call	LC002
 865  0177 4a            	dec	a
 866  0178 2624          	jrne	L323
 867                     ; 232 					HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = g_KeyCode[i].KeyCode_LO; // записываем в пакет скан-код кнопки
 869  017a 7b06          	ld	a,(OFST-1,sp)
 870  017c 0c06          	inc	(OFST-1,sp)
 872  017e 5f            	clrw	x
 873  017f 97            	ld	xl,a
 874  0180 7b07          	ld	a,(OFST+0,sp)
 875  0182 ad3a          	call	LC003
 876  0184 e711          	ld	(_HID_Dev+17,x),a
 877                     ; 233 					if (UsedKeyCodes >= KeyCodesMAX) // если все 7 байт под скан-коды уже использованы
 879  0186 7b06          	ld	a,(OFST-1,sp)
 880  0188 1103          	cp	a,(OFST-4,sp)
 881  018a 2512          	jrult	L323
 882                     ; 234 						goto EXT2_Send;	// пропускаем остальные клавиши и переходим к отправке пакета
 883  018c               L161:
 884                     ; 240 	EXT2_Send:
 884                     ; 241 		// отправка USB пакета и сброс флага изменения клавиатуры при успешной отправке
 884                     ; 242 		if (USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 1) == 0)
 886  018c 4b01          	push	#1
 887  018e 4b08          	push	#8
 888  0190 ae0010        	ldw	x,#_HID_Dev+16
 889  0193 cd0000        	call	_USB_Send_Data
 891  0196 4d            	tnz	a
 892  0197 85            	popw	x
 893  0198 26b7          	jrne	L113
 894                     ; 243 			HID_Dev.EXT2_KB_Report_changed_flag = 0;
 896  019a 3f18          	clr	_HID_Dev+24
 897  019c 20b3          	jra	L113
 898  019e               L323:
 899                     ; 229 		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
 901  019e 0c07          	inc	(OFST+0,sp)
 905  01a0 7b07          	ld	a,(OFST+0,sp)
 906  01a2 a110          	cp	a,#16
 907  01a4 25b8          	jrult	L513
 909  01a6 2006          	jra	L333
 910  01a8               L133:
 911                     ; 239 		while(UsedKeyCodes < KeyCodesMAX) HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = 0;
 913  01a8 0c06          	inc	(OFST-1,sp)
 915  01aa 5f            	clrw	x
 916  01ab 97            	ld	xl,a
 917  01ac 6f11          	clr	(_HID_Dev+17,x)
 918  01ae               L333:
 921  01ae 7b06          	ld	a,(OFST-1,sp)
 922  01b0 1103          	cp	a,(OFST-4,sp)
 923  01b2 25f4          	jrult	L133
 924  01b4 20d6          	jra	L161
 925                     ; 244 		return;
 927                     ; 41  светодиодов первой клавиатуры (STD keyboard), а также 
 929  01b6               LC002:
 930  01b6 97            	ld	xl,a
 931  01b7 a604          	ld	a,#4
 932  01b9 42            	mul	x,a
 933  01ba 92d600        	ld	a,([_g_KeyCode.w],x)
 934  01bd 81            	ret	
 935  01be               LC003:
 936  01be 905f          	clrw	y
 937  01c0 9097          	ld	yl,a
 938  01c2 9058          	sllw	y
 939  01c4 9058          	sllw	y
 940  01c6 72b90000      	addw	y,_g_KeyCode
 941  01ca 90e602        	ld	a,(2,y)
 942  01cd 81            	ret	
 988                     ; 252 int8_t USB_Class_Init_callback(uint8_t dev_config)
 988                     ; 253 {
 989                     .text:	section	.text,new
 990  0000               _USB_Class_Init_callback:
 992  0000 88            	push	a
 993       00000001      OFST:	set	1
 996                     ; 255 	for(i=0;i<sizeof(HID_Dev);i++) ((uint8_t*)&HID_Dev)[i] = 0; // типа memset
 998  0001 4f            	clr	a
 999  0002 6b01          	ld	(OFST+0,sp),a
1001  0004               L363:
1004  0004 5f            	clrw	x
1005  0005 97            	ld	xl,a
1006  0006 6f00          	clr	(_HID_Dev,x)
1009  0008 0c01          	inc	(OFST+0,sp)
1013  000a 7b01          	ld	a,(OFST+0,sp)
1014  000c a127          	cp	a,#39
1015  000e 25f4          	jrult	L363
1016                     ; 257 	HID_Dev.STD_KB_Report.ReportID = STD_KEYBOARD_REPORT_ID;
1018  0010 35290003      	mov	_HID_Dev+3,#41
1019                     ; 258 	HID_Dev.EXT1_KB_Report.ReportID = EXT1_KEYBOARD_REPORT_ID;
1021  0014 352a000c      	mov	_HID_Dev+12,#42
1022                     ; 259 	HID_Dev.EXT2_KB_Report.ReportID = EXT2_KEYBOARD_REPORT_ID;
1024  0018 352b0010      	mov	_HID_Dev+16,#43
1025                     ; 260 	HID_Dev.Key_settings.ReportID = READ_KEYS_REPORT_ID;
1027  001c 35040019      	mov	_HID_Dev+25,#4
1028                     ; 263 	HID_Dev.Key_settings.KeyCode = g_KeyCode[HID_Dev.Key_settings.key_num];
1030  0020 ae001b        	ldw	x,#_HID_Dev+27
1031  0023 b61a          	ld	a,_HID_Dev+26
1032  0025 905f          	clrw	y
1033  0027 9097          	ld	yl,a
1034  0029 9058          	sllw	y
1035  002b 9058          	sllw	y
1036  002d 72b90000      	addw	y,_g_KeyCode
1037  0031 a604          	ld	a,#4
1038  0033 cd0000        	call	c_xymvx
1040                     ; 264 	HID_Dev.Key_settings_to_write.write_flag = 0; // флаг отложенной записи настроек
1042  0036 3f1f          	clr	_HID_Dev+31
1043                     ; 266 	HID_Dev.STD_KB_Report_changed_flag = 1; 
1045  0038 3501000b      	mov	_HID_Dev+11,#1
1046                     ; 267 	HID_Dev.EXT1_KB_Report_changed_flag = 1;
1048  003c 3501000f      	mov	_HID_Dev+15,#1
1049                     ; 268 	HID_Dev.EXT2_KB_Report_changed_flag = 1;
1051  0040 35010018      	mov	_HID_Dev+24,#1
1052                     ; 269 	return 0;
1054  0044 4f            	clr	a
1057  0045 5b01          	addw	sp,#1
1058  0047 81            	ret	
1082                     ; 276 int8_t USB_Class_DeInit_callback(void)
1082                     ; 277 {
1083                     .text:	section	.text,new
1084  0000               _USB_Class_DeInit_callback:
1088                     ; 278 	return 0;
1090  0000 4f            	clr	a
1093  0001 81            	ret	
1207                     ; 285 int8_t USB_Setup_Request_callback(t_USB_SetupReq *p_req)
1207                     ; 286 {
1208                     .text:	section	.text,new
1209  0000               _USB_Setup_Request_callback:
1211  0000 89            	pushw	x
1212  0001 5204          	subw	sp,#4
1213       00000004      OFST:	set	4
1216                     ; 287 	switch (p_req->bmRequest & USB_REQ_TYPE_MASK)
1218  0003 f6            	ld	a,(x)
1219  0004 a460          	and	a,#96
1221                     ; 395 					break;
1222  0006 2603cc00c9    	jreq	L334
1223  000b a020          	sub	a,#32
1224  000d 2703cc0148    	jrne	L515
1225                     ; 291 			switch (p_req->bRequest)
1227  0012 e601          	ld	a,(1,x)
1229                     ; 353 				case HID_REQ_GET_IDLE: // 0x02
1229                     ; 354 					return USB_Send_Data(&HID_Dev.IdleState, 1, 0);
1230  0014 4a            	dec	a
1231  0015 271c          	jreq	L304
1232  0017 4a            	dec	a
1233  0018 2603cc00c0    	jreq	L134
1234  001d 4a            	dec	a
1235  001e 2603cc00ac    	jreq	L524
1236  0023 a006          	sub	a,#6
1237  0025 2755          	jreq	L514
1238  0027 4a            	dec	a
1239  0028 2603cc00b5    	jreq	L724
1240  002d 4a            	dec	a
1241  002e 2771          	jreq	L324
1242  0030 cc0148        	jra	L515
1243  0033               L304:
1244                     ; 295 					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) // HID Device
1246  0033 e604          	ld	a,(4,x)
1247  0035 26f9          	jrne	L515
1248                     ; 298 						if ((p_req->wValue_HI == HID_REPORT_FEATURE)||(p_req->wValue_HI == HID_REPORT_INPUT))
1250  0037 e603          	ld	a,(3,x)
1251  0039 a103          	cp	a,#3
1252  003b 2703          	jreq	L725
1254  003d 4a            	dec	a
1255  003e 26f0          	jrne	L515
1256  0040               L725:
1257                     ; 301 							switch(p_req->wValue_LO) // ReportID
1259  0040 e602          	ld	a,(2,x)
1261                     ; 309 								case READ_KEYS_REPORT_ID: // Read key settings
1261                     ; 310 									return USB_Send_Data((uint8_t*)&HID_Dev.Key_settings, sizeof(HID_Dev.Key_settings), 0);
1262  0042 a004          	sub	a,#4
1263  0044 272d          	jreq	L314
1264  0046 a025          	sub	a,#37
1265  0048 2709          	jreq	L504
1266  004a 4a            	dec	a
1267  004b 270f          	jreq	L704
1268  004d 4a            	dec	a
1269  004e 271a          	jreq	L114
1270  0050 cc0148        	jra	L515
1271  0053               L504:
1272                     ; 303 								case STD_KEYBOARD_REPORT_ID: // STD Keyboard
1272                     ; 304 									return USB_Send_Data((uint8_t*)&HID_Dev.STD_KB_Report, sizeof(HID_Dev.STD_KB_Report), 0);
1274  0053 4b00          	push	#0
1275  0055 4b08          	push	#8
1276  0057 ae0003        	ldw	x,#_HID_Dev+3
1279  005a 2007          	jp	LC004
1280  005c               L704:
1281                     ; 305 								case EXT1_KEYBOARD_REPORT_ID: // EXT1 Keyboard
1281                     ; 306 									return USB_Send_Data((uint8_t*)&HID_Dev.EXT1_KB_Report, sizeof(HID_Dev.EXT1_KB_Report), 0);
1283  005c 4b00          	push	#0
1284  005e 4b03          	push	#3
1285  0060 ae000c        	ldw	x,#_HID_Dev+12
1287  0063               LC004:
1288  0063 cd0000        	call	_USB_Send_Data
1289  0066 85            	popw	x
1291  0067               L451:
1293  0067 5b06          	addw	sp,#6
1294  0069 81            	ret	
1295  006a               L114:
1296                     ; 307 								case EXT2_KEYBOARD_REPORT_ID: // EXT2 Keyboard
1296                     ; 308 									return USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 0);
1298  006a 4b00          	push	#0
1299  006c 4b08          	push	#8
1300  006e ae0010        	ldw	x,#_HID_Dev+16
1303  0071 20f0          	jp	LC004
1304  0073               L314:
1305                     ; 309 								case READ_KEYS_REPORT_ID: // Read key settings
1305                     ; 310 									return USB_Send_Data((uint8_t*)&HID_Dev.Key_settings, sizeof(HID_Dev.Key_settings), 0);
1307  0073 4b00          	push	#0
1308  0075 4b06          	push	#6
1309  0077 ae0019        	ldw	x,#_HID_Dev+25
1312  007a 20e7          	jp	LC004
1313  007c               L514:
1314                     ; 319 					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) // HID Device
1316  007c e604          	ld	a,(4,x)
1317  007e 26d0          	jrne	L515
1318                     ; 321 						if (p_req->wValue_HI == HID_REPORT_OUTPUT)
1320  0080 e603          	ld	a,(3,x)
1321  0082 a102          	cp	a,#2
1322  0084 26ca          	jrne	L515
1323                     ; 323 							switch(p_req->wValue_LO) // ReportID
1325  0086 e602          	ld	a,(2,x)
1327                     ; 329 								case STD_KEYBOARD_REPORT_ID: // установка состояний светодиодов
1327                     ; 330 									// Это SETUP STAGE перед отправкой (хостом) пакета с состояниями 
1327                     ; 331 									// светодиодов первой клавиатуры, см. USB_EP0_RxReady_callback
1327                     ; 332 								case READ_KEYS_REPORT_ID: // чтение настроек клавиши
1327                     ; 333 									// Это SETUP STAGE перед отправкой (хостом) пакета с 
1327                     ; 334 									// номером активной клавиши, см. USB_EP0_RxReady_callback
1327                     ; 335 									return USB_Send_Data(NULL, 0, 0); // типа ACK
1328  0088 a003          	sub	a,#3
1329  008a 270a          	jreq	L714
1330  008c 4a            	dec	a
1331  008d 270b          	jreq	L124
1332  008f a025          	sub	a,#37
1333  0091 2707          	jreq	L124
1334  0093 cc0148        	jra	L515
1335  0096               L714:
1336                     ; 325 								case CONFIGURE_KEYS_REPORT_ID: // запись настроек клавиши
1336                     ; 326 									// Это SETUP STAGE перед отправкой (хостом) пакета с 
1336                     ; 327 									// установками клавиши, см. USB_EP0_RxReady_callback
1336                     ; 328 									if (HID_Dev.Key_settings_to_write.write_flag) break; // если отложенная запись уже назначена - отвечаем ошибкой
1338  0096 b61f          	ld	a,_HID_Dev+31
1339  0098 26f9          	jrne	L515
1342  009a               L124:
1343                     ; 329 								case STD_KEYBOARD_REPORT_ID: // установка состояний светодиодов
1343                     ; 330 									// Это SETUP STAGE перед отправкой (хостом) пакета с состояниями 
1343                     ; 331 									// светодиодов первой клавиатуры, см. USB_EP0_RxReady_callback
1343                     ; 332 								case READ_KEYS_REPORT_ID: // чтение настроек клавиши
1343                     ; 333 									// Это SETUP STAGE перед отправкой (хостом) пакета с 
1343                     ; 334 									// номером активной клавиши, см. USB_EP0_RxReady_callback
1343                     ; 335 									return USB_Send_Data(NULL, 0, 0); // типа ACK
1345  009a 4b00          	push	#0
1346  009c 4b00          	push	#0
1347  009e 5f            	clrw	x
1350  009f 20c2          	jp	LC004
1351  00a1               L324:
1352                     ; 342 				case HID_REQ_SET_PROTOCOL: // 0x0B
1352                     ; 343 					HID_Dev.Protocol = p_req->wValue_LO;
1354  00a1 e602          	ld	a,(2,x)
1355  00a3 b700          	ld	_HID_Dev,a
1356                     ; 344 					return USB_Send_Data(NULL, 0, 0);
1358  00a5 4b00          	push	#0
1359  00a7 4b00          	push	#0
1360  00a9 5f            	clrw	x
1363  00aa 20b7          	jp	LC004
1364  00ac               L524:
1365                     ; 346 				case HID_REQ_GET_PROTOCOL: // 0x03
1365                     ; 347 					return USB_Send_Data(&HID_Dev.Protocol, 1, 0);
1367  00ac 4b00          	push	#0
1368  00ae 4b01          	push	#1
1369  00b0 ae0000        	ldw	x,#_HID_Dev
1372  00b3 20ae          	jp	LC004
1373  00b5               L724:
1374                     ; 349 				case HID_REQ_SET_IDLE: // 0x0A
1374                     ; 350 					HID_Dev.IdleState = p_req->wValue_HI;
1376  00b5 e603          	ld	a,(3,x)
1377  00b7 b701          	ld	_HID_Dev+1,a
1378                     ; 351 					return USB_Send_Data(NULL, 0, 0);
1380  00b9 4b00          	push	#0
1381  00bb 4b00          	push	#0
1382  00bd 5f            	clrw	x
1385  00be 20a3          	jp	LC004
1386  00c0               L134:
1387                     ; 353 				case HID_REQ_GET_IDLE: // 0x02
1387                     ; 354 					return USB_Send_Data(&HID_Dev.IdleState, 1, 0);
1389  00c0 4b00          	push	#0
1390  00c2 4b01          	push	#1
1391  00c4 ae0001        	ldw	x,#_HID_Dev+1
1394  00c7 209a          	jp	LC004
1395                     ; 356 			break;
1397  00c9               L334:
1398                     ; 361 			switch (p_req->bRequest)
1400  00c9 e601          	ld	a,(1,x)
1402                     ; 395 					break;
1403  00cb a006          	sub	a,#6
1404  00cd 2709          	jreq	L534
1405  00cf a004          	sub	a,#4
1406  00d1 2757          	jreq	L734
1407  00d3 4a            	dec	a
1408  00d4 2762          	jreq	L144
1409  00d6 2070          	jra	L515
1410  00d8               L534:
1411                     ; 365 					uint16_t wLength = (uint16_t)p_req->wLength_LO | (uint16_t)((uint16_t)p_req->wLength_HI << 8);
1413  00d8 e607          	ld	a,(7,x)
1414  00da 97            	ld	xl,a
1415  00db 4f            	clr	a
1416  00dc 02            	rlwa	x,a
1417  00dd 1f01          	ldw	(OFST-3,sp),x
1419  00df 1e05          	ldw	x,(OFST+1,sp)
1420  00e1 e606          	ld	a,(6,x)
1421  00e3 5f            	clrw	x
1422  00e4 97            	ld	xl,a
1423  00e5 01            	rrwa	x,a
1424  00e6 1a02          	or	a,(OFST-2,sp)
1425  00e8 01            	rrwa	x,a
1426  00e9 1a01          	or	a,(OFST-3,sp)
1427  00eb 01            	rrwa	x,a
1428  00ec 1f03          	ldw	(OFST-1,sp),x
1430                     ; 366 					if (p_req->wValue_HI == TYPE_REPORT_DESCRIPTOR) // 0x22
1432  00ee 1e05          	ldw	x,(OFST+1,sp)
1433  00f0 e603          	ld	a,(3,x)
1434  00f2 a122          	cp	a,#34
1435  00f4 261a          	jrne	L355
1436                     ; 368 						if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
1438  00f6 e604          	ld	a,(4,x)
1439  00f8 264e          	jrne	L515
1440                     ; 370 							return USB_Send_Data(usb_report_descriptor, (uint8_t)MIN(wLength, SIZE_REPORT_DESCRIPTOR), 0);
1442  00fa 4b00          	push	#0
1443  00fc 1e04          	ldw	x,(OFST+0,sp)
1444  00fe a30096        	cpw	x,#150
1445  0101 2404          	jruge	L431
1446  0103 7b05          	ld	a,(OFST+1,sp)
1447  0105 2002          	jra	L631
1448  0107               L431:
1449  0107 a695          	ld	a,#149
1450  0109               L631:
1451  0109 88            	push	a
1452  010a ae0000        	ldw	x,#_usb_report_descriptor
1455  010d cc0063        	jp	LC004
1456  0110               L355:
1457                     ; 373 					if (p_req->wValue_HI == TYPE_HID_DESCRIPTOR) // 0x21
1459  0110 a121          	cp	a,#33
1460  0112 2634          	jrne	L515
1461                     ; 376 						return USB_Send_Data(USB_HID_descriptor, (uint8_t)MIN(wLength, SIZE_HID_DESCRIPTOR), 0);
1463  0114 4b00          	push	#0
1464  0116 1e04          	ldw	x,(OFST+0,sp)
1465  0118 a3000a        	cpw	x,#10
1466  011b 2404          	jruge	L241
1467  011d 7b05          	ld	a,(OFST+1,sp)
1468  011f 2002          	jra	L441
1469  0121               L241:
1470  0121 a609          	ld	a,#9
1471  0123               L441:
1472  0123 88            	push	a
1473  0124 ae0000        	ldw	x,#_USB_HID_descriptor
1476  0127 cc0063        	jp	LC004
1477  012a               L734:
1478                     ; 383 					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
1480  012a e604          	ld	a,(4,x)
1481  012c 261a          	jrne	L515
1482                     ; 384 						return USB_Send_Data(&HID_Dev.AltSetting, 1, 0);
1484  012e 4b00          	push	#0
1485  0130 4b01          	push	#1
1486  0132 ae0002        	ldw	x,#_HID_Dev+2
1489  0135 cc0063        	jp	LC004
1490  0138               L144:
1491                     ; 391 					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
1493  0138 e604          	ld	a,(4,x)
1494  013a 260c          	jrne	L515
1495                     ; 392 						HID_Dev.AltSetting = p_req->wValue_LO;
1497  013c e602          	ld	a,(2,x)
1498  013e b702          	ld	_HID_Dev+2,a
1499                     ; 393 						return USB_Send_Data(NULL, 0, 0);
1501  0140 4b00          	push	#0
1502  0142 4b00          	push	#0
1503  0144 5f            	clrw	x
1506  0145 cc0063        	jp	LC004
1507  0148               L515:
1508                     ; 400 	return -1;
1510  0148 a6ff          	ld	a,#255
1512  014a cc0067        	jra	L451
1548                     ; 407 void USB_EP1_RxReady_callback(uint8_t *p_data, uint8_t length)
1548                     ; 408 {
1549                     .text:	section	.text,new
1550  0000               _USB_EP1_RxReady_callback:
1554                     ; 410 }
1557  0000 81            	ret	
1607                     ; 414 void main(void)
1607                     ; 415 {
1608                     .text:	section	.text,new
1609  0000               _main:
1611  0000 88            	push	a
1612       00000001      OFST:	set	1
1615                     ; 416 	uint8_t counter = 0;	
1617  0001 0f01          	clr	(OFST+0,sp)
1619                     ; 417 	Check_OPTION_BYTE();
1621  0003 cd0000        	call	_Check_OPTION_BYTE
1623                     ; 418 	disableInterrupts();
1626  0006 9b            	sim	
1628                     ; 419 	Init_Clock();
1631  0007 cd0000        	call	_Init_Clock
1633                     ; 420 	Init_GPIO();
1635  000a cd0000        	call	_Init_GPIO
1637                     ; 421 	Leds_init();
1639  000d cd0000        	call	_Leds_init
1641                     ; 422 	Buttons_init();
1643  0010 cd0000        	call	_Buttons_init
1645                     ; 423 	SYSTimer_Init();
1647  0013 cd0000        	call	_SYSTimer_Init
1649                     ; 424 	USB_Init();
1651  0016 cd0000        	call	_USB_Init
1653                     ; 425 	enableInterrupts();
1656  0019 9a            	rim	
1658                     ; 426 	USB_connect(); // подключение подтяжки 1K5
1661  001a cd0000        	call	_USB_connect
1663  001d               L326:
1664                     ; 430 		USB_loop(); // "быстрый" цикл USB, для обработки запросов
1666  001d cd0000        	call	_USB_loop
1668                     ; 431 		if (g_systimer_400Hz_flag) { // 400 Hz call
1670  0020 3d27          	tnz	_g_systimer_400Hz_flag
1671  0022 27f9          	jreq	L326
1672                     ; 432 			g_systimer_400Hz_flag = 0;
1674  0024 3f27          	clr	_g_systimer_400Hz_flag
1675                     ; 433 			Buttons_loop(); // опрос кнопок
1677  0026 cd0000        	call	_Buttons_loop
1679                     ; 434 			counter++;
1681  0029 0c01          	inc	(OFST+0,sp)
1683                     ; 435 			if (counter >= 4) { // 100 Hz call
1685  002b 7b01          	ld	a,(OFST+0,sp)
1686  002d a104          	cp	a,#4
1687  002f 25ec          	jrult	L326
1688                     ; 436 				counter = 0;
1690  0031 0f01          	clr	(OFST+0,sp)
1692                     ; 437 				BTN_USB_send_Loop(); // отправка USB пакетов с состоянием клавиш
1694  0033 cd0000        	call	_BTN_USB_send_Loop
1696                     ; 438 				USB_slow_loop(); // "медленный" цикл USB для настройки HSI генератора и EP1 watchdog
1698  0036 cd0000        	call	_USB_slow_loop
1700                     ; 439 				Write_key_settings(); // отложенная запись настроек клавиш в EEPROM
1702  0039 cd0000        	call	_Write_key_settings
1704  003c 20df          	jra	L326
2048                     	xdef	_main
2049                     	xdef	_BTN_USB_send_Loop
2050                     	xdef	_Write_key_settings
2051                     	xdef	_g_KeyCode
2052                     	switch	.ubsct
2053  0000               _HID_Dev:
2054  0000 000000000000  	ds.b	39
2055                     	xdef	_HID_Dev
2056  0027               _g_systimer_400Hz_flag:
2057  0027 00            	ds.b	1
2058                     	xdef	_g_systimer_400Hz_flag
2059                     	xdef	_EVENT_KEY_released
2060                     	xdef	_EVENT_KEY_pressed
2061                     	xref	_Buttons_loop
2062                     	xref	_Buttons_init
2063                     	xref.b	_g_buttons
2064                     	xref	_Led_setmode
2065                     	xref	_Leds_init
2066                     	xref	_Check_OPTION_BYTE
2067                     	xref	_SYSTimer_Init
2068                     	xref	_Init_Clock
2069                     	xref	_Init_GPIO
2070                     	xdef	_USB_Class_DeInit_callback
2071                     	xdef	_USB_Class_Init_callback
2072                     	xdef	_USB_Setup_Request_callback
2073                     	xdef	_USB_EP1_RxReady_callback
2074                     	xdef	_USB_EP0_RxReady_callback
2075                     	xref	_USB_Send_Data
2076                     	xref	_USB_slow_loop
2077                     	xref	_USB_connect
2078                     	xref	_USB_loop
2079                     	xref	_USB_Init
2080                     	xref	_USB_HID_descriptor
2081                     	xref	_usb_report_descriptor
2082                     	xref	_FLASH_WaitForLastOperation
2083                     	xref	_FLASH_Lock
2084                     	xref	_FLASH_Unlock
2085                     	xref.b	c_x
2105                     	xref	c_xymvx
2106                     	end
