.include"m8535def.inc"
    .def adl = r17
    .def adh = r16
    .def col = r18
    .def aux = r19
    .def cta = r20
;----------------------------Macro para cargar numeros------------------------------
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
;---------------------------Vector de interrumpiciones-------------------------------
        rjmp  Start
    .org $008 ;Timer/Counter1 Overflow
        rjmp barre;Multiplexado
    .org $0E  ;ADC Conversion 
        rjmp conv; ADC
;---------------------------------------------------------------------------
Start:
      LDI R16,LOW(RAMEND)
      OUT SPL,R16
      LDI R16,HIGH(RAMEND)
      OUT SPH,R16
      SER R16
      OUT DDRD,R16
      OUT DDRB,R16
      OUT DDRC,R16
      LDI R16,$ED ; 1110 1101
      OUT ADCSRA,R16
      ldi r16,$20
      out ADMUX,r16
      ldi aux,2
      out tccr0,aux
      ldi aux,2
      out tccr1b,aux
      ldi aux,5
      out timsk,aux
      SEI
      ldi col,1
      clr zh
      ldi zl,0
;----------------------------------------------------------------
Loop:
      OUT PORTC,adh
       rjmp  Loop
 ;----Conversion del ADC-------
CONV:
     IN adl,ADCL
     IN adh,ADCH

     mov cta,adh;---Guarda el valor en
	 ;cuenta para modificarlo

     RETI
;-----Multiplexado----------
barre:
      out portb,zh
      ld aux,z+
      lsl col
      brcs nbarre
sss:
      com col
      out portd,col
      com col
      out portb,aux
      reti
 nbarre:
      ldi col,1
      ldi zl,0
      ld aux,z+
      rjmp sss
;---------Codifcacion del adc--------------
 
       cpi cta, $FF; numero 0
       breq cta0

       cpi adh, $80; nuemro 1
       breq cta1

       cpi cta, $55; numero 2
       breq cta2

       cpi cta, $40; numero 3
       breq cta3

       cpi cta, $33; numero 4
       breq cta4

       cpi cta, $2A; numero 5
       breq cta5

       cpi cta, $24; numero 6
       breq cta6

       cpi cta, $20; numero 7
       breq cta7

       cpi cta, $1C; numero 8
       breq cta8

       cpi cta, $19; numero 9
       breq cta9

       brne  cara; si no se presiona nada mostrara una carita en los leds (:

      rjmp ncta
ncta:
      reti
cara:
      num carita
      rjmp ncta
;-------------------Saltos para estar dentro de rango-------------------
cta2:
      rjmp cta21
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
;--------------------------------Llamadas a macro-------------------------
cta0:
      num cero; macro con el numero 0
      rjmp ncta
cta1:
      num uno
      rjmp ncta; macro con el numero 1

cta21:
      num dos; macro con el numero 2
      rjmp ncta

cta31:
      num tres; macro con el numero 3
      rjmp ncta

cta41:
      num cuatro; macro con el numero 4
      rjmp ncta

cta51:
      num cinco; macro con el numero 5
      rjmp ncta

cta61:
      num seis; macro con el numero 6
      rjmp ncta

cta71:
      num siete; macro con el numero 7
      rjmp ncta

cta81:
      num ocho; macro con el numero 8
      rjmp ncta

cta91:
      num nueve; macro con el numero 9
      rjmp ncta

;---------Numeros----------------

cero:
    .db $38,$44,$82,$82,$82,$44,$38,$00
uno:
    .db $00,$22,$42,$FE,$02,$02,$00,$00
dos:
    .db $00,$42,$86,$85,$92,$62,$00,$00
tres:
    .db $00,$44,$82,$92,$92,$6C,$00,$00
cuatro:
    .db $00,$08,$18,$28,$48,$FE,$00,$00
cinco:
    .db $00,$F4,$92,$92,$92,$86,$00,$00
seis:
    .db $00,$FC,$92,$92,$92,$8C,$00,$00
siete:
    .db $82,$84,$88,$90,$A0,$C0,$00,$00
ocho:
    .db $6C,$92,$92,$92,$92,$92,$6C,$00
nueve:
    .db $60,$92,$92,$92,$92,$92,$6C,$00
carita:
    .db $00,$64,$62,$02,$02,$62,$64,$00

