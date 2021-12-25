.include "m8535def.inc"
.def aux = r16
.def contador = r27

	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
	ser aux
	out ddra,aux
	out portb,aux
	clr contador

	ldi r17,$3f
	ldi r18,6
	ldi r19,$5b
	ldi r20,$4f
	ldi r21,$66
	ldi r22,$6d
	ldi r23,$7d
	ldi r24,7
	ldi r25,$7f
	ldi r26,$6f
	clr ZH
uno:
	ldi ZL,17
	add ZL,contador
	ld aux,Z
	out porta,aux
	rcall retardo
	inc contador
	rjmp uno
retardo:
	push contador
	ldi  r27, 16
    ldi  r28, 57
    ldi  r29, 14
L1: dec  r29
    brne L1
    dec  r28
    brne L1
    dec  r27
    brne L1
	nop 
	pop contador
	ret