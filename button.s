	#include <xc.inc>

global	button_setup, button_int
	
extrn	active 
	
psect udata_acs				; reserving space in access ram
button_delay:ds 1

    
psect button_code, class = CODE	
	
button_setup:
    movlw   0xff
    movwf   TRISB
    bsf	    RBIE		    ; enable interrupt pin
    bsf	    INTEDG1		    ; interrupt on rising edge of RB1
    bsf	    GIE			    ; enable all interrupts
    
button_int:
    ; will eventually need if statements as we will have multiple interrupts
    ; movlw -  time needed for minimum
    ; mowvf button_delay
    ; call delay 
    ; BTFSC, RB1 - if button pin is high, skip next line
    ; call mode_check (subroutine which checks current mode and calls next one) 
    ; BTFSC, active if "active" pointer is 0, skip next line (active pointer is 0 for lights off and 1 for lights on) 
    ; call all_off
    ; call current mode
    ; set power pointer to 1
    ; bcf	RBIF
    ; retfie	f

mode_check:
    ; fetch active pointer value
    ; series of if statements 
    ; need to update active pointer value in the mode subroutines

    