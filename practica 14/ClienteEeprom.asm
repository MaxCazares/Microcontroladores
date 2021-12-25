.include"m8535def.inc"
	.def aux = r16
	.def msk = r17
	.def ini = r18
	.def tc1h = r19
	.def tc1l = r20
	.def auc = r21 
	.def dirh = r22
	.def dirl = r23
	.def dato = r24
	.def datodecimal = r25
	.def diezhex = r26
	.macro eeprw
	ldi dirh,@0
	ldi dirl,@1
	rcall EEPROM_write
	.endm
	.macro eeprr
	ldi dirh,@0
	ldi dirl,@1
	rcall EEPROM_read
	.endm
	.macro convdecimal
	clr datodecimal
	clr aux
	add aux, dato
	comprobar:
	cpi aux,10
	brlo terminar
	restar:
	add datodecimal, diezhex
	subi aux, 10
	rjmp comprobar
	terminar:
	add datodecimal, aux
	.endm


reset:
	rjmp main
	.org $004
	rjmp onda
	.org $008
	rjmp tmpo
	rjmp cliente
	.org $012
	rjmp interrupciondos
main:
	ldi aux,low(ramend)
	out spl,aux
	ldi aux,high(ramend)
	out sph,aux
	ser aux
	out ddra,aux
	out ddrc,aux
	out ddrd,aux
	out portb,aux
	ldi aux,6
	out tccr0,aux
	ldi aux,0b01000101
	out timsk,aux
	ldi	aux,0b01000000
	out mcucsr,aux
	ldi aux,0b00100000
	out gicr,aux
	sei
	ldi aux,250
	out tcnt0,aux
	ldi msk,1
	ldi ini,256-141
	ldi tc1h,$B3
	ldi tc1l,$B5
	out tcnt1h,tc1h
	out tcnt1l,tc1l
	ldi diezhex, $10
	eeprr $00, $00
	convdecimal
	cpi dato,$64 ;100 en hexadecimal
	brne nada
	ldi dato,$00
	convdecimal
	eeprw $00,$00
nada:
	in auc,tcnt0
	clr aux
	sub aux,auc
	out portc,aux
	out portd,datodecimal
	rjmp nada
onda:
	out tcnt2,ini
	in aux,pina
	eor aux,msk
	out porta,aux
	reti
tmpo:
	ldi aux,0
	out tccr2,aux
	out tccr1b,aux
	ldi aux,250
	out tcnt0,aux
	reti
cliente:
	ldi aux,2
	out tccr2,aux
	ldi aux,4
	out tccr1b,aux
    out tcnt1h,tc1h
	out tcnt1l,tc1l
	inc dato
	cpi dato,$64 ;100 en hexadecimal
	brne escribirdato
	ldi dato,$00
escribirdato:
	convdecimal
	eeprw $00,$00
	reti

interrupciondos:
	ldi dato,$00
	convdecimal
	eeprw $00,$00
	reti



EEPROM_write:
	; Wait for completion of previous write
	sbic EECR,EEWE
	rjmp EEPROM_write
	; Set up address (r18:r17) in address register
	out EEARH, dirh
	out EEARL, dirl
	; Write data (r16) to Data Register
	out EEDR,dato
	; Write logical one to EEMWE
	sbi EECR,EEMWE
	; Start eeprom write by setting EEWE
	sbi EECR,EEWE
	ret

EEPROM_read:
	; Wait for completion of previous write
	sbic EECR,EEWE
	rjmp EEPROM_read
	; Set up address (r18:r17) in Address Register
	out EEARH, dirh
	out EEARL, dirl
	; Start eeprom read by writing EERE
	sbi EECR,EERE
	; Read data from Data Register
	in dato,EEDR
	ret
