.include"m8535def.inc"
	.def aux =r16
	.def col=r17
	.def tec = r19
	.def tecf = r20
	.equ G = $40
	.equ cero = $3f
	.equ one = $06
	.equ two = $5b
	.equ tres = $4f
	.equ cuatro = $66
	.equ cinco = $6D
	.equ seis = $7d
	.equ siete = 7
	.equ ocho = $7f
	.equ nueve = $6f

.macro ldb
	ldi aux,@1
	mov @0,aux
	.endm
.macro mensaje
	ldb r7,@0 
	ldb r6,@1
	ldb r5,@2 
	ldb r4,@3
	ldb r3,@4 
	ldb r2,@5
	ldb r1,@6 
	ldb r0,@7
	.endm

reset:
	rjmp main 
	rjmp mueve
	rjmp borra
	.org $009
	rjmp barre
main:
	ldi aux,low(ramend)
	out spl,aux
	ldi aux,high(ramend)
	out sph,aux
	rcall config_io
	rcall texto0
	clr zh
	clr zl
	ldi col,1
	out portc,col
	ld aux,z
	out porta,aux
uno:nop
	nop
	nop
	rjmp uno

config_io:
	ser aux
	out ddra,aux
	out portb,aux
	out ddrc,aux
	out portd,aux
	ldi aux,3
	out tccr0,aux
	ldi aux,$01
	out timsk,aux
	ldi r18,193
	ldi aux,$03
	out mcucr,aux
	ldi aux,$C0
	out gicr,aux
	sei
	ret

texto0:
	mensaje G,G,G,G,G,G,G,G
	ret
barre:
	out tcnt0,r18
	out porta,zh
	inc zl
	lsl col
	brne dos
	ldi col,1
	clr zl
dos:
	out portc,col
	ld aux,z
	out porta,aux
	reti

mueve:
	mov r8,r7
	mov r7,r6
	mov r6,r5
	mov r5,r4
	mov r4,r3
	mov r3,r2
	mov r2,r1
	mov r1,r0
	in tec,pinb
	cpi tec,$be ; 0
	breq D_cero
	cpi tec,$7d ; 1
	breq D_uno
	cpi tec,$bd ; 2
	breq D_dos
	cpi tec,$dd ; 3
	breq D_tres
	cpi tec,$7b ; 4
	breq D_cuatro
	cpi tec,$bb ; 5
	breq D_cinco
	cpi tec,$db ; 6
	breq D_seis
	cpi tec,$77 ; 7
	breq D_siete
	cpi tec,$b7 ; 8
	breq D_ocho
	cpi tec,$d7 ; 9
	breq D_nueve

suelta:
	in tecf,pinb
	cp tecf,tec
	breq suelta  
	reti
D_cero: 
	ldb r0, cero
	rjmp suelta
D_uno: 
	ldb r0, one
	rjmp suelta
D_dos: 
	ldb r0, two
	rjmp suelta
D_tres: 
	ldb r0, tres
	rjmp suelta
D_cuatro: 
	ldb r0, cuatro
	rjmp suelta
D_cinco: 
	ldb r0, cinco
	rjmp suelta
D_seis: 
	ldb r0, seis
	rjmp suelta
D_siete: 
	ldb r0, siete
	rjmp suelta
D_ocho: 
	ldb r0, ocho
	rjmp suelta
D_nueve: 
	ldb r0, nueve
	rjmp suelta

borra:
	ldb r9,G
	mov r0,r1
	mov r1,r2
	mov r2,r3
	mov r3,r4
	mov r4,r5
	mov r5,r6
	mov r6,r7
	mov r7,r8
	mov r8,r9
	reti
