#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <string.h>
#include <avr/interrupt.h>

#define DATA_PORT PORTD
#define DATA_PIN 5
#define DATA_DDR DDRD

#define TRIG	(PC1)
#define ECHO	(PC0)

#define NBR_PIXELS (10)
#define SPEED (75)

#define BTN1	0x1
#define BTN2	0x2
#define BTN3	0x4
#define BTN4	0x8
#define BTN5	0x10
#define BTN6	0x20

enum direction {LEFT = 0, RIGHT = 1, PAUSE = 2};

typedef struct {
	uint8_t r;
	uint8_t g;
	uint8_t b;
} pixel_t;

pixel_t leds[10];
pixel_t leds_tmp[10];

void send_one();
void send_zero();

// ----- Global variable, to be set in assembly code, by YOU. -----
char button_state;

// Implemented to you by the authors :)
void init();
void fill_array(uint8_t *, uint8_t, uint8_t);
void clear_leds();
void set_pixels(pixel_t *);
uint16_t us_measure();
void loop();
uint16_t delay_loop = 30;

// ###################################################### Add your UART initialization code prototype here!

int main(void)
{
	
    init();
	
    	
    // init state
    leds[1].r = 25;
    leds[2].r = 50;
    leds[3].r = 100;
    leds[4].r = 50;
    leds[5].r = 25;
	
	sei();
		
    while (1) {

			loop();
		
    }
}

// ###################################################### Add your UART initialization code here!


// ###################################################### Add your ISR here!


void init() {
	// neopixels
	DATA_DDR = (1 << DATA_PIN);
	DATA_PORT &= ~(1 << DATA_PIN);


}


void loop() {
	
	uint8_t state = 1;
	uint8_t dir = LEFT;
		
	
		
	switch (PINA >> 2) {
		case BTN1:
		// set the color of the LEDs to red
		clear_leds();
		leds[state].r = 25;
		leds[(state + 1) % 10].r = 50;
		leds[(state + 2) % 10].r = 100;
		leds[(state + 3) % 10].r = 50;
		leds[(state + 4) % 10].r = 25;
		break;
		case BTN2:
		// set the color of the LEDs to green
		clear_leds();
		leds[state].g = 25;
		leds[(state + 1) % 10].g = 50;
		leds[(state + 2) % 10].g = 100;
		leds[(state + 3) % 10].g = 50;
		leds[(state + 4) % 10].g = 25;
		break;
		case BTN3:
		// set the color of the LEDs to blue
		clear_leds();
		leds[state].b = 25;
		leds[(state + 1) % 10].b = 50;
		leds[(state + 2) % 10].b = 100;
		leds[(state + 3) % 10].b = 50;
		leds[(state + 4) % 10].b = 25;
		break;
		case BTN4:
		dir = RIGHT;
		break;
		case BTN5:
		//dir = PAUSE;
			
		delay_loop = us_measure();
			
		break;
		case BTN6:
		dir = LEFT;
		break;
	}

	if (dir == LEFT) {
		for (uint8_t i = 9; i > 0; i--) {
			leds_tmp[i] = leds[i-1];
		}
		leds_tmp[0] = leds[9];
		} else if (dir == RIGHT) {
		leds_tmp[9] = leds[0];
		for (uint8_t i = 0; i < 9; i++) {
			leds_tmp[i] = leds[i+1];
		}
		} else if (dir == PAUSE) {
		for (int i = 0; i < 10; i++) {
			leds_tmp[i] = leds[i];
		}
	}

	set_pixels(leds_tmp);
	if (dir == LEFT) {
		state = (state + 1) % 10;
		} else if (dir == RIGHT) {
		state = (((state - 1) % 10) + 10) % 10;
		} else if (dir == PAUSE) {
		// pause
	}
		
	memcpy(leds, leds_tmp, 240);

	_delay_us(50);

	for (uint8_t i = 0; i < delay_loop; i++) {
		_delay_ms(2);
	}
	
}


void fill_array(uint8_t* arr, uint8_t color, uint8_t off) {
	for(int i = 0; i < 8; i++) {
		// expand a byte into 8 uint8_t binary values in array for faster access later
		arr[i + off] = (color & (1 << (7 - i))) >> (7-i);
	}
}

void clear_leds() {
	for (int i = 0; i < 10; i++) {
		leds[i].r = 0;
		leds[i].g = 0;
		leds[i].b = 0;
	}
	set_pixels(leds);
}


void set_pixels(pixel_t *p) {
	uint8_t led_expand[24 * NBR_PIXELS];
	for (uint8_t i = 0; i < 10; i++) {
		// retarded ordering...
		fill_array(led_expand, p[i].g, i * 24 + 0);
		fill_array(led_expand, p[i].r, i * 24 + 8);
		fill_array(led_expand, p[i].b, i * 24 + 16);
	}
	
	// send values to neopixel
	for (uint8_t i = 0; i < 24 * NBR_PIXELS; i++) {
		if (led_expand[i]) {
			// send 1
			send_one();		//<=============================== Sending pixel data
			} else {
			// send 0
			send_zero();	//<=============================== Sending pixel data
		}
	}
}



uint16_t us_measure() {
	
	DDRC |= _BV(TRIG);
	TCNT1 = 0;
	PORTC |= _BV(TRIG);
	_delay_us(10);
	PORTC &= ~_BV(TRIG);
	
	while(!(PINC & _BV(ECHO)));
	TCCR1B |= _BV(CS12);

	while((PINC & _BV(ECHO)));
	TCCR1B &= ~_BV(CS12);
	
	return 340*(TCNT1 >> 1)/625;

}

void send_one() {
	
	asm (
	"ldi r18, 0b00100000	\n"	
	"in r19, 0x0B			\n" 
	"or r19, r18			\n" 
 	"out 0x0B, r19			\n" 
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"ldi r18, 0b11011111	\n" 
	"in r19, 0x0B			\n" 
	"and r19, r18			\n" 
	"out 0x0B, r19			\n" 
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"ret					\n"
	);
	
}



void send_zero(){
	
	asm (
	"ldi r18, 0b00100000	\n"
	"in r19, 0x0B			\n"
	"or r19, r18			\n"
	"out 0x0B, r19			\n"
	"nop					\n"
	"ldi r18, 0b11011111	\n"
	"in r19, 0x0B			\n"
	"and r19, r18			\n"
	"out 0x0B, r19			\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"nop					\n"
	"ret					\n"
	);
	
}