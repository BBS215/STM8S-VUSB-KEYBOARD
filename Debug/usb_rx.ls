   1                     .utext: section
   2                     	xref	_ll_usb_rx_count, _ll_usb_rx_buffer, _usb_rx_ok
   3                     	xdef	_ll_usb_rx
   4                     ;;; 16 MHz ;;;
   5                     switch .utext
   6                     debug_cpl: macro
   7                     	;cpl		($14,y)					; DEBUG ; сигнал синхронизации	; invert (&GPIOC->IDR + 20) = GPIOG->ODR
   8                     	cpl		20495		; DEBUG ; инверсия выходных сигналов GPIOD->ODR
   9                     endm
  10                     
  11                     	;nop ;; BOUNDING
  12                     	;nop ;; BOUNDING
  13                     	;nop ;; BOUNDING
  14                     	
  15  0000               L_Bit0_Begin:
  16                     	debug_cpl			; DEBUG ;
  17  0004 0401          	srl		($01, SP)				; RX_BYTE >>= 1
  18  0006 90f6          	ld		a,(y)						; a = IDR
  19  0008 a4c0          	and		a,#$C0					; a &= 0b11000000
  20  000a 2604acb900b9  	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  21  0010 1801          	xor		a, ($01, SP)		; a = a XOR RX_BYTE
  22  0012 6b01          	ld		($01, SP),a			; RX_BYTE = a
  23  0014 9d            	nop
  24  0015 9d            	nop
  25  0016 9d            	nop
  26                     	
  27  0017               L_Bit1_Begin:
  28                     	debug_cpl			; DEBUG ;
  29  001b 0401          	srl		($01, SP)
  30  001d 90f6          	ld		a,(y)
  31  001f a4c0          	and		a,#$C0					; a &= 0b11000000
  32  0021 27e9          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  33  0023 1801          	xor		a, ($01, SP)
  34  0025 6b01          	ld		($01, SP),a
  35  0027 9d            	nop
  36  0028 9d            	nop
  37  0029 5c            	incw	x								; _ll_usb_rx_buffer++
  38                     
  39  002a               L_Bit2_Begin:
  40                     	debug_cpl			; DEBUG ;
  41  002e 0401          	srl		($01, SP)
  42  0030 90f6          	ld		a,(y)
  43  0032 a4c0          	and		a,#$C0					; a &= 0b11000000
  44  0034 27d6          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  45  0036 1801          	xor		a, ($01, SP)
  46  0038 6b01          	ld		($01, SP),a
  47  003a 9d            	nop
  48  003b 9d            	nop
  49  003c 9d            	nop
  50  003d 9d            	nop
  51                     
  52  003e               L_Bit3_Begin:
  53                     	debug_cpl			; DEBUG ;
  54  0042 0401          	srl		($01, SP)
  55  0044 90f6          	ld		a,(y)
  56  0046 a4c0          	and		a,#$C0					; a &= 0b11000000
  57  0048 276f          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  58  004a 1801          	xor		a, ($01, SP)
  59  004c 6b01          	ld		($01, SP),a
  60  004e 9d            	nop
  61  004f 9d            	nop
  62  0050 9d            	nop	
  63                     
  64  0051               L_Bit4_Begin:
  65                     	debug_cpl			; DEBUG ;
  66  0055 0401          	srl		($01, SP)
  67  0057 90f6          	ld		a,(y)
  68  0059 a4c0          	and		a,#$C0					; a &= 0b11000000
  69  005b 275c          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  70  005d 1801          	xor		a, ($01, SP)
  71  005f 6b01          	ld		($01, SP),a
  72  0061 9d            	nop
  73  0062 9d            	nop
  74  0063 9d            	nop
  75  0064 9d            	nop	
  76                     
  77  0065               L_Bit5_Begin:
  78                     	debug_cpl			; DEBUG ;
  79  0069 0401          	srl		($01, SP)
  80  006b 90f6          	ld		a,(y)
  81  006d a4c0          	and		a,#$C0					; a &= 0b11000000
  82  006f 2748          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  83  0071 1801          	xor		a, ($01, SP)
  84  0073 6b01          	ld		($01, SP),a
  85  0075 0a02          	dec		($02,SP) 				; декремент счётчика принятых байт
  86  0077 2740          	jreq	L_End_Rx 				; выход если счётчик = 0
  87  0079 9d            	nop	
  88                     
  89  007a               L_Bit6_Begin:
  90                     	debug_cpl			; DEBUG ;
  91  007e 0401          	srl		($01, SP)
  92  0080 90f6          	ld		a,(y)
  93  0082 a4c0          	and		a,#$C0					; a &= 0b11000000
  94  0084 2733          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  95  0086 1801          	xor		a, ($01, SP)
  96  0088 6b01          	ld		($01, SP),a
  97  008a 9d            	nop
  98  008b 9d            	nop
  99  008c 9d            	nop
 100  008d 9d            	nop	
 101                     
 102  008e               L_Bit7_Begin:
 103                     	debug_cpl			; DEBUG ;
 104  0092 0401          	srl		($01, SP)
 105  0094 90f6          	ld		a,(y)
 106  0096 a4c0          	and		a,#$C0					; a &= 0b11000000
 107  0098 271f          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
 108  009a 1801          	xor		a, ($01, SP)
 109  009c 6b01          	ld		($01, SP),a
 110  009e f7            	ld		(x),a					;; сохраняем принятый байт; _ll_usb_rx_buffer[] = a
 111  009f 79            	rlc   (x)						;; rotate x
 112  00a0 9d            	nop	
 113                     
 114                     	;; BIT 0
 115                     	debug_cpl			; DEBUG ;
 116  00a5 0401          	srl		($01, SP)
 117  00a7 90f6          	ld		a,(y)
 118  00a9 a4c0          	and		a,#$C0					; a &= 0b11000000
 119  00ab 270c          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
 120  00ad 1801          	xor		a, ($01, SP)
 121  00af 6b01          	ld		($01, SP),a
 122  00b1 9d            	nop	
 123  00b2 ac170017      	jra		L_Bit1_Begin
 124                     
 125  00b6 9d            	nop
 126  00b7 9d            	nop
 127  00b8 9d            	nop
 128                     
 129  00b9               L_End_Rx:
 130                     
 131                     	;debug_cpl			; DEBUG ;
 132  00b9 84            	pop		a
 133  00ba 84            	pop		a
 134  00bb c70000        	ld		_ll_usb_rx_count,a
 135                     
 136  00be cd0000        	call	_usb_rx_ok
 137                     
 138  00c1 35fb5255      	mov		21077,#251 			; сброс флага прерывания таймера ; TIM1_BaseAddress + SR1 = 0xFB
 139                     
 140  00c5 72115250      	bres	21072,#0				; стоп таймер ; TIM1_BaseAddress + CR1 &= 0x2
 141  00c9 725f525e      	clr		21086					; сброс счетного регистра ; TIM1_BaseAddress + CNTRH = 0
 142  00cd 725f525f      	clr		21087					; TIM1_BaseAddress + CNTRL = 0
 143                     	
 144                     	;clr		20495		; DEBUG ; сброс выходных сигналов GPIOD->ODR
 145                     	
 146  00d1 80            	iret
 147                     
 148                     ;
 149                     ;
 150                     ;
 151                     
 152  00d2               _ll_usb_rx:
 153  00d2 ae00e0        	ldw		x, #L_Delay_Begin	; адрес начала таблицы задержек
 154  00d5 72bb525e      	addw	x, 21086			; + смещение (значение таймера) ; x += TIM1_BaseAddress + CNTRH*256 + CNTRL
 155  00d9 a30113        	cpw		x, #L_Delay_End		; проверка выхода за границу таблицы (защита!)	; check x < L_Delay_End
 156  00dc 2401          	jruge	L_Error						; Jump if C = 0
 157  00de fc            	jp		(x)					; переход по таблице задержек
 158                     	
 159  00df               L_Error:
 160                     
 161  00df 80            	iret ; аварийный выход
 162                     
 163  00e0               L_Delay_Begin:
 164  00e0 9d            	nop		; 0
 165  00e1 9d            	nop		; 1
 166  00e2 9d            	nop		; 2
 167  00e3 9d            	nop		; 3
 168  00e4 9d            	nop		; 4
 169  00e5 9d            	nop		; 5
 170  00e6 9d            	nop		; 6
 171  00e7 9d            	nop		; 7
 172  00e8 9d            	nop		; 8
 173  00e9 9d            	nop		; 9
 174  00ea 9d            	nop		; 10
 175  00eb 9d            	nop		; 11
 176  00ec 9d            	nop		; 12
 177  00ed 9d            	nop		; 13
 178  00ee 9d            	nop		; 14
 179  00ef 9d            	nop		; 15
 180  00f0 9d            	nop		; 16
 181  00f1 9d            	nop		; 17
 182  00f2 9d            	nop		; 18
 183  00f3 9d            	nop		; 19
 184  00f4 9d            	nop		; 20
 185  00f5 9d            	nop		; 21
 186  00f6 9d            	nop		; 22
 187  00f7 9d            	nop		; 23
 188  00f8 9d            	nop		; 24
 189  00f9 9d            	nop		; 25
 190  00fa 9d            	nop		; 26
 191  00fb 9d            	nop		; 27
 192  00fc 9d            	nop		; 28
 193  00fd 9d            	nop		; 29
 194  00fe 9d            	nop		; 30
 195  00ff 9d            	nop		; 31
 196  0100 9d            	nop		; 32
 197  0101 9d            	nop		; 33
 198  0102 9d            	nop		; 34
 199  0103 9d            	nop		; 35
 200  0104 9d            	nop		; 36
 201  0105 9d            	nop		; 37
 202  0106 9d            	nop		; 38
 203  0107 9d            	nop		; 39
 204  0108 9d            	nop		; 40
 205  0109 9d            	nop		; 41
 206  010a 9d            	nop		; 42
 207  010b 9d            	nop		; 43
 208  010c 9d            	nop		; 44
 209  010d 9d            	nop		; 45
 210  010e 9d            	nop		; 46
 211  010f 9d            	nop		; 47
 212  0110 9d            	nop		; 48
 213  0111 9d            	nop		; 49 ;; MIN
 214  0112 9d            	nop		; 50
 215                     	;nop		; 51 
 216                     	;nop		; 52 ;; MAX
 217                     	;nop		; 53
 218                     	;nop		; 54
 219                     	;nop		; 55 
 220                     
 221  0113               L_Delay_End:
 222                              
 223  0113 ae0000        	ldw		x, #_ll_usb_rx_buffer		; адрес начала буфера ; x = _ll_usb_rx_buffer
 224  0116 90ae500b      	ldw		y, #20491 				; адрес входного сигнала ; y = &GPIOC->IDR
 225  011a a60e          	ld		a, #$0E					; максимальное кол-во принимаемых байт a = 14 (защита!)
 226  011c 88            	push	a								; a -> stack	
 227  011d a680          	ld		a, #$80					; a = 128; RX_BYTE = 0b10000000
 228  011f 88            	push	a								; a -> stack
 229                     	
 230  0120 ac000000      	jra		L_Bit0_Begin		; jump
 231                     	
 232                     switch .text
