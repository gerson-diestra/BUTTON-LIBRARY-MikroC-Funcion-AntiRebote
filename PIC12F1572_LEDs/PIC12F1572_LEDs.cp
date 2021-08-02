#line 1 "G:/clases virtual de pic/PIC12F1572/PIC12F1572_LEDs/PIC12F1572_LEDs.c"


bit estado_anterior;

void main() {
 C1ON_bit = 0x00;
 ADON_bit = 0x00;
 ANSELA = 0x00;
 OSCCON = 0x72;
 DACEN_bit = 0x00;

 TRISA = 0x0A;

 PORTA = 0x00;

 estado_anterior = 0;

 do{
 if(Button(&PORTA,1,200,1)){
 estado_anterior = 1;
 }
 if(estado_anterior && Button(&PORTA,1,200,0)){
 RA0_bit = ~RA0_bit;
 estado_anterior = 0;
 }
 }while(1);
}
