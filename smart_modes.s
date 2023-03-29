#include <xc.inc>

extrn	interrupt_state, execute_interrupt, all_on, all_off, distance, sensor_chirp
global	smart_mode, PWM_setup, disable_PWM
    
psect udata_acs				; reserving space in access ram
reading_delay: ds 1
 
psect smart_code, class = CODE
 
PWM_setup:
   ; PORT pins are already set to outputs 
   movlw    0xff
   movwf    PR2				    ; setting the period
   movlw    00001100B			    ; enabling PWM mode on pins
   movwf    CCP5CON			
   movlw    00001100B
   movwf    ECCP1CON
   movlw    00001100B
   movwf    ECCP2CON
  ; movlw    0xff			    ; setting a test duty cycle
  ; movwf    CCPR5L
  ; movlw    0xff			    ; setting a test duty cycle
  ; movwf    CCPR1L 
  ; movlw    0xff			    ; setting a test duty cycle
  ; movwf    CCPR2L 
   movlw    00000100B
   movwf    T2CON			   ; configuring timer2
  
		   ; enable PWM mode - need to do this for other pins as well (they are ECCP so may be slightly different)
   return
   
disable_PWM:
    clrf    T2CON
    clrf    CCP5CON
    clrf    ECCP1CON
    clrf    ECCP2CON
    return
    
    
smart_mode:
     movlw	0xff
     movwf	reading_delay
     call	delay
     call	sensor_chirp
     bra	smart_mode


delay:
    decfsz  reading_delay, A		; decrement until zero
    bra	    delay
    return