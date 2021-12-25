.include"m8535def.inc"
.def aux1 = r16
.def aux2 = r17
.def aux3 = r18
.def aux4 = r19 
.def aux5 = r20
.def aux6 = r21 
.org 0x00 
rjmp main 
.org 0x001
rjmp estado 
.org 0x008 
rjmp contador 
.org 0x009 
rjmp tiempo
main:
	ldi aux1, low(RAMEND)
	out spl, aux1
	ldi aux1, high(RAMEND)
	out sph, aux1 
	ser aux1 
	clr aux2 
	out ddra, aux1 
	out portd, aux1 
	ldi aux1, $0e 
	out mcucr, aux1 
	ldi aux1, $e0 
	out gicr, aux1
	ldi aux4, 2 
	out tccr0, aux4 
	ldi aux6, 101 
	out tcnt0, aux6 
	ldi aux4, 4 
	out timsk, aux4 
	ldi aux1, 2 
	out tccr1b, aux1 
	sei 
	clr aux5 
	clr r22 
	clr r23 
	ldi r24, $ff 
Continuo: 
	in r22, tcnt1h 
	in r23, tcnt1l
	cp r22, r24 
	brne seguir 
	cp r23, r24 
	brne seguir 
	ldi aux4, 4 
	out timsk, aux4 
	rjmp seguir 
	
seguir: 
	rjmp continuo 
estado: 
	ldi aux2, 6 
	ser aux5 
	ldi aux1, $f0 
	out tcnt0, aux1 
	ldi aux1, $ff
	out tcnt1h, aux1
	out tcnt1l, aux1 
contador: 
	dec aux2
	ldi aux4, 1 
	out timsk, aux4
	brne salir
	ldi aux3, $0b
	out tcnt1h, aux3
	ldi aux3, $dd 
	out tcnt1l, aux3
	ldi aux2, 0 
	ldi aux1, 0 
	clr aux5 
salir:
	reti 	
tiempo:
	out tcnt0, aux6 
  	in aux4, pina 
	eor aux4, aux5 
	out porta, aux4 
	reti



