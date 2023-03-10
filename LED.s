    #include <xc.inc>

global LED_setup, all_on, all_off, c2_on, c1_on, r4_on, c2_on_c1_on, c2_off_c1_on, c2_on_c1_off, r4_off, c2_off_c1_off

    
;psect udata_acs			; reserving space in access ram
    
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
    return
    
c2_on:
    movlw 00000100B
    movwf PORTC, A
    return 
    
c1_on:
    movlw 00000010B
    movwf PORTC, A
    return
   
c2_on_c1_on:
    movlw 00000110B
    movwf PORTC, A
    return

r4_on:
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
    
r4_off:
    movlw 0x00
    movwf PORTG, A
    return
   
c2_off_c1_off:
    movlw 0x00
    movwf PORTC, A
    return
