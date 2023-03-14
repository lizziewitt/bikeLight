#include <xc.inc>

extrn	LED_setup, all_on, all_off, g4_on, c2_on_c1_on, c2_off_c1_on, c2_on_c1_off, g4_off, c2_off_c1_off
global	flashing1, flashing2, flashing3, audi, brightness1, brightness2, brightness3, audi_s_line
    
psect udata_acs				; reserving space in access ram
flash_delay1:ds 1
flash_delay2:ds 1
flash_delay3:ds 1
    
psect s_mode_code, class = CODE
 
 ; flashing modes - have adjusted delays to create three different speeds 

flashing1:
    movlw   0xff
    movwf   flash_delay1, A		    ; setting delay values 
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x03
    movwf   flash_delay3, A
    call    all_on			    ; turning LEDs on
    ;call    board_on
    call    delay3			    ; delaying
    call    all_off
    ;call    board_off			    ; turning LEDs off
    movlw   0xff
    movwf   flash_delay1, A		    ; restting delay values
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x03
    movwf   flash_delay3, A
    call    delay3
    bra     flashing1		    ; looping
    
flashing2:
    movlw   0xff
    movwf   flash_delay1, A
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x05
    movwf   flash_delay3, A
    call    all_on
    ;call    board_on
    call    delay3
    call    all_off
    ;call    board_off
    movlw   0xff
    movwf   flash_delay1, A
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x05
    movwf   flash_delay3, A
    call    delay3
    bra     flashing2
    
flashing3:
    movlw   0xff
    movwf   flash_delay1, A
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x14
    movwf   flash_delay3, A
    call    all_on
    ;call    board_on
    call    delay3
    call    all_off
    ;call    board_off
    movlw   0xff
    movwf   flash_delay1, A
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x14
    movwf   flash_delay3, A
    call    delay3
    bra     flashing3
    
; brightness settings - will need to adjust the numbers used once tested on the LEDs    
    
    
brightness1:				    ; dimmest setting
    movlw   0x10
    movwf   flash_delay1
    call    all_on
    ;call    delay1
    call    all_off
    movlw   0xff
    movwf   flash_delay1
    call    delay1
    bra	    brightness1
   
brightness2:				    ; medium
    movlw   0x7D
    movwf   flash_delay1
    call    all_on
    call    all_off
    call    delay1
    bra	    brightness2
    
    
    
brightness3:				    ; brightest setting (without just being fully on)
    movlw   0xff
    movwf   flash_delay1
    call    all_on
    call    delay1
    movlw   0x32
    movwf   flash_delay1
    call    all_off
    call    delay1
    bra	    brightness3
    
; teehee

audi:
    call    c2_off_c1_on		    ; turns on inner ring   
    movlw   0xff
    movwf   flash_delay1, A		    
    call    delay1			    ; short delay for overlap
    call    g4_off			    ; turns off outer ring
    movlw   0xff
    movwf   flash_delay1, A		    ; setting long delay values 
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x03
    movwf   flash_delay3, A
    call    delay3			    ; inner ring remains on for duration of delay
    call    c2_on_c1_on			    ; turns on middle ring
    movlw   0xff
    movwf   flash_delay1, A
    call    delay1			    ; short delay for overlap
    call    c2_on_c1_off		    ; turns off inner ring
    movlw   0xff
    movwf   flash_delay1, A		    ; resetting long delay values 
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x03
    movwf   flash_delay3, A
    call    delay3			    ; middle ring remains on for duration of delay
    call    g4_on			    ; turns on outer
    movlw   0xff
    movwf   flash_delay1, A
    call    delay1			    ; overlap
    call    c2_off_c1_off		    ; turns middle off
    movlw   0xff
    movwf   flash_delay1, A		    ; resetting delay values 
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x03
    movwf   flash_delay3, A
    call    delay3			    ; outer remaining on for delay
    bra	    audi

audi_s_line:
    call    c2_off_c1_on		    ; turns on inner ring   
    movlw   0xff
    movwf   flash_delay1, A		    ; setting delay values 
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x01
    movwf   flash_delay3, A
    call    delay3			    ; delay before next ring turns on
    call    c2_on_c1_on			    ; turns on middle ring
    movlw   0xff
    movwf   flash_delay1, A		    ; resetting delay values 
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x01
    movwf   flash_delay3, A
    call    delay3			    ; delay before next ring turns on
    call    g4_on			    ; turns on outer
    movlw   0xff
    movwf   flash_delay1, A		    ; resetting delay values 
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x03
    movwf   flash_delay3, A
    call    delay3			    ; outer remaining on for delay
    call    all_off
    movlw   0xff
    movwf   flash_delay1, A		    ; resetting delay values 
    movlw   0xff
    movwf   flash_delay2, A
    movlw   0x03
    movwf   flash_delay3, A
    call    delay3
    bra	    audi_s_line
    
    
    
; cascading delays to use in the modes     
    
delay1:
    decfsz  flash_delay1, A		; decrement until zero
    bra	    delay1
    return
	
delay2:
    call    delay1
    decfsz  flash_delay2, A
    bra	    delay2
    return
    
delay3:
    call    delay2
    decfsz  flash_delay3, A
    bra	    delay3
    return
 
; methods to turn the LEDs on the development board on. useful for testing methods 
board_on:
    movlw	0xff			
    movwf	PORTD, A
    movlw	0xff
    movwf	PORTE, A
    return 
    
board_off:
    movlw	0x00
    movwf	PORTD, A
    movlw	0x00
    movwf	PORTE, A
    return 