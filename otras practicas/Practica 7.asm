.include"m8535def.inc"
    .def l1 = r16
    .def l2 = r17
    .def l3 = r18
    .def l4 = r19
    .def aux = r20

inic:   ;9
    rjmp main
    rjmp intr1
    rjmp intr2

main:   ;14
    ser aux
    out ddra,aux
    out ddrc,aux
    out portd,aux
    ldi aux,$0E
    out mcucr,aux
    ldi aux,$C0
    out GICR,aux
    sei

    ldi r22,$76
    ldi r23,$3f
    ldi r24,$38
    ldi r25,$77
    ldi r26,6
    ldi r27,$5b
    ldi r28,$4f
    ldi r29,$66

    clr zh

    ldi r20,$40
    ldi zl,20
    ld l1,z
    ld l2,z
    ld l3,z
    ld l4,z

most:   ;43
    ldi aux,1
    out portc,aux
    out porta,l1
    rcall retraso
    ldi aux,2
    out portc,aux
    out porta,l2
    rcall retraso
    ldi aux,4
    out portc,aux
    out porta,l3
    rcall retraso
    ldi aux,8
    out portc,aux
    out porta,l4
    rcall retraso
    rjmp most

intr1:  ;62
    ldi zl,22
    ld l4,z
    ldi zl,23
    ld l1,z
    ldi zl,24
    ld l2,z
    ldi zl,25
    ld l3,z
    reti

intr2: ;73
    ldi zl,26
    ld l4,z
    ldi zl,27
    ld l1,z
    ldi zl,28
    ld l2,z
    ldi zl,29
    ld l3,z
    reti

retraso:    ;84
    push aux
    ldi r21, 15
    ldi aux, 80
L:  dec aux
    brne L
    dec r21
    brne L
    pop aux
    ret

