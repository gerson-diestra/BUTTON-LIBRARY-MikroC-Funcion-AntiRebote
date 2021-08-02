
_main:

;PIC12F1572_LEDs.c,5 :: 		void main() {
;PIC12F1572_LEDs.c,6 :: 		C1ON_bit = 0x00; // Desabilita comparador
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;PIC12F1572_LEDs.c,7 :: 		ADON_bit = 0x00; // Desabilita ADC y no consume corriente
	BCF        ADON_bit+0, BitPos(ADON_bit+0)
;PIC12F1572_LEDs.c,8 :: 		ANSELA   = 0x00; // Selecciona todos los pines como I/O digitales
	CLRF       ANSELA+0
;PIC12F1572_LEDs.c,9 :: 		OSCCON   = 0x72; //Selecciona la Frencuencia interna del oscilador (8 MHz)
	MOVLW      114
	MOVWF      OSCCON+0
;PIC12F1572_LEDs.c,10 :: 		DACEN_bit = 0x00;// Desabilita el DAC
	BCF        DACEN_bit+0, BitPos(DACEN_bit+0)
;PIC12F1572_LEDs.c,12 :: 		TRISA = 0x0A;   // configura como entradas o salidas (RA1,RA3 input )
	MOVLW      10
	MOVWF      TRISA+0
;PIC12F1572_LEDs.c,14 :: 		PORTA = 0x00;   // Inicia en nivel Low(bajo)
	CLRF       PORTA+0
;PIC12F1572_LEDs.c,16 :: 		estado_anterior = 0;
	BCF        _estado_anterior+0, BitPos(_estado_anterior+0)
;PIC12F1572_LEDs.c,18 :: 		do{
L_main0:
;PIC12F1572_LEDs.c,19 :: 		if(Button(&PORTA,1,200,1)){   // Detecta el estado de RA1 en HIGH(1)
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      hi_addr(PORTA+0)
	MOVWF      FARG_Button_port+1
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      200
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;PIC12F1572_LEDs.c,20 :: 		estado_anterior = 1;     //
	BSF        _estado_anterior+0, BitPos(_estado_anterior+0)
;PIC12F1572_LEDs.c,21 :: 		}
L_main3:
;PIC12F1572_LEDs.c,22 :: 		if(estado_anterior && Button(&PORTA,1,200,0)){ //Detecta la transición de 1 a 0
	BTFSS      _estado_anterior+0, BitPos(_estado_anterior+0)
	GOTO       L_main6
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      hi_addr(PORTA+0)
	MOVWF      FARG_Button_port+1
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      200
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
L__main7:
;PIC12F1572_LEDs.c,23 :: 		RA0_bit = ~RA0_bit;          // RA0 se invierte
	MOVLW
	XORWF      RA0_bit+0, 1
;PIC12F1572_LEDs.c,24 :: 		estado_anterior = 0;        // actualiza el valor leído en RA1
	BCF        _estado_anterior+0, BitPos(_estado_anterior+0)
;PIC12F1572_LEDs.c,25 :: 		}
L_main6:
;PIC12F1572_LEDs.c,26 :: 		}while(1);
	GOTO       L_main0
;PIC12F1572_LEDs.c,27 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
