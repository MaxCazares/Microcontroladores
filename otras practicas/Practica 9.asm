.include"m8535def.inc"
.def aux = r16
.def j = r17
.def col = r19
.def dato = r20
.def i = r18
rjmp main
.org $004
rjmp cambio
.org $009
rjmp cuenta
main:

//.fgedcba
	ldi dato, $20 //00100000 -
	mov r7, dato
	ldi dato, $76 //01110110 H
	mov r6, dato
	ldi dato, $5f //01011111 O
	mov r5, dato
	ldi dato, $58 //01011000 L
	mov r4, dato
	ldi dato, $77 
	mov r3, dato 
	ldi dato, $20 
	ldi aux, low(RAMEND)
	out spl, aux 
	ldi aux, high(RAMEND) 
	out sph, aux 
	ser aux 
	out ddra, aux 
	out ddrc, aux 
	ldi aux,5
	out tccr0,aux
	ldi aux,1
	out tccr2,aux
	ldi aux,$41
	out timsk,aux
	sei
	ldi i,2
	ldi j,5
	clr zh
	clr col
	clr zl
	ldi zl,8
	ldi col,1
	com col
fin:
	out portc, dato 
	ldi aux, sreg 
	out portb,aux
	out porta,col
	rjmp fin
cuenta:
ldi aux,0
out tcnt0,aux
dec j
brne fin1
ldi j,2
inc zl
breq uno
reti
cambio:
ldi aux,20
out tcnt2,aux
dec i
brne fin2
ldi i,2
rol col
ld dato, z
dec zl
breq uno
reti
fin1:
reti
fin2:
reti
uno:
ldi zl,9
reti
