
#ifndef _LIBEITF70_H
#define _LIBEITF70_H

#include <avr/io.h>


#define BTN1    (PA2)
#define BTN2    (PA3)   
#define BTN3    (PA4)
#define BTN4    (PA5)
#define BTN5    (PA6)
#define BTN6    (PA7)

// ###################################################### Init 

void led_init();
void led_on(uint8_t);
void led_off(uint8_t);
void led_toggle(uint8_t);

void gdb_button_led_init();

// ###################################################### Buttons

void button_init();
uint8_t button_read(uint8_t);
uint8_t button_read_reliably();


// ###################################################### USART


//void    usart0_init(int UBRR_value);
//void    usart0_transmit(uint8_t data);
//void    usart0_transmit_array(char *aChar);
//uint8_t usart0_receive( void );

#endif