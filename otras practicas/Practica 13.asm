.include "m8535def.inc" 
.def aux = r16 
.macro pulso
sbi porta, 0 
ldi aux, @0 
loop1: 
	rcall delay
	dec aux 
	brne loop1
	cbi porta, 0 
	ldi aux, @1
loop2: 
	rcall delay 
	dec aux 
	brne loop2 
	rjmp otro 
	.endm 
main: 
	ldi aux, low(RAMEND)
	out spl, aux 
	ldi aux, high(RAMEND) 
	out sph, aux
	ser aux 
	out ddra, aux 
	out portd, aux 
otro: 
	sbis pind, 0 
	rjmp cero 
	sbis pind, 1 
	rjmp uno 
	sbis pind, 2 
	rjmp dos
	sbis pind, 3 
	rjmp tres
	sbis pind, 4 
	rjmp cuatro
	sbis pind, 5
	rjmp cinco
	sbis pind, 6
	rjmp seis
	sbis pind, 7
	rjmp siete 
	rjmp otro 

cero: 
