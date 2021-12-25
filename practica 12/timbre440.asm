;Timbre activado con flanco de bajada en timer/counter 0 
;frecuencia de timbre de 440 Hz (timer/counter 2)
;duración 5 segundos (timer/counter 1)
	.include"m8535def.inc"
	.def aux = r16
	.def aux2 = r17
	.def msk = r18
	.def icta1 = r19
	.def icta2 = r20
	.def t1h = r21
	.def t1l = r22
reset:
	rjmp main
	.org $004
	rjmp onda
	.org $008
	rjmp tmpo
	rjmp timbre
main:
	ldi aux,low(ramend)
	out spl,aux
	ldi aux,high(ramend)
	out sph,aux
	ser aux
	out ddra,aux
	out ddrc,aux
	out portb,aux
	ldi aux,2
	out mcucr,aux
	ldi aux,0b01000101
	out timsk,aux
	sei
	ldi msk,1
	ldi icta1,256-142
	ldi icta2,256-6
	ldi t1h,$B3
	ldi t1l,$B5
	ldi aux,6
	out tccr0,aux
	out tcnt0,icta2

ciclo:
	in aux2,tcnt0
	com aux2
	cpi aux2, $06
	brsh ciclo
	out portc,aux2
	rjmp ciclo
onda:
	out tcnt2,icta1
	in aux,pina
	eor aux,msk
	out porta,aux
	reti
tmpo:
	out tcnt1h,t1h
	out tcnt1l,t1l
	ldi aux,0
	out tccr2,aux
	ldi aux,0
	out tccr1b,aux
	out tcnt0,icta2
	reti
timbre:
	out tcnt1h,t1h
	out tcnt1l,t1l
	out tcnt2,icta1
	ldi aux,2
	out tccr2,aux
	ldi aux,4
	out tccr1b,aux
	reti

