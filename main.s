	#include <xc.inc>

extrn   LED_setup, all_on, all_off, g4_on, c2_on_c1_on, c2_off_c1_on, c2_on_c1_off, g4_off, c2_off_c1_off
extrn	flashing1, flashing2, flashing3, audi, brightness1, brightness2, brightness3, audi_s_line, current_mode
extrn	button_setup, button_int, press_delay2, button_delay1, button_delay2, active

psect	udata_acs			; reserve data space in access ram
delay_count:ds 1			; reserve one byte for counter in the delay routine
	
psect	code, abs

rst:	
    org	    0x0000
    goto    main
	
int_hi:	
    org	    0x0008			; high vector, no low vecto
    goto    button_int
    

main:
    ;movlw 	0x00
    ;movwf	TRISD, A		; Port D all outputs
    ;movlw 	0x00
    ;movwf	TRISE, A		; Port E all outputs
    ;movlw	0x00
    ;movwf	TRISH, A		; PORT H output
    call	LED_setup
    call	button_setup
    ;goto	board_LED
    ;goto	delay_test
    ;call	audi_s_line
    ;movlw	0xff
    ;movwf	active, A
    movlw	0x00
    movwf	current_mode
    call	button_int
    goto	$			; Main code starts here at address 0x100
	
	

delay_test:
	movlw	0xff
	movwf	button_delay1, A
	movlw	0x28
	movwf	button_delay2, A
	movlw	0xff
	movwf	PORTH
	call	press_delay2
	movlw	0x00
	movwf	PORTH
	movlw	0xff
	movwf	button_delay1, A
	movlw	0x28
	movwf	button_delay2, A
	call	press_delay2
	bra	delay_test
	
	end	rst