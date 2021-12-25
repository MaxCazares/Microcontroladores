	.include"m8535def.inc"
    .def aux=r16
    ldi aux,low(ramend)
    out spl,aux
    ldi aux,high(ramend)
    out sph,aux
    ser aux
    out ddra,aux
    out portb,aux

checa:
    sbis pinb,7
    rcall pos1

    sbis pinb,6
    rcall pos2

    sbis pinb,5
    rcall pos3

	sbis pinb,4
    rcall pos4

	sbis pinb,3
    rcall pos5

	sbis pinb,2
    rcall pos6

	sbis pinb,1
    rcall pos7

	sbis pinb,0
    rcall pos8

    rjmp checa

pos1:
    sbi porta,0
    rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
    cbi porta,0
    ldi aux,152
cta:
    rcall medms
    dec aux
    brne cta
    ret


pos2:
    sbi porta,0
    rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
    cbi porta,0
    ldi aux,151
cta2:
    rcall medms
    dec aux
    brne cta2
    ret

pos3:
    sbi porta,0
    rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
    cbi porta,0
    ldi aux,150
cta3:
    rcall medms
    dec aux
    brne cta3
    ret

pos4:
    sbi porta,0
    rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
    cbi porta,0
    ldi aux,149
cta4:
    rcall medms
    dec aux
    brne cta4
    ret

pos5:
    sbi porta,0
    rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
    cbi porta,0
    ldi aux,147
cta5:
    rcall medms
    dec aux
    brne cta5
    ret

pos6:
    sbi porta,0
    rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
    cbi porta,0
    ldi aux,146
cta6:
    rcall medms
    dec aux
    brne cta6
    ret

pos7:
    sbi porta,0
    rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
    cbi porta,0
    ldi aux,145
cta7:
    rcall medms
    dec aux
    brne cta7
    ret

pos8:
    sbi porta,0
    rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
	rcall medms
    cbi porta,0
    ldi aux,144
cta8:
    rcall medms
    dec aux
    brne cta8
    ret

medms:
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 125 cycles
; 125us at 1 MHz

    ldi  r18, 41
L1: dec  r18
    brne L1
    rjmp PC+1
	ret
