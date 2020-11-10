#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <string.h>

void init_uart_oled();
void send_string(unsigned char *, int);
void send_chr(unsigned char);
void secure_function(char *);
void hacked();


int main(void)
{
	_delay_ms(3000);	// needed to the OLED screen
	init_uart_oled();
	//unsigned char clear[] = {0xff, 0xd7};
	unsigned char text_width[] = {0xff, 0x7c, 0x00, 0x03};
	unsigned char text_height[] = {0xff, 0x7b, 0x00, 0x03};
	unsigned char move[] = {0xff, 0xe4, 0x00, 0x00, 0x00, 0x00};
	//send_string(clear, sizeof(clear));
	send_string(text_width, sizeof(text_width));
	send_string(text_height, sizeof(text_height));
	send_string(move, sizeof(move));
	
	
	unsigned char message[] = {1, 2, 3, 4, 5, 6, 7, 8, 'A', 'A', 'A', 'A', 0x01, 0x22};
	secure_function(message);
    while (1) 
    {
    }
}

void secure_function(char *input)
{
	char secret[8];
	strcpy(secret, input);
}

void hacked()
{
	unsigned char text[] = {0x00, 0x06, 'H', '4', 'c', 'k', '3', 'd', 0x00};
	send_string(text, sizeof(text));
}

void init_uart_oled()
{
	UBRR1H = (unsigned char) (103 >> 8);
	UBRR1L = (unsigned char) 103;
	UCSR1B = (1 << RXEN1) | (1 << TXEN1);
}

inline void send_string(unsigned char *msg, int len)
{
	for (int i = 0; i < len; i++) {
		send_chr(msg[i]);
	}
}

void send_chr(unsigned char c)
{
	while (!(UCSR1A & (1 << UDRE1)));
	UDR1 = c;
}
