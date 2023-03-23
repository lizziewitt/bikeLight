#include <xc.inc>

extrn	interrupt_state, execute_interrupt, all_on, all_off, distance, sensor_chirp
global	smart_brightness
    
psect udata_acs				; reserving space in access ram
 
psect smart_code, class = CODE
 
PWM_setup:
   ; enable PWM mode
   ; pins are already set to outputs 
   ; set the TMR2 prescale value
   ; enable Timer2 by writing to T2CON
   return
    
    
smart_brightness:
    ; call	sensor_chirp
    ; set PWM duty cycle using distance value (longer = brighter)
    ; BTFSC	interrupt_state, 0, A
    ; call	execute_interrupt
    ; delay	gives time until next distance reading
    ; bra	smart_brightness
    return
    
    


