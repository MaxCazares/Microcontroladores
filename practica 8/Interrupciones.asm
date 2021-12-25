	.include"m8535def.inc"
	.def aux = r16
	.def nbit = r17
	rjmp main
	rjmp conmuta
	rjmp cambia

main:
	ldi aux,low(ramend)
	out spl,aux
	ldi aux,high(ramend)
	out sph,aux
	ser aux
	out ddra,aux 	
	out portd,aux
	ldi aux,$0a
	out mcucr,aux
	ldi aux,$c0
	out gicr,aux
	clr aux
	ldi nbit,1
	sei

fin: 
	out porta,aux
	rjmp fin

conmuta:
	in aux,pina
	eor aux,nbit
	reti

cambia: 
	lsl nbit
	reti