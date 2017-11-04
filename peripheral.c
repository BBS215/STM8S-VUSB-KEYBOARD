#include "peripheral.h"

////////// LEDS /////////////////////

//																						LED0				LED1				LED2
const GPIO_Pin_TypeDef	LED_pin[LEDS_CNT] = { GPIO_PIN_5,	GPIO_PIN_4,	GPIO_PIN_2	};
GPIO_TypeDef* const		LED_port[LEDS_CNT] = 	{ GPIOB,			GPIOB,			GPIOD				};

uint8_t g_LEDS_mode[LEDS_CNT];
	
void Leds_init(void)
{
	uint8_t i;
	for(i=0;i<LEDS_CNT;i++)
	{
		GPIO_Init(LED_port[i], LED_pin[i], GPIO_MODE_OUT_PP_HIGH_SLOW);
		Led_setmode(i, LED_OFF);
	}
}

void Led_setmode(uint8_t num, uint8_t mode)
{
	if (num >= LEDS_CNT) return;
	g_LEDS_mode[num] = mode;
	if (mode == LED_ON) {
		GPIO_WriteLow(LED_port[num], LED_pin[num]);
	} else
	if (mode == LED_OFF) {
		GPIO_WriteHigh(LED_port[num], LED_pin[num]);
	}
}

/// BUTTONS ////////////////////////////

//																							BTN0				BTN1				BTN2				BTN3				BTN4				BTN5				BTN6				BTN7
const GPIO_Pin_TypeDef	BUTTON_pin[BTN_CNT] = { GPIO_PIN_1,	GPIO_PIN_3,	GPIO_PIN_5,	GPIO_PIN_4,	GPIO_PIN_6,	GPIO_PIN_3,	GPIO_PIN_4,	GPIO_PIN_5	};
GPIO_TypeDef* const		BUTTON_port[BTN_CNT] = 	{ GPIOD,			GPIOD,			GPIOD,			GPIOD,			GPIOD,			GPIOC,			GPIOC,			GPIOC				};

t_keys_struct g_buttons;

void Buttons_init(void)
{
	uint8_t i;
	for(i=0;i<BTN_CNT;i++)
	{
		GPIO_Init(BUTTON_port[i], BUTTON_pin[i], GPIO_MODE_IN_PU_NO_IT);
		g_buttons.holdtime[i] = BTN_TIME_TRESH+1;
	}
	g_buttons.state = 0;
	g_buttons.pressed = 0;
}

void Buttons_loop(void)
{
	uint8_t i;
	for(i=0; i<BTN_CNT; i++)
	{		
		if (GPIO_ReadInputPin(BUTTON_port[i], BUTTON_pin[i]) == RESET) // button pressed
		{
			if (g_buttons.state & (1 << i)) // already pressed
			{
				if ((g_buttons.holdtime[i]) < BTN_TIME_TRESH) {
					g_buttons.holdtime[i]++; // increment time
				} else
				if ((g_buttons.holdtime[i]) == BTN_TIME_TRESH) { // timeout
					if ((g_buttons.pressed & (1 << i)) == 0)
					{
						g_buttons.pressed |= (uint8_t)(1 << i);
						// KEYPRESS EVENT HERE
						EVENT_KEY_pressed(i);
					}
					g_buttons.holdtime[i]++; // increment time
				}
			} else { // not pressed
				g_buttons.state |= (uint8_t)(1 << i);
				g_buttons.holdtime[i] = 0;
			}
		} else { // button released
			if ((g_buttons.state & (1 << i))==0) // already released
			{
				if ((g_buttons.holdtime[i]) < BTN_TIME_TRESH) {
					g_buttons.holdtime[i]++; // increment time
				} else
				if ((g_buttons.holdtime[i]) == BTN_TIME_TRESH) { // timeout
					if (g_buttons.pressed & (1 << i)) {
						g_buttons.pressed &= (uint8_t)~(1 << i);
						// KEY RERLEASE EVENT HERE
						EVENT_KEY_released(i);
					}
					g_buttons.holdtime[i]++; // increment time
				}
			} else { // not released
				g_buttons.state &= (uint8_t)~(1 << i);
				g_buttons.holdtime[i] = 0;
			}
		}
	}
}


