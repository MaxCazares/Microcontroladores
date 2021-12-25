include "m8535def.inc"
inicio:
	ser r16
	out ddra,r16
	out ddrc,r16
	out portb,r16
	out portd,r16
uno:
	clr r19
	in r16,pinb
	in r17,pind
	mov r18,r16
dos:
	dec r17
	breq tres
	add r18,r16
	adc r19,r20
	rjmp dos
tres:
	out porta,r18
	out portc,r19
	rjmp uno