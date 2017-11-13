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

void RESET_CHIP(void)
{
	IWDG->KR = IWDG_KEY_ENABLE; // Reset the CPU: Enable the watchdog and wait until it expires
	while(1);    // Wait until reset occurs from IWDG
}

void Check_OPTION_BYTE(void)
{
	uint8_t option_byte;
	uint8_t option_byte_neg;
	uint16_t option_byte_addr;
	// 0 - ROP
	// 1,2 - UBC
	// 3,4 - AFR
	// 5,6 - options
	
	option_byte_addr = OPTION_BYTE_START_PHYSICAL_ADDRESS + 3; // AFR
	option_byte = *((NEAR uint8_t*)option_byte_addr);
	option_byte_neg = *((NEAR uint8_t*)(option_byte_addr + 1));
	if ((option_byte != (uint8_t)(~option_byte_neg)) ||
	((option_byte & (1 << 0)) == 0)) { // check AFR0
		option_byte |= (1 << 0); // set AFR0 = 1 // PORT C7 Alternate Function = TIM1_CH2
		FLASH_Unlock(FLASH_MEMTYPE_DATA);
		FLASH->CR2 |= FLASH_CR2_OPT;
		FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
		// Program option byte and his complement
		do {
			*((NEAR uint8_t*)option_byte_addr) = option_byte;
			FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
		} while(*((NEAR uint8_t*)option_byte_addr) != option_byte);
		do {
			*((NEAR uint8_t*)((uint16_t)(option_byte_addr + 1))) = (uint8_t)(~option_byte);
			FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
		} while(*((NEAR uint8_t*)((uint16_t)(option_byte_addr + 1))) != (uint8_t)(~option_byte));
		
		// Disable write access to option bytes
		FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
		FLASH->NCR2 |= FLASH_NCR2_NOPT;
		FLASH_Lock(FLASH_MEMTYPE_DATA);
    RESET_CHIP();
	}

	option_byte_addr = OPTION_BYTE_START_PHYSICAL_ADDRESS + 5; // options
	option_byte = *((NEAR uint8_t*)option_byte_addr);
	option_byte_neg = *((NEAR uint8_t*)(option_byte_addr + 1));
	if ((option_byte != (uint8_t)(~option_byte_neg)) ||
	((option_byte & (1 << 4)) == 0)) { // check HSITRIM
		option_byte |= (1 << 4); // set HSITRIM = 1 // 4 bit on-the-fly trimming
		FLASH_Unlock(FLASH_MEMTYPE_DATA);
		FLASH->CR2 |= FLASH_CR2_OPT;
		FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
		// Program option byte and his complement
		do {
			*((NEAR uint8_t*)option_byte_addr) = option_byte;
			FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
		} while(*((NEAR uint8_t*)option_byte_addr) != option_byte);
		//FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
		do {
			*((NEAR uint8_t*)((uint16_t)(option_byte_addr + 1))) = (uint8_t)(~option_byte);
			FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
		} while(*((NEAR uint8_t*)((uint16_t)(option_byte_addr + 1))) != (uint8_t)(~option_byte));
		//FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
		
		// Disable write access to option bytes
		FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
		FLASH->NCR2 |= FLASH_NCR2_NOPT;
		FLASH_Lock(FLASH_MEMTYPE_DATA);
    RESET_CHIP();
	}
	
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
