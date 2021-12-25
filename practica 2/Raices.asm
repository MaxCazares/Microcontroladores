	.include"m8535def.inc"
inicio:
	ser r20
	out ddra,r20
	out portb,r20
	ldi r16,0
	ldi r17,-1
	ldi r18,2
	ldi r19,0
	in r20,pinb
uno:
	cpi r20,0
	breq tres
	rjmp dos
dos:
	add r17,r18
	add r19,r17
	cp r20,r19
	brlo tres
	inc r16
	rjmp dos
tres:
	out porta,r16
	nop	
