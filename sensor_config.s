    #include <xc.inc>

global	sensor_chirp    
    
psect udata_acs			; reserving space in access ram
pulse_delay:	ds 1
casc_delay:	ds 1
 
psect sensor_code, class = CODE

; Want to write methods for sending pulse to the ultrasonic sensor and
; interpreting the distance it senses
 
sensor_chirp:
    call    send_pulse
    call    interpret_pulse
   
 
send_pulse:
    movlw   0xff
    movwf   TRISH, A			; Sets port H to output
    movlw   00000001B
    movwf   PORTH, A			; Makes pin RH0 high
    movlw   0xf			; delay then make pin low
    movwf   pulse_delay, A
    ;movlw   0x03
    ;movwf   casc_delay, A
    call    simple_delay
    movlw   00000000B
    movwf   PORTH, A			; Makes pin RH0 low, sends chirp to sensor
    movlw   0x00
    movwf   TRISH, A			; Sets port H to input so it can receive pulse back
    goto    $
    ;return
    
interpret_pulse:
    return
    
simple_delay:
    decfsz  pulse_delay, A
    bra	    simple_delay
    return

casc_delay1:
    call    simple_delay
    decfsz  pulse_delay, A
    bra	    casc_delay1
    return

