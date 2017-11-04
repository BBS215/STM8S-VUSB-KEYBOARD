#ifndef __PERIPHERAL_H
#define __PERIPHERAL_H

#include "main.h"

/// LEDS ///////////////////////////////////////////

#define LEDS_CNT 3

#define LED_0		0
#define LED_1		1
#define LED_2		2

#define LED_OFF 0
#define LED_ON 	1

void Leds_init(void);
void Led_setmode(uint8_t num, uint8_t mode);

/// BUTTONS //////////////////////////////////////////

#define BTN_0					0
#define BTN_1					1
#define BTN_2					2
#define BTN_3					3
#define BTN_4					4
#define BTN_5					5
#define BTN_6					6
#define BTN_7					7
#define BTN_CNT 			8

#define BTN_TIME_TRESH	3 // (time+1)/100Hz // 7 = 75..80ms // 3 = 35..40ms

typedef struct
{
	uint8_t pressed;
	uint8_t state;
	uint8_t holdtime[BTN_CNT];
} t_keys_struct;

extern t_keys_struct g_buttons;

void Buttons_init(void);
void Buttons_loop(void);
@inline uint8_t Buttons_get_mask(void) { return g_buttons.pressed; }
void EVENT_KEY_pressed(uint8_t key_num);
void EVENT_KEY_released(uint8_t key_num);

#endif // __PERIPHERAL_H


