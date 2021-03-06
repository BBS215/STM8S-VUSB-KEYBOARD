	xref	_ll_usb_tx_count, _ll_usb_tx_buffer_pointer

	xdef	_ll_usb_tx

L_Bit0_Idle:
	nop
	nop
	dec		a
	jrne	L_Bit1_Begin
	nop
	nop
	nop
	cpl		20490
	nop
	nop
	ld		a, #$06
	jra		L_Bit1_Begin
	nop
	nop

L_Bit1_Idle:
	nop
	nop
	dec		a
	jrne	L_Bit2_Begin
	nop
	nop
	nop
	cpl		20490
	nop
	nop
	ld		a, #$06
	jra		L_Bit2_Begin
	nop
	nop

L_Bit2_Idle:
	nop
	dec		a
	jrne	L_Bit3_Begin
	nop
	nop
	nop
	nop
	cpl		20490
	nop
	ld		a, #$06
	jra		L_Bit3_Begin
	nop
	nop

L_Bit3_Idle:
	nop
	nop
	nop
	dec		a
	jrne	L_Bit4_Begin
	nop;
	nop
	nop
	cpl		20490
	nop
	nop
	ld		a, #$06
	jra		L_Bit4_Begin
	nop
	nop
	;nop


L_Bit0_Begin:
	rrc		(x)						// ��� 0 -> �C.C
	jrc		L_Bit0_Idle				// �������, ���� ����� C�.C = 1
	cpl		20490					// �������� �������� �������� [N,Z,C=1]
	ld		a, #$06					// ���� ���� ��������, ����������
	nop
	nop
	nop
	nop

L_Bit1_Begin:
	rrc		(x)						// ��� 0 -> �C.C
	jrc		L_Bit1_Idle				// �������, ���� ����� C�.C = 1
	cpl		20490					// �������� �������� �������� [N,Z,C=1]
	ld		a, #$06
	nop
	nop
	nop
	nop

L_Bit2_Begin:
	rrc		(x)						// ��� 0 -> �C.C
	jrc		L_Bit2_Idle				// �������, ���� ����� C�.C = 1
	cpl		20490					// �������� �������� �������� [N,Z,C=1]
	ld		a, #$06
	nop
	nop
	nop
	;nop

L_Bit3_Begin:
	rrc		(x)						// ��� 0 -> �C.C
	jrc		L_Bit3_Idle				// �������, ���� ����� C�.C = 1
	nop;
	cpl		20490					// �������� �������� �������� [N,Z,C=1]
	ld		a, #$06
	nop
	nop
	nop
	nop

L_Bit4_Begin:
	rrc		(x)						// ��� 0 -> �C.C
	jrc		L_Bit4_Idle				// �������, ���� ����� C�.C = 1
	cpl		20490					// �������� �������� �������� [N,Z,C=1]
	ld		a, #$06
	nop
	nop
	nop
	nop

L_Bit5_Begin:
	rrc		(x)						// ��� 0 -> �C.C
	jrc		L_Bit5_Idle				// �������, ���� ����� C�.C = 1
	cpl		20490					// �������� �������� �������� [N,Z,C=1]
	ld		a, #$06
	nop
	nop
	nop
	nop

L_Bit6_Begin:
	rrc		(x)						// ��� 0 -> �C.C
	jrc		L_Bit6_Idle				// �������, ���� ����� C�.C = 1
	cpl		20490					// �������� �������� �������� [N,Z,C=1]
	ld		a, #$06
	nop
	nop

L_Bit7_Begin:
	rrc		(x)						// ��� 0 -> �C.C
	jrc		L_Bit7_Idle				// �������, ���� ����� C�.C = 1
	nop
	nop
	cpl		20490					// �������� �������� �������� [N,Z,C=1]
	ld		a, #$06

L_Check_End:

	incw	x
	dec		_ll_usb_tx_count
	jrne	L_Bit0_Begin

	nop
L_Tx_End:
	nop
	nop

	clr		20490

	ret

	nop
	nop
	nop
	nop

;
;
;
	nop

L_Bit4_Idle:
	nop
	nop
	dec		a
	jrne	L_Bit5_Begin
	nop
	nop
	nop
	cpl		20490
	nop
	nop
	ld		a, #$06
	jra		L_Bit5_Begin
	nop

	nop
L_Bit5_Idle:
	nop
	nop
	dec		a
	jrne	L_Bit6_Begin
	nop
	nop
	nop
	cpl		20490
	nop
	nop
	ld		a, #$06
	jra		L_Bit6_Begin
	nop
	nop

L_Bit6_Idle:

	dec		a
	jrne	L_Bit7_Begin
	nop
	nop
	nop
	nop
	nop
	cpl		20490
	ld		a, #$06
	jra		L_Bit7_Begin
	nop
	nop
	nop

L_Bit7_Idle:
	dec		a
	jrne	L_Check_End
	dec		_ll_usb_tx_count
	nop
	incw	x
	nop
	ld		a, #$06
	nop
	cpl		20490
	nop
	tnz		_ll_usb_tx_count
	jrne	L_Bit0_Begin
	jra		L_Tx_End

;
;	����� �����
;
_ll_usb_tx:

	ldw		x, _ll_usb_tx_buffer_pointer

	ld		a,#$40
	ld		20490,a

	ld		a, #$06						; ����

	jra		L_Bit0_Begin