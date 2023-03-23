    #include <xc.inc>

global	sensor_chirp, distance
    
extrn	smart_brightness
    
psect udata_acs			; reserving space in access ram
pulse_delay:	ds 1
casc_delay:	ds 1
distance:	ds 1
interpret_delay:ds 1
 
psect sensor_code, class = CODE

; Want to write methods for sending pulse to the ultrasonic sensor and
; interpreting the distance it senses
 
sensor_chirp: ; might change this to "find_distance"
    call    send_pulse
    call    interpret_pulse
    goto    $
   
 
send_pulse:
    movlw   0x00
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
    movlw   0xff
    movwf   TRISH, A			; Sets port H to input so it can receive pulse back
    ;goto    $
    return
    
interpret_pulse:
    ;delay
    ; BTFSS RH0, A	    ;check if pulse has returned
    ; call set_distance1
    ;delay
    ; BTFSS RH0, A
    ; call set_distance2
    ;delay
    ; BTFSS RH0, A
    ; call set_distance3
    ;delay
    ; BTFSS RH0, A
    ; call set_distance4
    ;delay
    ; BTFSS RH0, A
    ; call set_distance5
    return
    
set_distance1:
    ; movlw PWM1
    ; movwf distance
    ; call smart_brightness
    
set_distance2:
    ; movlw PWM2
    ; movwf distance
    ; call smart_brightness
set_distance3:
    ; movlw PWM3
    ; movwf distance
    ; call smart_brightness
set_distance4:
    ; movlw PWM4
    ; movwf distance
    ; call smart_brightness
set_distance5:
    ; movlw PWM5
    ; movwf distance
    ; call smart_brightness
    
    
simple_delay:
    decfsz  pulse_delay, A
    bra	    simple_delay
    return

casc_delay1:
    call    simple_delay
    decfsz  pulse_delay, A
    bra	    casc_delay1
    return

