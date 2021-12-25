.include"m8535def.inc"
.def aux = r16
.def dat = r17
.def dsp = r18

;lpm CARGA LA MEMORIA DE PROGRAMA
reset: 
	rjmp main 
	.org $009
	rjmp barre 
main:
	push zh
	push zl
	ldi ZH, high(dato<<1)
	ldi ZL, low(dato<<1)
	lpm aux, Z
	out spl, aux
	out sph, aux
	rcall config_io
	ldi dsp, 1
	lpm
	ldi zl, 26
ciclo: 
	nop
	nop 
	nop 
	rjmp ciclo
barre: 
	out porta, zh 
	com dsp
	out portc, dsp
	com dsp
	ld	dat, -z 
	out porta, dat
	lsl dsp 
	sbrc dsp, 7
	rjmp otro 
sal: 
	reti
otro: 
	ldi dsp,1
	lpm 
	ldi zl, 26
	rjmp sal 

config_io: 
	ser aux 
	out ddra, aux
	out ddrc, aux
	ldi aux,2
	out tccr0, aux 
	ldi aux, 1
	out timsk, aux
	clr zh
	ldi r20, $40
	lpm 
	ldi r21, $77
	lpm 
	ldi r22, $38
	lpm 
	ldi r23, $3f
	lpm
	ldi r24, $76
	lpm 
	ldi r25, $40
	sei
	ret 
dato: 
.db $40, $77, $38, $3f, $76, $40
