#include <xc.inc>

extrn	LED_setup, all_on, all_off
global	flashing1, flashing2, flashing3
    
psect udata_acs				; reserving space in access ram
flash_delay1:ds 1
flash_delay2:ds 1
flash_delay3:ds 1
    
psect s_mode_code, class = CODE

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

audi:
    
    

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