   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  81                     ; 87 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
  81                     ; 88 {
  83                     .text:	section	.text,new
  84  0000               _FLASH_Unlock:
  88                     ; 90   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
  90                     ; 93   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
  92  0000 a1fd          	cp	a,#253
  93  0002 2609          	jrne	L73
  94                     ; 95     FLASH->PUKR = FLASH_RASS_KEY1;
  96  0004 35565062      	mov	20578,#86
  97                     ; 96     FLASH->PUKR = FLASH_RASS_KEY2;
  99  0008 35ae5062      	mov	20578,#174
 102  000c 81            	ret	
 103  000d               L73:
 104                     ; 101     FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
 106  000d 35ae5064      	mov	20580,#174
 107                     ; 102     FLASH->DUKR = FLASH_RASS_KEY1;
 109  0011 35565064      	mov	20580,#86
 110                     ; 104 }
 113  0015 81            	ret	
 148                     ; 112 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 148                     ; 113 {
 149                     .text:	section	.text,new
 150  0000               _FLASH_Lock:
 154                     ; 115   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
 156                     ; 118   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 158  0000 c4505f        	and	a,20575
 159  0003 c7505f        	ld	20575,a
 160                     ; 119 }
 163  0006 81            	ret	
 186                     ; 126 void FLASH_DeInit(void)
 186                     ; 127 {
 187                     .text:	section	.text,new
 188  0000               _FLASH_DeInit:
 192                     ; 128   FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 194  0000 725f505a      	clr	20570
 195                     ; 129   FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 197  0004 725f505b      	clr	20571
 198                     ; 130   FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 200  0008 35ff505c      	mov	20572,#255
 201                     ; 131   FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
 203  000c 7217505f      	bres	20575,#3
 204                     ; 132   FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
 206  0010 7213505f      	bres	20575,#1
 207                     ; 133   (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 209  0014 c6505f        	ld	a,20575
 210                     ; 134 }
 213  0017 81            	ret	
 268                     ; 142 void FLASH_ITConfig(FunctionalState NewState)
 268                     ; 143 {
 269                     .text:	section	.text,new
 270  0000               _FLASH_ITConfig:
 274                     ; 145   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 276                     ; 147   if(NewState != DISABLE)
 278  0000 4d            	tnz	a
 279  0001 2705          	jreq	L711
 280                     ; 149     FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 282  0003 7212505a      	bset	20570,#1
 285  0007 81            	ret	
 286  0008               L711:
 287                     ; 153     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 289  0008 7213505a      	bres	20570,#1
 290                     ; 155 }
 293  000c 81            	ret	
 327                     ; 164 void FLASH_EraseByte(uint32_t Address)
 327                     ; 165 {
 328                     .text:	section	.text,new
 329  0000               _FLASH_EraseByte:
 331       00000000      OFST:	set	0
 334                     ; 167   assert_param(IS_FLASH_ADDRESS_OK(Address));
 336                     ; 170   *(PointerAttr uint8_t*) (MemoryAddressCast)Address = FLASH_CLEAR_BYTE; 
 338  0000 1e05          	ldw	x,(OFST+5,sp)
 339  0002 7f            	clr	(x)
 340                     ; 171 }
 343  0003 81            	ret	
 386                     ; 181 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 386                     ; 182 {
 387                     .text:	section	.text,new
 388  0000               _FLASH_ProgramByte:
 390       00000000      OFST:	set	0
 393                     ; 184   assert_param(IS_FLASH_ADDRESS_OK(Address));
 395                     ; 185   *(PointerAttr uint8_t*) (MemoryAddressCast)Address = Data;
 397  0000 1e05          	ldw	x,(OFST+5,sp)
 398  0002 7b07          	ld	a,(OFST+7,sp)
 399  0004 f7            	ld	(x),a
 400                     ; 186 }
 403  0005 81            	ret	
 437                     ; 195 uint8_t FLASH_ReadByte(uint32_t Address)
 437                     ; 196 {
 438                     .text:	section	.text,new
 439  0000               _FLASH_ReadByte:
 441       00000000      OFST:	set	0
 444                     ; 198   assert_param(IS_FLASH_ADDRESS_OK(Address));
 446                     ; 201   return(*(PointerAttr uint8_t *) (MemoryAddressCast)Address); 
 448  0000 1e05          	ldw	x,(OFST+5,sp)
 449  0002 f6            	ld	a,(x)
 452  0003 81            	ret	
 495                     ; 212 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 495                     ; 213 {
 496                     .text:	section	.text,new
 497  0000               _FLASH_ProgramWord:
 499       00000000      OFST:	set	0
 502                     ; 215   assert_param(IS_FLASH_ADDRESS_OK(Address));
 504                     ; 218   FLASH->CR2 |= FLASH_CR2_WPRG;
 506  0000 721c505b      	bset	20571,#6
 507                     ; 219   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 509  0004 721d505c      	bres	20572,#6
 510                     ; 222   *((PointerAttr uint8_t*)(MemoryAddressCast)Address)       = *((uint8_t*)(&Data));
 512  0008 1e05          	ldw	x,(OFST+5,sp)
 513  000a 7b07          	ld	a,(OFST+7,sp)
 514  000c f7            	ld	(x),a
 515                     ; 224   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 1) = *((uint8_t*)(&Data)+1); 
 517  000d 7b08          	ld	a,(OFST+8,sp)
 518  000f e701          	ld	(1,x),a
 519                     ; 226   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 2) = *((uint8_t*)(&Data)+2); 
 521  0011 7b09          	ld	a,(OFST+9,sp)
 522  0013 e702          	ld	(2,x),a
 523                     ; 228   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 3) = *((uint8_t*)(&Data)+3); 
 525  0015 7b0a          	ld	a,(OFST+10,sp)
 526  0017 e703          	ld	(3,x),a
 527                     ; 229 }
 530  0019 81            	ret	
 575                     ; 237 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 575                     ; 238 {
 576                     .text:	section	.text,new
 577  0000               _FLASH_ProgramOptionByte:
 579  0000 89            	pushw	x
 580       00000000      OFST:	set	0
 583                     ; 240   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 585                     ; 243   FLASH->CR2 |= FLASH_CR2_OPT;
 587  0001 721e505b      	bset	20571,#7
 588                     ; 244   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 590  0005 721f505c      	bres	20572,#7
 591                     ; 247   if(Address == 0x4800)
 593  0009 a34800        	cpw	x,#18432
 594  000c 2605          	jrne	L542
 595                     ; 250     *((NEAR uint8_t*)Address) = Data;
 597  000e 7b05          	ld	a,(OFST+5,sp)
 598  0010 f7            	ld	(x),a
 600  0011 2006          	jra	L742
 601  0013               L542:
 602                     ; 255     *((NEAR uint8_t*)Address) = Data;
 604  0013 7b05          	ld	a,(OFST+5,sp)
 605  0015 f7            	ld	(x),a
 606                     ; 256     *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 608  0016 43            	cpl	a
 609  0017 e701          	ld	(1,x),a
 610  0019               L742:
 611                     ; 258   FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 613  0019 a6fd          	ld	a,#253
 614  001b cd0000        	call	_FLASH_WaitForLastOperation
 616                     ; 261   FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 618  001e 721f505b      	bres	20571,#7
 619                     ; 262   FLASH->NCR2 |= FLASH_NCR2_NOPT;
 621  0022 721e505c      	bset	20572,#7
 622                     ; 263 }
 625  0026 85            	popw	x
 626  0027 81            	ret	
 662                     ; 270 void FLASH_EraseOptionByte(uint16_t Address)
 662                     ; 271 {
 663                     .text:	section	.text,new
 664  0000               _FLASH_EraseOptionByte:
 666  0000 89            	pushw	x
 667       00000000      OFST:	set	0
 670                     ; 273   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 672                     ; 276   FLASH->CR2 |= FLASH_CR2_OPT;
 674  0001 721e505b      	bset	20571,#7
 675                     ; 277   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 677  0005 721f505c      	bres	20572,#7
 678                     ; 280   if(Address == 0x4800)
 680  0009 a34800        	cpw	x,#18432
 681  000c 2603          	jrne	L762
 682                     ; 283     *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 684  000e 7f            	clr	(x)
 686  000f 2005          	jra	L172
 687  0011               L762:
 688                     ; 288     *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 690  0011 7f            	clr	(x)
 691                     ; 289     *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 693  0012 a6ff          	ld	a,#255
 694  0014 e701          	ld	(1,x),a
 695  0016               L172:
 696                     ; 291   FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 698  0016 a6fd          	ld	a,#253
 699  0018 cd0000        	call	_FLASH_WaitForLastOperation
 701                     ; 294   FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 703  001b 721f505b      	bres	20571,#7
 704                     ; 295   FLASH->NCR2 |= FLASH_NCR2_NOPT;
 706  001f 721e505c      	bset	20572,#7
 707                     ; 296 }
 710  0023 85            	popw	x
 711  0024 81            	ret	
 774                     ; 303 uint16_t FLASH_ReadOptionByte(uint16_t Address)
 774                     ; 304 {
 775                     .text:	section	.text,new
 776  0000               _FLASH_ReadOptionByte:
 778  0000 5204          	subw	sp,#4
 779       00000004      OFST:	set	4
 782                     ; 305   uint8_t value_optbyte, value_optbyte_complement = 0;
 784                     ; 306   uint16_t res_value = 0;
 786                     ; 309   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 788                     ; 311   value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
 790  0002 f6            	ld	a,(x)
 791  0003 6b01          	ld	(OFST-3,sp),a
 793                     ; 312   value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
 795  0005 e601          	ld	a,(1,x)
 796  0007 6b02          	ld	(OFST-2,sp),a
 798                     ; 315   if(Address == 0x4800)	 
 800  0009 a34800        	cpw	x,#18432
 801  000c 2606          	jrne	L523
 802                     ; 317     res_value =	 value_optbyte;
 804  000e 7b01          	ld	a,(OFST-3,sp)
 805  0010 5f            	clrw	x
 806  0011 97            	ld	xl,a
 809  0012 201c          	jra	L723
 810  0014               L523:
 811                     ; 321     if(value_optbyte == (uint8_t)(~value_optbyte_complement))
 813  0014 43            	cpl	a
 814  0015 1101          	cp	a,(OFST-3,sp)
 815  0017 2614          	jrne	L133
 816                     ; 323       res_value = (uint16_t)((uint16_t)value_optbyte << 8);
 818  0019 7b01          	ld	a,(OFST-3,sp)
 819  001b 97            	ld	xl,a
 820  001c 4f            	clr	a
 821  001d 02            	rlwa	x,a
 822  001e 1f03          	ldw	(OFST-1,sp),x
 824                     ; 324       res_value = res_value | (uint16_t)value_optbyte_complement;
 826  0020 5f            	clrw	x
 827  0021 7b02          	ld	a,(OFST-2,sp)
 828  0023 97            	ld	xl,a
 829  0024 01            	rrwa	x,a
 830  0025 1a04          	or	a,(OFST+0,sp)
 831  0027 01            	rrwa	x,a
 832  0028 1a03          	or	a,(OFST-1,sp)
 833  002a 01            	rrwa	x,a
 836  002b 2003          	jra	L723
 837  002d               L133:
 838                     ; 328       res_value = FLASH_OPTIONBYTE_ERROR;
 840  002d ae5555        	ldw	x,#21845
 842  0030               L723:
 843                     ; 331   return(res_value);
 847  0030 5b04          	addw	sp,#4
 848  0032 81            	ret	
 922                     ; 340 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
 922                     ; 341 {
 923                     .text:	section	.text,new
 924  0000               _FLASH_SetLowPowerMode:
 926  0000 88            	push	a
 927       00000000      OFST:	set	0
 930                     ; 343   assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
 932                     ; 346   FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
 934  0001 c6505a        	ld	a,20570
 935  0004 a4f3          	and	a,#243
 936  0006 c7505a        	ld	20570,a
 937                     ; 349   FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
 939  0009 c6505a        	ld	a,20570
 940  000c 1a01          	or	a,(OFST+1,sp)
 941  000e c7505a        	ld	20570,a
 942                     ; 350 }
 945  0011 84            	pop	a
 946  0012 81            	ret	
1004                     ; 358 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
1004                     ; 359 {
1005                     .text:	section	.text,new
1006  0000               _FLASH_SetProgrammingTime:
1010                     ; 361   assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
1012                     ; 363   FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
1014  0000 7211505a      	bres	20570,#0
1015                     ; 364   FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
1017  0004 ca505a        	or	a,20570
1018  0007 c7505a        	ld	20570,a
1019                     ; 365 }
1022  000a 81            	ret	
1047                     ; 372 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1047                     ; 373 {
1048                     .text:	section	.text,new
1049  0000               _FLASH_GetLowPowerMode:
1053                     ; 374   return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1055  0000 c6505a        	ld	a,20570
1056  0003 a40c          	and	a,#12
1059  0005 81            	ret	
1084                     ; 382 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1084                     ; 383 {
1085                     .text:	section	.text,new
1086  0000               _FLASH_GetProgrammingTime:
1090                     ; 384   return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1092  0000 c6505a        	ld	a,20570
1093  0003 a401          	and	a,#1
1096  0005 81            	ret	
1130                     ; 392 uint32_t FLASH_GetBootSize(void)
1130                     ; 393 {
1131                     .text:	section	.text,new
1132  0000               _FLASH_GetBootSize:
1134  0000 5204          	subw	sp,#4
1135       00000004      OFST:	set	4
1138                     ; 394   uint32_t temp = 0;
1140                     ; 397   temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1142  0002 c6505d        	ld	a,20573
1143  0005 5f            	clrw	x
1144  0006 97            	ld	xl,a
1145  0007 90ae0200      	ldw	y,#512
1146  000b cd0000        	call	c_umul
1148  000e 96            	ldw	x,sp
1149  000f 5c            	incw	x
1150  0010 cd0000        	call	c_rtol
1153                     ; 400   if(FLASH->FPR == 0xFF)
1155  0013 c6505d        	ld	a,20573
1156  0016 4c            	inc	a
1157  0017 260d          	jrne	L354
1158                     ; 402     temp += 512;
1160  0019 ae0200        	ldw	x,#512
1161  001c bf02          	ldw	c_lreg+2,x
1162  001e 5f            	clrw	x
1163  001f bf00          	ldw	c_lreg,x
1164  0021 96            	ldw	x,sp
1165  0022 5c            	incw	x
1166  0023 cd0000        	call	c_lgadd
1169  0026               L354:
1170                     ; 406   return(temp);
1172  0026 96            	ldw	x,sp
1173  0027 5c            	incw	x
1174  0028 cd0000        	call	c_ltor
1178  002b 5b04          	addw	sp,#4
1179  002d 81            	ret	
1281                     ; 417 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1281                     ; 418 {
1282                     .text:	section	.text,new
1283  0000               _FLASH_GetFlagStatus:
1285       00000001      OFST:	set	1
1288                     ; 419   FlagStatus status = RESET;
1290                     ; 421   assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1292                     ; 424   if((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1294  0000 c4505f        	and	a,20575
1295  0003 2702          	jreq	L325
1296                     ; 426     status = SET; /* FLASH_FLAG is set */
1298  0005 a601          	ld	a,#1
1301  0007               L325:
1302                     ; 430     status = RESET; /* FLASH_FLAG is reset*/
1305                     ; 434   return status;
1309  0007 81            	ret	
1394                     ; 549 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1394                     ; 550 {
1395                     .text:	section	.text,new
1396  0000               _FLASH_WaitForLastOperation:
1398  0000 5203          	subw	sp,#3
1399       00000003      OFST:	set	3
1402                     ; 551   uint8_t flagstatus = 0x00;
1404  0002 0f03          	clr	(OFST+0,sp)
1406                     ; 552   uint16_t timeout = OPERATION_TIMEOUT;
1408  0004 aeffff        	ldw	x,#65535
1410  0007 2008          	jra	L375
1411  0009               L765:
1412                     ; 578     flagstatus = (uint8_t)(FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS));
1414  0009 c6505f        	ld	a,20575
1415  000c a405          	and	a,#5
1416  000e 6b03          	ld	(OFST+0,sp),a
1418                     ; 579     timeout--;
1420  0010 5a            	decw	x
1421  0011               L375:
1422  0011 1f01          	ldw	(OFST-2,sp),x
1424                     ; 576   while((flagstatus == 0x00) && (timeout != 0x00))
1426  0013 7b03          	ld	a,(OFST+0,sp)
1427  0015 2604          	jrne	L775
1429  0017 1e01          	ldw	x,(OFST-2,sp)
1430  0019 26ee          	jrne	L765
1431  001b               L775:
1432                     ; 583   if(timeout == 0x00 )
1434  001b 1e01          	ldw	x,(OFST-2,sp)
1435  001d 2602          	jrne	L106
1436                     ; 585     flagstatus = FLASH_STATUS_TIMEOUT;
1438  001f a602          	ld	a,#2
1440  0021               L106:
1441                     ; 588   return((FLASH_Status_TypeDef)flagstatus);
1445  0021 5b03          	addw	sp,#3
1446  0023 81            	ret	
1509                     ; 598 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1509                     ; 599 {
1510                     .text:	section	.text,new
1511  0000               _FLASH_EraseBlock:
1513  0000 89            	pushw	x
1514  0001 5206          	subw	sp,#6
1515       00000006      OFST:	set	6
1518                     ; 600   uint32_t startaddress = 0;
1520                     ; 610   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1522                     ; 611   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
1524  0003 7b0b          	ld	a,(OFST+5,sp)
1525  0005 a1fd          	cp	a,#253
1526  0007 2605          	jrne	L536
1527                     ; 613     assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1529                     ; 614     startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1531  0009 ae8000        	ldw	x,#32768
1533  000c 2003          	jra	L736
1534  000e               L536:
1535                     ; 618     assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1537                     ; 619     startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1539  000e ae4000        	ldw	x,#16384
1540  0011               L736:
1541  0011 1f05          	ldw	(OFST-1,sp),x
1542  0013 5f            	clrw	x
1543  0014 1f03          	ldw	(OFST-3,sp),x
1545                     ; 627     pwFlash = (PointerAttr uint32_t *)(MemoryAddressCast)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1547  0016 a640          	ld	a,#64
1548  0018 1e07          	ldw	x,(OFST+1,sp)
1549  001a cd0000        	call	c_cmulx
1551  001d 96            	ldw	x,sp
1552  001e 1c0003        	addw	x,#OFST-3
1553  0021 cd0000        	call	c_ladd
1555  0024 be02          	ldw	x,c_lreg+2
1556  0026 1f01          	ldw	(OFST-5,sp),x
1558                     ; 631   FLASH->CR2 |= FLASH_CR2_ERASE;
1560  0028 721a505b      	bset	20571,#5
1561                     ; 632   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
1563  002c 721b505c      	bres	20572,#5
1564                     ; 636     *pwFlash = (uint32_t)0;
1566  0030 4f            	clr	a
1567  0031 e703          	ld	(3,x),a
1568  0033 e702          	ld	(2,x),a
1569  0035 e701          	ld	(1,x),a
1570  0037 f7            	ld	(x),a
1571                     ; 644 }
1574  0038 5b08          	addw	sp,#8
1575  003a 81            	ret	
1679                     ; 655 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
1679                     ; 656                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1679                     ; 657 {
1680                     .text:	section	.text,new
1681  0000               _FLASH_ProgramBlock:
1683  0000 89            	pushw	x
1684  0001 5206          	subw	sp,#6
1685       00000006      OFST:	set	6
1688                     ; 658   uint16_t Count = 0;
1690                     ; 659   uint32_t startaddress = 0;
1692                     ; 662   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1694                     ; 663   assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
1696                     ; 664   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
1698  0003 7b0b          	ld	a,(OFST+5,sp)
1699  0005 a1fd          	cp	a,#253
1700  0007 2605          	jrne	L317
1701                     ; 666     assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1703                     ; 667     startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1705  0009 ae8000        	ldw	x,#32768
1707  000c 2003          	jra	L517
1708  000e               L317:
1709                     ; 671     assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1711                     ; 672     startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1713  000e ae4000        	ldw	x,#16384
1714  0011               L517:
1715  0011 1f03          	ldw	(OFST-3,sp),x
1716  0013 5f            	clrw	x
1717  0014 1f01          	ldw	(OFST-5,sp),x
1719                     ; 676   startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1721  0016 a640          	ld	a,#64
1722  0018 1e07          	ldw	x,(OFST+1,sp)
1723  001a cd0000        	call	c_cmulx
1725  001d 96            	ldw	x,sp
1726  001e 5c            	incw	x
1727  001f cd0000        	call	c_lgadd
1730                     ; 679   if(FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
1732  0022 7b0c          	ld	a,(OFST+6,sp)
1733  0024 260a          	jrne	L717
1734                     ; 682     FLASH->CR2 |= FLASH_CR2_PRG;
1736  0026 7210505b      	bset	20571,#0
1737                     ; 683     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
1739  002a 7211505c      	bres	20572,#0
1741  002e 2008          	jra	L127
1742  0030               L717:
1743                     ; 688     FLASH->CR2 |= FLASH_CR2_FPRG;
1745  0030 7218505b      	bset	20571,#4
1746                     ; 689     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
1748  0034 7219505c      	bres	20572,#4
1749  0038               L127:
1750                     ; 693   for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1752  0038 5f            	clrw	x
1753  0039 1f05          	ldw	(OFST-1,sp),x
1755  003b               L327:
1756                     ; 695     *((PointerAttr uint8_t*) (MemoryAddressCast)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1758  003b 1e0d          	ldw	x,(OFST+7,sp)
1759  003d 72fb05        	addw	x,(OFST-1,sp)
1760  0040 f6            	ld	a,(x)
1761  0041 1e03          	ldw	x,(OFST-3,sp)
1762  0043 72fb05        	addw	x,(OFST-1,sp)
1763  0046 f7            	ld	(x),a
1764                     ; 693   for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1766  0047 1e05          	ldw	x,(OFST-1,sp)
1767  0049 5c            	incw	x
1768  004a 1f05          	ldw	(OFST-1,sp),x
1772  004c a30040        	cpw	x,#64
1773  004f 25ea          	jrult	L327
1774                     ; 697 }
1777  0051 5b08          	addw	sp,#8
1778  0053 81            	ret	
1791                     	xdef	_FLASH_WaitForLastOperation
1792                     	xdef	_FLASH_ProgramBlock
1793                     	xdef	_FLASH_EraseBlock
1794                     	xdef	_FLASH_GetFlagStatus
1795                     	xdef	_FLASH_GetBootSize
1796                     	xdef	_FLASH_GetProgrammingTime
1797                     	xdef	_FLASH_GetLowPowerMode
1798                     	xdef	_FLASH_SetProgrammingTime
1799                     	xdef	_FLASH_SetLowPowerMode
1800                     	xdef	_FLASH_EraseOptionByte
1801                     	xdef	_FLASH_ProgramOptionByte
1802                     	xdef	_FLASH_ReadOptionByte
1803                     	xdef	_FLASH_ProgramWord
1804                     	xdef	_FLASH_ReadByte
1805                     	xdef	_FLASH_ProgramByte
1806                     	xdef	_FLASH_EraseByte
1807                     	xdef	_FLASH_ITConfig
1808                     	xdef	_FLASH_DeInit
1809                     	xdef	_FLASH_Lock
1810                     	xdef	_FLASH_Unlock
1811                     	xref.b	c_lreg
1812                     	xref.b	c_x
1813                     	xref.b	c_y
1832                     	xref	c_ladd
1833                     	xref	c_cmulx
1834                     	xref	c_ltor
1835                     	xref	c_lgadd
1836                     	xref	c_rtol
1837                     	xref	c_umul
1838                     	end
