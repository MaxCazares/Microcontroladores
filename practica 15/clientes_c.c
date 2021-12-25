#include <avr/io.h>
#include <util/delay.h>
#include <avr/eeprom.h>

void sonar(void){
	int i = 0;
	for(i = 0; i < 200; i++){
		PORTA = 0x01;
		_delay_ms(2);
		PORTA = 0x00;
		_delay_ms(2);
	}
}

void config_io(void){
	DDRA = 0x01;
	DDRB = 0b11111010;
	PORTB = _BV(PB0);
	PORTB = _BV(PB2);
	DDRC = 0x0F;
	DDRD = 0xFF;
	while(!eeprom_is_ready()){
		_delay_ms(10);
	}
	eeprom_write_byte(0x00,0x00);
}

int main(void){
	config_io();
	unsigned char cta = 0, wins = 0;
	while(1){
		switch(PINB){			
			case (4):
				cta++;
				if(cta == 6){
					PORTC = cta;
					wins++;
					sonar();
					while(!eeprom_is_ready()){
						_delay_ms(10);
					}	
					eeprom_write_byte(0x00,wins);
					cta = 0;
				}

			break;
			case (1):
				wins = 0;
				while(!eeprom_is_ready()){
					_delay_ms(10);
				}	
				eeprom_write_byte(0x00,wins);
			break;
		}
		_delay_ms(200);
		PORTC = cta;
		PORTD = eeprom_read_byte(0x00);
	}
}