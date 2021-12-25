.include"m8535def.inc"
.def adl = r17
.def adh = r16 
.def teclado= r18 
rjmp empiezo 
.ORG $0E
RJMP CONV

empiezo: 
	ldi r16, low(RAMEND)
	out spl, r16
	ldi r16, high(RAMEND)
	out sph, r16
	ser r16
	out ddrd, r16
	out ddrb, r16
	out ddrc, r16
	ldi r16, $ED
	out adcsra, r16
	ldi r16, $20
	out ADMUX, r16
	clr teclado 
	sei
loop: 
	out portd, adl 
	out portb, adh 
	out portc, teclado
	rjmp loop

conv: 
	in adl, ADCL
	in adh, ADCH
	cpi adl, $c0
	breq compara00
	cpi adl, $40
	breq compara01
	cpi adl, $80
	breq compara02
	cpi adl, $00
	breq compara03
	brne nada 
	reti
nada: 
	clr teclado
	reti

compara00: 
	cpi adh, $C8
	breq uno 
	cpi adh, $54
	breq mas 
	cpi adh, $B7
	breq cuatro 
	cpi adh, $89
	breq ocho 
	reti 

compara01: 
	cpi adh, $D8
	breq on_c
	cpi adh, $52
	breq menos 
	cpi adh, $4F
	breq equis 
	cpi adh, $6F
	breq nueve
	reti	

compara02: 
	cpi adh, $A2 
	breq cero 
	cpi adh, $99
	breq dos 
	cpi adh, $79
	breq tres 
	cpi adh, $8F
	breq cinco
	cpi adh, $AE
	breq siete 
	cpi adh, $4D
	breq div
	reti

compara03: 
	cpi adh, $7F
	breq igual 
	cpi adh, $73 
	breq seis 
	reti 

on_c: 
	ldi teclado, $39
	reti 

cero: 
	ldi teclado, $3F
	reti 

uno: 
	ldi teclado, $06
	reti

dos: 
	ldi teclado, $5B
	reti 

tres: 
	ldi teclado, $4F 
	reti 

cuatro: 
	ldi teclado, $66
	reti 

cinco: 
	ldi teclado, $6D
	reti
	
seis: 
	ldi teclado, $7D
	reti
	
siete: 
	ldi teclado, $27
	reti

ocho: 
	ldi teclado, $7f
	reti 

nueve: 
	ldi teclado, $6f 
	reti 
	
mas: 
	ldi teclado, $09 
	reti
	
menos: 
	ldi teclado, $40 
	reti 

equis: 	
	ldi teclado, $76  
	reti

div: 
	ldi teclado, $52
	reti

igual: 
	ldi teclado, $48 
	reti
