/*
 * true_den.h
 *
 * Created: 2019-02-17 00:52:57
 *  Author: Christoffer
 */ 


#ifndef TRUE_DEN_H_
#define TRUE_DEN_H_


#define F_CPU   16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#define TRIG	(PORTC1)
#define ECHO	(PORTC0)

// ##################################### Lion stuff

void send_lions(uint8_t);

void security_system_init();

void security_system_run();

// ##################################### UART stuff

void uart0_init();

void uart0_tx_str(char *);
void uart0_tx_str_n(char *);
void uart0_tx_str_del(char *); 

void uart0_tx_chr(char);

char uart0_rx_chr();

// ##################################### Ultrasonic

uint16_t us_measure();

// ##################################### ADC stuff

void adc_init() ;

uint16_t adc_read_p1();

uint16_t adc_read_p2();

// ##################################### PWM stuff

void pwm_init();

void set_pulse_a(uint16_t);

void set_pulse_b(uint16_t);

void set_period(uint16_t);
#endif /* TRUE_DEN_H_ */