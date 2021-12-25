.include "m8535def.inc"
ser r16
	out ddra,r16
	out portb,r16

filtro:
	ldi r17,$00
	ldi r18,$01
	ldi r19,$01
	ldi r20,$02

	in r16,pinb
	cpi r16,$01
	brge comparacion
	rjmp fin

comparacion:
	inc r17
	cp r16,r18
	breq fin
	brlo fin2
	add r19,r20
	add r18,r19
	rjmp comparacion

fin:
	out porta,r17
	rjmp filtro

fin2:
	subi r17,$01
	out porta,r17
	rjmp filtro
