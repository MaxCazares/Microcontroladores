.include "m8535def.inc"
.def aux = r16

data:
    .db $3f,6,$5b,$4f,$66,$6d,$7d,7,$7f,$6f,10

main:
    ldi aux,low(RAMEND)
    out spl,aux
    ldi aux,high(RAMEND)
    out sph,aux
    ser aux
    out ddra,aux
    out portb,aux

ini:
    ldi zh,high(data)
    ldi zl,low(data)
uno:
    lpm r16,z+
    out porta,aux
    cpi aux,10
    breq ini
    rcall retardo
    rjmp uno

retardo:
    ldi  r27, 16
    ldi  r28, 57
    ldi  r29, 14
L1: dec  r29
    brne L1
    dec  r28
    brne L1
    dec  r27
    brne L1
    nop 
    ret
