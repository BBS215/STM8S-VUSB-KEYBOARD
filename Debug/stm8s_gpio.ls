   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
 115                     ; 53 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 115                     ; 54 {
 117                     .text:	section	.text,new
 118  0000               _GPIO_DeInit:
 122                     ; 55   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 124  0000 7f            	clr	(x)
 125                     ; 56   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 127  0001 6f02          	clr	(2,x)
 128                     ; 57   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 130  0003 6f03          	clr	(3,x)
 131                     ; 58   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 133  0005 6f04          	clr	(4,x)
 134                     ; 59 }
 137  0007 81            	ret	
 377                     ; 71 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 377                     ; 72 {
 378                     .text:	section	.text,new
 379  0000               _GPIO_Init:
 381  0000 89            	pushw	x
 382       00000000      OFST:	set	0
 385                     ; 77   assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 387                     ; 78   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 389                     ; 81   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 391  0001 7b05          	ld	a,(OFST+5,sp)
 392  0003 43            	cpl	a
 393  0004 e404          	and	a,(4,x)
 394  0006 e704          	ld	(4,x),a
 395                     ; 87   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 397  0008 7b06          	ld	a,(OFST+6,sp)
 398  000a 2a16          	jrpl	L771
 399                     ; 89     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 401  000c a510          	bcp	a,#16
 402  000e 2705          	jreq	L102
 403                     ; 91       GPIOx->ODR |= (uint8_t)GPIO_Pin;
 405  0010 f6            	ld	a,(x)
 406  0011 1a05          	or	a,(OFST+5,sp)
 408  0013 2004          	jra	L302
 409  0015               L102:
 410                     ; 95       GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 412  0015 7b05          	ld	a,(OFST+5,sp)
 413  0017 43            	cpl	a
 414  0018 f4            	and	a,(x)
 415  0019               L302:
 416  0019 f7            	ld	(x),a
 417                     ; 98     GPIOx->DDR |= (uint8_t)GPIO_Pin;
 419  001a 1e01          	ldw	x,(OFST+1,sp)
 420  001c e602          	ld	a,(2,x)
 421  001e 1a05          	or	a,(OFST+5,sp)
 423  0020 2005          	jra	L502
 424  0022               L771:
 425                     ; 103     GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 427  0022 7b05          	ld	a,(OFST+5,sp)
 428  0024 43            	cpl	a
 429  0025 e402          	and	a,(2,x)
 430  0027               L502:
 431  0027 e702          	ld	(2,x),a
 432                     ; 110   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 434  0029 7b06          	ld	a,(OFST+6,sp)
 435  002b a540          	bcp	a,#64
 436  002d 2706          	jreq	L702
 437                     ; 112     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 439  002f e603          	ld	a,(3,x)
 440  0031 1a05          	or	a,(OFST+5,sp)
 442  0033 2005          	jra	L112
 443  0035               L702:
 444                     ; 116     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 446  0035 7b05          	ld	a,(OFST+5,sp)
 447  0037 43            	cpl	a
 448  0038 e403          	and	a,(3,x)
 449  003a               L112:
 450  003a e703          	ld	(3,x),a
 451                     ; 123   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 453  003c 7b06          	ld	a,(OFST+6,sp)
 454  003e a520          	bcp	a,#32
 455  0040 2706          	jreq	L312
 456                     ; 125     GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 458  0042 e604          	ld	a,(4,x)
 459  0044 1a05          	or	a,(OFST+5,sp)
 461  0046 2005          	jra	L512
 462  0048               L312:
 463                     ; 129     GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 465  0048 7b05          	ld	a,(OFST+5,sp)
 466  004a 43            	cpl	a
 467  004b e404          	and	a,(4,x)
 468  004d               L512:
 469  004d e704          	ld	(4,x),a
 470                     ; 131 }
 473  004f 85            	popw	x
 474  0050 81            	ret	
 520                     ; 141 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 520                     ; 142 {
 521                     .text:	section	.text,new
 522  0000               _GPIO_Write:
 524       fffffffe      OFST: set -2
 527                     ; 143   GPIOx->ODR = PortVal;
 529  0000 7b03          	ld	a,(OFST+5,sp)
 530  0002 f7            	ld	(x),a
 531                     ; 144 }
 534  0003 81            	ret	
 581                     ; 154 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 581                     ; 155 {
 582                     .text:	section	.text,new
 583  0000               _GPIO_WriteHigh:
 585       fffffffe      OFST: set -2
 588                     ; 156   GPIOx->ODR |= (uint8_t)PortPins;
 590  0000 f6            	ld	a,(x)
 591  0001 1a03          	or	a,(OFST+5,sp)
 592  0003 f7            	ld	(x),a
 593                     ; 157 }
 596  0004 81            	ret	
 643                     ; 167 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 643                     ; 168 {
 644                     .text:	section	.text,new
 645  0000               _GPIO_WriteLow:
 647       fffffffe      OFST: set -2
 650                     ; 169   GPIOx->ODR &= (uint8_t)(~PortPins);
 652  0000 7b03          	ld	a,(OFST+5,sp)
 653  0002 43            	cpl	a
 654  0003 f4            	and	a,(x)
 655  0004 f7            	ld	(x),a
 656                     ; 170 }
 659  0005 81            	ret	
 706                     ; 180 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 706                     ; 181 {
 707                     .text:	section	.text,new
 708  0000               _GPIO_WriteReverse:
 710       fffffffe      OFST: set -2
 713                     ; 182   GPIOx->ODR ^= (uint8_t)PortPins;
 715  0000 f6            	ld	a,(x)
 716  0001 1803          	xor	a,(OFST+5,sp)
 717  0003 f7            	ld	(x),a
 718                     ; 183 }
 721  0004 81            	ret	
 759                     ; 191 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 759                     ; 192 {
 760                     .text:	section	.text,new
 761  0000               _GPIO_ReadOutputData:
 765                     ; 193   return ((uint8_t)GPIOx->ODR);
 767  0000 f6            	ld	a,(x)
 770  0001 81            	ret	
 807                     ; 202 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 807                     ; 203 {
 808                     .text:	section	.text,new
 809  0000               _GPIO_ReadInputData:
 813                     ; 204   return ((uint8_t)GPIOx->IDR);
 815  0000 e601          	ld	a,(1,x)
 818  0002 81            	ret	
 886                     ; 213 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 886                     ; 214 {
 887                     .text:	section	.text,new
 888  0000               _GPIO_ReadInputPin:
 890       fffffffe      OFST: set -2
 893                     ; 215   return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 895  0000 e601          	ld	a,(1,x)
 896  0002 1403          	and	a,(OFST+5,sp)
 899  0004 81            	ret	
 977                     ; 225 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 977                     ; 226 {
 978                     .text:	section	.text,new
 979  0000               _GPIO_ExternalPullUpConfig:
 981       fffffffe      OFST: set -2
 984                     ; 228   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 986                     ; 229   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 988                     ; 231   if (NewState != DISABLE) /* External Pull-Up Set*/
 990  0000 7b04          	ld	a,(OFST+6,sp)
 991  0002 2706          	jreq	L374
 992                     ; 233     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 994  0004 e603          	ld	a,(3,x)
 995  0006 1a03          	or	a,(OFST+5,sp)
 997  0008 2005          	jra	L574
 998  000a               L374:
 999                     ; 236     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1001  000a 7b03          	ld	a,(OFST+5,sp)
1002  000c 43            	cpl	a
1003  000d e403          	and	a,(3,x)
1004  000f               L574:
1005  000f e703          	ld	(3,x),a
1006                     ; 238 }
1009  0011 81            	ret	
1022                     	xdef	_GPIO_ExternalPullUpConfig
1023                     	xdef	_GPIO_ReadInputPin
1024                     	xdef	_GPIO_ReadOutputData
1025                     	xdef	_GPIO_ReadInputData
1026                     	xdef	_GPIO_WriteReverse
1027                     	xdef	_GPIO_WriteLow
1028                     	xdef	_GPIO_WriteHigh
1029                     	xdef	_GPIO_Write
1030                     	xdef	_GPIO_Init
1031                     	xdef	_GPIO_DeInit
1050                     	end
