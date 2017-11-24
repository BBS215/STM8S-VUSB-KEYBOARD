   1                     .utext: section
   2                     	xref	_ll_usb_rx_count, _ll_usb_rx_buffer, _usb_rx_ok
   3                     	xdef	_ll_usb_rx
   4                     ;;; 16 MHz ;;;
   5                     switch .utext
   6                     debug_cpl: macro
   7                     	cpl		($14,y)					; DEBUG ; сигнал синхронизации	; invert (&GPIOC->IDR + 20) = GPIOG->ODR
   8                     	;cpl		20495		; DEBUG ; инверсия выходных сигналов GPIOD->ODR
   9                     endm
  10                     
  11                     	;nop ;; BOUNDING
  12                     	;nop ;; BOUNDING
  13                     	;nop ;; BOUNDING
  14                     	
  15  0000               L_Bit0_Begin:
  16                     	debug_cpl			; DEBUG ;
  17  0003 0401          	srl		($01, SP)				; RX_BYTE >>= 1
  18  0005 90f6          	ld		a,(y)						; a = IDR
  19  0007 a4c0          	and		a,#$C0					; a &= 0b11000000
  20  0009 2604acb000b0  	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  21  000f 1801          	xor		a, ($01, SP)		; a = a XOR RX_BYTE
  22  0011 6b01          	ld		($01, SP),a			; RX_BYTE = a
  23  0013 9d            	nop
  24  0014 9d            	nop
  25  0015 9d            	nop
  26                     	
  27  0016               L_Bit1_Begin:
  28                     	debug_cpl			; DEBUG ;
  29  0019 0401          	srl		($01, SP)
  30  001b 90f6          	ld		a,(y)
  31  001d a4c0          	and		a,#$C0					; a &= 0b11000000
  32  001f 27ea          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  33  0021 1801          	xor		a, ($01, SP)
  34  0023 6b01          	ld		($01, SP),a
  35  0025 9d            	nop
  36  0026 9d            	nop
  37  0027 5c            	incw	x								; _ll_usb_rx_buffer++
  38                     
  39  0028               L_Bit2_Begin:
  40                     	debug_cpl			; DEBUG ;
  41  002b 0401          	srl		($01, SP)
  42  002d 90f6          	ld		a,(y)
  43  002f a4c0          	and		a,#$C0					; a &= 0b11000000
  44  0031 277d          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  45  0033 1801          	xor		a, ($01, SP)
  46  0035 6b01          	ld		($01, SP),a
  47  0037 9d            	nop
  48  0038 9d            	nop
  49  0039 9d            	nop
  50  003a 9d            	nop
  51                     
  52  003b               L_Bit3_Begin:
  53                     	debug_cpl			; DEBUG ;
  54  003e 0401          	srl		($01, SP)
  55  0040 90f6          	ld		a,(y)
  56  0042 a4c0          	and		a,#$C0					; a &= 0b11000000
  57  0044 276a          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  58  0046 1801          	xor		a, ($01, SP)
  59  0048 6b01          	ld		($01, SP),a
  60  004a 9d            	nop
  61  004b 9d            	nop
  62  004c 9d            	nop	
  63                     
  64  004d               L_Bit4_Begin:
  65                     	debug_cpl			; DEBUG ;
  66  0050 0401          	srl		($01, SP)
  67  0052 90f6          	ld		a,(y)
  68  0054 a4c0          	and		a,#$C0					; a &= 0b11000000
  69  0056 2758          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  70  0058 1801          	xor		a, ($01, SP)
  71  005a 6b01          	ld		($01, SP),a
  72  005c 9d            	nop
  73  005d 9d            	nop
  74  005e 9d            	nop
  75  005f 9d            	nop	
  76                     
  77  0060               L_Bit5_Begin:
  78                     	debug_cpl			; DEBUG ;
  79  0063 0401          	srl		($01, SP)
  80  0065 90f6          	ld		a,(y)
  81  0067 a4c0          	and		a,#$C0					; a &= 0b11000000
  82  0069 2745          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  83  006b 1801          	xor		a, ($01, SP)
  84  006d 6b01          	ld		($01, SP),a
  85  006f 0a02          	dec		($02,SP) 				; декремент счётчика принятых байт
  86  0071 273d          	jreq	L_End_Rx 				; выход если счётчик = 0
  87  0073 9d            	nop	
  88                     
  89  0074               L_Bit6_Begin:
  90                     	debug_cpl			; DEBUG ;
  91  0077 0401          	srl		($01, SP)
  92  0079 90f6          	ld		a,(y)
  93  007b a4c0          	and		a,#$C0					; a &= 0b11000000
  94  007d 2731          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
  95  007f 1801          	xor		a, ($01, SP)
  96  0081 6b01          	ld		($01, SP),a
  97  0083 9d            	nop
  98  0084 9d            	nop
  99  0085 9d            	nop
 100  0086 9d            	nop	
 101                     
 102  0087               L_Bit7_Begin:
 103                     	debug_cpl			; DEBUG ;
 104  008a 0401          	srl		($01, SP)
 105  008c 90f6          	ld		a,(y)
 106  008e a4c0          	and		a,#$C0					; a &= 0b11000000
 107  0090 271e          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
 108  0092 1801          	xor		a, ($01, SP)
 109  0094 6b01          	ld		($01, SP),a
 110  0096 f7            	ld		(x),a					;; сохраняем принятый байт; _ll_usb_rx_buffer[] = a
 111  0097 79            	rlc   (x)						;; rotate x
 112  0098 9d            	nop	
 113                     
 114                     	;; BIT 0
 115                     	debug_cpl			; DEBUG ;
 116  009c 0401          	srl		($01, SP)
 117  009e 90f6          	ld		a,(y)
 118  00a0 a4c0          	and		a,#$C0					; a &= 0b11000000
 119  00a2 270c          	jreq	L_End_Rx				; выход, если input = 0 (конец пакета)
 120  00a4 1801          	xor		a, ($01, SP)
 121  00a6 6b01          	ld		($01, SP),a
 122  00a8 9d            	nop	
 123  00a9 ac160016      	jra		L_Bit1_Begin
 124                     
 125  00ad 9d            	nop
 126  00ae 9d            	nop
 127  00af 9d            	nop
 128                     
 129  00b0               L_End_Rx:
 130                     
 131                     	;debug_cpl			; DEBUG ;
 132  00b0 84            	pop		a
 133  00b1 84            	pop		a
 134  00b2 c70000        	ld		_ll_usb_rx_count,a
 135                     
 136  00b5 cd0000        	call	_usb_rx_ok
 137                     
 138  00b8 35fb5255      	mov		21077,#251 			; сброс флага прерывания таймера ; TIM1_BaseAddress + SR1 = 0xFB
 139                     
 140  00bc 72115250      	bres	21072,#0				; стоп таймер ; TIM1_BaseAddress + CR1 &= 0x2
 141  00c0 725f525e      	clr		21086					; сброс счетного регистра ; TIM1_BaseAddress + CNTRH = 0
 142  00c4 725f525f      	clr		21087					; TIM1_BaseAddress + CNTRL = 0
 143                     	
 144                     	;clr		20495		; DEBUG ; сброс выходных сигналов GPIOD->ODR
 145                     	
 146  00c8 80            	iret
 147                     
 148                     ;
 149                     ;
 150                     ;
 151                     
 152  00c9               _ll_usb_rx:
 153  00c9 ae00d7        	ldw		x, #L_Delay_Begin	; адрес начала таблицы задержек
 154  00cc 72bb525e      	addw	x, 21086			; + смещение (значение таймера) ; x += TIM1_BaseAddress + CNTRH*256 + CNTRL
 155  00d0 a3010a        	cpw		x, #L_Delay_End		; проверка выхода за границу таблицы (защита!)	; check x < L_Delay_End
 156  00d3 2401          	jruge	L_Error						; Jump if C = 0
 157  00d5 fc            	jp		(x)					; переход по таблице задержек
 158                     	
 159  00d6               L_Error:
 160                     
 161  00d6 80            	iret ; аварийный выход
 162                     
 163  00d7               L_Delay_Begin:
 164  00d7 9d            	nop		; 0
 165  00d8 9d            	nop		; 1
 166  00d9 9d            	nop		; 2
 167  00da 9d            	nop		; 3
 168  00db 9d            	nop		; 4
 169  00dc 9d            	nop		; 5
 170  00dd 9d            	nop		; 6
 171  00de 9d            	nop		; 7
 172  00df 9d            	nop		; 8
 173  00e0 9d            	nop		; 9
 174  00e1 9d            	nop		; 10
 175  00e2 9d            	nop		; 11
 176  00e3 9d            	nop		; 12
 177  00e4 9d            	nop		; 13
 178  00e5 9d            	nop		; 14
 179  00e6 9d            	nop		; 15
 180  00e7 9d            	nop		; 16
 181  00e8 9d            	nop		; 17
 182  00e9 9d            	nop		; 18
 183  00ea 9d            	nop		; 19
 184  00eb 9d            	nop		; 20
 185  00ec 9d            	nop		; 21
 186  00ed 9d            	nop		; 22
 187  00ee 9d            	nop		; 23
 188  00ef 9d            	nop		; 24
 189  00f0 9d            	nop		; 25
 190  00f1 9d            	nop		; 26
 191  00f2 9d            	nop		; 27
 192  00f3 9d            	nop		; 28
 193  00f4 9d            	nop		; 29
 194  00f5 9d            	nop		; 30
 195  00f6 9d            	nop		; 31
 196  00f7 9d            	nop		; 32
 197  00f8 9d            	nop		; 33
 198  00f9 9d            	nop		; 34
 199  00fa 9d            	nop		; 35
 200  00fb 9d            	nop		; 36
 201  00fc 9d            	nop		; 37
 202  00fd 9d            	nop		; 38
 203  00fe 9d            	nop		; 39
 204  00ff 9d            	nop		; 40
 205  0100 9d            	nop		; 41
 206  0101 9d            	nop		; 42
 207  0102 9d            	nop		; 43
 208  0103 9d            	nop		; 44
 209  0104 9d            	nop		; 45
 210  0105 9d            	nop		; 46
 211  0106 9d            	nop		; 47
 212  0107 9d            	nop		; 48
 213  0108 9d            	nop		; 49 ;; MIN
 214  0109 9d            	nop		; 50
 215                     	;nop		; 51 
 216                     	;nop		; 52 ;; MAX
 217                     	;nop		; 53
 218                     	;nop		; 54
 219                     	;nop		; 55 
 220                     
 221  010a               L_Delay_End:
 222                              
 223  010a ae0000        	ldw		x, #_ll_usb_rx_buffer		; адрес начала буфера ; x = _ll_usb_rx_buffer
 224  010d 90ae500b      	ldw		y, #20491 				; адрес входного сигнала ; y = &GPIOC->IDR
 225  0111 a60e          	ld		a, #$0E					; максимальное кол-во принимаемых байт a = 14 (защита!)
 226  0113 88            	push	a								; a -> stack	
 227  0114 a680          	ld		a, #$80					; a = 128; RX_BYTE = 0b10000000
 228  0116 88            	push	a								; a -> stack
 229                     	
 230  0117 ac000000      	jra		L_Bit0_Begin		; jump
 231                     	
 232                     switch .text
