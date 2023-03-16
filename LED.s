    #include <xc.inc>

global LED_setup, all_on, all_off, g4_on, c2_on_c1_on, c2_off_c1_on, c2_on_c1_off, g4_off, c2_off_c1_off, active 

    
psect udata_acs			; reserving space in access ram
active:ds 1
 
psect LED_code, class = CODE

 
LED_setup:
    movlw 0x00
    movwf TRISC, A
    movlw 0x00
    movwf TRISG, A			; setting PWM pins to outputs
    return
    
all_on: 
    movlw 00000110B
    movwf PORTC, A
    movlw 0xff
    movwf PORTG, A
    return 

all_off:
    movlw 0x00
    movwf PORTC, A
    movlw 0x00
    movwf PORTG, A
    movlw 0x00
    movwf active, A
    return
    
c2_on_c1_on:
    movlw 00000110B
    movwf PORTC, A
    return

g4_on:
    movlw 00010000B
    movwf PORTG, A
    return
    
c2_off_c1_on:
    movlw 00000010B
    movwf PORTC, A
    return 
    
c2_on_c1_off:
    movlw 00000100B
    movwf PORTC, A
    return 
    
g4_off:
    movlw 0x00
    movwf PORTG, A
    return
   
c2_off_c1_off:
    movlw 0x00
    movwf PORTC, A
    return
