#include "yoda.h"

// ###################################################### LEDs

void led_init()
{
    DDRB = 0xff;
}

void led_on(uint8_t num)
{
    PORTB |= (1 << num);
}

void led_off(uint8_t num)
{
    PORTB &= ~(1 << num);
}

void led_toggle(uint8_t num)
{
    PORTB ^= (1 << num);
}



// ###################################################### Read buttons

void button_init()
{
	// Set buttons on port A to inputs
	DDRA &= 0b00000011;
	DDRD &= 0b01111111;
}

uint8_t button_read(uint8_t num)
{
	num = num + 1;
	// Returns 1 if button number 'num' is pressed, otherwise 0
	return ((PINA & (1 << num)) >> num);
}


uint8_t button_read_reliably() {

	if ((PIND & 0b10000000) != 0) {

		_delay_ms(50);

		return (PIND & 0b10000000) > 0;

	}
	
	return 0;

}

// ###################################################### USART

//void usart0_init(int UBRR_value)
//{
//	
//	UCSR0A= 0x00;
//	
//	// Enable both receiver and transmitter. Note that the TX- and RX-pins are now no longer IO-pins.
//	UCSR0B	= (1 << RXEN0)	| (1 << TXEN0);
//	
//	// Stop bits (two of them) and length (8 bit)
//	UCSR0C  |= (1 << USBS0)	| (1 << UCSZ10) | (1 << UCSZ00);
//	
//	// Enable interrupts!
//	//UCSR0B  |= (1 << RXCIE0)  | (0 << TXCIE0);
//	
//	// 	Setting the baud rate
//	UBRR0H	= (unsigned char) (UBRR_value >> 8);
//	UBRR0L	= (unsigned char) UBRR_value;
//
//}

//void usart0_transmit(uint8_t data)
//{
//	
//	//Wait until the Transmitter is ready
//	while (!(UCSR0A & (1 << UDRE0)));
//	
//	//Send data
//	UDR0 = data;
//
//}

//void usart0_transmit_array(char *aChar) 
//{
//	
//	while (*aChar != '\0') {
//		usart0_transmit(*aChar++);
//	}
//
//}
//
//uint8_t usart0_receive( void )
//{
//	/* Wait for data to be received */
//	while ( !(UCSR0A & (1<<RXC0)) )
//	;
//	/* Get and return received data from buffer */
//	return UDR0;
//}

