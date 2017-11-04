   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  49                     ; 52 void TIM2_DeInit(void)
  49                     ; 53 {
  51                     .text:	section	.text,new
  52  0000               _TIM2_DeInit:
  56                     ; 54   TIM2->CR1 = (uint8_t)TIM2_CR1_RESET_VALUE;
  58  0000 725f5300      	clr	21248
  59                     ; 55   TIM2->IER = (uint8_t)TIM2_IER_RESET_VALUE;
  61  0004 725f5303      	clr	21251
  62                     ; 56   TIM2->SR2 = (uint8_t)TIM2_SR2_RESET_VALUE;
  64  0008 725f5305      	clr	21253
  65                     ; 59   TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  67  000c 725f530a      	clr	21258
  68                     ; 60   TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  70  0010 725f530b      	clr	21259
  71                     ; 64   TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  73  0014 725f530a      	clr	21258
  74                     ; 65   TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  76  0018 725f530b      	clr	21259
  77                     ; 66   TIM2->CCMR1 = (uint8_t)TIM2_CCMR1_RESET_VALUE;
  79  001c 725f5307      	clr	21255
  80                     ; 67   TIM2->CCMR2 = (uint8_t)TIM2_CCMR2_RESET_VALUE;
  82  0020 725f5308      	clr	21256
  83                     ; 68   TIM2->CCMR3 = (uint8_t)TIM2_CCMR3_RESET_VALUE;
  85  0024 725f5309      	clr	21257
  86                     ; 69   TIM2->CNTRH = (uint8_t)TIM2_CNTRH_RESET_VALUE;
  88  0028 725f530c      	clr	21260
  89                     ; 70   TIM2->CNTRL = (uint8_t)TIM2_CNTRL_RESET_VALUE;
  91  002c 725f530d      	clr	21261
  92                     ; 71   TIM2->PSCR = (uint8_t)TIM2_PSCR_RESET_VALUE;
  94  0030 725f530e      	clr	21262
  95                     ; 72   TIM2->ARRH  = (uint8_t)TIM2_ARRH_RESET_VALUE;
  97  0034 35ff530f      	mov	21263,#255
  98                     ; 73   TIM2->ARRL  = (uint8_t)TIM2_ARRL_RESET_VALUE;
 100  0038 35ff5310      	mov	21264,#255
 101                     ; 74   TIM2->CCR1H = (uint8_t)TIM2_CCR1H_RESET_VALUE;
 103  003c 725f5311      	clr	21265
 104                     ; 75   TIM2->CCR1L = (uint8_t)TIM2_CCR1L_RESET_VALUE;
 106  0040 725f5312      	clr	21266
 107                     ; 76   TIM2->CCR2H = (uint8_t)TIM2_CCR2H_RESET_VALUE;
 109  0044 725f5313      	clr	21267
 110                     ; 77   TIM2->CCR2L = (uint8_t)TIM2_CCR2L_RESET_VALUE;
 112  0048 725f5314      	clr	21268
 113                     ; 78   TIM2->CCR3H = (uint8_t)TIM2_CCR3H_RESET_VALUE;
 115  004c 725f5315      	clr	21269
 116                     ; 79   TIM2->CCR3L = (uint8_t)TIM2_CCR3L_RESET_VALUE;
 118  0050 725f5316      	clr	21270
 119                     ; 80   TIM2->SR1 = (uint8_t)TIM2_SR1_RESET_VALUE;
 121  0054 725f5304      	clr	21252
 122                     ; 81 }
 125  0058 81            	ret	
 293                     ; 89 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 293                     ; 90                         uint16_t TIM2_Period)
 293                     ; 91 {
 294                     .text:	section	.text,new
 295  0000               _TIM2_TimeBaseInit:
 297       ffffffff      OFST: set -1
 300                     ; 93   TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 302  0000 c7530e        	ld	21262,a
 303                     ; 95   TIM2->ARRH = (uint8_t)(TIM2_Period >> 8);
 305  0003 7b03          	ld	a,(OFST+4,sp)
 306  0005 c7530f        	ld	21263,a
 307                     ; 96   TIM2->ARRL = (uint8_t)(TIM2_Period);
 309  0008 7b04          	ld	a,(OFST+5,sp)
 310  000a c75310        	ld	21264,a
 311                     ; 97 }
 314  000d 81            	ret	
 471                     ; 108 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 471                     ; 109                   TIM2_OutputState_TypeDef TIM2_OutputState,
 471                     ; 110                   uint16_t TIM2_Pulse,
 471                     ; 111                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 471                     ; 112 {
 472                     .text:	section	.text,new
 473  0000               _TIM2_OC1Init:
 475  0000 89            	pushw	x
 476  0001 88            	push	a
 477       00000001      OFST:	set	1
 480                     ; 114   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 482                     ; 115   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 484                     ; 116   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 486                     ; 119   TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
 488  0002 c6530a        	ld	a,21258
 489  0005 a4fc          	and	a,#252
 490  0007 c7530a        	ld	21258,a
 491                     ; 121   TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER1_CC1E ) | 
 491                     ; 122                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC1P));
 493  000a 7b08          	ld	a,(OFST+7,sp)
 494  000c a402          	and	a,#2
 495  000e 6b01          	ld	(OFST+0,sp),a
 497  0010 9f            	ld	a,xl
 498  0011 a401          	and	a,#1
 499  0013 1a01          	or	a,(OFST+0,sp)
 500  0015 ca530a        	or	a,21258
 501  0018 c7530a        	ld	21258,a
 502                     ; 125   TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM)) |
 502                     ; 126                           (uint8_t)TIM2_OCMode);
 504  001b c65307        	ld	a,21255
 505  001e a48f          	and	a,#143
 506  0020 1a02          	or	a,(OFST+1,sp)
 507  0022 c75307        	ld	21255,a
 508                     ; 129   TIM2->CCR1H = (uint8_t)(TIM2_Pulse >> 8);
 510  0025 7b06          	ld	a,(OFST+5,sp)
 511  0027 c75311        	ld	21265,a
 512                     ; 130   TIM2->CCR1L = (uint8_t)(TIM2_Pulse);
 514  002a 7b07          	ld	a,(OFST+6,sp)
 515  002c c75312        	ld	21266,a
 516                     ; 131 }
 519  002f 5b03          	addw	sp,#3
 520  0031 81            	ret	
 584                     ; 142 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 584                     ; 143                   TIM2_OutputState_TypeDef TIM2_OutputState,
 584                     ; 144                   uint16_t TIM2_Pulse,
 584                     ; 145                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 584                     ; 146 {
 585                     .text:	section	.text,new
 586  0000               _TIM2_OC2Init:
 588  0000 89            	pushw	x
 589  0001 88            	push	a
 590       00000001      OFST:	set	1
 593                     ; 148   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 595                     ; 149   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 597                     ; 150   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 599                     ; 154   TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC2E |  TIM2_CCER1_CC2P ));
 601  0002 c6530a        	ld	a,21258
 602  0005 a4cf          	and	a,#207
 603  0007 c7530a        	ld	21258,a
 604                     ; 156   TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState  & TIM2_CCER1_CC2E ) |
 604                     ; 157                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC2P));
 606  000a 7b08          	ld	a,(OFST+7,sp)
 607  000c a420          	and	a,#32
 608  000e 6b01          	ld	(OFST+0,sp),a
 610  0010 9f            	ld	a,xl
 611  0011 a410          	and	a,#16
 612  0013 1a01          	or	a,(OFST+0,sp)
 613  0015 ca530a        	or	a,21258
 614  0018 c7530a        	ld	21258,a
 615                     ; 161   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM)) | 
 615                     ; 162                           (uint8_t)TIM2_OCMode);
 617  001b c65308        	ld	a,21256
 618  001e a48f          	and	a,#143
 619  0020 1a02          	or	a,(OFST+1,sp)
 620  0022 c75308        	ld	21256,a
 621                     ; 166   TIM2->CCR2H = (uint8_t)(TIM2_Pulse >> 8);
 623  0025 7b06          	ld	a,(OFST+5,sp)
 624  0027 c75313        	ld	21267,a
 625                     ; 167   TIM2->CCR2L = (uint8_t)(TIM2_Pulse);
 627  002a 7b07          	ld	a,(OFST+6,sp)
 628  002c c75314        	ld	21268,a
 629                     ; 168 }
 632  002f 5b03          	addw	sp,#3
 633  0031 81            	ret	
 697                     ; 179 void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 697                     ; 180                   TIM2_OutputState_TypeDef TIM2_OutputState,
 697                     ; 181                   uint16_t TIM2_Pulse,
 697                     ; 182                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 697                     ; 183 {
 698                     .text:	section	.text,new
 699  0000               _TIM2_OC3Init:
 701  0000 89            	pushw	x
 702  0001 88            	push	a
 703       00000001      OFST:	set	1
 706                     ; 185   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 708                     ; 186   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 710                     ; 187   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 712                     ; 189   TIM2->CCER2 &= (uint8_t)(~( TIM2_CCER2_CC3E  | TIM2_CCER2_CC3P));
 714  0002 c6530b        	ld	a,21259
 715  0005 a4fc          	and	a,#252
 716  0007 c7530b        	ld	21259,a
 717                     ; 191   TIM2->CCER2 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER2_CC3E) |  
 717                     ; 192                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER2_CC3P));
 719  000a 7b08          	ld	a,(OFST+7,sp)
 720  000c a402          	and	a,#2
 721  000e 6b01          	ld	(OFST+0,sp),a
 723  0010 9f            	ld	a,xl
 724  0011 a401          	and	a,#1
 725  0013 1a01          	or	a,(OFST+0,sp)
 726  0015 ca530b        	or	a,21259
 727  0018 c7530b        	ld	21259,a
 728                     ; 195   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM)) |
 728                     ; 196                           (uint8_t)TIM2_OCMode);
 730  001b c65309        	ld	a,21257
 731  001e a48f          	and	a,#143
 732  0020 1a02          	or	a,(OFST+1,sp)
 733  0022 c75309        	ld	21257,a
 734                     ; 199   TIM2->CCR3H = (uint8_t)(TIM2_Pulse >> 8);
 736  0025 7b06          	ld	a,(OFST+5,sp)
 737  0027 c75315        	ld	21269,a
 738                     ; 200   TIM2->CCR3L = (uint8_t)(TIM2_Pulse);
 740  002a 7b07          	ld	a,(OFST+6,sp)
 741  002c c75316        	ld	21270,a
 742                     ; 201 }
 745  002f 5b03          	addw	sp,#3
 746  0031 81            	ret	
 939                     ; 212 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
 939                     ; 213                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
 939                     ; 214                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
 939                     ; 215                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
 939                     ; 216                  uint8_t TIM2_ICFilter)
 939                     ; 217 {
 940                     .text:	section	.text,new
 941  0000               _TIM2_ICInit:
 943  0000 89            	pushw	x
 944       00000000      OFST:	set	0
 947                     ; 219   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
 949                     ; 220   assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
 951                     ; 221   assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
 953                     ; 222   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
 955                     ; 223   assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));
 957                     ; 225   if (TIM2_Channel == TIM2_CHANNEL_1)
 959  0001 9e            	ld	a,xh
 960  0002 4d            	tnz	a
 961  0003 2614          	jrne	L104
 962                     ; 228     TI1_Config((uint8_t)TIM2_ICPolarity,
 962                     ; 229                (uint8_t)TIM2_ICSelection,
 962                     ; 230                (uint8_t)TIM2_ICFilter);
 964  0005 7b07          	ld	a,(OFST+7,sp)
 965  0007 88            	push	a
 966  0008 7b06          	ld	a,(OFST+6,sp)
 967  000a 97            	ld	xl,a
 968  000b 7b03          	ld	a,(OFST+3,sp)
 969  000d 95            	ld	xh,a
 970  000e cd0000        	call	L3_TI1_Config
 972  0011 84            	pop	a
 973                     ; 233     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
 975  0012 7b06          	ld	a,(OFST+6,sp)
 976  0014 cd0000        	call	_TIM2_SetIC1Prescaler
 979  0017 202b          	jra	L304
 980  0019               L104:
 981                     ; 235   else if (TIM2_Channel == TIM2_CHANNEL_2)
 983  0019 7b01          	ld	a,(OFST+1,sp)
 984  001b 4a            	dec	a
 985  001c 2614          	jrne	L504
 986                     ; 238     TI2_Config((uint8_t)TIM2_ICPolarity,
 986                     ; 239                (uint8_t)TIM2_ICSelection,
 986                     ; 240                (uint8_t)TIM2_ICFilter);
 988  001e 7b07          	ld	a,(OFST+7,sp)
 989  0020 88            	push	a
 990  0021 7b06          	ld	a,(OFST+6,sp)
 991  0023 97            	ld	xl,a
 992  0024 7b03          	ld	a,(OFST+3,sp)
 993  0026 95            	ld	xh,a
 994  0027 cd0000        	call	L5_TI2_Config
 996  002a 84            	pop	a
 997                     ; 243     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
 999  002b 7b06          	ld	a,(OFST+6,sp)
