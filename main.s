	#include <xc.inc>

extrn   LED_setup, all_on, all_off, g4_on, c2_on_c1_on, c2_off_c1_on, c2_on_c1_off, g4_off, c2_off_c1_off
extrn	flashing1, flashing2, flashing3, audi, brightness1, brightness2, brightness3, audi_s_line
extrn	button_setup, button_int

psect	udata_acs			; reserve data space in access ram
delay_count:ds 1			; reserve one byte for counter in the delay routine
	
psect	code, abs
	
main:
	org	0x0			; turning on LEDs on clicker2
	;movlw 	0x00
	;movwf	TRISD, A		; Port D all outputs
	;movlw 	0x00
	;movwf	TRISE, A		; Port E all outputs
	call	LED_setup
	call	button_setup
	;goto	board_LED
	goto	flash_test
	org	0x100			; Main code starts here at address 0x100
	
	
int_hi:	
    org	    0x0008			; high vector, no low vecto
    goto    button_int
	
flash_test:
	call	audi_s_line
    
	
	end	main