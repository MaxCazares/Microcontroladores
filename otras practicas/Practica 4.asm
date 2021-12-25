.include "m8535def.inc" 
.def aux = r16

ser aux
out ddra, aux
out portb, aux
clr zh 

leer: 
in aux,pinb
andi aux, $0f
cpi r16, $0A
brge M

ldi r20, $3f
ldi r21,6
ldi r22, $5b
ldi r23, $4f
ldi r24, $66
ldi r25, $6d
ldi r26, $7d 
ldi r27, 7 
ldi r28, $7f 
ldi r29, $6f 
rjmp fin 

M: 
	ldi r20, $77
	ldi r21, $7C
	ldi r22, $39 
	ldi r23, $5E
	ldi r24, $79 
	ldi r25, $71 
	rjmp fin2
fin:
	ldi zl, 20
	add zl, aux
	ld aux, z 
	out porta, aux
	rjmp leer

fin2: 
ldi zl, 20
add zl, aux
subi zl, $0A
ld aux, z 
out porta, aux 
rjmp leer
