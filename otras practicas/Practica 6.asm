.include "m8535def.inc" 
.def aux = r16
.def dato = r17 

ldi aux,low(RAMEND) 
out spl,aux 
ldi aux,high(RAMEND)
ser aux 
out ddra,aux
out portb, aux
out ddrc, aux 
clr zh 

ldi r20, $3f
ldi r21, 6
ldi r22, $5b
ldi r23, $4f 
ldi r24, $66
ldi r25, $6d
ldi r26, $7d
ldi r27, $27
ldi r28, $7f
ldi r29, $6f

otro: 
in dato,pinb
andi dato, $0F
rcall ddat
cbi portc, 0 
sbi portc, 1 
out porta, dato 
rcall delay 
out porta, zh 
in dato, pinb
andi dato, $F0 
swap dato
rcall ddat 
cbi portc, 1 
sbi portc, 0 
out porta, dato
rcall delay 
out porta, zh 
rjmp otro 

ddat: 
ldi zl,20
add zl,dato 
ld dato,z 
ret

delay: 

    ldi  r18, 2
    ldi  r19, 74
L1: dec  r19
    brne L1
    dec  r18
    brne L1
    nop
	ret
