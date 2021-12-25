	.include "m8535def.inc"
	ser r16
	out ddra,r16
	out portb,r16

	ldi r16,$3f
		mov r0,r16

	ldi r16,6
		mov r1,r16

	ldi r16,$5b
		mov r2,r16

	ldi r16,$4f
		mov r3,r16

	ldi r16,$66
		mov r4,r16

	ldi r16,$6d
		mov r5,r16

	ldi r16,$7d
		mov r6,r16

	ldi r16,7
		mov r7,r16

	ldi r16,$7f
		mov r8,r16

	ldi r16,$6f
		mov r9,r16

	ldi r16,$77
		mov r10,r16

	ldi r16,$7C
		mov r11,r16

	ldi r16,$39
		mov r12,r16

	ldi r16,$5E
		mov r13,r16

	ldi r16,$79
		mov r14,r16

	ldi r16,$71
		mov r15,r16

	clr ZH
uno:
	ldi ZL,0
	in r16,pinb
	add ZL,r16
	ld r16,Z
	out porta,r16
	rjmp uno
