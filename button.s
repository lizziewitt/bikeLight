	#include <xc.inc>

global	button_setup, button_int
	
extrn	active, current_mode
extrn	flashing1, flashing2, flashing3, audi, brightness1, brightness2, brightness3, audi_s_line, current_mode
	
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

    ; call delay 
    ;BTFSC   PORTB, A			    ; if button pin is high, skip next line
    ;call    mode_check_rotate
    ;BTFSC   active, A			    ; if "active" pointer is 0, skip next line (active pointer is 0 for lights off and 1 for lights on) 
    ;call    all_off
    ;call    mode_check_call
    ;movlw   0xff
    ;movwf   active, A
    ;bcf	    RBIF
    ;retfie  f
    
mode_check_rotate: ; subroutine which checks current mode and calls next one
    call    flashing1_check_rotate
    
mode_check_call:
    call    flashing1_check

    
flashing1_check_rotate:
    movlw   00000001B
    CPFSEQ  current_mode, A
    bra	    flashing2_check_rotate
    call    flashing2
    
flashing2_check_rotate:
    movlw   00000010B
    CPFSEQ  current_mode, A
    bra	    flashing3_check_rotate
    call    flashing3
    
flashing3_check_rotate:
    movlw   00000100B
    CPFSEQ  current_mode, A
    bra	    brightness1_check_rotate
    call    brightness1
    
brightness1_check_rotate:
    movlw   00001000B
    CPFSEQ  current_mode, A
    bra	    brightness2_check_rotate
    call    brightness2
    
brightness2_check_rotate:
    movlw   00010000B
    CPFSEQ  current_mode, A
    bra	    brightness3_check_rotate
    call    brightness3
    
brightness3_check_rotate:
    movlw   00100000B
    CPFSEQ  current_mode, A
    bra	    audi_check_rotate
    call    audi
    
audi_check_rotate:
    movlw   01000000B
    CPFSEQ  current_mode, A
    bra	    audi_s_line_check_rotate
    call    audi_s_line
    
audi_s_line_check_rotate:
    movlw   10000000B
    CPFSEQ  current_mode, A
    bra	    flashing1_check_rotate
    call    flashing1

    
flashing1_check:
    movlw   00000001B
    CPFSEQ  current_mode, A
    bra	    flashing2_check
    call    flashing1
    
flashing2_check:
    movlw   00000010B
    CPFSEQ  current_mode, A
    bra	    flashing3_check
    call    flashing2
    
flashing3_check:
    movlw   00000100B
    CPFSEQ  current_mode, A
    bra	    brightness1_check
    call    flashing3
    
brightness1_check:
    movlw   00001000B
    CPFSEQ  current_mode, A
    bra	    brightness2_check
    call    brightness1
    
brightness2_check:
    movlw   00010000B
    CPFSEQ  current_mode, A
    bra	    brightness3_check
    call    brightness2
    
brightness3_check:
    movlw   00100000B
    CPFSEQ  current_mode, A
    bra	    audi_check
    call    brightness3
    
audi_check:
    movlw   01000000B
    CPFSEQ  current_mode, A
    bra	    audi_s_line_check
    call    audi
    
audi_s_line_check:
    movlw   10000000B
    CPFSEQ  current_mode, A
    bra	    flashing1_check
    call    audi_s_line
    
    

    