	#include <xc.inc>

global	button_setup, button_int, press_delay2, button_delay1, button_delay2
	
extrn	active, current_mode
extrn	flashing1, flashing2, flashing3, audi, brightness1, brightness2, brightness3, audi_s_line, current_mode
extrn	all_off
	
psect udata_acs				; reserving space in access ram
button_delay1:ds 1
button_delay2:ds 1
    
psect button_code, class = CODE	
	
button_setup:
    movlw   0xff
    movwf   TRISB, A
    bsf	    RBIE		    ; enable interrupt pin
    bsf	    INTEDG1		    ; interrupt on rising edge of RB1
    bsf	    GIE			    ; enable all interrupts
    return
    
button_int:
    ;call flashing1
    ; will eventually need if statements as we will have multiple interrupts
    movlw   0xff
    movwf   button_delay1, A
    movlw   0xff
    movwf   button_delay2, A
    call    press_delay2 
    BTFSS   PORTB, 1, A			    ; if button pin is high, skip next line
    call    mode_check_rotate
    BTFSC   active, 0, A			    ; if "active" pointer is 0, skip next line (active pointer is 0 for lights off and 1 for lights on) 
    call    all_off
    ; need to return to main code after calling all_off
    call    mode_check_call
    movlw   0xff
    movwf   active, A
    ;bcf	    RBIF
    ;goto    $
    ;retfie  f
    
mode_check_rotate: ; subroutine which checks current mode and calls next one
    call    flashing1_check_rotate
    
mode_check_call:
    call    flashing1_check
    
turn_off:
    call    all_off
    bcf	    RBIF
    retfie  f
    

    
flashing1_check_rotate:
    movlw   0x00
    CPFSEQ  current_mode, A
    bra	    flashing2_check_rotate
    call    flashing2
    
flashing2_check_rotate:
    movlw   0x01
    CPFSEQ  current_mode, A
    bra	    flashing3_check_rotate
    call    flashing3
    
flashing3_check_rotate:
    movlw   0x02
    CPFSEQ  current_mode, A
    bra	    brightness1_check_rotate
    call    brightness1
    
brightness1_check_rotate:
    movlw   0x03
    CPFSEQ  current_mode, A
    bra	    brightness2_check_rotate
    call    brightness2
    
brightness2_check_rotate:
    movlw   0x04
    CPFSEQ  current_mode, A
    bra	    brightness3_check_rotate
    call    brightness3
    
brightness3_check_rotate:
    movlw   0x05
    CPFSEQ  current_mode, A
    bra	    audi_check_rotate
    call    audi
    
audi_check_rotate:
    movlw   0x06
    cpfseq  current_mode, A
    bra	    audi_s_line_check_rotate
    call    audi_s_line
    
audi_s_line_check_rotate:
    movlw   0x07
    cpfseq  current_mode, A
    bra	    flashing1_check_rotate
    call    flashing1

    
flashing1_check:
    movlw   0x00
    CPFSEQ  current_mode, 0
    bra	    flashing2_check
    call    flashing1
    
flashing2_check:
    movlw   0x01
    CPFSEQ  current_mode, 0
    bra	    flashing3_check
    call    flashing2
    
flashing3_check:
    movlw   0x02
    CPFSEQ  current_mode, A
    bra	    brightness1_check
    call    flashing3
    
brightness1_check:
    movlw   0x03
    CPFSEQ  current_mode, A
    bra	    brightness2_check
    call    brightness1
    
brightness2_check:
    movlw   0x04
    CPFSEQ  current_mode, A
    bra	    brightness3_check
    call    brightness2
    
brightness3_check:
    movlw   0x05
    CPFSEQ  current_mode, A
    bra	    audi_check
    call    brightness3
    
audi_check:
    movlw   0x06
    CPFSEQ  current_mode, A
    bra	    audi_s_line_check
    call    audi
    
audi_s_line_check:
    movlw   0x07
    CPFSEQ  current_mode, A
    bra	    flashing1_check
    call    audi_s_line
    
press_delay1:
    nop
    decfsz  button_delay1, A
    bra	    press_delay1
    return

press_delay2:
    call    press_delay1
    decfsz  button_delay2, A
    bra	    press_delay2
    return

    