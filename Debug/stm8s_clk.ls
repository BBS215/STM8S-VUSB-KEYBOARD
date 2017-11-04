   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  21                     .const:	section	.text
  22  0000               _HSIDivFactor:
  23  0000 01            	dc.b	1
  24  0001 02            	dc.b	2
  25  0002 04            	dc.b	4
  26  0003 08            	dc.b	8
  27  0004               _CLKPrescTable:
  28  0004 01            	dc.b	1
  29  0005 02            	dc.b	2
  30  0006 04            	dc.b	4
  31  0007 08            	dc.b	8
  32  0008 0a            	dc.b	10
  33  0009 10            	dc.b	16
  34  000a 14            	dc.b	20
  35  000b 28            	dc.b	40
  64                     ; 72 void CLK_DeInit(void)
  64                     ; 73 {
  66                     .text:	section	.text,new
  67  0000               _CLK_DeInit:
  71                     ; 74   CLK->ICKR = CLK_ICKR_RESET_VALUE;
  73  0000 350150c0      	mov	20672,#1
  74                     ; 75   CLK->ECKR = CLK_ECKR_RESET_VALUE;
  76  0004 725f50c1      	clr	20673
  77                     ; 76   CLK->SWR  = CLK_SWR_RESET_VALUE;
  79  0008 35e150c4      	mov	20676,#225
  80                     ; 77   CLK->SWCR = CLK_SWCR_RESET_VALUE;
  82  000c 725f50c5      	clr	20677
  83                     ; 78   CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  85  0010 351850c6      	mov	20678,#24
  86                     ; 79   CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  88  0014 35ff50c7      	mov	20679,#255
  89                     ; 80   CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  91  0018 35ff50ca      	mov	20682,#255
  92                     ; 81   CLK->CSSR = CLK_CSSR_RESET_VALUE;
  94  001c 725f50c8      	clr	20680
  95                     ; 82   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  97  0020 725f50c9      	clr	20681
  99  0024               L52:
 100                     ; 83   while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
 102  0024 720050c9fb    	btjt	20681,#0,L52
 103                     ; 85   CLK->CCOR = CLK_CCOR_RESET_VALUE;
 105  0029 725f50c9      	clr	20681
 106                     ; 86   CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 108  002d 725f50cc      	clr	20684
 109                     ; 87   CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 111  0031 725f50cd      	clr	20685
 112                     ; 88 }
 115  0035 81            	ret	
 171                     ; 99 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 171                     ; 100 {
 172                     .text:	section	.text,new
 173  0000               _CLK_FastHaltWakeUpCmd:
 177                     ; 102   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 179                     ; 104   if (NewState != DISABLE)
 181  0000 4d            	tnz	a
 182  0001 2705          	jreq	L75
 183                     ; 107     CLK->ICKR |= CLK_ICKR_FHWU;
 185  0003 721450c0      	bset	20672,#2
 188  0007 81            	ret	
 189  0008               L75:
 190                     ; 112     CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 192  0008 721550c0      	bres	20672,#2
 193                     ; 114 }
 196  000c 81            	ret	
 231                     ; 121 void CLK_HSECmd(FunctionalState NewState)
 231                     ; 122 {
 232                     .text:	section	.text,new
 233  0000               _CLK_HSECmd:
 237                     ; 124   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 239                     ; 126   if (NewState != DISABLE)
 241  0000 4d            	tnz	a
 242  0001 2705          	jreq	L101
 243                     ; 129     CLK->ECKR |= CLK_ECKR_HSEEN;
 245  0003 721050c1      	bset	20673,#0
 248  0007 81            	ret	
 249  0008               L101:
 250                     ; 134     CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 252  0008 721150c1      	bres	20673,#0
 253                     ; 136 }
 256  000c 81            	ret	
 291                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 291                     ; 144 {
 292                     .text:	section	.text,new
 293  0000               _CLK_HSICmd:
 297                     ; 146   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 299                     ; 148   if (NewState != DISABLE)
 301  0000 4d            	tnz	a
 302  0001 2705          	jreq	L321
 303                     ; 151     CLK->ICKR |= CLK_ICKR_HSIEN;
 305  0003 721050c0      	bset	20672,#0
 308  0007 81            	ret	
 309  0008               L321:
 310                     ; 156     CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 312  0008 721150c0      	bres	20672,#0
 313                     ; 158 }
 316  000c 81            	ret	
 351                     ; 166 void CLK_LSICmd(FunctionalState NewState)
 351                     ; 167 {
 352                     .text:	section	.text,new
 353  0000               _CLK_LSICmd:
 357                     ; 169   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 359                     ; 171   if (NewState != DISABLE)
 361  0000 4d            	tnz	a
 362  0001 2705          	jreq	L541
 363                     ; 174     CLK->ICKR |= CLK_ICKR_LSIEN;
 365  0003 721650c0      	bset	20672,#3
 368  0007 81            	ret	
 369  0008               L541:
 370                     ; 179     CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 372  0008 721750c0      	bres	20672,#3
 373                     ; 181 }
 376  000c 81            	ret	
 411                     ; 189 void CLK_CCOCmd(FunctionalState NewState)
 411                     ; 190 {
 412                     .text:	section	.text,new
 413  0000               _CLK_CCOCmd:
 417                     ; 192   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 419                     ; 194   if (NewState != DISABLE)
 421  0000 4d            	tnz	a
 422  0001 2705          	jreq	L761
 423                     ; 197     CLK->CCOR |= CLK_CCOR_CCOEN;
 425  0003 721050c9      	bset	20681,#0
 428  0007 81            	ret	
 429  0008               L761:
 430                     ; 202     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 432  0008 721150c9      	bres	20681,#0
 433                     ; 204 }
 436  000c 81            	ret	
 471                     ; 213 void CLK_ClockSwitchCmd(FunctionalState NewState)
 471                     ; 214 {
 472                     .text:	section	.text,new
 473  0000               _CLK_ClockSwitchCmd:
 477                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 479                     ; 218   if (NewState != DISABLE )
 481  0000 4d            	tnz	a
 482  0001 2705          	jreq	L112
 483                     ; 221     CLK->SWCR |= CLK_SWCR_SWEN;
 485  0003 721250c5      	bset	20677,#1
 488  0007 81            	ret	
 489  0008               L112:
 490                     ; 226     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 492  0008 721350c5      	bres	20677,#1
 493                     ; 228 }
 496  000c 81            	ret	
 532                     ; 238 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 532                     ; 239 {
 533                     .text:	section	.text,new
 534  0000               _CLK_SlowActiveHaltWakeUpCmd:
 538                     ; 241   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 540                     ; 243   if (NewState != DISABLE)
 542  0000 4d            	tnz	a
 543  0001 2705          	jreq	L332
 544                     ; 246     CLK->ICKR |= CLK_ICKR_SWUAH;
 546  0003 721a50c0      	bset	20672,#5
 549  0007 81            	ret	
 550  0008               L332:
 551                     ; 251     CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 553  0008 721b50c0      	bres	20672,#5
 554                     ; 253 }
 557  000c 81            	ret	
 716                     ; 263 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 716                     ; 264 {
 717                     .text:	section	.text,new
 718  0000               _CLK_PeripheralClockConfig:
 720  0000 89            	pushw	x
 721       00000000      OFST:	set	0
 724                     ; 266   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 726                     ; 267   assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 728                     ; 269   if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 730  0001 9e            	ld	a,xh
 731  0002 a510          	bcp	a,#16
 732  0004 2626          	jrne	L123
 733                     ; 271     if (NewState != DISABLE)
 735  0006 7b02          	ld	a,(OFST+2,sp)
 736  0008 270f          	jreq	L323
 737                     ; 274       CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 739  000a 7b01          	ld	a,(OFST+1,sp)
 740  000c ad44          	call	LC003
 741  000e 2704          	jreq	L62
 742  0010               L03:
 743  0010 48            	sll	a
 744  0011 5a            	decw	x
 745  0012 26fc          	jrne	L03
 746  0014               L62:
 747  0014 ca50c7        	or	a,20679
 749  0017 200e          	jp	LC002
 750  0019               L323:
 751                     ; 279       CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 753  0019 7b01          	ld	a,(OFST+1,sp)
 754  001b ad35          	call	LC003
 755  001d 2704          	jreq	L23
 756  001f               L43:
 757  001f 48            	sll	a
 758  0020 5a            	decw	x
 759  0021 26fc          	jrne	L43
 760  0023               L23:
 761  0023 43            	cpl	a
 762  0024 c450c7        	and	a,20679
 763  0027               LC002:
 764  0027 c750c7        	ld	20679,a
 765  002a 2024          	jra	L723
 766  002c               L123:
 767                     ; 284     if (NewState != DISABLE)
 769  002c 7b02          	ld	a,(OFST+2,sp)
 770  002e 270f          	jreq	L133
 771                     ; 287       CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 773  0030 7b01          	ld	a,(OFST+1,sp)
 774  0032 ad1e          	call	LC003
 775  0034 2704          	jreq	L63
 776  0036               L04:
 777  0036 48            	sll	a
 778  0037 5a            	decw	x
 779  0038 26fc          	jrne	L04
 780  003a               L63:
 781  003a ca50ca        	or	a,20682
 783  003d 200e          	jp	LC001
 784  003f               L133:
 785                     ; 292       CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 787  003f 7b01          	ld	a,(OFST+1,sp)
 788  0041 ad0f          	call	LC003
 789  0043 2704          	jreq	L24
 790  0045               L44:
 791  0045 48            	sll	a
 792  0046 5a            	decw	x
 793  0047 26fc          	jrne	L44
 794  0049               L24:
 795  0049 43            	cpl	a
 796  004a c450ca        	and	a,20682
 797  004d               LC001:
 798  004d c750ca        	ld	20682,a
 799  0050               L723:
 800                     ; 295 }
 803  0050 85            	popw	x
 804  0051 81            	ret	
 805  0052               LC003:
 806  0052 a40f          	and	a,#15
 807  0054 5f            	clrw	x
 808  0055 97            	ld	xl,a
 809  0056 a601          	ld	a,#1
 810  0058 5d            	tnzw	x
 811  0059 81            	ret	
 999                     ; 309 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 999                     ; 310 {
1000                     .text:	section	.text,new
1001  0000               _CLK_ClockSwitchConfig:
1003  0000 89            	pushw	x
1004  0001 5204          	subw	sp,#4
1005       00000004      OFST:	set	4
1008                     ; 312   uint16_t DownCounter = CLK_TIMEOUT;
1010  0003 aeffff        	ldw	x,#65535
1011  0006 1f03          	ldw	(OFST-1,sp),x
1013                     ; 313   ErrorStatus Swif = ERROR;
1015                     ; 316   assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1017                     ; 317   assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1019                     ; 318   assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1021                     ; 319   assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1023                     ; 322   clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1025  0008 c650c3        	ld	a,20675
1026  000b 6b01          	ld	(OFST-3,sp),a
1028                     ; 325   if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1030  000d 7b05          	ld	a,(OFST+1,sp)
1031  000f 4a            	dec	a
1032  0010 263d          	jrne	L544
1033                     ; 328     CLK->SWCR |= CLK_SWCR_SWEN;
1035  0012 721250c5      	bset	20677,#1
1036                     ; 331     if (ITState != DISABLE)
1038  0016 7b09          	ld	a,(OFST+5,sp)
1039  0018 2706          	jreq	L744
1040                     ; 333       CLK->SWCR |= CLK_SWCR_SWIEN;
1042  001a 721450c5      	bset	20677,#2
1044  001e 2004          	jra	L154
1045  0020               L744:
1046                     ; 337       CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1048  0020 721550c5      	bres	20677,#2
1049  0024               L154:
1050                     ; 341     CLK->SWR = (uint8_t)CLK_NewClock;
1052  0024 7b06          	ld	a,(OFST+2,sp)
1053  0026 c750c4        	ld	20676,a
1055  0029 2003          	jra	L754
1056  002b               L354:
1057                     ; 346       DownCounter--;
1059  002b 5a            	decw	x
1060  002c 1f03          	ldw	(OFST-1,sp),x
1062  002e               L754:
1063                     ; 344     while((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1065  002e 720150c504    	btjf	20677,#0,L364
1067  0033 1e03          	ldw	x,(OFST-1,sp)
1068  0035 26f4          	jrne	L354
1069  0037               L364:
1070                     ; 349     if(DownCounter != 0)
1072  0037 1e03          	ldw	x,(OFST-1,sp)
1073                     ; 351       Swif = SUCCESS;
1075  0039 263d          	jrne	LC005
1076  003b               L564:
1077                     ; 355       Swif = ERROR;
1080  003b 0f02          	clr	(OFST-2,sp)
1082  003d               L174:
1083                     ; 390   if(Swif != ERROR)
1085  003d 275d          	jreq	L515
1086                     ; 393     if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1088  003f 7b0a          	ld	a,(OFST+6,sp)
1089  0041 263b          	jrne	L715
1091  0043 7b01          	ld	a,(OFST-3,sp)
1092  0045 a1e1          	cp	a,#225
1093  0047 2635          	jrne	L715
1094                     ; 395       CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1096  0049 721150c0      	bres	20672,#0
1098  004d 204d          	jra	L515
1099  004f               L544:
1100                     ; 361     if (ITState != DISABLE)
1102  004f 7b09          	ld	a,(OFST+5,sp)
1103  0051 2706          	jreq	L374
1104                     ; 363       CLK->SWCR |= CLK_SWCR_SWIEN;
1106  0053 721450c5      	bset	20677,#2
1108  0057 2004          	jra	L574
1109  0059               L374:
1110                     ; 367       CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1112  0059 721550c5      	bres	20677,#2
1113  005d               L574:
1114                     ; 371     CLK->SWR = (uint8_t)CLK_NewClock;
1116  005d 7b06          	ld	a,(OFST+2,sp)
1117  005f c750c4        	ld	20676,a
1119  0062 2003          	jra	L305
1120  0064               L774:
1121                     ; 376       DownCounter--;
1123  0064 5a            	decw	x
1124  0065 1f03          	ldw	(OFST-1,sp),x
1126  0067               L305:
1127                     ; 374     while((((CLK->SWCR & CLK_SWCR_SWIF) != 0 ) && (DownCounter != 0)))
1129  0067 720750c504    	btjf	20677,#3,L705
1131  006c 1e03          	ldw	x,(OFST-1,sp)
1132  006e 26f4          	jrne	L774
1133  0070               L705:
1134                     ; 379     if(DownCounter != 0)
1136  0070 1e03          	ldw	x,(OFST-1,sp)
1137  0072 27c7          	jreq	L564
1138                     ; 382       CLK->SWCR |= CLK_SWCR_SWEN;
1140  0074 721250c5      	bset	20677,#1
1141                     ; 383       Swif = SUCCESS;
1143  0078               LC005:
1145  0078 a601          	ld	a,#1
1146  007a 6b02          	ld	(OFST-2,sp),a
1149  007c 20bf          	jra	L174
1150                     ; 387       Swif = ERROR;
1151  007e               L715:
1152                     ; 397     else if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1154  007e 7b0a          	ld	a,(OFST+6,sp)
1155  0080 260c          	jrne	L325
1157  0082 7b01          	ld	a,(OFST-3,sp)
1158  0084 a1d2          	cp	a,#210
1159  0086 2606          	jrne	L325
1160                     ; 399       CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1162  0088 721750c0      	bres	20672,#3
1164  008c 200e          	jra	L515
1165  008e               L325:
1166                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1168  008e 7b0a          	ld	a,(OFST+6,sp)
1169  0090 260a          	jrne	L515
1171  0092 7b01          	ld	a,(OFST-3,sp)
1172  0094 a1b4          	cp	a,#180
1173  0096 2604          	jrne	L515
1174                     ; 403       CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1176  0098 721150c1      	bres	20673,#0
1177  009c               L515:
1178                     ; 406   return(Swif);
1180  009c 7b02          	ld	a,(OFST-2,sp)
1183  009e 5b06          	addw	sp,#6
1184  00a0 81            	ret	
1322                     ; 415 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1322                     ; 416 {
1323                     .text:	section	.text,new
1324  0000               _CLK_HSIPrescalerConfig:
1326  0000 88            	push	a
1327       00000000      OFST:	set	0
1330                     ; 418   assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1332                     ; 421   CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1334  0001 c650c6        	ld	a,20678
1335  0004 a4e7          	and	a,#231
1336  0006 c750c6        	ld	20678,a
1337                     ; 424   CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1339  0009 c650c6        	ld	a,20678
1340  000c 1a01          	or	a,(OFST+1,sp)
1341  000e c750c6        	ld	20678,a
1342                     ; 425 }
1345  0011 84            	pop	a
1346  0012 81            	ret	
1481                     ; 436 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1481                     ; 437 {
1482                     .text:	section	.text,new
1483  0000               _CLK_CCOConfig:
1485  0000 88            	push	a
1486       00000000      OFST:	set	0
1489                     ; 439   assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1491                     ; 442   CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1493  0001 c650c9        	ld	a,20681
1494  0004 a4e1          	and	a,#225
1495  0006 c750c9        	ld	20681,a
1496                     ; 445   CLK->CCOR |= (uint8_t)CLK_CCO;
1498  0009 c650c9        	ld	a,20681
1499  000c 1a01          	or	a,(OFST+1,sp)
1500  000e c750c9        	ld	20681,a
1501                     ; 448   CLK->CCOR |= CLK_CCOR_CCOEN;
1503  0011 721050c9      	bset	20681,#0
1504                     ; 449 }
1507  0015 84            	pop	a
1508  0016 81            	ret	
1573                     ; 459 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1573                     ; 460 {
1574                     .text:	section	.text,new
1575  0000               _CLK_ITConfig:
1577  0000 89            	pushw	x
1578       00000000      OFST:	set	0
1581                     ; 462   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1583                     ; 463   assert_param(IS_CLK_IT_OK(CLK_IT));
1585                     ; 465   if (NewState != DISABLE)
1587  0001 9f            	ld	a,xl
1588  0002 4d            	tnz	a
1589  0003 2715          	jreq	L527
1590                     ; 467     switch (CLK_IT)
1592  0005 9e            	ld	a,xh
1594                     ; 475     default:
1594                     ; 476       break;
1595  0006 a00c          	sub	a,#12
1596  0008 270a          	jreq	L166
1597  000a a010          	sub	a,#16
1598  000c 2620          	jrne	L337
1599                     ; 469     case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1599                     ; 470       CLK->SWCR |= CLK_SWCR_SWIEN;
1601  000e 721450c5      	bset	20677,#2
1602                     ; 471       break;
1604  0012 201a          	jra	L337
1605  0014               L166:
1606                     ; 472     case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1606                     ; 473       CLK->CSSR |= CLK_CSSR_CSSDIE;
1608  0014 721450c8      	bset	20680,#2
1609                     ; 474       break;
1611  0018 2014          	jra	L337
1612                     ; 475     default:
1612                     ; 476       break;
1615  001a               L527:
1616                     ; 481     switch (CLK_IT)
1618  001a 7b01          	ld	a,(OFST+1,sp)
1620                     ; 489     default:
1620                     ; 490       break;
1621  001c a00c          	sub	a,#12
1622  001e 270a          	jreq	L766
1623  0020 a010          	sub	a,#16
1624  0022 260a          	jrne	L337
1625                     ; 483     case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1625                     ; 484       CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1627  0024 721550c5      	bres	20677,#2
1628                     ; 485       break;
1630  0028 2004          	jra	L337
1631  002a               L766:
1632                     ; 486     case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1632                     ; 487       CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1634  002a 721550c8      	bres	20680,#2
1635                     ; 488       break;
1636  002e               L337:
1637                     ; 493 }
1640  002e 85            	popw	x
1641  002f 81            	ret	
1642                     ; 489     default:
1642                     ; 490       break;
1678                     ; 500 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1678                     ; 501 {
1679                     .text:	section	.text,new
1680  0000               _CLK_SYSCLKConfig:
1682  0000 88            	push	a
1683       00000000      OFST:	set	0
1686                     ; 503   assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1688                     ; 505   if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1690  0001 a580          	bcp	a,#128
1691  0003 260e          	jrne	L757
1692                     ; 507     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1694  0005 c650c6        	ld	a,20678
1695  0008 a4e7          	and	a,#231
1696  000a c750c6        	ld	20678,a
1697                     ; 508     CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1699  000d 7b01          	ld	a,(OFST+1,sp)
1700  000f a418          	and	a,#24
1702  0011 200c          	jra	L167
1703  0013               L757:
1704                     ; 512     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1706  0013 c650c6        	ld	a,20678
1707  0016 a4f8          	and	a,#248
1708  0018 c750c6        	ld	20678,a
1709                     ; 513     CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1711  001b 7b01          	ld	a,(OFST+1,sp)
1712  001d a407          	and	a,#7
1713  001f               L167:
1714  001f ca50c6        	or	a,20678
1715  0022 c750c6        	ld	20678,a
1716                     ; 515 }
1719  0025 84            	pop	a
1720  0026 81            	ret	
1776                     ; 523 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1776                     ; 524 {
1777                     .text:	section	.text,new
1778  0000               _CLK_SWIMConfig:
1782                     ; 526   assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1784                     ; 528   if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1786  0000 4d            	tnz	a
1787  0001 2705          	jreq	L1101
1788                     ; 531     CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1790  0003 721050cd      	bset	20685,#0
1793  0007 81            	ret	
1794  0008               L1101:
1795                     ; 536     CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1797  0008 721150cd      	bres	20685,#0
1798                     ; 538 }
1801  000c 81            	ret	
1825                     ; 547 void CLK_ClockSecuritySystemEnable(void)
1825                     ; 548 {
1826                     .text:	section	.text,new
1827  0000               _CLK_ClockSecuritySystemEnable:
1831                     ; 550   CLK->CSSR |= CLK_CSSR_CSSEN;
1833  0000 721050c8      	bset	20680,#0
1834                     ; 551 }
1837  0004 81            	ret	
1862                     ; 559 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1862                     ; 560 {
1863                     .text:	section	.text,new
1864  0000               _CLK_GetSYSCLKSource:
1868                     ; 561   return((CLK_Source_TypeDef)CLK->CMSR);
1870  0000 c650c3        	ld	a,20675
1873  0003 81            	ret	
1936                     ; 569 uint32_t CLK_GetClockFreq(void)
1936                     ; 570 {
1937                     .text:	section	.text,new
1938  0000               _CLK_GetClockFreq:
1940  0000 5209          	subw	sp,#9
1941       00000009      OFST:	set	9
1944                     ; 571   uint32_t clockfrequency = 0;
1946                     ; 572   CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1948                     ; 573   uint8_t tmp = 0, presc = 0;
1952                     ; 576   clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1954  0002 c650c3        	ld	a,20675
1955  0005 6b09          	ld	(OFST+0,sp),a
1957                     ; 578   if (clocksource == CLK_SOURCE_HSI)
1959  0007 a1e1          	cp	a,#225
1960  0009 2634          	jrne	L7601
1961                     ; 580     tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1963  000b c650c6        	ld	a,20678
1964  000e a418          	and	a,#24
1965  0010 44            	srl	a
1966  0011 44            	srl	a
1967  0012 44            	srl	a
1969                     ; 581     tmp = (uint8_t)(tmp >> 3);
1972                     ; 582     presc = HSIDivFactor[tmp];
1974  0013 5f            	clrw	x
1975  0014 97            	ld	xl,a
1976  0015 d60000        	ld	a,(_HSIDivFactor,x)
1977  0018 6b09          	ld	(OFST+0,sp),a
1979                     ; 583     clockfrequency = HSI_VALUE / presc;
1981  001a b703          	ld	c_lreg+3,a
1982  001c 3f02          	clr	c_lreg+2
1983  001e 3f01          	clr	c_lreg+1
1984  0020 3f00          	clr	c_lreg
1985  0022 96            	ldw	x,sp
1986  0023 5c            	incw	x
1987  0024 cd0000        	call	c_rtol
1990  0027 ae2400        	ldw	x,#9216
1991  002a bf02          	ldw	c_lreg+2,x
1992  002c ae00f4        	ldw	x,#244
1993  002f bf00          	ldw	c_lreg,x
1994  0031 96            	ldw	x,sp
1995  0032 5c            	incw	x
1996  0033 cd0000        	call	c_ludv
1998  0036 96            	ldw	x,sp
1999  0037 1c0005        	addw	x,#OFST-4
2000  003a cd0000        	call	c_rtol
2004  003d 2018          	jra	L1701
2005  003f               L7601:
2006                     ; 585   else if ( clocksource == CLK_SOURCE_LSI)
2008  003f a1d2          	cp	a,#210
2009  0041 260a          	jrne	L3701
2010                     ; 587     clockfrequency = LSI_VALUE;
2012  0043 aef400        	ldw	x,#62464
2013  0046 1f07          	ldw	(OFST-2,sp),x
2014  0048 ae0001        	ldw	x,#1
2016  004b 2008          	jp	LC006
2017  004d               L3701:
2018                     ; 591     clockfrequency = HSE_VALUE;
2020  004d ae2400        	ldw	x,#9216
2021  0050 1f07          	ldw	(OFST-2,sp),x
2022  0052 ae00f4        	ldw	x,#244
2023  0055               LC006:
2024  0055 1f05          	ldw	(OFST-4,sp),x
2026  0057               L1701:
2027                     ; 594   return((uint32_t)clockfrequency);
2029  0057 96            	ldw	x,sp
2030  0058 1c0005        	addw	x,#OFST-4
2031  005b cd0000        	call	c_ltor
2035  005e 5b09          	addw	sp,#9
2036  0060 81            	ret	
2135                     ; 604 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2135                     ; 605 {
2136                     .text:	section	.text,new
2137  0000               _CLK_AdjustHSICalibrationValue:
2139  0000 88            	push	a
2140       00000000      OFST:	set	0
2143                     ; 607   assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2145                     ; 610   CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2147  0001 c650cc        	ld	a,20684
2148  0004 a4f8          	and	a,#248
2149  0006 1a01          	or	a,(OFST+1,sp)
2150  0008 c750cc        	ld	20684,a
2151                     ; 611 }
2154  000b 84            	pop	a
2155  000c 81            	ret	
2179                     ; 622 void CLK_SYSCLKEmergencyClear(void)
2179                     ; 623 {
2180                     .text:	section	.text,new
2181  0000               _CLK_SYSCLKEmergencyClear:
2185                     ; 624   CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2187  0000 721150c5      	bres	20677,#0
2188                     ; 625 }
2191  0004 81            	ret	
2344                     ; 634 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2344                     ; 635 {
2345                     .text:	section	.text,new
2346  0000               _CLK_GetFlagStatus:
2348  0000 89            	pushw	x
2349  0001 5203          	subw	sp,#3
2350       00000003      OFST:	set	3
2353                     ; 636   uint16_t statusreg = 0;
2355                     ; 637   uint8_t tmpreg = 0;
2357                     ; 638   FlagStatus bitstatus = RESET;
2359                     ; 641   assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2361                     ; 644   statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2363  0003 01            	rrwa	x,a
2364  0004 4f            	clr	a
2365  0005 02            	rlwa	x,a
2366  0006 1f01          	ldw	(OFST-2,sp),x
2368                     ; 647   if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2370  0008 a30100        	cpw	x,#256
2371  000b 2605          	jrne	L1421
2372                     ; 649     tmpreg = CLK->ICKR;
2374  000d c650c0        	ld	a,20672
2376  0010 2021          	jra	L3421
2377  0012               L1421:
2378                     ; 651   else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2380  0012 a30200        	cpw	x,#512
2381  0015 2605          	jrne	L5421
2382                     ; 653     tmpreg = CLK->ECKR;
2384  0017 c650c1        	ld	a,20673
2386  001a 2017          	jra	L3421
2387  001c               L5421:
2388                     ; 655   else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2390  001c a30300        	cpw	x,#768
2391  001f 2605          	jrne	L1521
2392                     ; 657     tmpreg = CLK->SWCR;
2394  0021 c650c5        	ld	a,20677
2396  0024 200d          	jra	L3421
2397  0026               L1521:
2398                     ; 659   else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2400  0026 a30400        	cpw	x,#1024
2401  0029 2605          	jrne	L5521
2402                     ; 661     tmpreg = CLK->CSSR;
2404  002b c650c8        	ld	a,20680
2406  002e 2003          	jra	L3421
2407  0030               L5521:
2408                     ; 665     tmpreg = CLK->CCOR;
2410  0030 c650c9        	ld	a,20681
2411  0033               L3421:
2412  0033 6b03          	ld	(OFST+0,sp),a
2414                     ; 668   if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2416  0035 7b05          	ld	a,(OFST+2,sp)
2417  0037 1503          	bcp	a,(OFST+0,sp)
2418  0039 2704          	jreq	L1621
2419                     ; 670     bitstatus = SET;
2421  003b a601          	ld	a,#1
2424  003d 2001          	jra	L3621
2425  003f               L1621:
2426                     ; 674     bitstatus = RESET;
2428  003f 4f            	clr	a
2430  0040               L3621:
2431                     ; 678   return((FlagStatus)bitstatus);
2435  0040 5b05          	addw	sp,#5
2436  0042 81            	ret	
2482                     ; 687 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2482                     ; 688 {
2483                     .text:	section	.text,new
2484  0000               _CLK_GetITStatus:
2486  0000 88            	push	a
2487  0001 88            	push	a
2488       00000001      OFST:	set	1
2491                     ; 689   ITStatus bitstatus = RESET;
2493                     ; 692   assert_param(IS_CLK_IT_OK(CLK_IT));
2495                     ; 694   if (CLK_IT == CLK_IT_SWIF)
2497  0002 a11c          	cp	a,#28
2498  0004 2609          	jrne	L7031
2499                     ; 697     if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2501  0006 c450c5        	and	a,20677
2502  0009 a10c          	cp	a,#12
2503  000b 260f          	jrne	L7131
2504                     ; 699       bitstatus = SET;
2506  000d 2009          	jp	LC008
2507                     ; 703       bitstatus = RESET;
2508  000f               L7031:
2509                     ; 709     if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2511  000f c650c8        	ld	a,20680
2512  0012 1402          	and	a,(OFST+1,sp)
2513  0014 a10c          	cp	a,#12
2514  0016 2604          	jrne	L7131
2515                     ; 711       bitstatus = SET;
2517  0018               LC008:
2519  0018 a601          	ld	a,#1
2522  001a 2001          	jra	L5131
2523  001c               L7131:
2524                     ; 715       bitstatus = RESET;
2527  001c 4f            	clr	a
2529  001d               L5131:
2530                     ; 720   return bitstatus;
2534  001d 85            	popw	x
2535  001e 81            	ret	
2571                     ; 729 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2571                     ; 730 {
2572                     .text:	section	.text,new
2573  0000               _CLK_ClearITPendingBit:
2577                     ; 732   assert_param(IS_CLK_IT_OK(CLK_IT));
2579                     ; 734   if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2581  0000 a10c          	cp	a,#12
2582  0002 2605          	jrne	L1431
2583                     ; 737     CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2585  0004 721750c8      	bres	20680,#3
2588  0008 81            	ret	
2589  0009               L1431:
2590                     ; 742     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2592  0009 721750c5      	bres	20677,#3
2593                     ; 745 }
2596  000d 81            	ret	
2631                     	xdef	_CLKPrescTable
2632                     	xdef	_HSIDivFactor
2633                     	xdef	_CLK_ClearITPendingBit
2634                     	xdef	_CLK_GetITStatus
2635                     	xdef	_CLK_GetFlagStatus
2636                     	xdef	_CLK_GetSYSCLKSource
2637                     	xdef	_CLK_GetClockFreq
2638                     	xdef	_CLK_AdjustHSICalibrationValue
2639                     	xdef	_CLK_SYSCLKEmergencyClear
2640                     	xdef	_CLK_ClockSecuritySystemEnable
2641                     	xdef	_CLK_SWIMConfig
2642                     	xdef	_CLK_SYSCLKConfig
2643                     	xdef	_CLK_ITConfig
2644                     	xdef	_CLK_CCOConfig
2645                     	xdef	_CLK_HSIPrescalerConfig
2646                     	xdef	_CLK_ClockSwitchConfig
2647                     	xdef	_CLK_PeripheralClockConfig
2648                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
2649                     	xdef	_CLK_FastHaltWakeUpCmd
2650                     	xdef	_CLK_ClockSwitchCmd
2651                     	xdef	_CLK_CCOCmd
2652                     	xdef	_CLK_LSICmd
2653                     	xdef	_CLK_HSICmd
2654                     	xdef	_CLK_HSECmd
2655                     	xdef	_CLK_DeInit
2656                     	xref.b	c_lreg
2657                     	xref.b	c_x
2676                     	xref	c_ltor
2677                     	xref	c_ludv
2678                     	xref	c_rtol
2679                     	end
