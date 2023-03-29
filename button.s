	#include <xc.inc>

global	button_setup, button_int, press_delay2, button_delay1, button_delay2, mode_check_call, mode_check_rotate, interrupt_state, button_state
	
extrn	active, current_mode
extrn	flashing1, flashing2, flashing3, audi, brightness1, brightness2, brightness3, audi_s_line, current_mode
extrn	all_off, disable_PWM,smart_mode, PWM_setup
	
psect udata_acs				; reserving space in access ram
button_delay1:ds 1
button_delay2:ds 1
button_delay3:ds 1
button_state:ds 1
interrupt_state:ds 1
    
psect button_code, class = CODE	
	
button_setup:
    movlw   0xff
    movwf   TRISB, A
    clrf    PORTB
    ;clrf    INTCON
    ;clrf    INTCON2
    ;clrf    INTCON3
    ;clrf    PORTB
    ;clrf    LATB
    ;bcf     RBPU
    ;bsf	    INT1IP
    bsf	    GIE			    ; enable all interrupts
   ; bsf	    INT0IE
    bsf	    RBIE		    ; enable interrupt pin
    ;bsf	    INTEDG1		    ; interrupt on rising edge of RB1
    ;bsf	    INTEDG0

    return
    
button_int:
    movlw   0x00
    movwf   button_state		    ; clearing button state
    movlw   0xff
    movwf   interrupt_state, A		    ; setting interrupt state
    movlw   0xff
    movwf   button_delay1, A
    movlw   0xff
    movwf   button_delay2, A
    movlw   0x10
    movwf   button_delay3, A
    call    press_delay3 
    BTFSS   PORTB, 4, A			    ; if button pin is high, skip next line
    call    button_set_short
    BTFSS   button_state, 0, A		    ; skip if button_state is 1 (i.e. short press)
    call    button_set_long
    call    release_check
    bcf	    RBIF
    bcf	    INT0IF
    retfie  f
    
release_check:
    BTFSS   PORTB, 4, A ; if button pin is high, skip next line
    return
    bra	    release_check
    
mode_check_rotate: ; subroutine which checks current mode and calls next one
    call    flashing1_check_rotate
    
mode_check_call:
    call    flashing1_check
    

button_set_short:
    movlw   0xff
    movwf   button_state, A
    return  

button_set_long:
    movlw   0x00
    movwf   button_state, A
    return
    
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
    bra	    smart_check_rotate
    call    PWM_setup
    call    smart_mode
    
smart_check_rotate:
    movlw   0x08
    cpfseq  current_mode, A
    bra	    flashing1_check_rotate
    call    disable_PWM
    call    flashing1    

    
flashing1_check:
    call    disable_PWM
    movlw   0x00
    CPFSEQ  current_mode, 0
    bra	    flashing2_check
    call    disable_PWM
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
    bra	    smart_check
    call    audi_s_line
    
smart_check:
    movlw   0x08
    cpfseq  current_mode, A
    bra	    flashing1_check
    call    PWM_setup
    call    smart_mode
    
    

    
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
    
press_delay3:
    call    press_delay2
    decfsz  button_delay3, A
    bra	    press_delay3
    return

    