    #include <xc.inc>

global LED_setup, all_on, all_off
    
;psect udata_acs	;reserving space in access ram
    
psect LED_code, class = CODE

 
LED_setup:
    movlw 0x00
    movwf TRISC, A
    movlw 0x00
    movwf TRISG, A  ;setting PWM pins to outputs
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