1000  002d cd0000        	call	_TIM2_SetIC2Prescaler
1003  0030 2012          	jra	L304
1004  0032               L504:
1005                     ; 248     TI3_Config((uint8_t)TIM2_ICPolarity,
1005                     ; 249                (uint8_t)TIM2_ICSelection,
1005                     ; 250                (uint8_t)TIM2_ICFilter);
1007  0032 7b07          	ld	a,(OFST+7,sp)
1008  0034 88            	push	a
1009  0035 7b06          	ld	a,(OFST+6,sp)
1010  0037 97            	ld	xl,a
1011  0038 7b03          	ld	a,(OFST+3,sp)
1012  003a 95            	ld	xh,a
1013  003b cd0000        	call	L7_TI3_Config
1015  003e 84            	pop	a
1016                     ; 253     TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
1018  003f 7b06          	ld	a,(OFST+6,sp)
1019  0041 cd0000        	call	_TIM2_SetIC3Prescaler
1021  0044               L304:
1022                     ; 255 }
1025  0044 85            	popw	x
1026  0045 81            	ret	
1122                     ; 266 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
1122                     ; 267                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1122                     ; 268                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
1122                     ; 269                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1122                     ; 270                      uint8_t TIM2_ICFilter)
1122                     ; 271 {
1123                     .text:	section	.text,new
1124  0000               _TIM2_PWMIConfig:
1126  0000 89            	pushw	x
1127  0001 89            	pushw	x
1128       00000002      OFST:	set	2
1131                     ; 272   uint8_t icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1133                     ; 273   uint8_t icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1135                     ; 276   assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_Channel));
1137                     ; 277   assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1139                     ; 278   assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1141                     ; 279   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1143                     ; 282   if (TIM2_ICPolarity != TIM2_ICPOLARITY_FALLING)
1145  0002 9f            	ld	a,xl
1146  0003 a144          	cp	a,#68
1147  0005 2706          	jreq	L754
1148                     ; 284     icpolarity = (uint8_t)TIM2_ICPOLARITY_FALLING;
1150  0007 a644          	ld	a,#68
1151  0009 6b01          	ld	(OFST-1,sp),a
1154  000b 2002          	jra	L164
1155  000d               L754:
1156                     ; 288     icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1158  000d 0f01          	clr	(OFST-1,sp)
1160  000f               L164:
1161                     ; 292   if (TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
1163  000f 7b07          	ld	a,(OFST+5,sp)
1164  0011 4a            	dec	a
1165  0012 2604          	jrne	L364
1166                     ; 294     icselection = (uint8_t)TIM2_ICSELECTION_INDIRECTTI;
1168  0014 a602          	ld	a,#2
1170  0016 2002          	jra	L564
1171  0018               L364:
1172                     ; 298     icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1174  0018 a601          	ld	a,#1
1175  001a               L564:
1176  001a 6b02          	ld	(OFST+0,sp),a
1178                     ; 301   if (TIM2_Channel == TIM2_CHANNEL_1)
1180  001c 7b03          	ld	a,(OFST+1,sp)
1181  001e 2626          	jrne	L764
1182                     ; 304     TI1_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1182                     ; 305                (uint8_t)TIM2_ICFilter);
1184  0020 7b09          	ld	a,(OFST+7,sp)
1185  0022 88            	push	a
1186  0023 7b08          	ld	a,(OFST+6,sp)
1187  0025 97            	ld	xl,a
1188  0026 7b05          	ld	a,(OFST+3,sp)
1189  0028 95            	ld	xh,a
1190  0029 cd0000        	call	L3_TI1_Config
1192  002c 84            	pop	a
1193                     ; 308     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1195  002d 7b08          	ld	a,(OFST+6,sp)
1196  002f cd0000        	call	_TIM2_SetIC1Prescaler
1198                     ; 311     TI2_Config(icpolarity, icselection, TIM2_ICFilter);
1200  0032 7b09          	ld	a,(OFST+7,sp)
1201  0034 88            	push	a
1202  0035 7b03          	ld	a,(OFST+1,sp)
1203  0037 97            	ld	xl,a
1204  0038 7b02          	ld	a,(OFST+0,sp)
1205  003a 95            	ld	xh,a
1206  003b cd0000        	call	L5_TI2_Config
1208  003e 84            	pop	a
1209                     ; 314     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1211  003f 7b08          	ld	a,(OFST+6,sp)
1212  0041 cd0000        	call	_TIM2_SetIC2Prescaler
1215  0044 2024          	jra	L174
1216  0046               L764:
1217                     ; 319     TI2_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1217                     ; 320                (uint8_t)TIM2_ICFilter);
1219  0046 7b09          	ld	a,(OFST+7,sp)
1220  0048 88            	push	a
1221  0049 7b08          	ld	a,(OFST+6,sp)
1222  004b 97            	ld	xl,a
1223  004c 7b05          	ld	a,(OFST+3,sp)
1224  004e 95            	ld	xh,a
1225  004f cd0000        	call	L5_TI2_Config
1227  0052 84            	pop	a
1228                     ; 323     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1230  0053 7b08          	ld	a,(OFST+6,sp)
1231  0055 cd0000        	call	_TIM2_SetIC2Prescaler
1233                     ; 326     TI1_Config((uint8_t)icpolarity, icselection, (uint8_t)TIM2_ICFilter);
1235  0058 7b09          	ld	a,(OFST+7,sp)
1236  005a 88            	push	a
1237  005b 7b03          	ld	a,(OFST+1,sp)
1238  005d 97            	ld	xl,a
1239  005e 7b02          	ld	a,(OFST+0,sp)
1240  0060 95            	ld	xh,a
1241  0061 cd0000        	call	L3_TI1_Config
1243  0064 84            	pop	a
1244                     ; 329     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1246  0065 7b08          	ld	a,(OFST+6,sp)
1247  0067 cd0000        	call	_TIM2_SetIC1Prescaler
1249  006a               L174:
1250                     ; 331 }
1253  006a 5b04          	addw	sp,#4
1254  006c 81            	ret	
1309                     ; 339 void TIM2_Cmd(FunctionalState NewState)
1309                     ; 340 {
1310                     .text:	section	.text,new
1311  0000               _TIM2_Cmd:
1315                     ; 342   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1317                     ; 345   if (NewState != DISABLE)
1319  0000 4d            	tnz	a
1320  0001 2705          	jreq	L125
1321                     ; 347     TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
1323  0003 72105300      	bset	21248,#0
1326  0007 81            	ret	
1327  0008               L125:
1328                     ; 351     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_CEN);
1330  0008 72115300      	bres	21248,#0
1331                     ; 353 }
1334  000c 81            	ret	
1413                     ; 368 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
1413                     ; 369 {
1414                     .text:	section	.text,new
1415  0000               _TIM2_ITConfig:
1417  0000 89            	pushw	x
1418       00000000      OFST:	set	0
1421                     ; 371   assert_param(IS_TIM2_IT_OK(TIM2_IT));
1423                     ; 372   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1425                     ; 374   if (NewState != DISABLE)
1427  0001 9f            	ld	a,xl
1428  0002 4d            	tnz	a
1429  0003 2706          	jreq	L365
1430                     ; 377     TIM2->IER |= (uint8_t)TIM2_IT;
1432  0005 9e            	ld	a,xh
1433  0006 ca5303        	or	a,21251
1435  0009 2006          	jra	L565
1436  000b               L365:
1437                     ; 382     TIM2->IER &= (uint8_t)(~TIM2_IT);
1439  000b 7b01          	ld	a,(OFST+1,sp)
1440  000d 43            	cpl	a
1441  000e c45303        	and	a,21251
1442  0011               L565:
1443  0011 c75303        	ld	21251,a
1444                     ; 384 }
1447  0014 85            	popw	x
1448  0015 81            	ret	
1484                     ; 392 void TIM2_UpdateDisableConfig(FunctionalState NewState)
1484                     ; 393 {
1485                     .text:	section	.text,new
1486  0000               _TIM2_UpdateDisableConfig:
1490                     ; 395   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1492                     ; 398   if (NewState != DISABLE)
1494  0000 4d            	tnz	a
1495  0001 2705          	jreq	L506
1496                     ; 400     TIM2->CR1 |= (uint8_t)TIM2_CR1_UDIS;
1498  0003 72125300      	bset	21248,#1
1501  0007 81            	ret	
1502  0008               L506:
1503                     ; 404     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_UDIS);
1505  0008 72135300      	bres	21248,#1
1506                     ; 406 }
1509  000c 81            	ret	
1567                     ; 416 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
1567                     ; 417 {
1568                     .text:	section	.text,new
1569  0000               _TIM2_UpdateRequestConfig:
1573                     ; 419   assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));
1575                     ; 422   if (TIM2_UpdateSource != TIM2_UPDATESOURCE_GLOBAL)
1577  0000 4d            	tnz	a
1578  0001 2705          	jreq	L736
1579                     ; 424     TIM2->CR1 |= (uint8_t)TIM2_CR1_URS;
1581  0003 72145300      	bset	21248,#2
1584  0007 81            	ret	
1585  0008               L736:
1586                     ; 428     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_URS);
1588  0008 72155300      	bres	21248,#2
1589                     ; 430 }
1592  000c 81            	ret	
1649                     ; 440 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
1649                     ; 441 {
1650                     .text:	section	.text,new
1651  0000               _TIM2_SelectOnePulseMode:
1655                     ; 443   assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));
1657                     ; 446   if (TIM2_OPMode != TIM2_OPMODE_REPETITIVE)
1659  0000 4d            	tnz	a
1660  0001 2705          	jreq	L176
1661                     ; 448     TIM2->CR1 |= (uint8_t)TIM2_CR1_OPM;
1663  0003 72165300      	bset	21248,#3
1666  0007 81            	ret	
1667  0008               L176:
1668                     ; 452     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_OPM);
1670  0008 72175300      	bres	21248,#3
1671                     ; 454 }
1674  000c 81            	ret	
1742                     ; 484 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
1742                     ; 485                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
1742                     ; 486 {
1743                     .text:	section	.text,new
1744  0000               _TIM2_PrescalerConfig:
1748                     ; 488   assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
1750                     ; 489   assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
1752                     ; 492   TIM2->PSCR = (uint8_t)Prescaler;
1754  0000 9e            	ld	a,xh
1755  0001 c7530e        	ld	21262,a
1756                     ; 495   TIM2->EGR = (uint8_t)TIM2_PSCReloadMode;
1758  0004 9f            	ld	a,xl
1759  0005 c75306        	ld	21254,a
1760                     ; 496 }
1763  0008 81            	ret	
1821                     ; 507 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1821                     ; 508 {
1822                     .text:	section	.text,new
1823  0000               _TIM2_ForcedOC1Config:
1825  0000 88            	push	a
1826       00000000      OFST:	set	0
1829                     ; 510   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1831                     ; 513   TIM2->CCMR1  =  (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))  
1831                     ; 514                             | (uint8_t)TIM2_ForcedAction);
1833  0001 c65307        	ld	a,21255
1834  0004 a48f          	and	a,#143
1835  0006 1a01          	or	a,(OFST+1,sp)
1836  0008 c75307        	ld	21255,a
1837                     ; 515 }
1840  000b 84            	pop	a
1841  000c 81            	ret	
1877                     ; 526 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1877                     ; 527 {
1878                     .text:	section	.text,new
1879  0000               _TIM2_ForcedOC2Config:
1881  0000 88            	push	a
1882       00000000      OFST:	set	0
1885                     ; 529   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1887                     ; 532   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))  
1887                     ; 533                           | (uint8_t)TIM2_ForcedAction);
1889  0001 c65308        	ld	a,21256
1890  0004 a48f          	and	a,#143
1891  0006 1a01          	or	a,(OFST+1,sp)
1892  0008 c75308        	ld	21256,a
1893                     ; 534 }
1896  000b 84            	pop	a
1897  000c 81            	ret	
1933                     ; 545 void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1933                     ; 546 {
1934                     .text:	section	.text,new
1935  0000               _TIM2_ForcedOC3Config:
1937  0000 88            	push	a
1938       00000000      OFST:	set	0
1941                     ; 548   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1943                     ; 551   TIM2->CCMR3  =  (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
1943                     ; 552                             | (uint8_t)TIM2_ForcedAction);
1945  0001 c65309        	ld	a,21257
1946  0004 a48f          	and	a,#143
1947  0006 1a01          	or	a,(OFST+1,sp)
1948  0008 c75309        	ld	21257,a
1949                     ; 553 }
1952  000b 84            	pop	a
1953  000c 81            	ret	
1989                     ; 561 void TIM2_ARRPreloadConfig(FunctionalState NewState)
1989                     ; 562 {
1990                     .text:	section	.text,new
1991  0000               _TIM2_ARRPreloadConfig:
1995                     ; 564   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1997                     ; 567   if (NewState != DISABLE)
1999  0000 4d            	tnz	a
2000  0001 2705          	jreq	L7201
2001                     ; 569     TIM2->CR1 |= (uint8_t)TIM2_CR1_ARPE;
2003  0003 721e5300      	bset	21248,#7
2006  0007 81            	ret	
2007  0008               L7201:
2008                     ; 573     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_ARPE);
2010  0008 721f5300      	bres	21248,#7
2011                     ; 575 }
2014  000c 81            	ret	
2050                     ; 583 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2050                     ; 584 {
2051                     .text:	section	.text,new
2052  0000               _TIM2_OC1PreloadConfig:
2056                     ; 586   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2058                     ; 589   if (NewState != DISABLE)
2060  0000 4d            	tnz	a
2061  0001 2705          	jreq	L1501
2062                     ; 591     TIM2->CCMR1 |= (uint8_t)TIM2_CCMR_OCxPE;
2064  0003 72165307      	bset	21255,#3
2067  0007 81            	ret	
2068  0008               L1501:
2069                     ; 595     TIM2->CCMR1 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2071  0008 72175307      	bres	21255,#3
2072                     ; 597 }
2075  000c 81            	ret	
2111                     ; 605 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2111                     ; 606 {
2112                     .text:	section	.text,new
2113  0000               _TIM2_OC2PreloadConfig:
2117                     ; 608   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2119                     ; 611   if (NewState != DISABLE)
2121  0000 4d            	tnz	a
2122  0001 2705          	jreq	L3701
2123                     ; 613     TIM2->CCMR2 |= (uint8_t)TIM2_CCMR_OCxPE;
2125  0003 72165308      	bset	21256,#3
2128  0007 81            	ret	
2129  0008               L3701:
2130                     ; 617     TIM2->CCMR2 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2132  0008 72175308      	bres	21256,#3
2133                     ; 619 }
2136  000c 81            	ret	
2172                     ; 627 void TIM2_OC3PreloadConfig(FunctionalState NewState)
2172                     ; 628 {
2173                     .text:	section	.text,new
2174  0000               _TIM2_OC3PreloadConfig:
2178                     ; 630   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2180                     ; 633   if (NewState != DISABLE)
2182  0000 4d            	tnz	a
2183  0001 2705          	jreq	L5111
2184                     ; 635     TIM2->CCMR3 |= (uint8_t)TIM2_CCMR_OCxPE;
2186  0003 72165309      	bset	21257,#3
2189  0007 81            	ret	
2190  0008               L5111:
2191                     ; 639     TIM2->CCMR3 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2193  0008 72175309      	bres	21257,#3
2194                     ; 641 }
2197  000c 81            	ret	
2270                     ; 653 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
2270                     ; 654 {
2271                     .text:	section	.text,new
2272  0000               _TIM2_GenerateEvent:
2276                     ; 656   assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
2278                     ; 659   TIM2->EGR = (uint8_t)TIM2_EventSource;
2280  0000 c75306        	ld	21254,a
2281                     ; 660 }
2284  0003 81            	ret	
2320                     ; 670 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2320                     ; 671 {
2321                     .text:	section	.text,new
2322  0000               _TIM2_OC1PolarityConfig:
2326                     ; 673   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2328                     ; 676   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2330  0000 4d            	tnz	a
2331  0001 2705          	jreq	L1711
2332                     ; 678     TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1P;
2334  0003 7212530a      	bset	21258,#1
2337  0007 81            	ret	
2338  0008               L1711:
2339                     ; 682     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
2341  0008 7213530a      	bres	21258,#1
2342                     ; 684 }
2345  000c 81            	ret	
2381                     ; 694 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2381                     ; 695 {
2382                     .text:	section	.text,new
2383  0000               _TIM2_OC2PolarityConfig:
2387                     ; 697   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2389                     ; 700   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2391  0000 4d            	tnz	a
2392  0001 2705          	jreq	L3121
2393                     ; 702     TIM2->CCER1 |= TIM2_CCER1_CC2P;
2395  0003 721a530a      	bset	21258,#5
2398  0007 81            	ret	
2399  0008               L3121:
2400                     ; 706     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
2402  0008 721b530a      	bres	21258,#5
2403                     ; 708 }
2406  000c 81            	ret	
2442                     ; 718 void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2442                     ; 719 {
2443                     .text:	section	.text,new
2444  0000               _TIM2_OC3PolarityConfig:
2448                     ; 721   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2450                     ; 724   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2452  0000 4d            	tnz	a
2453  0001 2705          	jreq	L5321
2454                     ; 726     TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3P;
2456  0003 7212530b      	bset	21259,#1
2459  0007 81            	ret	
2460  0008               L5321:
2461                     ; 730     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
2463  0008 7213530b      	bres	21259,#1
2464                     ; 732 }
2467  000c 81            	ret	
2512                     ; 745 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState)
2512                     ; 746 {
2513                     .text:	section	.text,new
2514  0000               _TIM2_CCxCmd:
2516  0000 89            	pushw	x
2517       00000000      OFST:	set	0
2520                     ; 748   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2522                     ; 749   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2524                     ; 751   if (TIM2_Channel == TIM2_CHANNEL_1)
2526  0001 9e            	ld	a,xh
2527  0002 4d            	tnz	a
2528  0003 2610          	jrne	L3621
2529                     ; 754     if (NewState != DISABLE)
2531  0005 9f            	ld	a,xl
2532  0006 4d            	tnz	a
2533  0007 2706          	jreq	L5621
2534                     ; 756       TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1E;
2536  0009 7210530a      	bset	21258,#0
2538  000d 2029          	jra	L1721
2539  000f               L5621:
2540                     ; 760       TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2542  000f 7211530a      	bres	21258,#0
2543  0013 2023          	jra	L1721
2544  0015               L3621:
2545                     ; 764   else if (TIM2_Channel == TIM2_CHANNEL_2)
2547  0015 7b01          	ld	a,(OFST+1,sp)
2548  0017 4a            	dec	a
2549  0018 2610          	jrne	L3721
2550                     ; 767     if (NewState != DISABLE)
2552  001a 7b02          	ld	a,(OFST+2,sp)
2553  001c 2706          	jreq	L5721
2554                     ; 769       TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC2E;
2556  001e 7218530a      	bset	21258,#4
2558  0022 2014          	jra	L1721
2559  0024               L5721:
2560                     ; 773       TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2562  0024 7219530a      	bres	21258,#4
2563  0028 200e          	jra	L1721
2564  002a               L3721:
2565                     ; 779     if (NewState != DISABLE)
2567  002a 7b02          	ld	a,(OFST+2,sp)
2568  002c 2706          	jreq	L3031
2569                     ; 781       TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3E;
2571  002e 7210530b      	bset	21259,#0
2573  0032 2004          	jra	L1721
2574  0034               L3031:
2575                     ; 785       TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2577  0034 7211530b      	bres	21259,#0
2578  0038               L1721:
2579                     ; 788 }
2582  0038 85            	popw	x
2583  0039 81            	ret	
2628                     ; 810 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode)
2628                     ; 811 {
2629                     .text:	section	.text,new
2630  0000               _TIM2_SelectOCxM:
2632  0000 89            	pushw	x
2633       00000000      OFST:	set	0
2636                     ; 813   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2638                     ; 814   assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));
2640                     ; 816   if (TIM2_Channel == TIM2_CHANNEL_1)
2642  0001 9e            	ld	a,xh
2643  0002 4d            	tnz	a
2644  0003 2610          	jrne	L1331
2645                     ; 819     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2647  0005 7211530a      	bres	21258,#0
2648                     ; 822     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))
2648                     ; 823                             | (uint8_t)TIM2_OCMode);
2650  0009 c65307        	ld	a,21255
2651  000c a48f          	and	a,#143
2652  000e 1a02          	or	a,(OFST+2,sp)
2653  0010 c75307        	ld	21255,a
2655  0013 2023          	jra	L3331
2656  0015               L1331:
2657                     ; 825   else if (TIM2_Channel == TIM2_CHANNEL_2)
2659  0015 7b01          	ld	a,(OFST+1,sp)
2660  0017 4a            	dec	a
2661  0018 2610          	jrne	L5331
2662                     ; 828     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2664  001a 7219530a      	bres	21258,#4
2665                     ; 831     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))
2665                     ; 832                             | (uint8_t)TIM2_OCMode);
2667  001e c65308        	ld	a,21256
2668  0021 a48f          	and	a,#143
2669  0023 1a02          	or	a,(OFST+2,sp)
2670  0025 c75308        	ld	21256,a
2672  0028 200e          	jra	L3331
2673  002a               L5331:
2674                     ; 837     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2676  002a 7211530b      	bres	21259,#0
2677                     ; 840     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
2677                     ; 841                             | (uint8_t)TIM2_OCMode);
2679  002e c65309        	ld	a,21257
2680  0031 a48f          	and	a,#143
2681  0033 1a02          	or	a,(OFST+2,sp)
2682  0035 c75309        	ld	21257,a
2683  0038               L3331:
2684                     ; 843 }
2687  0038 85            	popw	x
2688  0039 81            	ret	
2722                     ; 851 void TIM2_SetCounter(uint16_t Counter)
2722                     ; 852 {
2723                     .text:	section	.text,new
2724  0000               _TIM2_SetCounter:
2728                     ; 854   TIM2->CNTRH = (uint8_t)(Counter >> 8);
2730  0000 9e            	ld	a,xh
2731  0001 c7530c        	ld	21260,a
2732                     ; 855   TIM2->CNTRL = (uint8_t)(Counter);
2734  0004 9f            	ld	a,xl
2735  0005 c7530d        	ld	21261,a
2736                     ; 856 }
2739  0008 81            	ret	
2773                     ; 864 void TIM2_SetAutoreload(uint16_t Autoreload)
2773                     ; 865 {
2774                     .text:	section	.text,new
2775  0000               _TIM2_SetAutoreload:
2779                     ; 867   TIM2->ARRH = (uint8_t)(Autoreload >> 8);
2781  0000 9e            	ld	a,xh
2782  0001 c7530f        	ld	21263,a
2783                     ; 868   TIM2->ARRL = (uint8_t)(Autoreload);
2785  0004 9f            	ld	a,xl
2786  0005 c75310        	ld	21264,a
2787                     ; 869 }
2790  0008 81            	ret	
2824                     ; 877 void TIM2_SetCompare1(uint16_t Compare1)
2824                     ; 878 {
2825                     .text:	section	.text,new
2826  0000               _TIM2_SetCompare1:
2830                     ; 880   TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
2832  0000 9e            	ld	a,xh
2833  0001 c75311        	ld	21265,a
2834                     ; 881   TIM2->CCR1L = (uint8_t)(Compare1);
2836  0004 9f            	ld	a,xl
2837  0005 c75312        	ld	21266,a
2838                     ; 882 }
2841  0008 81            	ret	
2875                     ; 890 void TIM2_SetCompare2(uint16_t Compare2)
2875                     ; 891 {
2876                     .text:	section	.text,new
2877  0000               _TIM2_SetCompare2:
2881                     ; 893   TIM2->CCR2H = (uint8_t)(Compare2 >> 8);
2883  0000 9e            	ld	a,xh
2884  0001 c75313        	ld	21267,a
2885                     ; 894   TIM2->CCR2L = (uint8_t)(Compare2);
2887  0004 9f            	ld	a,xl
2888  0005 c75314        	ld	21268,a
2889                     ; 895 }
2892  0008 81            	ret	
2926                     ; 903 void TIM2_SetCompare3(uint16_t Compare3)
2926                     ; 904 {
2927                     .text:	section	.text,new
2928  0000               _TIM2_SetCompare3:
2932                     ; 906   TIM2->CCR3H = (uint8_t)(Compare3 >> 8);
2934  0000 9e            	ld	a,xh
2935  0001 c75315        	ld	21269,a
2936                     ; 907   TIM2->CCR3L = (uint8_t)(Compare3);
2938  0004 9f            	ld	a,xl
2939  0005 c75316        	ld	21270,a
2940                     ; 908 }
2943  0008 81            	ret	
2979                     ; 920 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
2979                     ; 921 {
2980                     .text:	section	.text,new
2981  0000               _TIM2_SetIC1Prescaler:
2983  0000 88            	push	a
2984       00000000      OFST:	set	0
2987                     ; 923   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));
2989                     ; 926   TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_ICxPSC))
2989                     ; 927                           | (uint8_t)TIM2_IC1Prescaler);
2991  0001 c65307        	ld	a,21255
2992  0004 a4f3          	and	a,#243
2993  0006 1a01          	or	a,(OFST+1,sp)
2994  0008 c75307        	ld	21255,a
2995                     ; 928 }
2998  000b 84            	pop	a
2999  000c 81            	ret	
3035                     ; 940 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
3035                     ; 941 {
3036                     .text:	section	.text,new
3037  0000               _TIM2_SetIC2Prescaler:
3039  0000 88            	push	a
3040       00000000      OFST:	set	0
3043                     ; 943   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));
3045                     ; 946   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3045                     ; 947                           | (uint8_t)TIM2_IC2Prescaler);
3047  0001 c65308        	ld	a,21256
3048  0004 a4f3          	and	a,#243
3049  0006 1a01          	or	a,(OFST+1,sp)
3050  0008 c75308        	ld	21256,a
3051                     ; 948 }
3054  000b 84            	pop	a
3055  000c 81            	ret	
3091                     ; 960 void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
3091                     ; 961 {
3092                     .text:	section	.text,new
3093  0000               _TIM2_SetIC3Prescaler:
3095  0000 88            	push	a
3096       00000000      OFST:	set	0
3099                     ; 964   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
3101                     ; 966   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3101                     ; 967                           | (uint8_t)TIM2_IC3Prescaler);
3103  0001 c65309        	ld	a,21257
3104  0004 a4f3          	and	a,#243
3105  0006 1a01          	or	a,(OFST+1,sp)
3106  0008 c75309        	ld	21257,a
3107                     ; 968 }
3110  000b 84            	pop	a
3111  000c 81            	ret	
3163                     ; 975 uint16_t TIM2_GetCapture1(void)
3163                     ; 976 {
3164                     .text:	section	.text,new
3165  0000               _TIM2_GetCapture1:
3167  0000 5204          	subw	sp,#4
3168       00000004      OFST:	set	4
3171                     ; 978   uint16_t tmpccr1 = 0;
3173                     ; 979   uint8_t tmpccr1l=0, tmpccr1h=0;
3177                     ; 981   tmpccr1h = TIM2->CCR1H;
3179  0002 c65311        	ld	a,21265
3180  0005 6b02          	ld	(OFST-2,sp),a
3182                     ; 982   tmpccr1l = TIM2->CCR1L;
3184  0007 c65312        	ld	a,21266
3185  000a 6b01          	ld	(OFST-3,sp),a
3187                     ; 984   tmpccr1 = (uint16_t)(tmpccr1l);
3189  000c 5f            	clrw	x
3190  000d 97            	ld	xl,a
3191  000e 1f03          	ldw	(OFST-1,sp),x
3193                     ; 985   tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
3195  0010 5f            	clrw	x
3196  0011 7b02          	ld	a,(OFST-2,sp)
3197  0013 97            	ld	xl,a
3198  0014 7b04          	ld	a,(OFST+0,sp)
3199  0016 01            	rrwa	x,a
3200  0017 1a03          	or	a,(OFST-1,sp)
3201  0019 01            	rrwa	x,a
3203                     ; 987   return (uint16_t)tmpccr1;
3207  001a 5b04          	addw	sp,#4
3208  001c 81            	ret	
3260                     ; 995 uint16_t TIM2_GetCapture2(void)
3260                     ; 996 {
3261                     .text:	section	.text,new
3262  0000               _TIM2_GetCapture2:
3264  0000 5204          	subw	sp,#4
3265       00000004      OFST:	set	4
3268                     ; 998   uint16_t tmpccr2 = 0;
3270                     ; 999   uint8_t tmpccr2l=0, tmpccr2h=0;
3274                     ; 1001   tmpccr2h = TIM2->CCR2H;
3276  0002 c65313        	ld	a,21267
3277  0005 6b02          	ld	(OFST-2,sp),a
3279                     ; 1002   tmpccr2l = TIM2->CCR2L;
3281  0007 c65314        	ld	a,21268
3282  000a 6b01          	ld	(OFST-3,sp),a
3284                     ; 1004   tmpccr2 = (uint16_t)(tmpccr2l);
3286  000c 5f            	clrw	x
3287  000d 97            	ld	xl,a
3288  000e 1f03          	ldw	(OFST-1,sp),x
3290                     ; 1005   tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
3292  0010 5f            	clrw	x
3293  0011 7b02          	ld	a,(OFST-2,sp)
3294  0013 97            	ld	xl,a
3295  0014 7b04          	ld	a,(OFST+0,sp)
3296  0016 01            	rrwa	x,a
3297  0017 1a03          	or	a,(OFST-1,sp)
3298  0019 01            	rrwa	x,a
3300                     ; 1007   return (uint16_t)tmpccr2;
3304  001a 5b04          	addw	sp,#4
3305  001c 81            	ret	
3357                     ; 1015 uint16_t TIM2_GetCapture3(void)
3357                     ; 1016 {
3358                     .text:	section	.text,new
3359  0000               _TIM2_GetCapture3:
3361  0000 5204          	subw	sp,#4
3362       00000004      OFST:	set	4
3365                     ; 1018   uint16_t tmpccr3 = 0;
3367                     ; 1019   uint8_t tmpccr3l=0, tmpccr3h=0;
3371                     ; 1021   tmpccr3h = TIM2->CCR3H;
3373  0002 c65315        	ld	a,21269
3374  0005 6b02          	ld	(OFST-2,sp),a
3376                     ; 1022   tmpccr3l = TIM2->CCR3L;
3378  0007 c65316        	ld	a,21270
3379  000a 6b01          	ld	(OFST-3,sp),a
3381                     ; 1024   tmpccr3 = (uint16_t)(tmpccr3l);
3383  000c 5f            	clrw	x
3384  000d 97            	ld	xl,a
3385  000e 1f03          	ldw	(OFST-1,sp),x
3387                     ; 1025   tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
3389  0010 5f            	clrw	x
3390  0011 7b02          	ld	a,(OFST-2,sp)
3391  0013 97            	ld	xl,a
3392  0014 7b04          	ld	a,(OFST+0,sp)
3393  0016 01            	rrwa	x,a
3394  0017 1a03          	or	a,(OFST-1,sp)
3395  0019 01            	rrwa	x,a
3397                     ; 1027   return (uint16_t)tmpccr3;
3401  001a 5b04          	addw	sp,#4
3402  001c 81            	ret	
3436                     ; 1035 uint16_t TIM2_GetCounter(void)
3436                     ; 1036 {
3437                     .text:	section	.text,new
3438  0000               _TIM2_GetCounter:
3440  0000 89            	pushw	x
3441       00000002      OFST:	set	2
3444                     ; 1037   uint16_t tmpcntr = 0;
3446                     ; 1039   tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
3448  0001 c6530c        	ld	a,21260
3449  0004 97            	ld	xl,a
3450  0005 4f            	clr	a
3451  0006 02            	rlwa	x,a
3452  0007 1f01          	ldw	(OFST-1,sp),x
3454                     ; 1041   return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
3456  0009 c6530d        	ld	a,21261
3457  000c 5f            	clrw	x
3458  000d 97            	ld	xl,a
3459  000e 01            	rrwa	x,a
3460  000f 1a02          	or	a,(OFST+0,sp)
3461  0011 01            	rrwa	x,a
3462  0012 1a01          	or	a,(OFST-1,sp)
3463  0014 01            	rrwa	x,a
3466  0015 5b02          	addw	sp,#2
3467  0017 81            	ret	
3491                     ; 1049 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
3491                     ; 1050 {
3492                     .text:	section	.text,new
3493  0000               _TIM2_GetPrescaler:
3497                     ; 1052   return (TIM2_Prescaler_TypeDef)(TIM2->PSCR);
3499  0000 c6530e        	ld	a,21262
3502  0003 81            	ret	
3641                     ; 1068 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
3641                     ; 1069 {
3642                     .text:	section	.text,new
3643  0000               _TIM2_GetFlagStatus:
3645  0000 89            	pushw	x
3646  0001 89            	pushw	x
3647       00000002      OFST:	set	2
3650                     ; 1070   FlagStatus bitstatus = RESET;
3652                     ; 1071   uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
3656                     ; 1074   assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
3658                     ; 1076   tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_FLAG);
3660  0002 9f            	ld	a,xl
3661  0003 c45304        	and	a,21252
3662  0006 6b01          	ld	(OFST-1,sp),a
3664                     ; 1077   tim2_flag_h = (uint8_t)((uint16_t)TIM2_FLAG >> 8);
3666  0008 7b03          	ld	a,(OFST+1,sp)
3667  000a 6b02          	ld	(OFST+0,sp),a
3669                     ; 1079   if ((tim2_flag_l | (uint8_t)(TIM2->SR2 & tim2_flag_h)) != (uint8_t)RESET )
3671  000c c45305        	and	a,21253
3672  000f 1a01          	or	a,(OFST-1,sp)
3673  0011 2702          	jreq	L5371
3674                     ; 1081     bitstatus = SET;
3676  0013 a601          	ld	a,#1
3679  0015               L5371:
3680                     ; 1085     bitstatus = RESET;
3683                     ; 1087   return (FlagStatus)bitstatus;
3687  0015 5b04          	addw	sp,#4
3688  0017 81            	ret	
3723                     ; 1103 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
3723                     ; 1104 {
3724                     .text:	section	.text,new
3725  0000               _TIM2_ClearFlag:
3729                     ; 1106   assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
3731                     ; 1109   TIM2->SR1 = (uint8_t)(~((uint8_t)(TIM2_FLAG)));
3733  0000 9f            	ld	a,xl
3734  0001 43            	cpl	a
3735  0002 c75304        	ld	21252,a
3736                     ; 1110   TIM2->SR2 = (uint8_t)(~((uint8_t)((uint8_t)TIM2_FLAG >> 8)));
3738  0005 35ff5305      	mov	21253,#255
3739                     ; 1111 }
3742  0009 81            	ret	
3806                     ; 1123 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
3806                     ; 1124 {
3807                     .text:	section	.text,new
3808  0000               _TIM2_GetITStatus:
3810  0000 88            	push	a
3811  0001 89            	pushw	x
3812       00000002      OFST:	set	2
3815                     ; 1125   ITStatus bitstatus = RESET;
3817                     ; 1126   uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
3821                     ; 1129   assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
3823                     ; 1131   TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
3825  0002 c45304        	and	a,21252
3826  0005 6b01          	ld	(OFST-1,sp),a
3828                     ; 1133   TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
3830  0007 c65303        	ld	a,21251
3831  000a 1403          	and	a,(OFST+1,sp)
3832  000c 6b02          	ld	(OFST+0,sp),a
3834                     ; 1135   if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
3836  000e 7b01          	ld	a,(OFST-1,sp)
3837  0010 2708          	jreq	L1102
3839  0012 7b02          	ld	a,(OFST+0,sp)
3840  0014 2704          	jreq	L1102
3841                     ; 1137     bitstatus = SET;
3843  0016 a601          	ld	a,#1
3846  0018 2001          	jra	L3102
3847  001a               L1102:
3848                     ; 1141     bitstatus = RESET;
3850  001a 4f            	clr	a
3852  001b               L3102:
3853                     ; 1143   return (ITStatus)(bitstatus);
3857  001b 5b03          	addw	sp,#3
3858  001d 81            	ret	
3894                     ; 1156 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
3894                     ; 1157 {
3895                     .text:	section	.text,new
3896  0000               _TIM2_ClearITPendingBit:
3900                     ; 1159   assert_param(IS_TIM2_IT_OK(TIM2_IT));
3902                     ; 1162   TIM2->SR1 = (uint8_t)(~TIM2_IT);
3904  0000 43            	cpl	a
3905  0001 c75304        	ld	21252,a
3906                     ; 1163 }
3909  0004 81            	ret	
3961                     ; 1181 static void TI1_Config(uint8_t TIM2_ICPolarity,
3961                     ; 1182                        uint8_t TIM2_ICSelection,
3961                     ; 1183                        uint8_t TIM2_ICFilter)
3961                     ; 1184 {
3962                     .text:	section	.text,new
3963  0000               L3_TI1_Config:
3965  0000 89            	pushw	x
3966  0001 88            	push	a
3967       00000001      OFST:	set	1
3970                     ; 1186   TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3972  0002 7211530a      	bres	21258,#0
3973                     ; 1189   TIM2->CCMR1  = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF )))
3973                     ; 1190                            | (uint8_t)(((TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
3975  0006 7b06          	ld	a,(OFST+5,sp)
3976  0008 97            	ld	xl,a
3977  0009 a610          	ld	a,#16
3978  000b 42            	mul	x,a
3979  000c 9f            	ld	a,xl
3980  000d 1a03          	or	a,(OFST+2,sp)
3981  000f 6b01          	ld	(OFST+0,sp),a
3983  0011 c65307        	ld	a,21255
3984  0014 a40c          	and	a,#12
3985  0016 1a01          	or	a,(OFST+0,sp)
3986  0018 c75307        	ld	21255,a
3987                     ; 1193   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
3989  001b 7b02          	ld	a,(OFST+1,sp)
3990  001d 2706          	jreq	L1602
3991                     ; 1195     TIM2->CCER1 |= TIM2_CCER1_CC1P;
3993  001f 7212530a      	bset	21258,#1
3995  0023 2004          	jra	L3602
3996  0025               L1602:
3997                     ; 1199     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
3999  0025 7213530a      	bres	21258,#1
4000  0029               L3602:
4001                     ; 1202   TIM2->CCER1 |= TIM2_CCER1_CC1E;
4003  0029 7210530a      	bset	21258,#0
4004                     ; 1203 }
4007  002d 5b03          	addw	sp,#3
4008  002f 81            	ret	
4060                     ; 1221 static void TI2_Config(uint8_t TIM2_ICPolarity,
4060                     ; 1222                        uint8_t TIM2_ICSelection,
4060                     ; 1223                        uint8_t TIM2_ICFilter)
4060                     ; 1224 {
4061                     .text:	section	.text,new
4062  0000               L5_TI2_Config:
4064  0000 89            	pushw	x
4065  0001 88            	push	a
4066       00000001      OFST:	set	1
4069                     ; 1226   TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
4071  0002 7219530a      	bres	21258,#4
4072                     ; 1229   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF ))) 
4072                     ; 1230                           | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4074  0006 7b06          	ld	a,(OFST+5,sp)
4075  0008 97            	ld	xl,a
4076  0009 a610          	ld	a,#16
4077  000b 42            	mul	x,a
4078  000c 9f            	ld	a,xl
4079  000d 1a03          	or	a,(OFST+2,sp)
4080  000f 6b01          	ld	(OFST+0,sp),a
4082  0011 c65308        	ld	a,21256
4083  0014 a40c          	and	a,#12
4084  0016 1a01          	or	a,(OFST+0,sp)
4085  0018 c75308        	ld	21256,a
4086                     ; 1234   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4088  001b 7b02          	ld	a,(OFST+1,sp)
4089  001d 2706          	jreq	L3112
4090                     ; 1236     TIM2->CCER1 |= TIM2_CCER1_CC2P;
4092  001f 721a530a      	bset	21258,#5
4094  0023 2004          	jra	L5112
4095  0025               L3112:
4096                     ; 1240     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
4098  0025 721b530a      	bres	21258,#5
4099  0029               L5112:
4100                     ; 1244   TIM2->CCER1 |= TIM2_CCER1_CC2E;
4102  0029 7218530a      	bset	21258,#4
4103                     ; 1245 }
4106  002d 5b03          	addw	sp,#3
4107  002f 81            	ret	
4159                     ; 1261 static void TI3_Config(uint8_t TIM2_ICPolarity, uint8_t TIM2_ICSelection,
4159                     ; 1262                        uint8_t TIM2_ICFilter)
4159                     ; 1263 {
4160                     .text:	section	.text,new
4161  0000               L7_TI3_Config:
4163  0000 89            	pushw	x
4164  0001 88            	push	a
4165       00000001      OFST:	set	1
4168                     ; 1265   TIM2->CCER2 &=  (uint8_t)(~TIM2_CCER2_CC3E);
4170  0002 7211530b      	bres	21259,#0
4171                     ; 1268   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF))) 
4171                     ; 1269                           | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4173  0006 7b06          	ld	a,(OFST+5,sp)
4174  0008 97            	ld	xl,a
4175  0009 a610          	ld	a,#16
4176  000b 42            	mul	x,a
4177  000c 9f            	ld	a,xl
4178  000d 1a03          	or	a,(OFST+2,sp)
4179  000f 6b01          	ld	(OFST+0,sp),a
4181  0011 c65309        	ld	a,21257
4182  0014 a40c          	and	a,#12
4183  0016 1a01          	or	a,(OFST+0,sp)
4184  0018 c75309        	ld	21257,a
4185                     ; 1273   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4187  001b 7b02          	ld	a,(OFST+1,sp)
4188  001d 2706          	jreq	L5412
4189                     ; 1275     TIM2->CCER2 |= TIM2_CCER2_CC3P;
4191  001f 7212530b      	bset	21259,#1
4193  0023 2004          	jra	L7412
4194  0025               L5412:
4195                     ; 1279     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
4197  0025 7213530b      	bres	21259,#1
4198  0029               L7412:
4199                     ; 1282   TIM2->CCER2 |= TIM2_CCER2_CC3E;
4201  0029 7210530b      	bset	21259,#0
4202                     ; 1283 }
4205  002d 5b03          	addw	sp,#3
4206  002f 81            	ret	
4219                     	xdef	_TIM2_ClearITPendingBit
4220                     	xdef	_TIM2_GetITStatus
4221                     	xdef	_TIM2_ClearFlag
4222                     	xdef	_TIM2_GetFlagStatus
4223                     	xdef	_TIM2_GetPrescaler
4224                     	xdef	_TIM2_GetCounter
4225                     	xdef	_TIM2_GetCapture3
4226                     	xdef	_TIM2_GetCapture2
4227                     	xdef	_TIM2_GetCapture1
4228                     	xdef	_TIM2_SetIC3Prescaler
4229                     	xdef	_TIM2_SetIC2Prescaler
4230                     	xdef	_TIM2_SetIC1Prescaler
4231                     	xdef	_TIM2_SetCompare3
4232                     	xdef	_TIM2_SetCompare2
4233                     	xdef	_TIM2_SetCompare1
4234                     	xdef	_TIM2_SetAutoreload
4235                     	xdef	_TIM2_SetCounter
4236                     	xdef	_TIM2_SelectOCxM
4237                     	xdef	_TIM2_CCxCmd
4238                     	xdef	_TIM2_OC3PolarityConfig
4239                     	xdef	_TIM2_OC2PolarityConfig
4240                     	xdef	_TIM2_OC1PolarityConfig
4241                     	xdef	_TIM2_GenerateEvent
4242                     	xdef	_TIM2_OC3PreloadConfig
4243                     	xdef	_TIM2_OC2PreloadConfig
4244                     	xdef	_TIM2_OC1PreloadConfig
4245                     	xdef	_TIM2_ARRPreloadConfig
4246                     	xdef	_TIM2_ForcedOC3Config
4247                     	xdef	_TIM2_ForcedOC2Config
4248                     	xdef	_TIM2_ForcedOC1Config
4249                     	xdef	_TIM2_PrescalerConfig
4250                     	xdef	_TIM2_SelectOnePulseMode
4251                     	xdef	_TIM2_UpdateRequestConfig
4252                     	xdef	_TIM2_UpdateDisableConfig
4253                     	xdef	_TIM2_ITConfig
4254                     	xdef	_TIM2_Cmd
4255                     	xdef	_TIM2_PWMIConfig
4256                     	xdef	_TIM2_ICInit
4257                     	xdef	_TIM2_OC3Init
4258                     	xdef	_TIM2_OC2Init
4259                     	xdef	_TIM2_OC1Init
4260                     	xdef	_TIM2_TimeBaseInit
4261                     	xdef	_TIM2_DeInit
4280                     	end
