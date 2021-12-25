	.include"m8535def.inc"
	.def adl = r17
	.def adh = r16
	.def col = r18
	.def aux = r19
	.def cta = r20
;----------------------------------------------------------------------------
.macro num
	push zh
	push zl
	ldi ZH, high(@0<<1)              ; Initialize Z pointer
	ldi ZL, low(@0<<1)
	lpm r0, Z+
	lpm r1, Z+
	lpm r2, Z+
	lpm r3, Z+
	lpm r4, Z+
	lpm r5, Z+
	lpm r6, Z+
	lpm r7, Z
	pop zl
	pop zh
.endm
;--------------------------------------------------------------------------
	rjmp Start
	.org $008
	rjmp cuenta
	rjmp barre
	.ORG $0E
	RJMP CONV
;---------------------------------------------------------------------------
Start:
	LDI R16, LOW(RAMEND)
	OUT SPL, R16
	LDI R16, HIGH(RAMEND)
	OUT SPH, R16
	SER R16
	OUT DDRD, R16
	OUT DDRB, R16
	OUT DDRC, R16
	LDI R16, $ED
	OUT ADCSRA, R16
	ldi r16, $27
	out ADMUX, r16
	ldi aux, 2
	out tccr0, aux
	ldi aux, 2
	out tccr1b, aux
	ldi aux, 5
	out timsk, aux
	SEI
	ldi cta, -1
	ldi col, 1
	clr zh
	ldi zl, 0
;--------------------------------------------
Loop:
	OUT PORTD, adh
	rjmp Loop
;--------------------------------------------
CONV:
	IN adl, ADCL
	IN adh, ADCH
	RETI
;--------------------------------------------
barre:
	out portb, zh
	ld aux, z+
	lsl col
	brcs nbarre
sss:
	com col
	out portc, col
	com col
	out portb, aux
	reti
nbarre:
	ldi col, 1
	ldi zl, 0
	ld aux, z+
	rjmp sss
;-------------------------------------------
cuenta:
	;inc cta
	mov cta, adh
	cpi cta, $19
	breq cta0
	cpi cta, $33
	breq cta1
	cpi cta, $4C
	breq cta2
	cpi cta, $66
	breq cta3
	cpi cta, $80
	breq cta4
	cpi cta, $99
	breq cta5
	cpi cta, $B3
	breq cta6
	cpi cta, $CC
	breq cta7
	cpi cta, $E6
	breq cta8
	cpi cta, $FF
	breq cta9
	cpi cta, $00
	breq ctax
	;brne ncta
	;ldi cta, -1
ncta:
	reti
cta3:
	rjmp cta31
cta4:
	rjmp cta41
cta5:
	rjmp cta51
cta6:
	rjmp cta61
cta7:
	rjmp cta71
cta8:
	rjmp cta81
cta9:
	rjmp cta91
ctax:
	rjmp ctax1
cta0:
	num cero
	rjmp ncta
cta1:
	num uno
	rjmp ncta
cta2:
	num dos
	rjmp ncta
cta31:
	num tres
	rjmp ncta
cta41:
	num cuatro
	rjmp ncta
cta51:
	num cinco
	rjmp ncta
cta61:
	num seis
	rjmp ncta
cta71:
	num siete
	rjmp ncta
cta81:
	num ocho
	rjmp ncta
cta91:
	num nueve
	rjmp ncta
ctax1:
	num equis
	rjmp ncta
;---------------------------------------
cero:
	.db $00,$7C,$82,$82,$82,$7C,$00,$00
uno:
	.db $00,$22,$42,$FE,$02,$02,$00,$00
dos:
	.db $00,$42,$86,$8A,$92,$62,$00,$00
tres:
	.db $00,$44,$82,$92,$92,$6C,$00,$00
cuatro:
	.db $00,$08,$18,$28,$48,$FE,$00,$00
cinco:
	.db $00,$F4,$92,$92,$92,$8C,$00,$00
seis:
	.db $00,$7C,$92,$92,$92,$4C,$00,$00
siete:
	.db $00,$80,$80,$80,$80,$FE,$00,$00
ocho:
	.db $00,$6C,$92,$92,$92,$6C,$00,$00
nueve:
	.db $00,$64,$92,$92,$92,$7C,$00,$00
equis:
	.db $7E,$81,$A9,$85,$85,$A9,$81,$7E
