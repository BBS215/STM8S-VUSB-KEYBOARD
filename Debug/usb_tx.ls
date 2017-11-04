   1                     	xref	_ll_usb_tx_count, _ll_usb_tx_buffer_pointer
   2                     
   3                     	xdef	_ll_usb_tx
   4                     ;;; 16 MHz ;;;
   5  0000               L_Bit0_Idle:
   6  0000 4a            	dec		a		; a--
   7  0001 2647          	jrne	L_Bit1_Begin	; Jump if Z == 0; if a != 0
   8  0003 9d            	nop
   9  0004 9d            	nop
  10  0005 9d            	nop
  11  0006 9d            	nop	
  12  0007 7253500a      	cpl		20490				; GPIOC+ODR ; инверсия выходных сигналов; добавляем бит
  13  000b a606          	ld		a, #$06		; сброс счётчика
  14  000d 9d            	nop
  15  000e 203a          	jra		L_Bit1_Begin
  16                     
  17  0010               L_Bit1_Idle:
  18  0010 4a            	dec		a
  19  0011 2646          	jrne	L_Bit2_Begin
  20  0013 9d            	nop
  21  0014 9d            	nop
  22  0015 9d            	nop
  23  0016 9d            	nop	
  24  0017 7253500a      	cpl		20490				; GPIOC+ODR ; инверсия выходных сигналов
  25  001b a606          	ld		a, #$06
  26  001d 9d            	nop
  27  001e 2039          	jra		L_Bit2_Begin
  28                     
  29  0020               L_Bit2_Idle:
  30  0020 4a            	dec		a
  31  0021 2645          	jrne	L_Bit3_Begin
  32  0023 9d            	nop
  33  0024 9d            	nop
  34  0025 9d            	nop
  35  0026 9d            	nop	
  36  0027 7253500a      	cpl		20490				; GPIOC+ODR ; инверсия выходных сигналов
  37  002b a606          	ld		a, #$06
  38  002d 9d            	nop
  39  002e 2038          	jra		L_Bit3_Begin
  40                     
  41  0030               L_Bit3_Idle:
  42  0030 4a            	dec		a
  43  0031 2644          	jrne	L_Bit4_Begin
  44  0033 9d            	nop
  45  0034 9d            	nop
  46  0035 9d            	nop
  47  0036 9d            	nop	
  48  0037 7253500a      	cpl		20490				; GPIOC+ODR ; инверсия выходных сигналов
  49  003b a606          	ld		a, #$06
  50  003d 9d            	nop
  51  003e 2037          	jra		L_Bit4_Begin
  52                     
  53                     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  54                     
  55  0040               L_Bit0_Begin:
  56                     	;;nop
  57                     	;;nop
  58                     	;;nop
  59                     	;;nop
  60                     	;;nop
  61  0040 76            	rrc		(x)						; бит 0 -> СC.C		; rotate right, C = 1 if LSB of register was set
  62  0041 25bd          	jrc		L_Bit0_Idle		; перейти, если равен CС.C = 1		; Jump if C = 1
  63  0043 7253500a      	cpl		20490					; инверсия выходных сигналов [N,Z,C=1]
  64  0047 a606          	ld		a, #$06				; если была инверсия, сбрасываем ; a = 6
  65  0049 9d            	nop
  66                     
  67  004a               L_Bit1_Begin:
  68  004a 9d            	nop
  69  004b 9d            	nop
  70  004c 9d            	nop
  71  004d 9d            	nop
  72  004e 9d            	nop
  73  004f 76            	rrc		(x)						; бит 0 -> СC.C
  74  0050 25be          	jrc		L_Bit1_Idle		; перейти, если равен CС.C = 1
  75  0052 7253500a      	cpl		20490					; инверсия выходных сигналов [N,Z,C=1]
  76  0056 a606          	ld		a, #$06       
  77  0058 9d            	nop
  78                     
  79  0059               L_Bit2_Begin:
  80  0059 9d            	nop
  81  005a 9d            	nop
  82  005b 9d            	nop
  83  005c 9d            	nop
  84  005d 9d            	nop
  85  005e 76            	rrc		(x)						; бит 0 -> СC.C
  86  005f 25bf          	jrc		L_Bit2_Idle		; перейти, если равен CС.C = 1
  87  0061 7253500a      	cpl		20490					; инверсия выходных сигналов [N,Z,C=1]
  88  0065 a606          	ld		a, #$06       
  89  0067 9d            	nop
  90                     
  91  0068               L_Bit3_Begin:
  92  0068 9d            	nop
  93  0069 9d            	nop
  94  006a 9d            	nop
  95  006b 9d            	nop
  96  006c 9d            	nop
  97  006d 76            	rrc		(x)						; бит 0 -> СC.C
  98  006e 25c0          	jrc		L_Bit3_Idle		; перейти, если равен CС.C = 1
  99  0070 7253500a      	cpl		20490					; инверсия выходных сигналов [N,Z,C=1]
 100  0074 a606          	ld		a, #$06       
 101  0076 9d            	nop
 102                     
 103  0077               L_Bit4_Begin:
 104  0077 9d            	nop
 105  0078 9d            	nop
 106  0079 9d            	nop
 107  007a 9d            	nop
 108  007b 9d            	nop
 109  007c 76            	rrc		(x)						; бит 0 -> СC.C
 110  007d 2552          	jrc		L_Bit4_Idle		; перейти, если равен CС.C = 1
 111  007f 7253500a      	cpl		20490					; инверсия выходных сигналов [N,Z,C=1]
 112  0083 a606          	ld		a, #$06       
 113  0085 9d            	nop
 114                     
 115  0086               L_Bit5_Begin:
 116  0086 9d            	nop
 117  0087 9d            	nop
 118  0088 9d            	nop
 119  0089 9d            	nop
 120  008a 9d            	nop
 121  008b 76            	rrc		(x)						; бит 0 -> СC.C
 122  008c 2553          	jrc		L_Bit5_Idle		; перейти, если равен CС.C = 1
 123  008e 7253500a      	cpl		20490					; инверсия выходных сигналов [N,Z,C=1]
 124  0092 a606          	ld		a, #$06       
 125  0094 9d            	nop
 126                     
 127  0095               L_Bit6_Begin:
 128  0095 9d            	nop
 129  0096 9d            	nop
 130  0097 9d            	nop
 131  0098 9d            	nop
 132  0099 9d            	nop
 133  009a 76            	rrc		(x)						; бит 0 -> СC.C
 134  009b 2554          	jrc		L_Bit6_Idle		; перейти, если равен CС.C = 1
 135  009d 7253500a      	cpl		20490					; инверсия выходных сигналов [N,Z,C=1]
 136  00a1 a606          	ld		a, #$06       
 137  00a3 9d            	nop
 138                     
 139  00a4               L_Bit7_Begin:
 140  00a4 9d            	nop
 141  00a5 9d            	nop
 142  00a6 9d            	nop
 143  00a7 9d            	nop
 144  00a8 9d            	nop
 145  00a9 76            	rrc		(x)						; бит 0 -> СC.C
 146  00aa 2555          	jrc		L_Bit7_Idle		; перейти, если равен CС.C = 1
 147  00ac 7253500a      	cpl		20490					; инверсия выходных сигналов [N,Z,C=1]
 148  00b0 a606          	ld		a, #$06
 149  00b2 9d            	nop
 150  00b3 9d            	nop	
 151                     
 152  00b4               L_Check_End:
 153                     
 154  00b4 5c            	incw	x
 155  00b5 725a0000      	dec		_ll_usb_tx_count
 156  00b9 2685          	jrne	L_Bit0_Begin
 157  00bb 9d            	nop
 158                     	
 159  00bc               L_Tx_End:
 160                     	;;nop                
 161  00bc 9d            	nop
 162  00bd 9d            	nop
 163                     	
 164  00be 725f500a      	clr		20490			 ; сброс выходных сигналов
 165                     
 166  00c2 9d            	nop
 167  00c3 9d            	nop
 168  00c4 9d            	nop
 169  00c5 9d            	nop
 170                     
 171  00c6 9d            	nop	;
 172  00c7 9d            	nop	;
 173  00c8 9d            	nop	;
 174  00c9 9d            	nop	;
 175  00ca 9d            	nop	;
 176                     	
 177  00cb 81            	ret
 178                     
 179  00cc 9d            	nop
 180  00cd 9d            	nop
 181  00ce 9d            	nop
 182  00cf 9d            	nop
 183                     
 184                     ;
 185                     ;
 186                     ;
 187  00d0 9d            	nop
 188                     
 189  00d1               L_Bit4_Idle:
 190  00d1 4a            	dec		a
 191  00d2 26b2          	jrne	L_Bit5_Begin
 192  00d4 9d            	nop
 193  00d5 9d            	nop
 194  00d6 9d            	nop
 195  00d7 9d            	nop	
 196  00d8 7253500a      	cpl		20490		; GPIOC+ODR ; инверсия выходных сигналов
 197  00dc a606          	ld		a, #$06
 198  00de 9d            	nop
 199  00df 20a5          	jra		L_Bit5_Begin
 200                     
 201  00e1               L_Bit5_Idle:
 202  00e1 4a            	dec		a
 203  00e2 26b1          	jrne	L_Bit6_Begin
 204  00e4 9d            	nop
 205  00e5 9d            	nop
 206  00e6 9d            	nop
 207  00e7 9d            	nop
 208  00e8 7253500a      	cpl		20490		; GPIOC+ODR ; инверсия выходных сигналов
 209  00ec a606          	ld		a, #$06
 210  00ee 9d            	nop
 211  00ef 20a4          	jra		L_Bit6_Begin
 212                     
 213  00f1               L_Bit6_Idle:
 214  00f1 4a            	dec		a
 215  00f2 26b0          	jrne	L_Bit7_Begin
 216  00f4 9d            	nop
 217  00f5 9d            	nop
 218  00f6 9d            	nop
 219  00f7 9d            	nop
 220  00f8 7253500a      	cpl		20490		; GPIOC+ODR ; инверсия выходных сигналов
 221  00fc a606          	ld		a, #$06
 222  00fe 9d            	nop
 223  00ff 20a3          	jra		L_Bit7_Begin
 224                     
 225  0101               L_Bit7_Idle:
 226  0101 4a            	dec		a
 227  0102 26b0          	jrne	L_Check_End
 228  0104 9d            	nop
 229  0105 9d            	nop
 230  0106 725a0000      	dec		_ll_usb_tx_count
 231  010a 5c            	incw	x
 232  010b a606          	ld		a, #$06
 233  010d 7253500a      	cpl		20490		; GPIOC+ODR ; инверсия выходных сигналов
 234  0111 725d0000      	tnz		_ll_usb_tx_count
 235  0115 2704ac400040  	jrne	L_Bit0_Begin
 236                     	
 237                     	;;cpl		20490		; GPIOC+ODR ; инверсия выходных сигналов
 238                     	;;ld		a, #$06
 239                     	;;incw	x
 240                     	;;dec		_ll_usb_tx_count
 241                     	;;jrne	L_Bit0_Begin
 242  011b 209f          	jra		L_Tx_End
 243                     
 244                     ;
 245                     ;	Точка входа
 246                     ;
 247  011d               _ll_usb_tx:
 248                     
 249  011d ce0000        	ldw		x, _ll_usb_tx_buffer_pointer
 250                     	
 251  0120 a640          	ld		a,#$40		; a = 0x40 (bit 6)
 252  0122 c7500a        	ld		20490,a		; GPIOC->ODR = a (set bit 6)
 253  0125 a606          	ld		a, #$06						; счетчик постоянного уровня
 254  0127 ac400040      	jra		L_Bit0_Begin