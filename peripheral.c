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

/// BUTTON MATRIX ////////////////////////////

// ROWS:																								BTN-R0			BTN-R1			BTN-R2			BTN-R3
GPIO_TypeDef* const		BUTTON_ROW_port[BTN_ROW_CNT] = 	{ GPIOD,			GPIOD,			GPIOD,			GPIOD				};
const GPIO_Pin_TypeDef	BUTTON_ROW_pin[BTN_ROW_CNT] = { GPIO_PIN_3,	GPIO_PIN_4,	GPIO_PIN_5,	GPIO_PIN_6	};
// COLS:																								BTN-C0			BTN-C1			BTN-C2			BTN-C3
GPIO_TypeDef* const		BUTTON_COL_port[BTN_COL_CNT] = 	{ GPIOC,			GPIOC,			GPIOC,			GPIOD				};
const GPIO_Pin_TypeDef	BUTTON_COL_pin[BTN_COL_CNT] = { GPIO_PIN_5,	GPIO_PIN_4,	GPIO_PIN_3,	GPIO_PIN_1	};

t_keys_struct g_buttons;

void Buttons_init(void)
{
	uint8_t i;
	for(i=0;i<BTN_ROW_CNT;i++)
		GPIO_Init(BUTTON_ROW_port[i], BUTTON_ROW_pin[i], GPIO_MODE_IN_PU_NO_IT);
	for(i=0;i<BTN_COL_CNT;i++)
		GPIO_Init(BUTTON_COL_port[i], BUTTON_COL_pin[i], GPIO_MODE_IN_PU_NO_IT);
	for(i=0;i<BTN_CNT;i++)
		g_buttons.holdtime[i] = BTN_TIME_TRESH+1;
	g_buttons.state = 0;
	g_buttons.pressed = 0;
	g_buttons.active_row = 0;
	GPIO_Init(BUTTON_ROW_port[0], BUTTON_ROW_pin[0], GPIO_MODE_OUT_PP_LOW_SLOW);
}

void Buttons_loop(void)
{
	uint8_t i;
	uint8_t btn_num;
	uint16_t btn_mask;
	for(i=0; i<BTN_COL_CNT; i++)
	{
		btn_num = (uint8_t)((i*BTN_ROW_CNT)+g_buttons.active_row);
		btn_mask = (uint16_t)(1 << btn_num);
		if (GPIO_ReadInputPin(BUTTON_COL_port[i], BUTTON_COL_pin[i]) == RESET) // button pressed
		{
			if (g_buttons.state & btn_mask) // already pressed
			{
				if ((g_buttons.holdtime[btn_num]) < BTN_TIME_TRESH) {
					g_buttons.holdtime[btn_num]++; // increment time
				} else
				if ((g_buttons.holdtime[btn_num]) == BTN_TIME_TRESH) { // timeout
					if ((g_buttons.pressed & btn_mask) == 0)
					{
						g_buttons.pressed |= btn_mask;
						// KEYPRESS EVENT HERE
						EVENT_KEY_pressed(btn_num);
					}
					g_buttons.holdtime[btn_num]++; // increment time
				}
			} else { // not pressed
				g_buttons.state |= btn_mask;
				g_buttons.holdtime[btn_num] = 0;
			}
		} else { // button released
			if ((g_buttons.state & btn_mask) == 0) // already released
			{
				if ((g_buttons.holdtime[btn_num]) < BTN_TIME_TRESH) {
					g_buttons.holdtime[btn_num]++; // increment time
				} else
				if ((g_buttons.holdtime[btn_num]) == BTN_TIME_TRESH) { // timeout
					if (g_buttons.pressed & btn_mask) {
						g_buttons.pressed &= ~btn_mask;
						// KEY RERLEASE EVENT HERE
						EVENT_KEY_released(btn_num);
					}
					g_buttons.holdtime[btn_num]++; // increment time
				}
			} else { // not released
				g_buttons.state &= ~btn_mask;
				g_buttons.holdtime[btn_num] = 0;
			}
		}
	}
	GPIO_Init(BUTTON_ROW_port[g_buttons.active_row], BUTTON_ROW_pin[g_buttons.active_row], GPIO_MODE_IN_PU_NO_IT);
	g_buttons.active_row++;
	if (g_buttons.active_row >= BTN_ROW_CNT) g_buttons.active_row = 0;
	GPIO_Init(BUTTON_ROW_port[g_buttons.active_row], BUTTON_ROW_pin[g_buttons.active_row], GPIO_MODE_OUT_PP_LOW_SLOW);
}




