.include"m8535def.inc"
.def aux0 = r16
.def aux1 = r17
.def aux2 = r18
.def aux3 = r19
reset:
	rjmp main
	.org $008
	rjmp onda1
	rjmp onda2
main:
	ldi aux0,low(RAMEND)
	out spl,aux0
	ldi aux0,high(RAMEND)
	out sph,aux0
	rcall config_io
fin:
	nop
	nop
	rjmp fin
config_io:
	ser aux0
	out ddra,aux0
	out ddrc,aux0
	ldi aux0,1
	out tccr1b,aux0
	ldi aux0,1
	out tccr0,aux0
	ldi aux0,$65
	out timsk,aux0
	sei
	ldi aux1,$FE
	ldi aux2,245
	ldi aux3,135
	ret
onda1:
	nop
	out tcnt1l,aux2
	out tcnt1h,aux1
	in aux0,pina
	com aux0
	out porta,aux0
	reti
onda2:
	nop
	nop
	out tcnt0,aux3
	in aux0,pinc
	com aux0
	out portc,aux0
	reti

