   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  50                     ; 3 void Init_GPIO(void)
  50                     ; 4 {
  52                     .text:	section	.text,new
  53  0000               _Init_GPIO:
  57                     ; 5 	GPIO_DeInit(GPIOA);
  59  0000 ae5000        	ldw	x,#20480
  60  0003 cd0000        	call	_GPIO_DeInit
  62                     ; 6 	GPIO_DeInit(GPIOB);
  64  0006 ae5005        	ldw	x,#20485
  65  0009 cd0000        	call	_GPIO_DeInit
  67                     ; 7 	GPIO_DeInit(GPIOC);
  69  000c ae500a        	ldw	x,#20490
  70  000f cd0000        	call	_GPIO_DeInit
  72                     ; 8 	GPIO_DeInit(GPIOD);
  74  0012 ae500f        	ldw	x,#20495
  76                     ; 9 }
  79  0015 cc0000        	jp	_GPIO_DeInit
 102                     ; 11 void Init_Clock(void)
 102                     ; 12 {
 103                     .text:	section	.text,new
 104  0000               _Init_Clock:
 108                     ; 13 	CLK->CKDIVR = 0; // HSIDIV = 0; CPUDIV = 0
 110  0000 725f50c6      	clr	20678
 111                     ; 14 }
 114  0004 81            	ret	
 137                     ; 16 void RESET_CHIP(void)
 137                     ; 17 {
 138                     .text:	section	.text,new
 139  0000               _RESET_CHIP:
 143                     ; 18 	IWDG->KR = IWDG_KEY_ENABLE; // Reset the CPU: Enable the watchdog and wait until it expires
 145  0000 35cc50e0      	mov	20704,#204
 146  0004               L14:
 147                     ; 19 	while(1);    // Wait until reset occurs from IWDG
 149  0004 20fe          	jra	L14
 205                     ; 22 void Check_OPTION_BYTE(void)
 205                     ; 23 {
 206                     .text:	section	.text,new
 207  0000               _Check_OPTION_BYTE:
 209  0000 5205          	subw	sp,#5
 210       00000005      OFST:	set	5
 213                     ; 32 	option_byte_addr = OPTION_BYTE_START_PHYSICAL_ADDRESS + 3; // AFR
 215  0002 ae4803        	ldw	x,#18435
 216  0005 1f03          	ldw	(OFST-2,sp),x
 218                     ; 33 	option_byte = *((NEAR uint8_t*)option_byte_addr);
 220  0007 c64803        	ld	a,18435
 221  000a 6b05          	ld	(OFST+0,sp),a
 223                     ; 34 	option_byte_neg = *((NEAR uint8_t*)(option_byte_addr + 1));
 225  000c c64804        	ld	a,18436
 226  000f 6b02          	ld	(OFST-3,sp),a
 228                     ; 35 	if ((option_byte != (uint8_t)(~option_byte_neg)) ||
 228                     ; 36 	((option_byte & (1 << 0)) == 0)) { // check AFR0
 230  0011 43            	cpl	a
 231  0012 1105          	cp	a,(OFST+0,sp)
 232  0014 2606          	jrne	L57
 234  0016 7b05          	ld	a,(OFST+0,sp)
 235  0018 a501          	bcp	a,#1
 236  001a 2633          	jrne	L37
 237  001c               L57:
 238                     ; 37 		option_byte |= (1 << 0); // set AFR0 = 1 // PORT C7 Alternate Function = TIM1_CH2
 240  001c 7b05          	ld	a,(OFST+0,sp)
 241  001e aa01          	or	a,#1
 242  0020 6b05          	ld	(OFST+0,sp),a
 244                     ; 38 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 246  0022 cd00ae        	call	LC002
 247  0025 1e03          	ldw	x,(OFST-2,sp)
 248  0027               L77:
 249                     ; 43 			*((NEAR uint8_t*)option_byte_addr) = option_byte;
 251  0027 7b05          	ld	a,(OFST+0,sp)
 252  0029 f7            	ld	(x),a
 253                     ; 44 			FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 255  002a a6fd          	ld	a,#253
 256  002c cd0000        	call	_FLASH_WaitForLastOperation
 258                     ; 45 		} while(*((NEAR uint8_t*)option_byte_addr) != option_byte);
 260  002f 1e03          	ldw	x,(OFST-2,sp)
 261  0031 f6            	ld	a,(x)
 262  0032 1105          	cp	a,(OFST+0,sp)
 263  0034 26f1          	jrne	L77
 264  0036               L501:
 265                     ; 47 			*((NEAR uint8_t*)((uint16_t)(option_byte_addr + 1))) = (uint8_t)(~option_byte);
 267  0036 7b05          	ld	a,(OFST+0,sp)
 268  0038 43            	cpl	a
 269  0039 e701          	ld	(1,x),a
 270                     ; 48 			FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 272  003b a6fd          	ld	a,#253
 273  003d cd0000        	call	_FLASH_WaitForLastOperation
 275                     ; 49 		} while(*((NEAR uint8_t*)((uint16_t)(option_byte_addr + 1))) != (uint8_t)(~option_byte));
 277  0040 7b05          	ld	a,(OFST+0,sp)
 278  0042 43            	cpl	a
 279  0043 6b01          	ld	(OFST-4,sp),a
 281  0045 1e03          	ldw	x,(OFST-2,sp)
 282  0047 e601          	ld	a,(1,x)
 283  0049 1101          	cp	a,(OFST-4,sp)
 284  004b 26e9          	jrne	L501
 285                     ; 52 		FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 287  004d ad4f          	call	LC001
 289  004f               L37:
 290                     ; 58 	option_byte_addr = OPTION_BYTE_START_PHYSICAL_ADDRESS + 5; // options
 292  004f ae4805        	ldw	x,#18437
 293  0052 1f03          	ldw	(OFST-2,sp),x
 295                     ; 59 	option_byte = *((NEAR uint8_t*)option_byte_addr);
 297  0054 c64805        	ld	a,18437
 298  0057 6b05          	ld	(OFST+0,sp),a
 300                     ; 60 	option_byte_neg = *((NEAR uint8_t*)(option_byte_addr + 1));
 302  0059 c64806        	ld	a,18438
 303  005c 6b02          	ld	(OFST-3,sp),a
 305                     ; 61 	if ((option_byte != (uint8_t)(~option_byte_neg)) ||
 305                     ; 62 	((option_byte & (1 << 4)) == 0)) { // check HSITRIM
 307  005e 43            	cpl	a
 308  005f 1105          	cp	a,(OFST+0,sp)
 309  0061 2606          	jrne	L511
 311  0063 7b05          	ld	a,(OFST+0,sp)
 312  0065 a510          	bcp	a,#16
 313  0067 2632          	jrne	L311
 314  0069               L511:
 315                     ; 63 		option_byte |= (1 << 4); // set HSITRIM = 1 // 4 bit on-the-fly trimming
 317  0069 7b05          	ld	a,(OFST+0,sp)
 318  006b aa10          	or	a,#16
 319  006d 6b05          	ld	(OFST+0,sp),a
 321                     ; 64 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 323  006f ad3d          	call	LC002
 324  0071 1e03          	ldw	x,(OFST-2,sp)
 325  0073               L711:
 326                     ; 69 			*((NEAR uint8_t*)option_byte_addr) = option_byte;
 328  0073 7b05          	ld	a,(OFST+0,sp)
 329  0075 f7            	ld	(x),a
 330                     ; 70 			FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 332  0076 a6fd          	ld	a,#253
 333  0078 cd0000        	call	_FLASH_WaitForLastOperation
 335                     ; 71 		} while(*((NEAR uint8_t*)option_byte_addr) != option_byte);
 337  007b 1e03          	ldw	x,(OFST-2,sp)
 338  007d f6            	ld	a,(x)
 339  007e 1105          	cp	a,(OFST+0,sp)
 340  0080 26f1          	jrne	L711
 341  0082               L521:
 342                     ; 73 			*((NEAR uint8_t*)((uint16_t)(option_byte_addr + 1))) = (uint8_t)(~option_byte);
 344  0082 7b05          	ld	a,(OFST+0,sp)
 345  0084 43            	cpl	a
 346  0085 e701          	ld	(1,x),a
 347                     ; 74 			FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 349  0087 a6fd          	ld	a,#253
 350  0089 cd0000        	call	_FLASH_WaitForLastOperation
 352                     ; 75 		} while(*((NEAR uint8_t*)((uint16_t)(option_byte_addr + 1))) != (uint8_t)(~option_byte));
 354  008c 7b05          	ld	a,(OFST+0,sp)
 355  008e 43            	cpl	a
 356  008f 6b01          	ld	(OFST-4,sp),a
 358  0091 1e03          	ldw	x,(OFST-2,sp)
 359  0093 e601          	ld	a,(1,x)
 360  0095 1101          	cp	a,(OFST-4,sp)
 361  0097 26e9          	jrne	L521
 362                     ; 78 		FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 364  0099 ad03          	call	LC001
 366  009b               L311:
 367                     ; 84 }
 370  009b 5b05          	addw	sp,#5
 371  009d 81            	ret	
 372  009e               LC001:
 373  009e 721f505b      	bres	20571,#7
 374                     ; 79 		FLASH->NCR2 |= FLASH_NCR2_NOPT;
 376  00a2 721e505c      	bset	20572,#7
 377                     ; 80 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 379  00a6 a6f7          	ld	a,#247
 380  00a8 cd0000        	call	_FLASH_Lock
 382                     ; 81     RESET_CHIP();
 384  00ab cc0000        	jp	_RESET_CHIP
 385  00ae               LC002:
 386  00ae a6f7          	ld	a,#247
 387  00b0 cd0000        	call	_FLASH_Unlock
 389                     ; 39 		FLASH->CR2 |= FLASH_CR2_OPT;
 391  00b3 721e505b      	bset	20571,#7
 392                     ; 40 		FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 394  00b7 721f505c      	bres	20572,#7
 395  00bb 81            	ret	
 424                     ; 86 void SYSTimer_Init(void)
 424                     ; 87 {
 425                     .text:	section	.text,new
 426  0000               _SYSTimer_Init:
 430                     ; 88 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 432  0000 ae0501        	ldw	x,#1281
 433  0003 cd0000        	call	_CLK_PeripheralClockConfig
 435                     ; 89 	TIM2_DeInit();
 437  0006 cd0000        	call	_TIM2_DeInit
 439                     ; 90 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, 2500); // 16 MHz / 16 / 2500 = 400 Hz
 441  0009 ae09c4        	ldw	x,#2500
 442  000c 89            	pushw	x
 443  000d a604          	ld	a,#4
 444  000f cd0000        	call	_TIM2_TimeBaseInit
 446  0012 85            	popw	x
 447                     ; 91 	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 449  0013 ae0001        	ldw	x,#1
 450  0016 cd0000        	call	_TIM2_ClearFlag
 452                     ; 92 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 454  0019 ae0101        	ldw	x,#257
 455  001c cd0000        	call	_TIM2_ITConfig
 457                     ; 93 	TIM2_Cmd(ENABLE);
 459  001f a601          	ld	a,#1
 461                     ; 94 }
 464  0021 cc0000        	jp	_TIM2_Cmd
 477                     	xdef	_RESET_CHIP
 478                     	xdef	_Check_OPTION_BYTE
 479                     	xdef	_SYSTimer_Init
 480                     	xdef	_Init_Clock
 481                     	xdef	_Init_GPIO
 482                     	xref	_TIM2_ClearFlag
 483                     	xref	_TIM2_ITConfig
 484                     	xref	_TIM2_Cmd
 485                     	xref	_TIM2_TimeBaseInit
 486                     	xref	_TIM2_DeInit
 487                     	xref	_GPIO_DeInit
 488                     	xref	_FLASH_WaitForLastOperation
 489                     	xref	_FLASH_Lock
 490                     	xref	_FLASH_Unlock
 491                     	xref	_CLK_PeripheralClockConfig
 510                     	end
