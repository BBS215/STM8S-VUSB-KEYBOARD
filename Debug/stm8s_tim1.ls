   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  49                     ; 58 void TIM1_DeInit(void)
  49                     ; 59 {
  51                     .text:	section	.text,new
  52  0000               _TIM1_DeInit:
  56                     ; 60   TIM1->CR1  = TIM1_CR1_RESET_VALUE;
  58  0000 725f5250      	clr	21072
  59                     ; 61   TIM1->CR2  = TIM1_CR2_RESET_VALUE;
  61  0004 725f5251      	clr	21073
  62                     ; 62   TIM1->SMCR = TIM1_SMCR_RESET_VALUE;
  64  0008 725f5252      	clr	21074
  65                     ; 63   TIM1->ETR  = TIM1_ETR_RESET_VALUE;
  67  000c 725f5253      	clr	21075
  68                     ; 64   TIM1->IER  = TIM1_IER_RESET_VALUE;
  70  0010 725f5254      	clr	21076
  71                     ; 65   TIM1->SR2  = TIM1_SR2_RESET_VALUE;
  73  0014 725f5256      	clr	21078
  74                     ; 67   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  76  0018 725f525c      	clr	21084
  77                     ; 68   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  79  001c 725f525d      	clr	21085
  80                     ; 70   TIM1->CCMR1 = 0x01;
  82  0020 35015258      	mov	21080,#1
  83                     ; 71   TIM1->CCMR2 = 0x01;
  85  0024 35015259      	mov	21081,#1
  86                     ; 72   TIM1->CCMR3 = 0x01;
  88  0028 3501525a      	mov	21082,#1
  89                     ; 73   TIM1->CCMR4 = 0x01;
  91  002c 3501525b      	mov	21083,#1
  92                     ; 75   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  94  0030 725f525c      	clr	21084
  95                     ; 76   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  97  0034 725f525d      	clr	21085
  98                     ; 77   TIM1->CCMR1 = TIM1_CCMR1_RESET_VALUE;
 100  0038 725f5258      	clr	21080
 101                     ; 78   TIM1->CCMR2 = TIM1_CCMR2_RESET_VALUE;
 103  003c 725f5259      	clr	21081
 104                     ; 79   TIM1->CCMR3 = TIM1_CCMR3_RESET_VALUE;
 106  0040 725f525a      	clr	21082
 107                     ; 80   TIM1->CCMR4 = TIM1_CCMR4_RESET_VALUE;
 109  0044 725f525b      	clr	21083
 110                     ; 81   TIM1->CNTRH = TIM1_CNTRH_RESET_VALUE;
 112  0048 725f525e      	clr	21086
 113                     ; 82   TIM1->CNTRL = TIM1_CNTRL_RESET_VALUE;
 115  004c 725f525f      	clr	21087
 116                     ; 83   TIM1->PSCRH = TIM1_PSCRH_RESET_VALUE;
 118  0050 725f5260      	clr	21088
 119                     ; 84   TIM1->PSCRL = TIM1_PSCRL_RESET_VALUE;
 121  0054 725f5261      	clr	21089
 122                     ; 85   TIM1->ARRH  = TIM1_ARRH_RESET_VALUE;
 124  0058 35ff5262      	mov	21090,#255
 125                     ; 86   TIM1->ARRL  = TIM1_ARRL_RESET_VALUE;
 127  005c 35ff5263      	mov	21091,#255
 128                     ; 87   TIM1->CCR1H = TIM1_CCR1H_RESET_VALUE;
 130  0060 725f5265      	clr	21093
 131                     ; 88   TIM1->CCR1L = TIM1_CCR1L_RESET_VALUE;
 133  0064 725f5266      	clr	21094
 134                     ; 89   TIM1->CCR2H = TIM1_CCR2H_RESET_VALUE;
 136  0068 725f5267      	clr	21095
 137                     ; 90   TIM1->CCR2L = TIM1_CCR2L_RESET_VALUE;
 139  006c 725f5268      	clr	21096
 140                     ; 91   TIM1->CCR3H = TIM1_CCR3H_RESET_VALUE;
 142  0070 725f5269      	clr	21097
 143                     ; 92   TIM1->CCR3L = TIM1_CCR3L_RESET_VALUE;
 145  0074 725f526a      	clr	21098
 146                     ; 93   TIM1->CCR4H = TIM1_CCR4H_RESET_VALUE;
 148  0078 725f526b      	clr	21099
 149                     ; 94   TIM1->CCR4L = TIM1_CCR4L_RESET_VALUE;
 151  007c 725f526c      	clr	21100
 152                     ; 95   TIM1->OISR  = TIM1_OISR_RESET_VALUE;
 154  0080 725f526f      	clr	21103
 155                     ; 96   TIM1->EGR   = 0x01; /* TIM1_EGR_UG */
 157  0084 35015257      	mov	21079,#1
 158                     ; 97   TIM1->DTR   = TIM1_DTR_RESET_VALUE;
 160  0088 725f526e      	clr	21102
 161                     ; 98   TIM1->BKR   = TIM1_BKR_RESET_VALUE;
 163  008c 725f526d      	clr	21101
 164                     ; 99   TIM1->RCR   = TIM1_RCR_RESET_VALUE;
 166  0090 725f5264      	clr	21092
 167                     ; 100   TIM1->SR1   = TIM1_SR1_RESET_VALUE;
 169  0094 725f5255      	clr	21077
 170                     ; 101 }
 173  0098 81            	ret	
 282                     ; 111 void TIM1_TimeBaseInit(uint16_t TIM1_Prescaler,
 282                     ; 112                        TIM1_CounterMode_TypeDef TIM1_CounterMode,
 282                     ; 113                        uint16_t TIM1_Period,
 282                     ; 114                        uint8_t TIM1_RepetitionCounter)
 282                     ; 115 {
 283                     .text:	section	.text,new
 284  0000               _TIM1_TimeBaseInit:
 286       fffffffe      OFST: set -2
 289                     ; 117   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
 291                     ; 120   TIM1->ARRH = (uint8_t)(TIM1_Period >> 8);
 293  0000 7b04          	ld	a,(OFST+6,sp)
 294  0002 c75262        	ld	21090,a
 295                     ; 121   TIM1->ARRL = (uint8_t)(TIM1_Period);
 297  0005 7b05          	ld	a,(OFST+7,sp)
 298  0007 c75263        	ld	21091,a
 299                     ; 124   TIM1->PSCRH = (uint8_t)(TIM1_Prescaler >> 8);
 301  000a 9e            	ld	a,xh
 302  000b c75260        	ld	21088,a
 303                     ; 125   TIM1->PSCRL = (uint8_t)(TIM1_Prescaler);
 305  000e 9f            	ld	a,xl
 306  000f c75261        	ld	21089,a
 307                     ; 128   TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)(~(TIM1_CR1_CMS | TIM1_CR1_DIR)))
 307                     ; 129                         | (uint8_t)(TIM1_CounterMode));
 309  0012 c65250        	ld	a,21072
 310  0015 a48f          	and	a,#143
 311  0017 1a03          	or	a,(OFST+5,sp)
 312  0019 c75250        	ld	21072,a
 313                     ; 132   TIM1->RCR = TIM1_RepetitionCounter;
 315  001c 7b06          	ld	a,(OFST+8,sp)
 316  001e c75264        	ld	21092,a
 317                     ; 133 }
 320  0021 81            	ret	
 605                     ; 154 void TIM1_OC1Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 605                     ; 155                   TIM1_OutputState_TypeDef TIM1_OutputState,
 605                     ; 156                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 605                     ; 157                   uint16_t TIM1_Pulse,
 605                     ; 158                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 605                     ; 159                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 605                     ; 160                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 605                     ; 161                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 605                     ; 162 {
 606                     .text:	section	.text,new
 607  0000               _TIM1_OC1Init:
 609  0000 89            	pushw	x
 610  0001 5203          	subw	sp,#3
 611       00000003      OFST:	set	3
 614                     ; 164   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 616                     ; 165   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 618                     ; 166   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 620                     ; 167   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 622                     ; 168   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 624                     ; 169   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 626                     ; 170   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 628                     ; 174   TIM1->CCER1 &= (uint8_t)(~( TIM1_CCER1_CC1E | TIM1_CCER1_CC1NE 
 628                     ; 175                              | TIM1_CCER1_CC1P | TIM1_CCER1_CC1NP));
 630  0003 c6525c        	ld	a,21084
 631  0006 a4f0          	and	a,#240
 632  0008 c7525c        	ld	21084,a
 633                     ; 178   TIM1->CCER1 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER1_CC1E)
 633                     ; 179                                      | (uint8_t)(TIM1_OutputNState & TIM1_CCER1_CC1NE))
 633                     ; 180                            | (uint8_t)( (uint8_t)(TIM1_OCPolarity  & TIM1_CCER1_CC1P)
 633                     ; 181                                        | (uint8_t)(TIM1_OCNPolarity & TIM1_CCER1_CC1NP)));
 635  000b 7b0c          	ld	a,(OFST+9,sp)
 636  000d a408          	and	a,#8
 637  000f 6b03          	ld	(OFST+0,sp),a
 639  0011 7b0b          	ld	a,(OFST+8,sp)
 640  0013 a402          	and	a,#2
 641  0015 1a03          	or	a,(OFST+0,sp)
 642  0017 6b02          	ld	(OFST-1,sp),a
 644  0019 7b08          	ld	a,(OFST+5,sp)
 645  001b a404          	and	a,#4
 646  001d 6b01          	ld	(OFST-2,sp),a
 648  001f 9f            	ld	a,xl
 649  0020 a401          	and	a,#1
 650  0022 1a01          	or	a,(OFST-2,sp)
 651  0024 1a02          	or	a,(OFST-1,sp)
 652  0026 ca525c        	or	a,21084
 653  0029 c7525c        	ld	21084,a
 654                     ; 184   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 654                     ; 185                           (uint8_t)TIM1_OCMode);
 656  002c c65258        	ld	a,21080
 657  002f a48f          	and	a,#143
 658  0031 1a04          	or	a,(OFST+1,sp)
 659  0033 c75258        	ld	21080,a
 660                     ; 188   TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS1 | TIM1_OISR_OIS1N));
 662  0036 c6526f        	ld	a,21103
 663  0039 a4fc          	and	a,#252
 664  003b c7526f        	ld	21103,a
 665                     ; 190   TIM1->OISR |= (uint8_t)((uint8_t)( TIM1_OCIdleState & TIM1_OISR_OIS1 ) | 
 665                     ; 191                           (uint8_t)( TIM1_OCNIdleState & TIM1_OISR_OIS1N ));
 667  003e 7b0e          	ld	a,(OFST+11,sp)
 668  0040 a402          	and	a,#2
 669  0042 6b03          	ld	(OFST+0,sp),a
 671  0044 7b0d          	ld	a,(OFST+10,sp)
 672  0046 a401          	and	a,#1
 673  0048 1a03          	or	a,(OFST+0,sp)
 674  004a ca526f        	or	a,21103
 675  004d c7526f        	ld	21103,a
 676                     ; 194   TIM1->CCR1H = (uint8_t)(TIM1_Pulse >> 8);
 678  0050 7b09          	ld	a,(OFST+6,sp)
 679  0052 c75265        	ld	21093,a
 680                     ; 195   TIM1->CCR1L = (uint8_t)(TIM1_Pulse);
 682  0055 7b0a          	ld	a,(OFST+7,sp)
 683  0057 c75266        	ld	21094,a
 684                     ; 196 }
 687  005a 5b05          	addw	sp,#5
 688  005c 81            	ret	
 792                     ; 217 void TIM1_OC2Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 792                     ; 218                   TIM1_OutputState_TypeDef TIM1_OutputState,
 792                     ; 219                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 792                     ; 220                   uint16_t TIM1_Pulse,
 792                     ; 221                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 792                     ; 222                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 792                     ; 223                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 792                     ; 224                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 792                     ; 225 {
 793                     .text:	section	.text,new
 794  0000               _TIM1_OC2Init:
 796  0000 89            	pushw	x
 797  0001 5203          	subw	sp,#3
 798       00000003      OFST:	set	3
 801                     ; 227   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 803                     ; 228   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 805                     ; 229   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 807                     ; 230   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 809                     ; 231   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 811                     ; 232   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 813                     ; 233   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 815                     ; 237   TIM1->CCER1 &= (uint8_t)(~( TIM1_CCER1_CC2E | TIM1_CCER1_CC2NE | 
 815                     ; 238                              TIM1_CCER1_CC2P | TIM1_CCER1_CC2NP));
 817  0003 c6525c        	ld	a,21084
 818  0006 a40f          	and	a,#15
 819  0008 c7525c        	ld	21084,a
 820                     ; 242   TIM1->CCER1 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER1_CC2E  ) | 
 820                     ; 243                                      (uint8_t)(TIM1_OutputNState & TIM1_CCER1_CC2NE )) | 
 820                     ; 244                            (uint8_t)((uint8_t)(TIM1_OCPolarity  & TIM1_CCER1_CC2P  ) | 
 820                     ; 245                                      (uint8_t)(TIM1_OCNPolarity & TIM1_CCER1_CC2NP )));
 822  000b 7b0c          	ld	a,(OFST+9,sp)
 823  000d a480          	and	a,#128
 824  000f 6b03          	ld	(OFST+0,sp),a
 826  0011 7b0b          	ld	a,(OFST+8,sp)
 827  0013 a420          	and	a,#32
 828  0015 1a03          	or	a,(OFST+0,sp)
 829  0017 6b02          	ld	(OFST-1,sp),a
 831  0019 7b08          	ld	a,(OFST+5,sp)
 832  001b a440          	and	a,#64
 833  001d 6b01          	ld	(OFST-2,sp),a
 835  001f 9f            	ld	a,xl
 836  0020 a410          	and	a,#16
 837  0022 1a01          	or	a,(OFST-2,sp)
 838  0024 1a02          	or	a,(OFST-1,sp)
 839  0026 ca525c        	or	a,21084
 840  0029 c7525c        	ld	21084,a
 841                     ; 248   TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 841                     ; 249                           (uint8_t)TIM1_OCMode);
 843  002c c65259        	ld	a,21081
 844  002f a48f          	and	a,#143
 845  0031 1a04          	or	a,(OFST+1,sp)
 846  0033 c75259        	ld	21081,a
 847                     ; 252   TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS2 | TIM1_OISR_OIS2N));
 849  0036 c6526f        	ld	a,21103
 850  0039 a4f3          	and	a,#243
 851  003b c7526f        	ld	21103,a
 852                     ; 254   TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS2 & TIM1_OCIdleState) | 
 852                     ; 255                           (uint8_t)(TIM1_OISR_OIS2N & TIM1_OCNIdleState));
 854  003e 7b0e          	ld	a,(OFST+11,sp)
 855  0040 a408          	and	a,#8
 856  0042 6b03          	ld	(OFST+0,sp),a
 858  0044 7b0d          	ld	a,(OFST+10,sp)
 859  0046 a404          	and	a,#4
 860  0048 1a03          	or	a,(OFST+0,sp)
 861  004a ca526f        	or	a,21103
 862  004d c7526f        	ld	21103,a
 863                     ; 258   TIM1->CCR2H = (uint8_t)(TIM1_Pulse >> 8);
 865  0050 7b09          	ld	a,(OFST+6,sp)
 866  0052 c75267        	ld	21095,a
 867                     ; 259   TIM1->CCR2L = (uint8_t)(TIM1_Pulse);
 869  0055 7b0a          	ld	a,(OFST+7,sp)
 870  0057 c75268        	ld	21096,a
 871                     ; 260 }
 874  005a 5b05          	addw	sp,#5
 875  005c 81            	ret	
 979                     ; 281 void TIM1_OC3Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 979                     ; 282                   TIM1_OutputState_TypeDef TIM1_OutputState,
 979                     ; 283                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 979                     ; 284                   uint16_t TIM1_Pulse,
 979                     ; 285                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 979                     ; 286                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 979                     ; 287                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 979                     ; 288                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 979                     ; 289 {
 980                     .text:	section	.text,new
 981  0000               _TIM1_OC3Init:
 983  0000 89            	pushw	x
 984  0001 5203          	subw	sp,#3
 985       00000003      OFST:	set	3
 988                     ; 291   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 990                     ; 292   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 992                     ; 293   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 994                     ; 294   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 996                     ; 295   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 998                     ; 296   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
1000                     ; 297   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
1002                     ; 301   TIM1->CCER2 &= (uint8_t)(~( TIM1_CCER2_CC3E | TIM1_CCER2_CC3NE | 
1002                     ; 302                              TIM1_CCER2_CC3P | TIM1_CCER2_CC3NP));
1004  0003 c6525d        	ld	a,21085
1005  0006 a4f0          	and	a,#240
1006  0008 c7525d        	ld	21085,a
1007                     ; 305   TIM1->CCER2 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState  & TIM1_CCER2_CC3E   ) |
1007                     ; 306                                      (uint8_t)(TIM1_OutputNState & TIM1_CCER2_CC3NE  )) | 
1007                     ; 307                            (uint8_t)((uint8_t)(TIM1_OCPolarity   & TIM1_CCER2_CC3P   ) | 
1007                     ; 308                                      (uint8_t)(TIM1_OCNPolarity  & TIM1_CCER2_CC3NP  )));
1009  000b 7b0c          	ld	a,(OFST+9,sp)
1010  000d a408          	and	a,#8
1011  000f 6b03          	ld	(OFST+0,sp),a
1013  0011 7b0b          	ld	a,(OFST+8,sp)
1014  0013 a402          	and	a,#2
1015  0015 1a03          	or	a,(OFST+0,sp)
1016  0017 6b02          	ld	(OFST-1,sp),a
1018  0019 7b08          	ld	a,(OFST+5,sp)
1019  001b a404          	and	a,#4
1020  001d 6b01          	ld	(OFST-2,sp),a
1022  001f 9f            	ld	a,xl
1023  0020 a401          	and	a,#1
1024  0022 1a01          	or	a,(OFST-2,sp)
1025  0024 1a02          	or	a,(OFST-1,sp)
1026  0026 ca525d        	or	a,21085
1027  0029 c7525d        	ld	21085,a
1028                     ; 311   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) | 
1028                     ; 312                           (uint8_t)TIM1_OCMode);
1030  002c c6525a        	ld	a,21082
1031  002f a48f          	and	a,#143
1032  0031 1a04          	or	a,(OFST+1,sp)
1033  0033 c7525a        	ld	21082,a
1034                     ; 315   TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS3 | TIM1_OISR_OIS3N));
1036  0036 c6526f        	ld	a,21103
1037  0039 a4cf          	and	a,#207
1038  003b c7526f        	ld	21103,a
1039                     ; 317   TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS3 & TIM1_OCIdleState) | 
1039                     ; 318                           (uint8_t)(TIM1_OISR_OIS3N & TIM1_OCNIdleState));
1041  003e 7b0e          	ld	a,(OFST+11,sp)
1042  0040 a420          	and	a,#32
1043  0042 6b03          	ld	(OFST+0,sp),a
1045  0044 7b0d          	ld	a,(OFST+10,sp)
1046  0046 a410          	and	a,#16
1047  0048 1a03          	or	a,(OFST+0,sp)
1048  004a ca526f        	or	a,21103
1049  004d c7526f        	ld	21103,a
1050                     ; 321   TIM1->CCR3H = (uint8_t)(TIM1_Pulse >> 8);
1052  0050 7b09          	ld	a,(OFST+6,sp)
1053  0052 c75269        	ld	21097,a
1054                     ; 322   TIM1->CCR3L = (uint8_t)(TIM1_Pulse);
1056  0055 7b0a          	ld	a,(OFST+7,sp)
1057  0057 c7526a        	ld	21098,a
1058                     ; 323 }
1061  005a 5b05          	addw	sp,#5
1062  005c 81            	ret	
1136                     ; 338 void TIM1_OC4Init(TIM1_OCMode_TypeDef TIM1_OCMode,
1136                     ; 339                   TIM1_OutputState_TypeDef TIM1_OutputState,
1136                     ; 340                   uint16_t TIM1_Pulse,
1136                     ; 341                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
1136                     ; 342                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState)
1136                     ; 343 {
1137                     .text:	section	.text,new
1138  0000               _TIM1_OC4Init:
1140  0000 89            	pushw	x
1141  0001 88            	push	a
1142       00000001      OFST:	set	1
1145                     ; 345   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
1147                     ; 346   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
1149                     ; 347   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
1151                     ; 348   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
1153                     ; 351   TIM1->CCER2 &= (uint8_t)(~(TIM1_CCER2_CC4E | TIM1_CCER2_CC4P));
1155  0002 c6525d        	ld	a,21085
1156  0005 a4cf          	and	a,#207
1157  0007 c7525d        	ld	21085,a
1158                     ; 353   TIM1->CCER2 |= (uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER2_CC4E ) |  
1158                     ; 354                            (uint8_t)(TIM1_OCPolarity  & TIM1_CCER2_CC4P ));
1160  000a 7b08          	ld	a,(OFST+7,sp)
1161  000c a420          	and	a,#32
1162  000e 6b01          	ld	(OFST+0,sp),a
1164  0010 9f            	ld	a,xl
1165  0011 a410          	and	a,#16
1166  0013 1a01          	or	a,(OFST+0,sp)
1167  0015 ca525d        	or	a,21085
1168  0018 c7525d        	ld	21085,a
1169                     ; 357   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) | 
1169                     ; 358                           TIM1_OCMode);
1171  001b c6525b        	ld	a,21083
1172  001e a48f          	and	a,#143
1173  0020 1a02          	or	a,(OFST+1,sp)
1174  0022 c7525b        	ld	21083,a
1175                     ; 361   if (TIM1_OCIdleState != TIM1_OCIDLESTATE_RESET)
1177  0025 7b09          	ld	a,(OFST+8,sp)
1178  0027 270a          	jreq	L534
1179                     ; 363     TIM1->OISR |= (uint8_t)(~TIM1_CCER2_CC4P);
1181  0029 c6526f        	ld	a,21103
1182  002c aadf          	or	a,#223
1183  002e c7526f        	ld	21103,a
1185  0031 2004          	jra	L734
1186  0033               L534:
1187                     ; 367     TIM1->OISR &= (uint8_t)(~TIM1_OISR_OIS4);
1189  0033 721d526f      	bres	21103,#6
1190  0037               L734:
1191                     ; 371   TIM1->CCR4H = (uint8_t)(TIM1_Pulse >> 8);
1193  0037 7b06          	ld	a,(OFST+5,sp)
1194  0039 c7526b        	ld	21099,a
1195                     ; 372   TIM1->CCR4L = (uint8_t)(TIM1_Pulse);
1197  003c 7b07          	ld	a,(OFST+6,sp)
1198  003e c7526c        	ld	21100,a
1199                     ; 373 }
1202  0041 5b03          	addw	sp,#3
1203  0043 81            	ret	
1408                     ; 388 void TIM1_BDTRConfig(TIM1_OSSIState_TypeDef TIM1_OSSIState,
1408                     ; 389                      TIM1_LockLevel_TypeDef TIM1_LockLevel,
1408                     ; 390                      uint8_t TIM1_DeadTime,
1408                     ; 391                      TIM1_BreakState_TypeDef TIM1_Break,
1408                     ; 392                      TIM1_BreakPolarity_TypeDef TIM1_BreakPolarity,
1408                     ; 393                      TIM1_AutomaticOutput_TypeDef TIM1_AutomaticOutput)
1408                     ; 394 {
1409                     .text:	section	.text,new
1410  0000               _TIM1_BDTRConfig:
1412  0000 89            	pushw	x
1413  0001 88            	push	a
1414       00000001      OFST:	set	1
1417                     ; 396   assert_param(IS_TIM1_OSSI_STATE_OK(TIM1_OSSIState));
1419                     ; 397   assert_param(IS_TIM1_LOCK_LEVEL_OK(TIM1_LockLevel));
1421                     ; 398   assert_param(IS_TIM1_BREAK_STATE_OK(TIM1_Break));
1423                     ; 399   assert_param(IS_TIM1_BREAK_POLARITY_OK(TIM1_BreakPolarity));
1425                     ; 400   assert_param(IS_TIM1_AUTOMATIC_OUTPUT_STATE_OK(TIM1_AutomaticOutput));
1427                     ; 402   TIM1->DTR = (uint8_t)(TIM1_DeadTime);
1429  0002 7b06          	ld	a,(OFST+5,sp)
1430  0004 c7526e        	ld	21102,a
1431                     ; 406   TIM1->BKR  =  (uint8_t)((uint8_t)(TIM1_OSSIState | (uint8_t)TIM1_LockLevel)  | 
1431                     ; 407                           (uint8_t)((uint8_t)(TIM1_Break | (uint8_t)TIM1_BreakPolarity)  | 
1431                     ; 408                           (uint8_t)TIM1_AutomaticOutput));
1433  0007 7b07          	ld	a,(OFST+6,sp)
1434  0009 1a08          	or	a,(OFST+7,sp)
1435  000b 1a09          	or	a,(OFST+8,sp)
1436  000d 6b01          	ld	(OFST+0,sp),a
1438  000f 9f            	ld	a,xl
1439  0010 1a02          	or	a,(OFST+1,sp)
1440  0012 1a01          	or	a,(OFST+0,sp)
1441  0014 c7526d        	ld	21101,a
1442                     ; 409 }
1445  0017 5b03          	addw	sp,#3
1446  0019 81            	ret	
1648                     ; 423 void TIM1_ICInit(TIM1_Channel_TypeDef TIM1_Channel,
1648                     ; 424                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1648                     ; 425                  TIM1_ICSelection_TypeDef TIM1_ICSelection,
1648                     ; 426                  TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1648                     ; 427                  uint8_t TIM1_ICFilter)
1648                     ; 428 {
1649                     .text:	section	.text,new
1650  0000               _TIM1_ICInit:
1652  0000 89            	pushw	x
1653       00000000      OFST:	set	0
1656                     ; 430   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
1658                     ; 431   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1660                     ; 432   assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1662                     ; 433   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1664                     ; 434   assert_param(IS_TIM1_IC_FILTER_OK(TIM1_ICFilter));
1666                     ; 436   if (TIM1_Channel == TIM1_CHANNEL_1)
1668  0001 9e            	ld	a,xh
1669  0002 4d            	tnz	a
1670  0003 2614          	jrne	L766
1671                     ; 439     TI1_Config((uint8_t)TIM1_ICPolarity,
1671                     ; 440                (uint8_t)TIM1_ICSelection,
1671                     ; 441                (uint8_t)TIM1_ICFilter);
1673  0005 7b07          	ld	a,(OFST+7,sp)
1674  0007 88            	push	a
1675  0008 7b06          	ld	a,(OFST+6,sp)
1676  000a 97            	ld	xl,a
1677  000b 7b03          	ld	a,(OFST+3,sp)
1678  000d 95            	ld	xh,a
1679  000e cd0000        	call	L3_TI1_Config
1681  0011 84            	pop	a
1682                     ; 443     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1684  0012 7b06          	ld	a,(OFST+6,sp)
1685  0014 cd0000        	call	_TIM1_SetIC1Prescaler
1688  0017 2044          	jra	L176
1689  0019               L766:
1690                     ; 445   else if (TIM1_Channel == TIM1_CHANNEL_2)
1692  0019 7b01          	ld	a,(OFST+1,sp)
1693  001b a101          	cp	a,#1
1694  001d 2614          	jrne	L376
1695                     ; 448     TI2_Config((uint8_t)TIM1_ICPolarity,
1695                     ; 449                (uint8_t)TIM1_ICSelection,
1695                     ; 450                (uint8_t)TIM1_ICFilter);
1697  001f 7b07          	ld	a,(OFST+7,sp)
1698  0021 88            	push	a
1699  0022 7b06          	ld	a,(OFST+6,sp)
1700  0024 97            	ld	xl,a
1701  0025 7b03          	ld	a,(OFST+3,sp)
1702  0027 95            	ld	xh,a
1703  0028 cd0000        	call	L5_TI2_Config
1705  002b 84            	pop	a
1706                     ; 452     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1708  002c 7b06          	ld	a,(OFST+6,sp)
1709  002e cd0000        	call	_TIM1_SetIC2Prescaler
1712  0031 202a          	jra	L176
1713  0033               L376:
1714                     ; 454   else if (TIM1_Channel == TIM1_CHANNEL_3)
1716  0033 a102          	cp	a,#2
1717  0035 2614          	jrne	L776
1718                     ; 457     TI3_Config((uint8_t)TIM1_ICPolarity,
1718                     ; 458                (uint8_t)TIM1_ICSelection,
1718                     ; 459                (uint8_t)TIM1_ICFilter);
1720  0037 7b07          	ld	a,(OFST+7,sp)
1721  0039 88            	push	a
1722  003a 7b06          	ld	a,(OFST+6,sp)
1723  003c 97            	ld	xl,a
1724  003d 7b03          	ld	a,(OFST+3,sp)
1725  003f 95            	ld	xh,a
1726  0040 cd0000        	call	L7_TI3_Config
1728  0043 84            	pop	a
1729                     ; 461     TIM1_SetIC3Prescaler(TIM1_ICPrescaler);
1731  0044 7b06          	ld	a,(OFST+6,sp)
1732  0046 cd0000        	call	_TIM1_SetIC3Prescaler
1735  0049 2012          	jra	L176
1736  004b               L776:
1737                     ; 466     TI4_Config((uint8_t)TIM1_ICPolarity,
1737                     ; 467                (uint8_t)TIM1_ICSelection,
1737                     ; 468                (uint8_t)TIM1_ICFilter);
1739  004b 7b07          	ld	a,(OFST+7,sp)
1740  004d 88            	push	a
1741  004e 7b06          	ld	a,(OFST+6,sp)
1742  0050 97            	ld	xl,a
1743  0051 7b03          	ld	a,(OFST+3,sp)
1744  0053 95            	ld	xh,a
1745  0054 cd0000        	call	L11_TI4_Config
1747  0057 84            	pop	a
1748                     ; 470     TIM1_SetIC4Prescaler(TIM1_ICPrescaler);
1750  0058 7b06          	ld	a,(OFST+6,sp)
1751  005a cd0000        	call	_TIM1_SetIC4Prescaler
1753  005d               L176:
1754                     ; 472 }
1757  005d 85            	popw	x
1758  005e 81            	ret	
1854                     ; 488 void TIM1_PWMIConfig(TIM1_Channel_TypeDef TIM1_Channel,
1854                     ; 489                      TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1854                     ; 490                      TIM1_ICSelection_TypeDef TIM1_ICSelection,
1854                     ; 491                      TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1854                     ; 492                      uint8_t TIM1_ICFilter)
1854                     ; 493 {
1855                     .text:	section	.text,new
1856  0000               _TIM1_PWMIConfig:
1858  0000 89            	pushw	x
1859  0001 89            	pushw	x
1860       00000002      OFST:	set	2
1863                     ; 494   uint8_t icpolarity = TIM1_ICPOLARITY_RISING;
1865                     ; 495   uint8_t icselection = TIM1_ICSELECTION_DIRECTTI;
1867                     ; 498   assert_param(IS_TIM1_PWMI_CHANNEL_OK(TIM1_Channel));
1869                     ; 499   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1871                     ; 500   assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1873                     ; 501   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1875                     ; 504   if (TIM1_ICPolarity != TIM1_ICPOLARITY_FALLING)
1877  0002 9f            	ld	a,xl
1878  0003 4a            	dec	a
1879  0004 2702          	jreq	L157
1880                     ; 506     icpolarity = TIM1_ICPOLARITY_FALLING;
1882  0006 a601          	ld	a,#1
1884  0008               L157:
1885                     ; 510     icpolarity = TIM1_ICPOLARITY_RISING;
1887  0008 6b01          	ld	(OFST-1,sp),a
1889                     ; 514   if (TIM1_ICSelection == TIM1_ICSELECTION_DIRECTTI)
1891  000a 7b07          	ld	a,(OFST+5,sp)
1892  000c 4a            	dec	a
1893  000d 2604          	jrne	L557
1894                     ; 516     icselection = TIM1_ICSELECTION_INDIRECTTI;
1896  000f a602          	ld	a,#2
1898  0011 2002          	jra	L757
1899  0013               L557:
1900                     ; 520     icselection = TIM1_ICSELECTION_DIRECTTI;
1902  0013 a601          	ld	a,#1
1903  0015               L757:
1904  0015 6b02          	ld	(OFST+0,sp),a
1906                     ; 523   if (TIM1_Channel == TIM1_CHANNEL_1)
1908  0017 7b03          	ld	a,(OFST+1,sp)
1909  0019 2626          	jrne	L167
1910                     ; 526     TI1_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSelection,
1910                     ; 527                (uint8_t)TIM1_ICFilter);
1912  001b 7b09          	ld	a,(OFST+7,sp)
1913  001d 88            	push	a
1914  001e 7b08          	ld	a,(OFST+6,sp)
1915  0020 97            	ld	xl,a
1916  0021 7b05          	ld	a,(OFST+3,sp)
1917  0023 95            	ld	xh,a
1918  0024 cd0000        	call	L3_TI1_Config
1920  0027 84            	pop	a
1921                     ; 530     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1923  0028 7b08          	ld	a,(OFST+6,sp)
1924  002a cd0000        	call	_TIM1_SetIC1Prescaler
1926                     ; 533     TI2_Config(icpolarity, icselection, TIM1_ICFilter);
1928  002d 7b09          	ld	a,(OFST+7,sp)
1929  002f 88            	push	a
1930  0030 7b03          	ld	a,(OFST+1,sp)
1931  0032 97            	ld	xl,a
1932  0033 7b02          	ld	a,(OFST+0,sp)
1933  0035 95            	ld	xh,a
1934  0036 cd0000        	call	L5_TI2_Config
1936  0039 84            	pop	a
1937                     ; 536     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1939  003a 7b08          	ld	a,(OFST+6,sp)
1940  003c cd0000        	call	_TIM1_SetIC2Prescaler
1943  003f 2024          	jra	L367
1944  0041               L167:
1945                     ; 541     TI2_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSelection,
1945                     ; 542                (uint8_t)TIM1_ICFilter);
1947  0041 7b09          	ld	a,(OFST+7,sp)
1948  0043 88            	push	a
1949  0044 7b08          	ld	a,(OFST+6,sp)
1950  0046 97            	ld	xl,a
1951  0047 7b05          	ld	a,(OFST+3,sp)
1952  0049 95            	ld	xh,a
1953  004a cd0000        	call	L5_TI2_Config
1955  004d 84            	pop	a
1956                     ; 545     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1958  004e 7b08          	ld	a,(OFST+6,sp)
1959  0050 cd0000        	call	_TIM1_SetIC2Prescaler
1961                     ; 548     TI1_Config(icpolarity, icselection, TIM1_ICFilter);
1963  0053 7b09          	ld	a,(OFST+7,sp)
1964  0055 88            	push	a
1965  0056 7b03          	ld	a,(OFST+1,sp)
1966  0058 97            	ld	xl,a
1967  0059 7b02          	ld	a,(OFST+0,sp)
1968  005b 95            	ld	xh,a
1969  005c cd0000        	call	L3_TI1_Config
1971  005f 84            	pop	a
1972                     ; 551     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1974  0060 7b08          	ld	a,(OFST+6,sp)
1975  0062 cd0000        	call	_TIM1_SetIC1Prescaler
1977  0065               L367:
1978                     ; 553 }
1981  0065 5b04          	addw	sp,#4
1982  0067 81            	ret	
2037                     ; 561 void TIM1_Cmd(FunctionalState NewState)
2037                     ; 562 {
2038                     .text:	section	.text,new
2039  0000               _TIM1_Cmd:
2043                     ; 564   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2045                     ; 567   if (NewState != DISABLE)
2047  0000 4d            	tnz	a
2048  0001 2705          	jreq	L3101
2049                     ; 569     TIM1->CR1 |= TIM1_CR1_CEN;
2051  0003 72105250      	bset	21072,#0
2054  0007 81            	ret	
2055  0008               L3101:
2056                     ; 573     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_CEN);
2058  0008 72115250      	bres	21072,#0
2059                     ; 575 }
2062  000c 81            	ret	
2098                     ; 583 void TIM1_CtrlPWMOutputs(FunctionalState NewState)
2098                     ; 584 {
2099                     .text:	section	.text,new
2100  0000               _TIM1_CtrlPWMOutputs:
2104                     ; 586   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2106                     ; 590   if (NewState != DISABLE)
2108  0000 4d            	tnz	a
2109  0001 2705          	jreq	L5301
2110                     ; 592     TIM1->BKR |= TIM1_BKR_MOE;
2112  0003 721e526d      	bset	21101,#7
2115  0007 81            	ret	
2116  0008               L5301:
2117                     ; 596     TIM1->BKR &= (uint8_t)(~TIM1_BKR_MOE);
2119  0008 721f526d      	bres	21101,#7
2120                     ; 598 }
2123  000c 81            	ret	
2230                     ; 617 void TIM1_ITConfig(TIM1_IT_TypeDef  TIM1_IT, FunctionalState NewState)
2230                     ; 618 {
2231                     .text:	section	.text,new
2232  0000               _TIM1_ITConfig:
2234  0000 89            	pushw	x
2235       00000000      OFST:	set	0
2238                     ; 620   assert_param(IS_TIM1_IT_OK(TIM1_IT));
2240                     ; 621   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2242                     ; 623   if (NewState != DISABLE)
2244  0001 9f            	ld	a,xl
2245  0002 4d            	tnz	a
2246  0003 2706          	jreq	L7011
2247                     ; 626     TIM1->IER |= (uint8_t)TIM1_IT;
2249  0005 9e            	ld	a,xh
2250  0006 ca5254        	or	a,21076
2252  0009 2006          	jra	L1111
2253  000b               L7011:
2254                     ; 631     TIM1->IER &= (uint8_t)(~(uint8_t)TIM1_IT);
2256  000b 7b01          	ld	a,(OFST+1,sp)
2257  000d 43            	cpl	a
2258  000e c45254        	and	a,21076
2259  0011               L1111:
2260  0011 c75254        	ld	21076,a
2261                     ; 633 }
2264  0014 85            	popw	x
2265  0015 81            	ret	
2289                     ; 640 void TIM1_InternalClockConfig(void)
2289                     ; 641 {
2290                     .text:	section	.text,new
2291  0000               _TIM1_InternalClockConfig:
2295                     ; 643   TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_SMS);
2297  0000 c65252        	ld	a,21074
2298  0003 a4f8          	and	a,#248
2299  0005 c75252        	ld	21074,a
2300                     ; 644 }
2303  0008 81            	ret	
2420                     ; 662 void TIM1_ETRClockMode1Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2420                     ; 663                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2420                     ; 664                               uint8_t ExtTRGFilter)
2420                     ; 665 {
2421                     .text:	section	.text,new
2422  0000               _TIM1_ETRClockMode1Config:
2424  0000 89            	pushw	x
2425       00000000      OFST:	set	0
2428                     ; 667   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2430                     ; 668   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2432                     ; 671   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2434  0001 7b05          	ld	a,(OFST+5,sp)
2435  0003 88            	push	a
2436  0004 7b02          	ld	a,(OFST+2,sp)
2437  0006 95            	ld	xh,a
2438  0007 cd0000        	call	_TIM1_ETRConfig
2440  000a 84            	pop	a
2441                     ; 674   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~(uint8_t)(TIM1_SMCR_SMS | TIM1_SMCR_TS )))
2441                     ; 675                          | (uint8_t)((uint8_t)TIM1_SLAVEMODE_EXTERNAL1 | TIM1_TS_ETRF ));
2443  000b c65252        	ld	a,21074
2444  000e aa77          	or	a,#119
2445  0010 c75252        	ld	21074,a
2446                     ; 676 }
2449  0013 85            	popw	x
2450  0014 81            	ret	
2508                     ; 694 void TIM1_ETRClockMode2Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2508                     ; 695                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2508                     ; 696                               uint8_t ExtTRGFilter)
2508                     ; 697 {
2509                     .text:	section	.text,new
2510  0000               _TIM1_ETRClockMode2Config:
2512  0000 89            	pushw	x
2513       00000000      OFST:	set	0
2516                     ; 699   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2518                     ; 700   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2520                     ; 703   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2522  0001 7b05          	ld	a,(OFST+5,sp)
2523  0003 88            	push	a
2524  0004 7b02          	ld	a,(OFST+2,sp)
2525  0006 95            	ld	xh,a
2526  0007 cd0000        	call	_TIM1_ETRConfig
2528  000a 721c5253      	bset	21075,#6
2529                     ; 706   TIM1->ETR |= TIM1_ETR_ECE;
2531                     ; 707 }
2534  000e 5b03          	addw	sp,#3
2535  0010 81            	ret	
2591                     ; 725 void TIM1_ETRConfig(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2591                     ; 726                     TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2591                     ; 727                     uint8_t ExtTRGFilter)
2591                     ; 728 {
2592                     .text:	section	.text,new
2593  0000               _TIM1_ETRConfig:
2595  0000 89            	pushw	x
2596       00000000      OFST:	set	0
2599                     ; 730   assert_param(IS_TIM1_EXT_TRG_FILTER_OK(ExtTRGFilter));
2601                     ; 732   TIM1->ETR |= (uint8_t)((uint8_t)(TIM1_ExtTRGPrescaler | (uint8_t)TIM1_ExtTRGPolarity )|
2601                     ; 733                          (uint8_t)ExtTRGFilter );
2603  0001 9f            	ld	a,xl
2604  0002 1a01          	or	a,(OFST+1,sp)
2605  0004 1a05          	or	a,(OFST+5,sp)
2606  0006 ca5253        	or	a,21075
2607  0009 c75253        	ld	21075,a
2608                     ; 734 }
2611  000c 85            	popw	x
2612  000d 81            	ret	
2701                     ; 751 void TIM1_TIxExternalClockConfig(TIM1_TIxExternalCLK1Source_TypeDef TIM1_TIxExternalCLKSource,
2701                     ; 752                                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
2701                     ; 753                                  uint8_t ICFilter)
2701                     ; 754 {
2702                     .text:	section	.text,new
2703  0000               _TIM1_TIxExternalClockConfig:
2705  0000 89            	pushw	x
2706       00000000      OFST:	set	0
2709                     ; 756   assert_param(IS_TIM1_TIXCLK_SOURCE_OK(TIM1_TIxExternalCLKSource));
2711                     ; 757   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
2713                     ; 758   assert_param(IS_TIM1_IC_FILTER_OK(ICFilter));
2715                     ; 761   if (TIM1_TIxExternalCLKSource == TIM1_TIXEXTERNALCLK1SOURCE_TI2)
2717  0001 9e            	ld	a,xh
2718  0002 a160          	cp	a,#96
2719  0004 260d          	jrne	L1131
2720                     ; 763     TI2_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSELECTION_DIRECTTI, (uint8_t)ICFilter);
2722  0006 7b05          	ld	a,(OFST+5,sp)
2723  0008 88            	push	a
2724  0009 9f            	ld	a,xl
2725  000a ae0001        	ldw	x,#1
2726  000d 95            	ld	xh,a
2727  000e cd0000        	call	L5_TI2_Config
2730  0011 200c          	jra	L3131
2731  0013               L1131:
2732                     ; 767     TI1_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSELECTION_DIRECTTI, (uint8_t)ICFilter);
2734  0013 7b05          	ld	a,(OFST+5,sp)
2735  0015 88            	push	a
2736  0016 7b03          	ld	a,(OFST+3,sp)
2737  0018 ae0001        	ldw	x,#1
2738  001b 95            	ld	xh,a
2739  001c cd0000        	call	L3_TI1_Config
2741  001f               L3131:
2742  001f 84            	pop	a
2743                     ; 771   TIM1_SelectInputTrigger((TIM1_TS_TypeDef)TIM1_TIxExternalCLKSource);
2745  0020 7b01          	ld	a,(OFST+1,sp)
2746  0022 cd0000        	call	_TIM1_SelectInputTrigger
2748                     ; 774   TIM1->SMCR |= (uint8_t)(TIM1_SLAVEMODE_EXTERNAL1);
2750  0025 c65252        	ld	a,21074
2751  0028 aa07          	or	a,#7
2752  002a c75252        	ld	21074,a
2753                     ; 775 }
2756  002d 85            	popw	x
2757  002e 81            	ret	
2842                     ; 787 void TIM1_SelectInputTrigger(TIM1_TS_TypeDef TIM1_InputTriggerSource)
2842                     ; 788 {
2843                     .text:	section	.text,new
2844  0000               _TIM1_SelectInputTrigger:
2846  0000 88            	push	a
2847       00000000      OFST:	set	0
2850                     ; 790   assert_param(IS_TIM1_TRIGGER_SELECTION_OK(TIM1_InputTriggerSource));
2852                     ; 793   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_TS)) | (uint8_t)TIM1_InputTriggerSource);
2854  0001 c65252        	ld	a,21074
2855  0004 a48f          	and	a,#143
2856  0006 1a01          	or	a,(OFST+1,sp)
2857  0008 c75252        	ld	21074,a
2858                     ; 794 }
2861  000b 84            	pop	a
2862  000c 81            	ret	
2898                     ; 803 void TIM1_UpdateDisableConfig(FunctionalState NewState)
2898                     ; 804 {
2899                     .text:	section	.text,new
2900  0000               _TIM1_UpdateDisableConfig:
2904                     ; 806   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2906                     ; 809   if (NewState != DISABLE)
2908  0000 4d            	tnz	a
2909  0001 2705          	jreq	L1731
2910                     ; 811     TIM1->CR1 |= TIM1_CR1_UDIS;
2912  0003 72125250      	bset	21072,#1
2915  0007 81            	ret	
2916  0008               L1731:
2917                     ; 815     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_UDIS);
2919  0008 72135250      	bres	21072,#1
2920                     ; 817 }
2923  000c 81            	ret	
2981                     ; 827 void TIM1_UpdateRequestConfig(TIM1_UpdateSource_TypeDef TIM1_UpdateSource)
2981                     ; 828 {
2982                     .text:	section	.text,new
2983  0000               _TIM1_UpdateRequestConfig:
2987                     ; 830   assert_param(IS_TIM1_UPDATE_SOURCE_OK(TIM1_UpdateSource));
2989                     ; 833   if (TIM1_UpdateSource != TIM1_UPDATESOURCE_GLOBAL)
2991  0000 4d            	tnz	a
2992  0001 2705          	jreq	L3241
2993                     ; 835     TIM1->CR1 |= TIM1_CR1_URS;
2995  0003 72145250      	bset	21072,#2
2998  0007 81            	ret	
2999  0008               L3241:
3000                     ; 839     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_URS);
3002  0008 72155250      	bres	21072,#2
3003                     ; 841 }
3006  000c 81            	ret	
3042                     ; 849 void TIM1_SelectHallSensor(FunctionalState NewState)
3042                     ; 850 {
3043                     .text:	section	.text,new
3044  0000               _TIM1_SelectHallSensor:
3048                     ; 852   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3050                     ; 855   if (NewState != DISABLE)
3052  0000 4d            	tnz	a
3053  0001 2705          	jreq	L5441
3054                     ; 857     TIM1->CR2 |= TIM1_CR2_TI1S;
3056  0003 721e5251      	bset	21073,#7
3059  0007 81            	ret	
3060  0008               L5441:
3061                     ; 861     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_TI1S);
3063  0008 721f5251      	bres	21073,#7
3064                     ; 863 }
3067  000c 81            	ret	
3124                     ; 873 void TIM1_SelectOnePulseMode(TIM1_OPMode_TypeDef TIM1_OPMode)
3124                     ; 874 {
3125                     .text:	section	.text,new
3126  0000               _TIM1_SelectOnePulseMode:
3130                     ; 876   assert_param(IS_TIM1_OPM_MODE_OK(TIM1_OPMode));
3132                     ; 879   if (TIM1_OPMode != TIM1_OPMODE_REPETITIVE)
3134  0000 4d            	tnz	a
3135  0001 2705          	jreq	L7741
3136                     ; 881     TIM1->CR1 |= TIM1_CR1_OPM;
3138  0003 72165250      	bset	21072,#3
3141  0007 81            	ret	
3142  0008               L7741:
3143                     ; 885     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_OPM);
3145  0008 72175250      	bres	21072,#3
3146                     ; 888 }
3149  000c 81            	ret	
3247                     ; 903 void TIM1_SelectOutputTrigger(TIM1_TRGOSource_TypeDef TIM1_TRGOSource)
3247                     ; 904 {
3248                     .text:	section	.text,new
3249  0000               _TIM1_SelectOutputTrigger:
3251  0000 88            	push	a
3252       00000000      OFST:	set	0
3255                     ; 906   assert_param(IS_TIM1_TRGO_SOURCE_OK(TIM1_TRGOSource));
3257                     ; 909   TIM1->CR2 = (uint8_t)((uint8_t)(TIM1->CR2 & (uint8_t)(~TIM1_CR2_MMS)) | 
3257                     ; 910                         (uint8_t) TIM1_TRGOSource);
3259  0001 c65251        	ld	a,21073
3260  0004 a48f          	and	a,#143
3261  0006 1a01          	or	a,(OFST+1,sp)
3262  0008 c75251        	ld	21073,a
3263                     ; 911 }
3266  000b 84            	pop	a
3267  000c 81            	ret	
3341                     ; 923 void TIM1_SelectSlaveMode(TIM1_SlaveMode_TypeDef TIM1_SlaveMode)
3341                     ; 924 {
3342                     .text:	section	.text,new
3343  0000               _TIM1_SelectSlaveMode:
3345  0000 88            	push	a
3346       00000000      OFST:	set	0
3349                     ; 926   assert_param(IS_TIM1_SLAVE_MODE_OK(TIM1_SlaveMode));
3351                     ; 929   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_SMS)) |
3351                     ; 930                          (uint8_t)TIM1_SlaveMode);
3353  0001 c65252        	ld	a,21074
3354  0004 a4f8          	and	a,#248
3355  0006 1a01          	or	a,(OFST+1,sp)
3356  0008 c75252        	ld	21074,a
3357                     ; 931 }
3360  000b 84            	pop	a
3361  000c 81            	ret	
3397                     ; 939 void TIM1_SelectMasterSlaveMode(FunctionalState NewState)
3397                     ; 940 {
3398                     .text:	section	.text,new
3399  0000               _TIM1_SelectMasterSlaveMode:
3403                     ; 942   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3405                     ; 945   if (NewState != DISABLE)
3407  0000 4d            	tnz	a
3408  0001 2705          	jreq	L3161
3409                     ; 947     TIM1->SMCR |= TIM1_SMCR_MSM;
3411  0003 721e5252      	bset	21074,#7
3414  0007 81            	ret	
3415  0008               L3161:
3416                     ; 951     TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_MSM);
3418  0008 721f5252      	bres	21074,#7
3419                     ; 953 }
3422  000c 81            	ret	
3508                     ; 975 void TIM1_EncoderInterfaceConfig(TIM1_EncoderMode_TypeDef TIM1_EncoderMode,
3508                     ; 976                                  TIM1_ICPolarity_TypeDef TIM1_IC1Polarity,
3508                     ; 977                                  TIM1_ICPolarity_TypeDef TIM1_IC2Polarity)
3508                     ; 978 {
3509                     .text:	section	.text,new
3510  0000               _TIM1_EncoderInterfaceConfig:
3512  0000 89            	pushw	x
3513       00000000      OFST:	set	0
3516                     ; 980   assert_param(IS_TIM1_ENCODER_MODE_OK(TIM1_EncoderMode));
3518                     ; 981   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC1Polarity));
3520                     ; 982   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC2Polarity));
3522                     ; 985   if (TIM1_IC1Polarity != TIM1_ICPOLARITY_RISING)
3524  0001 9f            	ld	a,xl
3525  0002 4d            	tnz	a
3526  0003 2706          	jreq	L7561
3527                     ; 987     TIM1->CCER1 |= TIM1_CCER1_CC1P;
3529  0005 7212525c      	bset	21084,#1
3531  0009 2004          	jra	L1661
3532  000b               L7561:
3533                     ; 991     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
3535  000b 7213525c      	bres	21084,#1
3536  000f               L1661:
3537                     ; 994   if (TIM1_IC2Polarity != TIM1_ICPOLARITY_RISING)
3539  000f 7b05          	ld	a,(OFST+5,sp)
3540  0011 2706          	jreq	L3661
3541                     ; 996     TIM1->CCER1 |= TIM1_CCER1_CC2P;
3543  0013 721a525c      	bset	21084,#5
3545  0017 2004          	jra	L5661
3546  0019               L3661:
3547                     ; 1000     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
3549  0019 721b525c      	bres	21084,#5
3550  001d               L5661:
3551                     ; 1003   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(TIM1_SMCR_MSM | TIM1_SMCR_TS))
3551                     ; 1004                          | (uint8_t) TIM1_EncoderMode);
3553  001d c65252        	ld	a,21074
3554  0020 a4f0          	and	a,#240
3555  0022 1a01          	or	a,(OFST+1,sp)
3556  0024 c75252        	ld	21074,a
3557                     ; 1007   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_CCxS)) 
3557                     ; 1008                           | (uint8_t) CCMR_TIxDirect_Set);
3559  0027 c65258        	ld	a,21080
3560  002a a4fc          	and	a,#252
3561  002c aa01          	or	a,#1
3562  002e c75258        	ld	21080,a
3563                     ; 1009   TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_CCxS))
3563                     ; 1010                           | (uint8_t) CCMR_TIxDirect_Set);
3565  0031 c65259        	ld	a,21081
3566  0034 a4fc          	and	a,#252
3567  0036 aa01          	or	a,#1
3568  0038 c75259        	ld	21081,a
3569                     ; 1011 }
3572  003b 85            	popw	x
3573  003c 81            	ret	
3640                     ; 1023 void TIM1_PrescalerConfig(uint16_t Prescaler,
3640                     ; 1024                           TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
3640                     ; 1025 {
3641                     .text:	section	.text,new
3642  0000               _TIM1_PrescalerConfig:
3644       fffffffe      OFST: set -2
3647                     ; 1027   assert_param(IS_TIM1_PRESCALER_RELOAD_OK(TIM1_PSCReloadMode));
3649                     ; 1030   TIM1->PSCRH = (uint8_t)(Prescaler >> 8);
3651  0000 9e            	ld	a,xh
3652  0001 c75260        	ld	21088,a
3653                     ; 1031   TIM1->PSCRL = (uint8_t)(Prescaler);
3655  0004 9f            	ld	a,xl
3656  0005 c75261        	ld	21089,a
3657                     ; 1034   TIM1->EGR = (uint8_t)TIM1_PSCReloadMode;
3659  0008 7b03          	ld	a,(OFST+5,sp)
3660  000a c75257        	ld	21079,a
3661                     ; 1035 }
3664  000d 81            	ret	
3700                     ; 1048 void TIM1_CounterModeConfig(TIM1_CounterMode_TypeDef TIM1_CounterMode)
3700                     ; 1049 {
3701                     .text:	section	.text,new
3702  0000               _TIM1_CounterModeConfig:
3704  0000 88            	push	a
3705       00000000      OFST:	set	0
3708                     ; 1051   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
3710                     ; 1055   TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)((uint8_t)(~TIM1_CR1_CMS) & (uint8_t)(~TIM1_CR1_DIR)))
3710                     ; 1056                         | (uint8_t)TIM1_CounterMode);
3712  0001 c65250        	ld	a,21072
3713  0004 a48f          	and	a,#143
3714  0006 1a01          	or	a,(OFST+1,sp)
3715  0008 c75250        	ld	21072,a
3716                     ; 1057 }
3719  000b 84            	pop	a
3720  000c 81            	ret	
3778                     ; 1067 void TIM1_ForcedOC1Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3778                     ; 1068 {
3779                     .text:	section	.text,new
3780  0000               _TIM1_ForcedOC1Config:
3782  0000 88            	push	a
3783       00000000      OFST:	set	0
3786                     ; 1070   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3788                     ; 1073   TIM1->CCMR1 =  (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM))|
3788                     ; 1074                            (uint8_t)TIM1_ForcedAction);
3790  0001 c65258        	ld	a,21080
3791  0004 a48f          	and	a,#143
3792  0006 1a01          	or	a,(OFST+1,sp)
3793  0008 c75258        	ld	21080,a
3794                     ; 1075 }
3797  000b 84            	pop	a
3798  000c 81            	ret	
3834                     ; 1085 void TIM1_ForcedOC2Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3834                     ; 1086 {
3835                     .text:	section	.text,new
3836  0000               _TIM1_ForcedOC2Config:
3838  0000 88            	push	a
3839       00000000      OFST:	set	0
3842                     ; 1088   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3844                     ; 1091   TIM1->CCMR2  =  (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM))
3844                     ; 1092                             | (uint8_t)TIM1_ForcedAction);
3846  0001 c65259        	ld	a,21081
3847  0004 a48f          	and	a,#143
3848  0006 1a01          	or	a,(OFST+1,sp)
3849  0008 c75259        	ld	21081,a
3850                     ; 1093 }
3853  000b 84            	pop	a
3854  000c 81            	ret	
3890                     ; 1104 void TIM1_ForcedOC3Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3890                     ; 1105 {
3891                     .text:	section	.text,new
3892  0000               _TIM1_ForcedOC3Config:
3894  0000 88            	push	a
3895       00000000      OFST:	set	0
3898                     ; 1107   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3900                     ; 1110   TIM1->CCMR3  =  (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM))  
3900                     ; 1111                             | (uint8_t)TIM1_ForcedAction);
3902  0001 c6525a        	ld	a,21082
3903  0004 a48f          	and	a,#143
3904  0006 1a01          	or	a,(OFST+1,sp)
3905  0008 c7525a        	ld	21082,a
3906                     ; 1112 }
3909  000b 84            	pop	a
3910  000c 81            	ret	
3946                     ; 1123 void TIM1_ForcedOC4Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3946                     ; 1124 {
3947                     .text:	section	.text,new
3948  0000               _TIM1_ForcedOC4Config:
3950  0000 88            	push	a
3951       00000000      OFST:	set	0
3954                     ; 1126   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3956                     ; 1129   TIM1->CCMR4  =  (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) 
3956                     ; 1130                             | (uint8_t)TIM1_ForcedAction);
3958  0001 c6525b        	ld	a,21083
3959  0004 a48f          	and	a,#143
3960  0006 1a01          	or	a,(OFST+1,sp)
3961  0008 c7525b        	ld	21083,a
3962                     ; 1131 }
3965  000b 84            	pop	a
3966  000c 81            	ret	
4002                     ; 1139 void TIM1_ARRPreloadConfig(FunctionalState NewState)
4002                     ; 1140 {
4003                     .text:	section	.text,new
4004  0000               _TIM1_ARRPreloadConfig:
4008                     ; 1142   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4010                     ; 1145   if (NewState != DISABLE)
4012  0000 4d            	tnz	a
4013  0001 2705          	jreq	L5502
4014                     ; 1147     TIM1->CR1 |= TIM1_CR1_ARPE;
4016  0003 721e5250      	bset	21072,#7
4019  0007 81            	ret	
4020  0008               L5502:
4021                     ; 1151     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_ARPE);
4023  0008 721f5250      	bres	21072,#7
4024                     ; 1153 }
4027  000c 81            	ret	
4062                     ; 1161 void TIM1_SelectCOM(FunctionalState NewState)
4062                     ; 1162 {
4063                     .text:	section	.text,new
4064  0000               _TIM1_SelectCOM:
4068                     ; 1164   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4070                     ; 1167   if (NewState != DISABLE)
4072  0000 4d            	tnz	a
4073  0001 2705          	jreq	L7702
4074                     ; 1169     TIM1->CR2 |= TIM1_CR2_COMS;
4076  0003 72145251      	bset	21073,#2
4079  0007 81            	ret	
4080  0008               L7702:
4081                     ; 1173     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_COMS);
4083  0008 72155251      	bres	21073,#2
4084                     ; 1175 }
4087  000c 81            	ret	
4123                     ; 1183 void TIM1_CCPreloadControl(FunctionalState NewState)
4123                     ; 1184 {
4124                     .text:	section	.text,new
4125  0000               _TIM1_CCPreloadControl:
4129                     ; 1186   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4131                     ; 1189   if (NewState != DISABLE)
4133  0000 4d            	tnz	a
4134  0001 2705          	jreq	L1212
4135                     ; 1191     TIM1->CR2 |= TIM1_CR2_CCPC;
4137  0003 72105251      	bset	21073,#0
4140  0007 81            	ret	
4141  0008               L1212:
4142                     ; 1195     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_CCPC);
4144  0008 72115251      	bres	21073,#0
4145                     ; 1197 }
4148  000c 81            	ret	
4184                     ; 1205 void TIM1_OC1PreloadConfig(FunctionalState NewState)
4184                     ; 1206 {
4185                     .text:	section	.text,new
4186  0000               _TIM1_OC1PreloadConfig:
4190                     ; 1208   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4192                     ; 1211   if (NewState != DISABLE)
4194  0000 4d            	tnz	a
4195  0001 2705          	jreq	L3412
4196                     ; 1213     TIM1->CCMR1 |= TIM1_CCMR_OCxPE;
4198  0003 72165258      	bset	21080,#3
4201  0007 81            	ret	
4202  0008               L3412:
4203                     ; 1217     TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4205  0008 72175258      	bres	21080,#3
4206                     ; 1219 }
4209  000c 81            	ret	
4245                     ; 1227 void TIM1_OC2PreloadConfig(FunctionalState NewState)
4245                     ; 1228 {
4246                     .text:	section	.text,new
4247  0000               _TIM1_OC2PreloadConfig:
4251                     ; 1230   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4253                     ; 1233   if (NewState != DISABLE)
4255  0000 4d            	tnz	a
4256  0001 2705          	jreq	L5612
4257                     ; 1235     TIM1->CCMR2 |= TIM1_CCMR_OCxPE;
4259  0003 72165259      	bset	21081,#3
4262  0007 81            	ret	
4263  0008               L5612:
4264                     ; 1239     TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4266  0008 72175259      	bres	21081,#3
4267                     ; 1241 }
4270  000c 81            	ret	
4306                     ; 1249 void TIM1_OC3PreloadConfig(FunctionalState NewState)
4306                     ; 1250 {
4307                     .text:	section	.text,new
4308  0000               _TIM1_OC3PreloadConfig:
4312                     ; 1252   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4314                     ; 1255   if (NewState != DISABLE)
4316  0000 4d            	tnz	a
4317  0001 2705          	jreq	L7022
4318                     ; 1257     TIM1->CCMR3 |= TIM1_CCMR_OCxPE;
4320  0003 7216525a      	bset	21082,#3
4323  0007 81            	ret	
4324  0008               L7022:
4325                     ; 1261     TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4327  0008 7217525a      	bres	21082,#3
4328                     ; 1263 }
4331  000c 81            	ret	
4367                     ; 1271 void TIM1_OC4PreloadConfig(FunctionalState NewState)
4367                     ; 1272 {
4368                     .text:	section	.text,new
4369  0000               _TIM1_OC4PreloadConfig:
4373                     ; 1274   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4375                     ; 1277   if (NewState != DISABLE)
4377  0000 4d            	tnz	a
4378  0001 2705          	jreq	L1322
4379                     ; 1279     TIM1->CCMR4 |= TIM1_CCMR_OCxPE;
4381  0003 7216525b      	bset	21083,#3
4384  0007 81            	ret	
4385  0008               L1322:
4386                     ; 1283     TIM1->CCMR4 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4388  0008 7217525b      	bres	21083,#3
4389                     ; 1285 }
4392  000c 81            	ret	
4427                     ; 1293 void TIM1_OC1FastConfig(FunctionalState NewState)
4427                     ; 1294 {
4428                     .text:	section	.text,new
4429  0000               _TIM1_OC1FastConfig:
4433                     ; 1296   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4435                     ; 1299   if (NewState != DISABLE)
4437  0000 4d            	tnz	a
4438  0001 2705          	jreq	L3522
4439                     ; 1301     TIM1->CCMR1 |= TIM1_CCMR_OCxFE;
4441  0003 72145258      	bset	21080,#2
4444  0007 81            	ret	
4445  0008               L3522:
4446                     ; 1305     TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4448  0008 72155258      	bres	21080,#2
4449                     ; 1307 }
4452  000c 81            	ret	
4487                     ; 1315 void TIM1_OC2FastConfig(FunctionalState NewState)
4487                     ; 1316 {
4488                     .text:	section	.text,new
4489  0000               _TIM1_OC2FastConfig:
4493                     ; 1318   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4495                     ; 1321   if (NewState != DISABLE)
4497  0000 4d            	tnz	a
4498  0001 2705          	jreq	L5722
4499                     ; 1323     TIM1->CCMR2 |= TIM1_CCMR_OCxFE;
4501  0003 72145259      	bset	21081,#2
4504  0007 81            	ret	
4505  0008               L5722:
4506                     ; 1327     TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4508  0008 72155259      	bres	21081,#2
4509                     ; 1329 }
4512  000c 81            	ret	
4547                     ; 1337 void TIM1_OC3FastConfig(FunctionalState NewState)
4547                     ; 1338 {
4548                     .text:	section	.text,new
4549  0000               _TIM1_OC3FastConfig:
4553                     ; 1340   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4555                     ; 1343   if (NewState != DISABLE)
4557  0000 4d            	tnz	a
4558  0001 2705          	jreq	L7132
4559                     ; 1345     TIM1->CCMR3 |= TIM1_CCMR_OCxFE;
4561  0003 7214525a      	bset	21082,#2
4564  0007 81            	ret	
4565  0008               L7132:
4566                     ; 1349     TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4568  0008 7215525a      	bres	21082,#2
4569                     ; 1351 }
4572  000c 81            	ret	
4607                     ; 1359 void TIM1_OC4FastConfig(FunctionalState NewState)
4607                     ; 1360 {
4608                     .text:	section	.text,new
4609  0000               _TIM1_OC4FastConfig:
4613                     ; 1362   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4615                     ; 1365   if (NewState != DISABLE)
4617  0000 4d            	tnz	a
4618  0001 2705          	jreq	L1432
4619                     ; 1367     TIM1->CCMR4 |= TIM1_CCMR_OCxFE;
4621  0003 7214525b      	bset	21083,#2
4624  0007 81            	ret	
4625  0008               L1432:
4626                     ; 1371     TIM1->CCMR4 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4628  0008 7215525b      	bres	21083,#2
4629                     ; 1373 }
4632  000c 81            	ret	
4737                     ; 1389 void TIM1_GenerateEvent(TIM1_EventSource_TypeDef TIM1_EventSource)
4737                     ; 1390 {
4738                     .text:	section	.text,new
4739  0000               _TIM1_GenerateEvent:
4743                     ; 1392   assert_param(IS_TIM1_EVENT_SOURCE_OK(TIM1_EventSource));
4745                     ; 1395   TIM1->EGR = (uint8_t)TIM1_EventSource;
4747  0000 c75257        	ld	21079,a
4748                     ; 1396 }
4751  0003 81            	ret	
4787                     ; 1406 void TIM1_OC1PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4787                     ; 1407 {
4788                     .text:	section	.text,new
4789  0000               _TIM1_OC1PolarityConfig:
4793                     ; 1409   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4795                     ; 1412   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4797  0000 4d            	tnz	a
4798  0001 2705          	jreq	L5242
4799                     ; 1414     TIM1->CCER1 |= TIM1_CCER1_CC1P;
4801  0003 7212525c      	bset	21084,#1
4804  0007 81            	ret	
4805  0008               L5242:
4806                     ; 1418     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
4808  0008 7213525c      	bres	21084,#1
4809                     ; 1420 }
4812  000c 81            	ret	
4848                     ; 1430 void TIM1_OC1NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4848                     ; 1431 {
4849                     .text:	section	.text,new
4850  0000               _TIM1_OC1NPolarityConfig:
4854                     ; 1433   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4856                     ; 1436   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4858  0000 4d            	tnz	a
4859  0001 2705          	jreq	L7442
4860                     ; 1438     TIM1->CCER1 |= TIM1_CCER1_CC1NP;
4862  0003 7216525c      	bset	21084,#3
4865  0007 81            	ret	
4866  0008               L7442:
4867                     ; 1442     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1NP);
4869  0008 7217525c      	bres	21084,#3
4870                     ; 1444 }
4873  000c 81            	ret	
4909                     ; 1454 void TIM1_OC2PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4909                     ; 1455 {
4910                     .text:	section	.text,new
4911  0000               _TIM1_OC2PolarityConfig:
4915                     ; 1457   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4917                     ; 1460   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4919  0000 4d            	tnz	a
4920  0001 2705          	jreq	L1742
4921                     ; 1462     TIM1->CCER1 |= TIM1_CCER1_CC2P;
4923  0003 721a525c      	bset	21084,#5
4926  0007 81            	ret	
4927  0008               L1742:
4928                     ; 1466     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
4930  0008 721b525c      	bres	21084,#5
4931                     ; 1468 }
4934  000c 81            	ret	
4970                     ; 1478 void TIM1_OC2NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4970                     ; 1479 {
4971                     .text:	section	.text,new
4972  0000               _TIM1_OC2NPolarityConfig:
4976                     ; 1481   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4978                     ; 1484   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4980  0000 4d            	tnz	a
4981  0001 2705          	jreq	L3152
4982                     ; 1486     TIM1->CCER1 |= TIM1_CCER1_CC2NP;
4984  0003 721e525c      	bset	21084,#7
4987  0007 81            	ret	
4988  0008               L3152:
4989                     ; 1490     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2NP);
4991  0008 721f525c      	bres	21084,#7
4992                     ; 1492 }
4995  000c 81            	ret	
5031                     ; 1502 void TIM1_OC3PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
5031                     ; 1503 {
5032                     .text:	section	.text,new
5033  0000               _TIM1_OC3PolarityConfig:
5037                     ; 1505   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
5039                     ; 1508   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
5041  0000 4d            	tnz	a
5042  0001 2705          	jreq	L5352
5043                     ; 1510     TIM1->CCER2 |= TIM1_CCER2_CC3P;
5045  0003 7212525d      	bset	21085,#1
5048  0007 81            	ret	
5049  0008               L5352:
5050                     ; 1514     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
5052  0008 7213525d      	bres	21085,#1
5053                     ; 1516 }
5056  000c 81            	ret	
5092                     ; 1527 void TIM1_OC3NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
5092                     ; 1528 {
5093                     .text:	section	.text,new
5094  0000               _TIM1_OC3NPolarityConfig:
5098                     ; 1530   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
5100                     ; 1533   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
5102  0000 4d            	tnz	a
5103  0001 2705          	jreq	L7552
5104                     ; 1535     TIM1->CCER2 |= TIM1_CCER2_CC3NP;
5106  0003 7216525d      	bset	21085,#3
5109  0007 81            	ret	
5110  0008               L7552:
5111                     ; 1539     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NP);
5113  0008 7217525d      	bres	21085,#3
5114                     ; 1541 }
5117  000c 81            	ret	
5153                     ; 1551 void TIM1_OC4PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
5153                     ; 1552 {
5154                     .text:	section	.text,new
5155  0000               _TIM1_OC4PolarityConfig:
5159                     ; 1554   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
5161                     ; 1557   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
5163  0000 4d            	tnz	a
5164  0001 2705          	jreq	L1062
5165                     ; 1559     TIM1->CCER2 |= TIM1_CCER2_CC4P;
5167  0003 721a525d      	bset	21085,#5
5170  0007 81            	ret	
5171  0008               L1062:
5172                     ; 1563     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4P);
5174  0008 721b525d      	bres	21085,#5
5175                     ; 1565 }
5178  000c 81            	ret	
5223                     ; 1579 void TIM1_CCxCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
5223                     ; 1580 {
5224                     .text:	section	.text,new
5225  0000               _TIM1_CCxCmd:
5227  0000 89            	pushw	x
5228       00000000      OFST:	set	0
5231                     ; 1582   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5233                     ; 1583   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
5235                     ; 1585   if (TIM1_Channel == TIM1_CHANNEL_1)
5237  0001 9e            	ld	a,xh
5238  0002 4d            	tnz	a
5239  0003 2610          	jrne	L7262
5240                     ; 1588     if (NewState != DISABLE)
5242  0005 9f            	ld	a,xl
5243  0006 4d            	tnz	a
5244  0007 2706          	jreq	L1362
5245                     ; 1590       TIM1->CCER1 |= TIM1_CCER1_CC1E;
5247  0009 7210525c      	bset	21084,#0
5249  000d 203e          	jra	L5362
5250  000f               L1362:
5251                     ; 1594       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5253  000f 7211525c      	bres	21084,#0
5254  0013 2038          	jra	L5362
5255  0015               L7262:
5256                     ; 1598   else if (TIM1_Channel == TIM1_CHANNEL_2)
5258  0015 7b01          	ld	a,(OFST+1,sp)
5259  0017 a101          	cp	a,#1
5260  0019 2610          	jrne	L7362
5261                     ; 1601     if (NewState != DISABLE)
5263  001b 7b02          	ld	a,(OFST+2,sp)
5264  001d 2706          	jreq	L1462
5265                     ; 1603       TIM1->CCER1 |= TIM1_CCER1_CC2E;
5267  001f 7218525c      	bset	21084,#4
5269  0023 2028          	jra	L5362
5270  0025               L1462:
5271                     ; 1607       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2E);
5273  0025 7219525c      	bres	21084,#4
5274  0029 2022          	jra	L5362
5275  002b               L7362:
5276                     ; 1610   else if (TIM1_Channel == TIM1_CHANNEL_3)
5278  002b a102          	cp	a,#2
5279  002d 2610          	jrne	L7462
5280                     ; 1613     if (NewState != DISABLE)
5282  002f 7b02          	ld	a,(OFST+2,sp)
5283  0031 2706          	jreq	L1562
5284                     ; 1615       TIM1->CCER2 |= TIM1_CCER2_CC3E;
5286  0033 7210525d      	bset	21085,#0
5288  0037 2014          	jra	L5362
5289  0039               L1562:
5290                     ; 1619       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3E);
5292  0039 7211525d      	bres	21085,#0
5293  003d 200e          	jra	L5362
5294  003f               L7462:
5295                     ; 1625     if (NewState != DISABLE)
5297  003f 7b02          	ld	a,(OFST+2,sp)
5298  0041 2706          	jreq	L7562
5299                     ; 1627       TIM1->CCER2 |= TIM1_CCER2_CC4E;
5301  0043 7218525d      	bset	21085,#4
5303  0047 2004          	jra	L5362
5304  0049               L7562:
5305                     ; 1631       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4E);
5307  0049 7219525d      	bres	21085,#4
5308  004d               L5362:
5309                     ; 1634 }
5312  004d 85            	popw	x
5313  004e 81            	ret	
5358                     ; 1647 void TIM1_CCxNCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
5358                     ; 1648 {
5359                     .text:	section	.text,new
5360  0000               _TIM1_CCxNCmd:
5362  0000 89            	pushw	x
5363       00000000      OFST:	set	0
5366                     ; 1650   assert_param(IS_TIM1_COMPLEMENTARY_CHANNEL_OK(TIM1_Channel));
5368                     ; 1651   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
5370                     ; 1653   if (TIM1_Channel == TIM1_CHANNEL_1)
5372  0001 9e            	ld	a,xh
5373  0002 4d            	tnz	a
5374  0003 2610          	jrne	L5072
5375                     ; 1656     if (NewState != DISABLE)
5377  0005 9f            	ld	a,xl
5378  0006 4d            	tnz	a
5379  0007 2706          	jreq	L7072
5380                     ; 1658       TIM1->CCER1 |= TIM1_CCER1_CC1NE;
5382  0009 7214525c      	bset	21084,#2
5384  000d 2029          	jra	L3172
5385  000f               L7072:
5386                     ; 1662       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1NE);
5388  000f 7215525c      	bres	21084,#2
5389  0013 2023          	jra	L3172
5390  0015               L5072:
5391                     ; 1665   else if (TIM1_Channel == TIM1_CHANNEL_2)
5393  0015 7b01          	ld	a,(OFST+1,sp)
5394  0017 4a            	dec	a
5395  0018 2610          	jrne	L5172
5396                     ; 1668     if (NewState != DISABLE)
5398  001a 7b02          	ld	a,(OFST+2,sp)
5399  001c 2706          	jreq	L7172
5400                     ; 1670       TIM1->CCER1 |= TIM1_CCER1_CC2NE;
5402  001e 721c525c      	bset	21084,#6
5404  0022 2014          	jra	L3172
5405  0024               L7172:
5406                     ; 1674       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2NE);
5408  0024 721d525c      	bres	21084,#6
5409  0028 200e          	jra	L3172
5410  002a               L5172:
5411                     ; 1680     if (NewState != DISABLE)
5413  002a 7b02          	ld	a,(OFST+2,sp)
5414  002c 2706          	jreq	L5272
5415                     ; 1682       TIM1->CCER2 |= TIM1_CCER2_CC3NE;
5417  002e 7214525d      	bset	21085,#2
5419  0032 2004          	jra	L3172
5420  0034               L5272:
5421                     ; 1686       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NE);
5423  0034 7215525d      	bres	21085,#2
5424  0038               L3172:
5425                     ; 1689 }
5428  0038 85            	popw	x
5429  0039 81            	ret	
5474                     ; 1712 void TIM1_SelectOCxM(TIM1_Channel_TypeDef TIM1_Channel, TIM1_OCMode_TypeDef TIM1_OCMode)
5474                     ; 1713 {
5475                     .text:	section	.text,new
5476  0000               _TIM1_SelectOCxM:
5478  0000 89            	pushw	x
5479       00000000      OFST:	set	0
5482                     ; 1715   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5484                     ; 1716   assert_param(IS_TIM1_OCM_OK(TIM1_OCMode));
5486                     ; 1718   if (TIM1_Channel == TIM1_CHANNEL_1)
5488  0001 9e            	ld	a,xh
5489  0002 4d            	tnz	a
5490  0003 2610          	jrne	L3572
5491                     ; 1721     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5493  0005 7211525c      	bres	21084,#0
5494                     ; 1724     TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM)) 
5494                     ; 1725                             | (uint8_t)TIM1_OCMode);
5496  0009 c65258        	ld	a,21080
5497  000c a48f          	and	a,#143
5498  000e 1a02          	or	a,(OFST+2,sp)
5499  0010 c75258        	ld	21080,a
5501  0013 2038          	jra	L5572
5502  0015               L3572:
5503                     ; 1727   else if (TIM1_Channel == TIM1_CHANNEL_2)
5505  0015 7b01          	ld	a,(OFST+1,sp)
5506  0017 a101          	cp	a,#1
5507  0019 2610          	jrne	L7572
5508                     ; 1730     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2E);
5510  001b 7219525c      	bres	21084,#4
5511                     ; 1733     TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM))
5511                     ; 1734                             | (uint8_t)TIM1_OCMode);
5513  001f c65259        	ld	a,21081
5514  0022 a48f          	and	a,#143
5515  0024 1a02          	or	a,(OFST+2,sp)
5516  0026 c75259        	ld	21081,a
5518  0029 2022          	jra	L5572
5519  002b               L7572:
5520                     ; 1736   else if (TIM1_Channel == TIM1_CHANNEL_3)
5522  002b a102          	cp	a,#2
5523  002d 2610          	jrne	L3672
5524                     ; 1739     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3E);
5526  002f 7211525d      	bres	21085,#0
5527                     ; 1742     TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) 
5527                     ; 1743                             | (uint8_t)TIM1_OCMode);
5529  0033 c6525a        	ld	a,21082
5530  0036 a48f          	and	a,#143
5531  0038 1a02          	or	a,(OFST+2,sp)
5532  003a c7525a        	ld	21082,a
5534  003d 200e          	jra	L5572
5535  003f               L3672:
5536                     ; 1748     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4E);
5538  003f 7219525d      	bres	21085,#4
5539                     ; 1751     TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) 
5539                     ; 1752                             | (uint8_t)TIM1_OCMode);
5541  0043 c6525b        	ld	a,21083
5542  0046 a48f          	and	a,#143
5543  0048 1a02          	or	a,(OFST+2,sp)
5544  004a c7525b        	ld	21083,a
5545  004d               L5572:
5546                     ; 1754 }
5549  004d 85            	popw	x
5550  004e 81            	ret	
5584                     ; 1762 void TIM1_SetCounter(uint16_t Counter)
5584                     ; 1763 {
5585                     .text:	section	.text,new
5586  0000               _TIM1_SetCounter:
5590                     ; 1765   TIM1->CNTRH = (uint8_t)(Counter >> 8);
5592  0000 9e            	ld	a,xh
5593  0001 c7525e        	ld	21086,a
5594                     ; 1766   TIM1->CNTRL = (uint8_t)(Counter);
5596  0004 9f            	ld	a,xl
5597  0005 c7525f        	ld	21087,a
5598                     ; 1767 }
5601  0008 81            	ret	
5635                     ; 1775 void TIM1_SetAutoreload(uint16_t Autoreload)
5635                     ; 1776 {
5636                     .text:	section	.text,new
5637  0000               _TIM1_SetAutoreload:
5641                     ; 1778   TIM1->ARRH = (uint8_t)(Autoreload >> 8);
5643  0000 9e            	ld	a,xh
5644  0001 c75262        	ld	21090,a
5645                     ; 1779   TIM1->ARRL = (uint8_t)(Autoreload);
5647  0004 9f            	ld	a,xl
5648  0005 c75263        	ld	21091,a
5649                     ; 1780  }
5652  0008 81            	ret	
5686                     ; 1788 void TIM1_SetCompare1(uint16_t Compare1)
5686                     ; 1789 {
5687                     .text:	section	.text,new
5688  0000               _TIM1_SetCompare1:
5692                     ; 1791   TIM1->CCR1H = (uint8_t)(Compare1 >> 8);
5694  0000 9e            	ld	a,xh
5695  0001 c75265        	ld	21093,a
5696                     ; 1792   TIM1->CCR1L = (uint8_t)(Compare1);
5698  0004 9f            	ld	a,xl
5699  0005 c75266        	ld	21094,a
5700                     ; 1793 }
5703  0008 81            	ret	
5737                     ; 1801 void TIM1_SetCompare2(uint16_t Compare2)
5737                     ; 1802 {
5738                     .text:	section	.text,new
5739  0000               _TIM1_SetCompare2:
5743                     ; 1804   TIM1->CCR2H = (uint8_t)(Compare2 >> 8);
5745  0000 9e            	ld	a,xh
5746  0001 c75267        	ld	21095,a
5747                     ; 1805   TIM1->CCR2L = (uint8_t)(Compare2);
5749  0004 9f            	ld	a,xl
5750  0005 c75268        	ld	21096,a
5751                     ; 1806 }
5754  0008 81            	ret	
5788                     ; 1814 void TIM1_SetCompare3(uint16_t Compare3)
5788                     ; 1815 {
5789                     .text:	section	.text,new
5790  0000               _TIM1_SetCompare3:
5794                     ; 1817   TIM1->CCR3H = (uint8_t)(Compare3 >> 8);
5796  0000 9e            	ld	a,xh
5797  0001 c75269        	ld	21097,a
5798                     ; 1818   TIM1->CCR3L = (uint8_t)(Compare3);
5800  0004 9f            	ld	a,xl
5801  0005 c7526a        	ld	21098,a
5802                     ; 1819 }
5805  0008 81            	ret	
5839                     ; 1827 void TIM1_SetCompare4(uint16_t Compare4)
5839                     ; 1828 {
5840                     .text:	section	.text,new
5841  0000               _TIM1_SetCompare4:
5845                     ; 1830   TIM1->CCR4H = (uint8_t)(Compare4 >> 8);
5847  0000 9e            	ld	a,xh
5848  0001 c7526b        	ld	21099,a
5849                     ; 1831   TIM1->CCR4L = (uint8_t)(Compare4);
5851  0004 9f            	ld	a,xl
5852  0005 c7526c        	ld	21100,a
5853                     ; 1832 }
5856  0008 81            	ret	
5892                     ; 1844 void TIM1_SetIC1Prescaler(TIM1_ICPSC_TypeDef TIM1_IC1Prescaler)
5892                     ; 1845 {
5893                     .text:	section	.text,new
5894  0000               _TIM1_SetIC1Prescaler:
5896  0000 88            	push	a
5897       00000000      OFST:	set	0
5900                     ; 1847   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC1Prescaler));
5902                     ; 1850   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
5902                     ; 1851                           | (uint8_t)TIM1_IC1Prescaler);
5904  0001 c65258        	ld	a,21080
5905  0004 a4f3          	and	a,#243
5906  0006 1a01          	or	a,(OFST+1,sp)
5907  0008 c75258        	ld	21080,a
5908                     ; 1852 }
5911  000b 84            	pop	a
5912  000c 81            	ret	
5948                     ; 1864 void TIM1_SetIC2Prescaler(TIM1_ICPSC_TypeDef TIM1_IC2Prescaler)
5948                     ; 1865 {
5949                     .text:	section	.text,new
5950  0000               _TIM1_SetIC2Prescaler:
5952  0000 88            	push	a
5953       00000000      OFST:	set	0
5956                     ; 1868   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC2Prescaler));
5958                     ; 1871   TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_ICxPSC))
5958                     ; 1872                           | (uint8_t)TIM1_IC2Prescaler);
5960  0001 c65259        	ld	a,21081
5961  0004 a4f3          	and	a,#243
5962  0006 1a01          	or	a,(OFST+1,sp)
5963  0008 c75259        	ld	21081,a
5964                     ; 1873 }
5967  000b 84            	pop	a
5968  000c 81            	ret	
6004                     ; 1885 void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler)
6004                     ; 1886 {
6005                     .text:	section	.text,new
6006  0000               _TIM1_SetIC3Prescaler:
6008  0000 88            	push	a
6009       00000000      OFST:	set	0
6012                     ; 1889   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC3Prescaler));
6014                     ; 1892   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_ICxPSC)) | 
6014                     ; 1893                           (uint8_t)TIM1_IC3Prescaler);
6016  0001 c6525a        	ld	a,21082
6017  0004 a4f3          	and	a,#243
6018  0006 1a01          	or	a,(OFST+1,sp)
6019  0008 c7525a        	ld	21082,a
6020                     ; 1894 }
6023  000b 84            	pop	a
6024  000c 81            	ret	
6060                     ; 1906 void TIM1_SetIC4Prescaler(TIM1_ICPSC_TypeDef TIM1_IC4Prescaler)
6060                     ; 1907 {
6061                     .text:	section	.text,new
6062  0000               _TIM1_SetIC4Prescaler:
6064  0000 88            	push	a
6065       00000000      OFST:	set	0
6068                     ; 1910   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC4Prescaler));
6070                     ; 1913   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_ICxPSC)) |
6070                     ; 1914                           (uint8_t)TIM1_IC4Prescaler);
6072  0001 c6525b        	ld	a,21083
6073  0004 a4f3          	and	a,#243
6074  0006 1a01          	or	a,(OFST+1,sp)
6075  0008 c7525b        	ld	21083,a
6076                     ; 1915 }
6079  000b 84            	pop	a
6080  000c 81            	ret	
6132                     ; 1922 uint16_t TIM1_GetCapture1(void)
6132                     ; 1923 {
6133                     .text:	section	.text,new
6134  0000               _TIM1_GetCapture1:
6136  0000 5204          	subw	sp,#4
6137       00000004      OFST:	set	4
6140                     ; 1926   uint16_t tmpccr1 = 0;
6142                     ; 1927   uint8_t tmpccr1l=0, tmpccr1h=0;
6146                     ; 1929   tmpccr1h = TIM1->CCR1H;
6148  0002 c65265        	ld	a,21093
6149  0005 6b02          	ld	(OFST-2,sp),a
6151                     ; 1930   tmpccr1l = TIM1->CCR1L;
6153  0007 c65266        	ld	a,21094
6154  000a 6b01          	ld	(OFST-3,sp),a
6156                     ; 1932   tmpccr1 = (uint16_t)(tmpccr1l);
6158  000c 5f            	clrw	x
6159  000d 97            	ld	xl,a
6160  000e 1f03          	ldw	(OFST-1,sp),x
6162                     ; 1933   tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
6164  0010 5f            	clrw	x
6165  0011 7b02          	ld	a,(OFST-2,sp)
6166  0013 97            	ld	xl,a
6167  0014 7b04          	ld	a,(OFST+0,sp)
6168  0016 01            	rrwa	x,a
6169  0017 1a03          	or	a,(OFST-1,sp)
6170  0019 01            	rrwa	x,a
6172                     ; 1935   return (uint16_t)tmpccr1;
6176  001a 5b04          	addw	sp,#4
6177  001c 81            	ret	
6229                     ; 1943 uint16_t TIM1_GetCapture2(void)
6229                     ; 1944 {
6230                     .text:	section	.text,new
6231  0000               _TIM1_GetCapture2:
6233  0000 5204          	subw	sp,#4
6234       00000004      OFST:	set	4
6237                     ; 1947   uint16_t tmpccr2 = 0;
6239                     ; 1948   uint8_t tmpccr2l=0, tmpccr2h=0;
6243                     ; 1950   tmpccr2h = TIM1->CCR2H;
6245  0002 c65267        	ld	a,21095
6246  0005 6b02          	ld	(OFST-2,sp),a
6248                     ; 1951   tmpccr2l = TIM1->CCR2L;
6250  0007 c65268        	ld	a,21096
6251  000a 6b01          	ld	(OFST-3,sp),a
6253                     ; 1953   tmpccr2 = (uint16_t)(tmpccr2l);
6255  000c 5f            	clrw	x
6256  000d 97            	ld	xl,a
6257  000e 1f03          	ldw	(OFST-1,sp),x
6259                     ; 1954   tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
6261  0010 5f            	clrw	x
6262  0011 7b02          	ld	a,(OFST-2,sp)
6263  0013 97            	ld	xl,a
6264  0014 7b04          	ld	a,(OFST+0,sp)
6265  0016 01            	rrwa	x,a
6266  0017 1a03          	or	a,(OFST-1,sp)
6267  0019 01            	rrwa	x,a
6269                     ; 1956   return (uint16_t)tmpccr2;
6273  001a 5b04          	addw	sp,#4
6274  001c 81            	ret	
6326                     ; 1964 uint16_t TIM1_GetCapture3(void)
6326                     ; 1965 {
6327                     .text:	section	.text,new
6328  0000               _TIM1_GetCapture3:
6330  0000 5204          	subw	sp,#4
6331       00000004      OFST:	set	4
6334                     ; 1967   uint16_t tmpccr3 = 0;
6336                     ; 1968   uint8_t tmpccr3l=0, tmpccr3h=0;
6340                     ; 1970   tmpccr3h = TIM1->CCR3H;
6342  0002 c65269        	ld	a,21097
6343  0005 6b02          	ld	(OFST-2,sp),a
6345                     ; 1971   tmpccr3l = TIM1->CCR3L;
6347  0007 c6526a        	ld	a,21098
6348  000a 6b01          	ld	(OFST-3,sp),a
6350                     ; 1973   tmpccr3 = (uint16_t)(tmpccr3l);
6352  000c 5f            	clrw	x
6353  000d 97            	ld	xl,a
6354  000e 1f03          	ldw	(OFST-1,sp),x
6356                     ; 1974   tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
6358  0010 5f            	clrw	x
6359  0011 7b02          	ld	a,(OFST-2,sp)
6360  0013 97            	ld	xl,a
6361  0014 7b04          	ld	a,(OFST+0,sp)
6362  0016 01            	rrwa	x,a
6363  0017 1a03          	or	a,(OFST-1,sp)
6364  0019 01            	rrwa	x,a
6366                     ; 1976   return (uint16_t)tmpccr3;
6370  001a 5b04          	addw	sp,#4
6371  001c 81            	ret	
6423                     ; 1984 uint16_t TIM1_GetCapture4(void)
6423                     ; 1985 {
6424                     .text:	section	.text,new
6425  0000               _TIM1_GetCapture4:
6427  0000 5204          	subw	sp,#4
6428       00000004      OFST:	set	4
6431                     ; 1987   uint16_t tmpccr4 = 0;
6433                     ; 1988   uint8_t tmpccr4l=0, tmpccr4h=0;
6437                     ; 1990   tmpccr4h = TIM1->CCR4H;
6439  0002 c6526b        	ld	a,21099
6440  0005 6b02          	ld	(OFST-2,sp),a
6442                     ; 1991   tmpccr4l = TIM1->CCR4L;
6444  0007 c6526c        	ld	a,21100
6445  000a 6b01          	ld	(OFST-3,sp),a
6447                     ; 1993   tmpccr4 = (uint16_t)(tmpccr4l);
6449  000c 5f            	clrw	x
6450  000d 97            	ld	xl,a
6451  000e 1f03          	ldw	(OFST-1,sp),x
6453                     ; 1994   tmpccr4 |= (uint16_t)((uint16_t)tmpccr4h << 8);
6455  0010 5f            	clrw	x
6456  0011 7b02          	ld	a,(OFST-2,sp)
6457  0013 97            	ld	xl,a
6458  0014 7b04          	ld	a,(OFST+0,sp)
6459  0016 01            	rrwa	x,a
6460  0017 1a03          	or	a,(OFST-1,sp)
6461  0019 01            	rrwa	x,a
6463                     ; 1996   return (uint16_t)tmpccr4;
6467  001a 5b04          	addw	sp,#4
6468  001c 81            	ret	
6502                     ; 2004 uint16_t TIM1_GetCounter(void)
6502                     ; 2005 {
6503                     .text:	section	.text,new
6504  0000               _TIM1_GetCounter:
6506  0000 89            	pushw	x
6507       00000002      OFST:	set	2
6510                     ; 2006   uint16_t tmpcntr = 0;
6512                     ; 2008   tmpcntr = ((uint16_t)TIM1->CNTRH << 8);
6514  0001 c6525e        	ld	a,21086
6515  0004 97            	ld	xl,a
6516  0005 4f            	clr	a
6517  0006 02            	rlwa	x,a
6518  0007 1f01          	ldw	(OFST-1,sp),x
6520                     ; 2011   return (uint16_t)(tmpcntr | (uint16_t)(TIM1->CNTRL));
6522  0009 c6525f        	ld	a,21087
6523  000c 5f            	clrw	x
6524  000d 97            	ld	xl,a
6525  000e 01            	rrwa	x,a
6526  000f 1a02          	or	a,(OFST+0,sp)
6527  0011 01            	rrwa	x,a
6528  0012 1a01          	or	a,(OFST-1,sp)
6529  0014 01            	rrwa	x,a
6532  0015 5b02          	addw	sp,#2
6533  0017 81            	ret	
6567                     ; 2019 uint16_t TIM1_GetPrescaler(void)
6567                     ; 2020 {
6568                     .text:	section	.text,new
6569  0000               _TIM1_GetPrescaler:
6571  0000 89            	pushw	x
6572       00000002      OFST:	set	2
6575                     ; 2021   uint16_t temp = 0;
6577                     ; 2023   temp = ((uint16_t)TIM1->PSCRH << 8);
6579  0001 c65260        	ld	a,21088
6580  0004 97            	ld	xl,a
6581  0005 4f            	clr	a
6582  0006 02            	rlwa	x,a
6583  0007 1f01          	ldw	(OFST-1,sp),x
6585                     ; 2026   return (uint16_t)( temp | (uint16_t)(TIM1->PSCRL));
6587  0009 c65261        	ld	a,21089
6588  000c 5f            	clrw	x
6589  000d 97            	ld	xl,a
6590  000e 01            	rrwa	x,a
6591  000f 1a02          	or	a,(OFST+0,sp)
6592  0011 01            	rrwa	x,a
6593  0012 1a01          	or	a,(OFST-1,sp)
6594  0014 01            	rrwa	x,a
6597  0015 5b02          	addw	sp,#2
6598  0017 81            	ret	
6772                     ; 2047 FlagStatus TIM1_GetFlagStatus(TIM1_FLAG_TypeDef TIM1_FLAG)
6772                     ; 2048 {
6773                     .text:	section	.text,new
6774  0000               _TIM1_GetFlagStatus:
6776  0000 89            	pushw	x
6777  0001 89            	pushw	x
6778       00000002      OFST:	set	2
6781                     ; 2049   FlagStatus bitstatus = RESET;
6783                     ; 2050   uint8_t tim1_flag_l = 0, tim1_flag_h = 0;
6787                     ; 2053   assert_param(IS_TIM1_GET_FLAG_OK(TIM1_FLAG));
6789                     ; 2055   tim1_flag_l = (uint8_t)(TIM1->SR1 & (uint8_t)TIM1_FLAG);
6791  0002 9f            	ld	a,xl
6792  0003 c45255        	and	a,21077
6793  0006 6b01          	ld	(OFST-1,sp),a
6795                     ; 2056   tim1_flag_h = (uint8_t)((uint16_t)TIM1_FLAG >> 8);
6797  0008 7b03          	ld	a,(OFST+1,sp)
6798  000a 6b02          	ld	(OFST+0,sp),a
6800                     ; 2058   if ((tim1_flag_l | (uint8_t)(TIM1->SR2 & tim1_flag_h)) != 0)
6802  000c c45256        	and	a,21078
6803  000f 1a01          	or	a,(OFST-1,sp)
6804  0011 2702          	jreq	L5643
6805                     ; 2060     bitstatus = SET;
6807  0013 a601          	ld	a,#1
6810  0015               L5643:
6811                     ; 2064     bitstatus = RESET;
6814                     ; 2066   return (FlagStatus)(bitstatus);
6818  0015 5b04          	addw	sp,#4
6819  0017 81            	ret	
6854                     ; 2087 void TIM1_ClearFlag(TIM1_FLAG_TypeDef TIM1_FLAG)
6854                     ; 2088 {
6855                     .text:	section	.text,new
6856  0000               _TIM1_ClearFlag:
6858  0000 89            	pushw	x
6859       00000000      OFST:	set	0
6862                     ; 2090   assert_param(IS_TIM1_CLEAR_FLAG_OK(TIM1_FLAG));
6864                     ; 2093   TIM1->SR1 = (uint8_t)(~(uint8_t)(TIM1_FLAG));
6866  0001 9f            	ld	a,xl
6867  0002 43            	cpl	a
6868  0003 c75255        	ld	21077,a
6869                     ; 2094   TIM1->SR2 = (uint8_t)((uint8_t)(~((uint8_t)((uint16_t)TIM1_FLAG >> 8))) & 
6869                     ; 2095                         (uint8_t)0x1E);
6871  0006 7b01          	ld	a,(OFST+1,sp)
6872  0008 43            	cpl	a
6873  0009 a41e          	and	a,#30
6874  000b c75256        	ld	21078,a
6875                     ; 2096 }
6878  000e 85            	popw	x
6879  000f 81            	ret	
6943                     ; 2112 ITStatus TIM1_GetITStatus(TIM1_IT_TypeDef TIM1_IT)
6943                     ; 2113 {
6944                     .text:	section	.text,new
6945  0000               _TIM1_GetITStatus:
6947  0000 88            	push	a
6948  0001 89            	pushw	x
6949       00000002      OFST:	set	2
6952                     ; 2114   ITStatus bitstatus = RESET;
6954                     ; 2115   uint8_t TIM1_itStatus = 0, TIM1_itEnable = 0;
6958                     ; 2118   assert_param(IS_TIM1_GET_IT_OK(TIM1_IT));
6960                     ; 2120   TIM1_itStatus = (uint8_t)(TIM1->SR1 & (uint8_t)TIM1_IT);
6962  0002 c45255        	and	a,21077
6963  0005 6b01          	ld	(OFST-1,sp),a
6965                     ; 2122   TIM1_itEnable = (uint8_t)(TIM1->IER & (uint8_t)TIM1_IT);
6967  0007 c65254        	ld	a,21076
6968  000a 1403          	and	a,(OFST+1,sp)
6969  000c 6b02          	ld	(OFST+0,sp),a
6971                     ; 2124   if ((TIM1_itStatus != (uint8_t)RESET ) && (TIM1_itEnable != (uint8_t)RESET ))
6973  000e 7b01          	ld	a,(OFST-1,sp)
6974  0010 2708          	jreq	L1453
6976  0012 7b02          	ld	a,(OFST+0,sp)
6977  0014 2704          	jreq	L1453
6978                     ; 2126     bitstatus = SET;
6980  0016 a601          	ld	a,#1
6983  0018 2001          	jra	L3453
6984  001a               L1453:
6985                     ; 2130     bitstatus = RESET;
6987  001a 4f            	clr	a
6989  001b               L3453:
6990                     ; 2132   return (ITStatus)(bitstatus);
6994  001b 5b03          	addw	sp,#3
6995  001d 81            	ret	
7031                     ; 2149 void TIM1_ClearITPendingBit(TIM1_IT_TypeDef TIM1_IT)
7031                     ; 2150 {
7032                     .text:	section	.text,new
7033  0000               _TIM1_ClearITPendingBit:
7037                     ; 2152   assert_param(IS_TIM1_IT_OK(TIM1_IT));
7039                     ; 2155   TIM1->SR1 = (uint8_t)(~(uint8_t)TIM1_IT);
7041  0000 43            	cpl	a
7042  0001 c75255        	ld	21077,a
7043                     ; 2156 }
7046  0004 81            	ret	
7098                     ; 2174 static void TI1_Config(uint8_t TIM1_ICPolarity,
7098                     ; 2175                        uint8_t TIM1_ICSelection,
7098                     ; 2176                        uint8_t TIM1_ICFilter)
7098                     ; 2177 {
7099                     .text:	section	.text,new
7100  0000               L3_TI1_Config:
7102  0000 89            	pushw	x
7103  0001 88            	push	a
7104       00000001      OFST:	set	1
7107                     ; 2179   TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
7109  0002 7211525c      	bres	21084,#0
7110                     ; 2182   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
7110                     ; 2183                           (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7112  0006 7b06          	ld	a,(OFST+5,sp)
7113  0008 97            	ld	xl,a
7114  0009 a610          	ld	a,#16
7115  000b 42            	mul	x,a
7116  000c 9f            	ld	a,xl
7117  000d 1a03          	or	a,(OFST+2,sp)
7118  000f 6b01          	ld	(OFST+0,sp),a
7120  0011 c65258        	ld	a,21080
7121  0014 a40c          	and	a,#12
7122  0016 1a01          	or	a,(OFST+0,sp)
7123  0018 c75258        	ld	21080,a
7124                     ; 2186   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7126  001b 7b02          	ld	a,(OFST+1,sp)
7127  001d 2706          	jreq	L1163
7128                     ; 2188     TIM1->CCER1 |= TIM1_CCER1_CC1P;
7130  001f 7212525c      	bset	21084,#1
7132  0023 2004          	jra	L3163
7133  0025               L1163:
7134                     ; 2192     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
7136  0025 7213525c      	bres	21084,#1
7137  0029               L3163:
7138                     ; 2196   TIM1->CCER1 |=  TIM1_CCER1_CC1E;
7140  0029 7210525c      	bset	21084,#0
7141                     ; 2197 }
7144  002d 5b03          	addw	sp,#3
7145  002f 81            	ret	
7197                     ; 2215 static void TI2_Config(uint8_t TIM1_ICPolarity,
7197                     ; 2216                        uint8_t TIM1_ICSelection,
7197                     ; 2217                        uint8_t TIM1_ICFilter)
7197                     ; 2218 {
7198                     .text:	section	.text,new
7199  0000               L5_TI2_Config:
7201  0000 89            	pushw	x
7202  0001 88            	push	a
7203       00000001      OFST:	set	1
7206                     ; 2220   TIM1->CCER1 &=  (uint8_t)(~TIM1_CCER1_CC2E);
7208  0002 7219525c      	bres	21084,#4
7209                     ; 2223   TIM1->CCMR2  = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) 
7209                     ; 2224                            | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7211  0006 7b06          	ld	a,(OFST+5,sp)
7212  0008 97            	ld	xl,a
7213  0009 a610          	ld	a,#16
7214  000b 42            	mul	x,a
7215  000c 9f            	ld	a,xl
7216  000d 1a03          	or	a,(OFST+2,sp)
7217  000f 6b01          	ld	(OFST+0,sp),a
7219  0011 c65259        	ld	a,21081
7220  0014 a40c          	and	a,#12
7221  0016 1a01          	or	a,(OFST+0,sp)
7222  0018 c75259        	ld	21081,a
7223                     ; 2226   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7225  001b 7b02          	ld	a,(OFST+1,sp)
7226  001d 2706          	jreq	L3463
7227                     ; 2228     TIM1->CCER1 |= TIM1_CCER1_CC2P;
7229  001f 721a525c      	bset	21084,#5
7231  0023 2004          	jra	L5463
7232  0025               L3463:
7233                     ; 2232     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
7235  0025 721b525c      	bres	21084,#5
7236  0029               L5463:
7237                     ; 2235   TIM1->CCER1 |=  TIM1_CCER1_CC2E;
7239  0029 7218525c      	bset	21084,#4
7240                     ; 2236 }
7243  002d 5b03          	addw	sp,#3
7244  002f 81            	ret	
7296                     ; 2254 static void TI3_Config(uint8_t TIM1_ICPolarity,
7296                     ; 2255                        uint8_t TIM1_ICSelection,
7296                     ; 2256                        uint8_t TIM1_ICFilter)
7296                     ; 2257 {
7297                     .text:	section	.text,new
7298  0000               L7_TI3_Config:
7300  0000 89            	pushw	x
7301  0001 88            	push	a
7302       00000001      OFST:	set	1
7305                     ; 2259   TIM1->CCER2 &=  (uint8_t)(~TIM1_CCER2_CC3E);
7307  0002 7211525d      	bres	21085,#0
7308                     ; 2262   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF))) 
7308                     ; 2263                           | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7310  0006 7b06          	ld	a,(OFST+5,sp)
7311  0008 97            	ld	xl,a
7312  0009 a610          	ld	a,#16
7313  000b 42            	mul	x,a
7314  000c 9f            	ld	a,xl
7315  000d 1a03          	or	a,(OFST+2,sp)
7316  000f 6b01          	ld	(OFST+0,sp),a
7318  0011 c6525a        	ld	a,21082
7319  0014 a40c          	and	a,#12
7320  0016 1a01          	or	a,(OFST+0,sp)
7321  0018 c7525a        	ld	21082,a
7322                     ; 2266   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7324  001b 7b02          	ld	a,(OFST+1,sp)
7325  001d 2706          	jreq	L5763
7326                     ; 2268     TIM1->CCER2 |= TIM1_CCER2_CC3P;
7328  001f 7212525d      	bset	21085,#1
7330  0023 2004          	jra	L7763
7331  0025               L5763:
7332                     ; 2272     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
7334  0025 7213525d      	bres	21085,#1
7335  0029               L7763:
7336                     ; 2275   TIM1->CCER2 |=  TIM1_CCER2_CC3E;
7338  0029 7210525d      	bset	21085,#0
7339                     ; 2276 }
7342  002d 5b03          	addw	sp,#3
7343  002f 81            	ret	
7395                     ; 2294 static void TI4_Config(uint8_t TIM1_ICPolarity,
7395                     ; 2295                        uint8_t TIM1_ICSelection,
7395                     ; 2296                        uint8_t TIM1_ICFilter)
7395                     ; 2297 {
7396                     .text:	section	.text,new
7397  0000               L11_TI4_Config:
7399  0000 89            	pushw	x
7400  0001 88            	push	a
7401       00000001      OFST:	set	1
7404                     ; 2299   TIM1->CCER2 &=  (uint8_t)(~TIM1_CCER2_CC4E);
7406  0002 7219525d      	bres	21085,#4
7407                     ; 2302   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF )))
7407                     ; 2303                           | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7409  0006 7b06          	ld	a,(OFST+5,sp)
7410  0008 97            	ld	xl,a
7411  0009 a610          	ld	a,#16
7412  000b 42            	mul	x,a
7413  000c 9f            	ld	a,xl
7414  000d 1a03          	or	a,(OFST+2,sp)
7415  000f 6b01          	ld	(OFST+0,sp),a
7417  0011 c6525b        	ld	a,21083
7418  0014 a40c          	and	a,#12
7419  0016 1a01          	or	a,(OFST+0,sp)
7420  0018 c7525b        	ld	21083,a
7421                     ; 2306   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7423  001b 7b02          	ld	a,(OFST+1,sp)
7424  001d 2706          	jreq	L7273
7425                     ; 2308     TIM1->CCER2 |= TIM1_CCER2_CC4P;
7427  001f 721a525d      	bset	21085,#5
7429  0023 2004          	jra	L1373
7430  0025               L7273:
7431                     ; 2312     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4P);
7433  0025 721b525d      	bres	21085,#5
7434  0029               L1373:
7435                     ; 2316   TIM1->CCER2 |=  TIM1_CCER2_CC4E;
7437  0029 7218525d      	bset	21085,#4
7438                     ; 2317 }
7441  002d 5b03          	addw	sp,#3
7442  002f 81            	ret	
7455                     	xdef	_TIM1_ClearITPendingBit
7456                     	xdef	_TIM1_GetITStatus
7457                     	xdef	_TIM1_ClearFlag
7458                     	xdef	_TIM1_GetFlagStatus
7459                     	xdef	_TIM1_GetPrescaler
7460                     	xdef	_TIM1_GetCounter
7461                     	xdef	_TIM1_GetCapture4
7462                     	xdef	_TIM1_GetCapture3
7463                     	xdef	_TIM1_GetCapture2
7464                     	xdef	_TIM1_GetCapture1
7465                     	xdef	_TIM1_SetIC4Prescaler
7466                     	xdef	_TIM1_SetIC3Prescaler
7467                     	xdef	_TIM1_SetIC2Prescaler
7468                     	xdef	_TIM1_SetIC1Prescaler
7469                     	xdef	_TIM1_SetCompare4
7470                     	xdef	_TIM1_SetCompare3
7471                     	xdef	_TIM1_SetCompare2
7472                     	xdef	_TIM1_SetCompare1
7473                     	xdef	_TIM1_SetAutoreload
7474                     	xdef	_TIM1_SetCounter
7475                     	xdef	_TIM1_SelectOCxM
7476                     	xdef	_TIM1_CCxNCmd
7477                     	xdef	_TIM1_CCxCmd
7478                     	xdef	_TIM1_OC4PolarityConfig
7479                     	xdef	_TIM1_OC3NPolarityConfig
7480                     	xdef	_TIM1_OC3PolarityConfig
7481                     	xdef	_TIM1_OC2NPolarityConfig
7482                     	xdef	_TIM1_OC2PolarityConfig
7483                     	xdef	_TIM1_OC1NPolarityConfig
7484                     	xdef	_TIM1_OC1PolarityConfig
7485                     	xdef	_TIM1_GenerateEvent
7486                     	xdef	_TIM1_OC4FastConfig
7487                     	xdef	_TIM1_OC3FastConfig
7488                     	xdef	_TIM1_OC2FastConfig
7489                     	xdef	_TIM1_OC1FastConfig
7490                     	xdef	_TIM1_OC4PreloadConfig
7491                     	xdef	_TIM1_OC3PreloadConfig
7492                     	xdef	_TIM1_OC2PreloadConfig
7493                     	xdef	_TIM1_OC1PreloadConfig
7494                     	xdef	_TIM1_CCPreloadControl
7495                     	xdef	_TIM1_SelectCOM
7496                     	xdef	_TIM1_ARRPreloadConfig
7497                     	xdef	_TIM1_ForcedOC4Config
7498                     	xdef	_TIM1_ForcedOC3Config
7499                     	xdef	_TIM1_ForcedOC2Config
7500                     	xdef	_TIM1_ForcedOC1Config
7501                     	xdef	_TIM1_CounterModeConfig
7502                     	xdef	_TIM1_PrescalerConfig
7503                     	xdef	_TIM1_EncoderInterfaceConfig
7504                     	xdef	_TIM1_SelectMasterSlaveMode
7505                     	xdef	_TIM1_SelectSlaveMode
7506                     	xdef	_TIM1_SelectOutputTrigger
7507                     	xdef	_TIM1_SelectOnePulseMode
7508                     	xdef	_TIM1_SelectHallSensor
7509                     	xdef	_TIM1_UpdateRequestConfig
7510                     	xdef	_TIM1_UpdateDisableConfig
7511                     	xdef	_TIM1_SelectInputTrigger
7512                     	xdef	_TIM1_TIxExternalClockConfig
7513                     	xdef	_TIM1_ETRConfig
7514                     	xdef	_TIM1_ETRClockMode2Config
7515                     	xdef	_TIM1_ETRClockMode1Config
7516                     	xdef	_TIM1_InternalClockConfig
7517                     	xdef	_TIM1_ITConfig
7518                     	xdef	_TIM1_CtrlPWMOutputs
7519                     	xdef	_TIM1_Cmd
7520                     	xdef	_TIM1_PWMIConfig
7521                     	xdef	_TIM1_ICInit
7522                     	xdef	_TIM1_BDTRConfig
7523                     	xdef	_TIM1_OC4Init
7524                     	xdef	_TIM1_OC3Init
7525                     	xdef	_TIM1_OC2Init
7526                     	xdef	_TIM1_OC1Init
7527                     	xdef	_TIM1_TimeBaseInit
7528                     	xdef	_TIM1_DeInit
7547                     	end
