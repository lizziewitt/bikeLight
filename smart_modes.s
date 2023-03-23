#include <xc.inc>

extrn	interrupt_state, execute_interrupt, all_on, all_off, distance, sensor_chirp
global	smart_mode, PWM_setup, disable_PWM
    
psect udata_acs				; reserving space in access ram
 
psect smart_code, class = CODE
 
PWM_setup:
   ; PORT pins are already set to outputs 
   movlw    00000100
   movwf    T2CON			   ; configuring timer2
   movlw    00001100B			
   movwf    CCP5CON			   ; enable PWM mode - need to do this for other pins as well (they are ECCP so may be slightly different)
   return
   
disable_PWM:
    clrf    T2CON
    clrf    CCP5CON
    
    
smart_mode:
     call	sensor_chirp
     bra	smart_brightness


