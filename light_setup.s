	#include <xc.inc>
	
global LED_setup, Button_setup, US_setup

psect udata_acs ; named variables in access ram



psect bike_code, class = CODE

LED_setup:
    movlw 0x00
    movwf, TRISC, A
    movlw 0x00
    movwf, TRISG, A ;setting PWM pins to outputs
    
Button_setup:
    
    
US_setup:
    
    
