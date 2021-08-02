// PIC12F1572
//unsigned short Button();
bit estado_anterior;   // puede ser '0' o '1'

void main() {
   C1ON_bit = 0x00; // Desabilita comparador
   ADON_bit = 0x00; // Desabilita ADC y no consume corriente
   ANSELA   = 0x00; // Selecciona todos los pines como I/O digitales
   OSCCON   = 0x72; //Selecciona la Frencuencia interna del oscilador (8 MHz)
   DACEN_bit = 0x00;// Desabilita el DAC
   
   TRISA = 0x0A;   // configura como entradas o salidas (RA1,RA3 input )

   PORTA = 0x00;   // Inicia en nivel Low(bajo)
   
   estado_anterior = 0;
//Button(&port,pin[0,...,7],time(milisegundos),active_state '0' o '1')
   do{
       if(Button(&PORTA,1,200,1)){   // Detecta el estado de RA1 en HIGH(1)
         estado_anterior = 1;     //
       }
       if(estado_anterior && Button(&PORTA,1,200,0)){ //Detecta la transición de 1 a 0
           RA0_bit = ~RA0_bit;          // RA0 se invierte
           estado_anterior = 0;        // actualiza el valor leído en RA1
       }
       }while(1);
}