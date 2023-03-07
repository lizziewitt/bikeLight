	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	movlw 	0x0
	movwf	TRISD, A            ; Port D all outputs
	movlw 	0x0
	movwf	TRISE, A            ; Port E all outputs
	goto	LED

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw   0x05
	movwf	0x05, A
	movlw 	0x0
	movwf	TRISD, A            ; Port D all outputs
	bra 	test
	movlw   0xff
	movwf   TRISC
loop:
	movff 	0x06, PORTD
	incf 	0x06, W, A
test:
	movwf	0x06, A	    ; Test for end of loop condition
	movf    0x05, W, A ;check value
	cpfsgt 	0x06, A
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x00 		    ; Re-run program from start

	
LED:	
	movlw 0xff
	movwf PORTD, A
	movlw 0xff
	movwf PORTE, A
	
	end	main
