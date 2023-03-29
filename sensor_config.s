    #include <xc.inc>

global	sensor_chirp, distance, interpret_pulse, delay1S, sensor_delay1
    
extrn	smart_mode, interrupt_state, execute_interrupt
    
psect udata_acs			; reserving space in access ram
pulse_delay:	ds 1
casc_delay:	ds 1
distance:	ds 1
interpret_delay:ds 1
sensor_delay1:  ds 1
sensor_delay2:  ds 1
sensor_delay3:  ds 1
 
psect sensor_code, class = CODE

; Want to write methods for sending pulse to the ultrasonic sensor and
; interpreting the distance it senses
 
sensor_chirp: ; might change this to "find_distance"
    call    send_pulse
    movlw   0xff
    movwf   sensor_delay1
    call    delay1S
    call    interpret_pulse
    return


 
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
    call    set_delay_time
    call    delay2S
    BTFSS   PORTH, 0, A	    ;check if pulse has returned
    call    set_distance1
    call    set_delay_time
    call    delay2S
    BTFSS   PORTH, 0, A	
    call    set_distance2
    call    set_delay_time
    call    delay2S
    BTFSS   PORTH, 0, A	
    call    set_distance3
    call    set_delay_time
    call    delay2S
    BTFSS   PORTH, 0, A	
    call    set_distance4
    call    set_delay_time
    call    delay2S
    BTFSS   PORTH, 0, A	
    call    set_distance5
    return
    
set_delay_time:
    movlw   0xff
    movwf   sensor_delay1
    movlw   0x05
    movwf   sensor_delay2
    return
    
set_distance1:
    movlw    0xff			    
    movwf    CCPR5L
    movlw    0xff			   
    movwf    CCPR1L 
    movlw    0xff			   
    movwf    CCPR2L 
    ;goto $
    ; delay		;allows for time between distance readings (has to be at least length of maximum distance)
    ;BTFSC   interrupt_state, 0, A
    ;call    execute_interrupt
    call    smart_mode
    return
    
set_distance2:
    movlw    0xCC			    
    movwf    CCPR5L
    movlw    0xCC			   
    movwf    CCPR1L 
    movlw    0xCC			   
    movwf    CCPR2L 
    ;goto $
    ; delay		;allows for time between distance readings (has to be at least length of maximum distance)
    ;BTFSC   interrupt_state, 0, A
    ;call    execute_interrupt
    call    smart_mode
    return
    
set_distance3:
    movlw    0x99			    
    movwf    CCPR5L
    movlw    0x99			   
    movwf    CCPR1L 
    movlw    0x99			   
    movwf    CCPR2L
    ;goto $
    ;delay		;allows for time between distance readings (has to be at least length of maximum distance)
    ;BTFSC   interrupt_state, 0, A
    ;call    execute_interrupt
    call    smart_mode
    return
    
set_distance4:
    movlw    0x66			    
    movwf    CCPR5L
    movlw    0x66			   
    movwf    CCPR1L 
    movlw    0x66			   
    movwf    CCPR2L 
    ;goto $
    ; delay		;allows for time between distance readings (has to be at least length of maximum distance)
    ;BTFSC   interrupt_state, 0, A
    ;call    execute_interrupt
    call    smart_mode
    return
    
set_distance5:
    movlw    0x33			    
    movwf    CCPR5L
    movlw    0x33			   
    movwf    CCPR1L 
    movlw    0x33			   
    movwf    CCPR2L 
    ;goto $
    ; delay		;allows for time between distance readings (has to be at least length of maximum distance)
    ;BTFSC   interrupt_state, 0, A
    ;call    execute_interrupt
    call    smart_mode
    return
    
delay1S:
    decfsz  sensor_delay1, A		; decrement until zero
    bra	    delay1S
    return
	
delay2S:
    call    delay1S
    decfsz  sensor_delay2, A
    bra	    delay2S
    return
    
delay3S:
    call    delay2S
    decfsz  sensor_delay3, A
    bra	    delay3S
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
