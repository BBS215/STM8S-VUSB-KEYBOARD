#include "init.h"

void Init_GPIO(void)
{
	GPIO_DeInit(GPIOA);
	GPIO_DeInit(GPIOB);
	GPIO_DeInit(GPIOC);
	GPIO_DeInit(GPIOD);
}

void Init_Clock(void)
{
	CLK->CKDIVR = 0; // HSIDIV = 0; CPUDIV = 0
}

void SYSTimer_Init(void)
{
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
	TIM2_DeInit();
	TIM2_TimeBaseInit(TIM2_PRESCALER_16, 10000); // 16 MHz / 16 / 10000 = 100 Hz
	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
	TIM2_Cmd(ENABLE);
}
