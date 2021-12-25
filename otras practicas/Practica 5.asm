.include "m8535def.inc"

    .def input = r16
    .def aux = r17
    .def nbajo = r18
    .def nalto = r19
    .def conv = r20
    .def conv2 = r21
    .def segundos = r25
    .def cuenta = r26

    ser aux
    out ddra,aux
    out portb, aux
    out ddrc,aux
    ldi aux,low(RAMEND)
    out spl,aux
    ldi aux,high(RAMEND)
    out sph,aux
leer:
    in input,pinb
    ldi nbajo,$0f
    ldi nalto,$f0
    clr conv2
    and nbajo,input
    and nalto,input
    swap nalto
    clr cuenta
    cpi nalto,0
    brne contar
    mov conv,nbajo
    rcall conversion
    nop
    nop
    rcall mostrar
    nop
    rjmp leer
contar:
    mov conv,cuenta
    rcall conversion
    rcall mostrar
    mov segundos,nalto
    rcall retardo
    inc cuenta
    cp nbajo,cuenta
    brge contar
    clr cuenta
    rjmp contar


mostrar:
    
    out portc,conv
    out porta,conv2
    ret


conversion:
    cpi conv,0
    breq es0
    cpi conv,1
    breq es1
    cpi conv,2
    breq es2
    cpi conv,3
    breq es3
    cpi conv,4
    breq es4
    cpi conv,5
    breq es5
    cpi conv,6
    breq es6
    cpi conv,7
    breq es7
    cpi conv,8
    breq es8
    cpi conv,9
    breq es9
    cpi conv,10
    breq es10
    cpi conv,11
    breq es11
    cpi conv,12
    breq es12
    cpi conv,13
    breq es13
    cpi conv,13
    breq es13
    cpi conv,14
    breq es14
    cpi conv,15
    breq es15
es0:
    ldi conv,$3f
    ret
es1:
    ldi conv,$06
    ret
es2:
    ldi conv,$5b
    ret
es3:
    ldi conv,$4f
    ret
es4:
    ldi conv,$66
    ret
es5:
    ldi conv,$6d
    ret
es6:
    ldi conv,$7d
    ret
es7:
    ldi conv,$07
    ret
es8:
    ldi conv,$7f
    ret
es9:
    ldi conv,$67
    ret
es10:
    ldi conv,$3f
    ldi conv2,$06
    ret
es11:
    ldi conv,$06
    ldi conv2,$06
    ret
es12:
    ldi conv,$5b
    ldi conv2,$06
    ret
es13:
    ldi conv,$4f
    ldi conv2,$06
    ret
es14:
    ldi conv,$66
    ldi conv2,$06
    ret
es15:
    ldi conv,$6d
    ldi conv2,$06
    ret

;----------------------------------------------------------
;---------------Subrutina retardo n seg -------------------
;-----------------------------------------------------------    

retardo:
    ldi  r22, 6
    ldi  r23, 19
    ldi  r24, 174

    
L1: dec  r24
    brne L1
    dec  r23
    brne L1
    dec  r22
    brne L1
    dec segundos
    brne retardo
    ret
