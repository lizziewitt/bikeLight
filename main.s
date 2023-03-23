	#include <xc.inc>

extrn   LED_setup, all_on, all_off
extrn	flashing1, flashing2, flashing3

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
	;goto	board_LED
	goto	flash_test
	org	0x100			; Main code starts here at address 0x100
	
board_LED:				; turns the LEDs on the clicker 2 on 
	;call	all_on
	movlw	0x00
	movwf	PORTD, A
	movlw	0x00
	movwf	PORTE, A
	movlw	0xff
	movwf	PORTD, A
	movlw	0xff
	movwf	PORTE, A
	goto	board_LED

LED_pins:
	;movlw	0x0f			; turns on all LEDs on proto-board (ones actually used for project) - control brightness with delay
	;movwf	delay_count, A 
	call	all_on
	;call	all_off
	;call	delay
	goto	$
	
	
flash_test:
	call	flashing1
    
delay:	decfsz	delay_count, A		; decrement until zero
	bra	delay
	return
	
	end	main