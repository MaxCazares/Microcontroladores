.include"m8535def.inc"
.def aux = r16
.equ step1 = 8  ; 00001000
.equ step2 = 4  ; 00000100
.equ step3 = 2  ; 00000010
.equ step4 = 1  ; 00000001

rjmp config_io      
rjmp secuencia2     

config_io:
    ldi aux, $0F
    out DDRC, aux   
    ldi aux, $04
    out PORTD,aux   
    ldi aux,$02
    out MCUCR,aux   
    ldi aux,$40
    out GICR,aux    
    sei

main:
    rcall secuencia1    
    rjmp main

secuencia1:             
    ldi aux,step1       
    out PORTC,aux       
    rcall retardo       

    ldi aux,step2       
    out PORTC,aux       
    rcall retardo       

    ldi aux,step3       
    out PORTC,aux       
    rcall retardo       

    ldi aux,step4       
    out PORTC,aux       
    rcall retardo       
    ret

secuencia2:             
    ldi aux,step4       
    out PORTC,aux       
    rcall retardo       

    ldi aux,step3       
    out PORTC,aux       
    rcall retardo       

    ldi aux,step2       
    out PORTC,aux       
    rcall retardo       

    ldi aux,step1       
    out PORTC,aux       
    rcall retardo       
    reti

retardo:
;    delay loop generator 
;     250000 cycles:
; ----------------------------- 
; delaying 249999 cycles:
          ldi  R17, $A7
WGLOOP0:  ldi  R18, $02
WGLOOP1:  ldi  R19, $F8
WGLOOP2:  dec  R19
          brne WGLOOP2
          dec  R18
          brne WGLOOP1
          dec  R17
          brne WGLOOP0
; ----------------------------- 
; delaying 1 cycle:
          nop
; ============================= 

    ret
