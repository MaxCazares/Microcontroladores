 .include"m8535def.inc"
    .def aux = r16
    .def contador = r17

    .def step1 = r18
    .def step2 = r19
    .def step3 = r20
    .def step4 = r21

    .def step = r22
    .def uno= r23

reset:
    rjmp main
    .org $008;Timer/Counter1 Overflow
    rjmp pasos
    .org $009;Timer/Counter0 Overflow
    rjmp overflowtc0
    
main:
    ldi aux,low(RAMEND)
    out spl,aux
    ldi aux,high(RAMEND)
    out sph,aux
    
    ser aux
    ;Salida
    out ddrc, aux
    ;Entrada
    out portb, aux


    ldi step1, $8
    ldi step2, $4
    ldi step3, $2
    ldi step4, $1


    ldi aux,$1 ; Timer/Counter0
    out timsk,aux
    
    ldi aux,$6; CS02:0: Clock Select.
    out TCCR0,aux ;

    ldi uno, $1
    ldi step, $0

    ldi contador,251
    out tcnt0,contador

    sei

fin:
    nop
    nop
    rjmp fin


overflowtc0:
    ldi aux,$2;  CS12:0: Clock Select. lkI/O/8
    out TCCR1B,aux ;

    ldi aux,$4; TOIE1: Timer/Counter1
    out timsk,aux

    reti

paso4:
    out portc, step4
paso3:
    out portc, step3
paso2:
    out portc, step2
paso1:
    out portc, step1
        ldi step, $0
pasos:
    add step, uno

    cpi step, 1
    breq paso4
        

    cpi step, 2
    breq paso3
        

    cpi step, 3
    breq paso2
        

    cpi step, 4
    breq paso1
        

    rjmp pasos

