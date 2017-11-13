#include "usb.h"

#define BIT(NUMBER)						(1 << (NUMBER))

uint8_t ll_usb_rx_buffer[16];
uint8_t* ll_usb_tx_buffer_pointer;
uint8_t ll_usb_tx_count;
uint8_t ll_usb_rx_count;
struct usb_type usb;

#if (USB_CLOCK_HSI == 1)
uint8_t *p_HSI_TRIM_VAL = (uint8_t*)EEPROM_START_ADDR;
uint8_t *p_HSI_TRIMING_DONE = (uint8_t*)(EEPROM_START_ADDR + 1);
#endif

extern void ll_usb_tx(void); // from usb_tx.s

void USB_Reset(void)
{
	if (usb.dev_state == USB_STATE_CONFIGURED) USB_Class_DeInit_callback();
	usb.device_address = 0;
	usb.setup_address  = 0;
	usb.dev_state = USB_STATE_DEFAULT;
	usb.stage = USB_STAGE_NONE;
	usb.dev_config = 0;
	usb.active_EP_num = 0;
	usb.reset_counter = 0;
	usb.EP[0].tx_length = 0;
	usb.EP[0].rx_length = 0;
	usb.EP[0].rx_state = USB_EP_NO_DATA;
	usb.EP[0].tx_state = USB_EP_NO_DATA;
	usb.EP[1].tx_length = 0;
	usb.EP[1].rx_length = 0;
	usb.EP[1].rx_state = USB_EP_NO_DATA;
	usb.EP[1].tx_state = USB_EP_NO_DATA;
}

void USB_Init(void)
{
#if (USB_CLOCK_HSI == 1)
	usb.delay_counter = 0;
	if (*p_HSI_TRIMING_DONE == MAGIC_VAL)
		usb.trimming_stage = HSI_TRIMMER_DISABLE;
	else
		usb.trimming_stage = HSI_TRIMMER_ENABLE;
	usb.HSI_Trim_val = (uint8_t)(*p_HSI_TRIM_VAL & 0x0F);
	CLK->HSITRIMR = (uint8_t)((CLK->HSITRIMR & (~0x0F)) | usb.HSI_Trim_val);
#else
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE); // 16 MHz external XTAL
#endif
	GPIO_Init(USB_CONNECT_PORT, USB_CONNECT_PIN, GPIO_MODE_OUT_PP_LOW_SLOW); // USB_CONNECT
	//GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // DEBUG
	usb.dev_state = USB_STATE_DEFAULT;
	USB_Reset();
	// Init TIMER
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
	TIM1_TimeBaseInit(0, TIM1_PSCRELOADMODE_UPDATE, 1000, 0);
	TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x02); // захват сигнала по линии USB D-
	TIM1_SelectInputTrigger(TIM1_TS_TI2FP2);
	TIM1_SelectSlaveMode(TIM1_SLAVEMODE_TRIGGER);
	TIM1_ClearFlag(TIM1_FLAG_CC2);
	TIM1_ITConfig(TIM1_IT_CC2, ENABLE);
}

void USB_connect(void)
{
	GPIO_WriteHigh(USB_CONNECT_PORT, USB_CONNECT_PIN);
}

void USB_disconnect(void)
{
	GPIO_WriteLow(USB_CONNECT_PORT, USB_CONNECT_PIN);
}

void usb_send_nack(void)
{
	const uint8_t data[2] = {USB_SYNC_BYTE, USB_PID_NACK};

	GPIOC->ODR |= 0x40; // set PC6
	GPIOC->CR1 |= 0xC0; // PC6, PC7 - PP (PU) mode
	GPIOC->CR2 |= 0xC0; // PC6, PC7 - 10 MHz mode (external INTR enable)
	GPIOC->DDR |= 0xC0; // PC6, PC7 - output mode

	ll_usb_tx_count = 2;
	ll_usb_tx_buffer_pointer = data;
	ll_usb_tx();

	GPIOC->CR2 &= (uint8_t)~0xC0; // PC6, PC7 - disable external INTR (2 MHz)
	GPIOC->CR1 &= (uint8_t)~0xC0; // PC6, PC7 - disable PU (PP) mode
	GPIOC->DDR = 0; // PC0..PC7 - input mode
}

@inline void usb_send_ack(void)
{
	const uint8_t data[2] = {USB_SYNC_BYTE, USB_PID_ACK};

	GPIOC->ODR |= 0x40; // set PC6
	GPIOC->CR1 |= 0xC0; // PC6, PC7 - PP (PU) mode
	GPIOC->CR2 |= 0xC0; // PC6, PC7 - 10 MHz mode (external INTR enable)
	GPIOC->DDR |= 0xC0; // PC6, PC7 - output mode

	ll_usb_tx_count = 2;
	ll_usb_tx_buffer_pointer = data;
	ll_usb_tx();

	GPIOC->CR2 &= (uint8_t)~0xC0; // PC6, PC7 - disable external INTR (2 MHz)
	GPIOC->CR1 &= (uint8_t)~0xC0; // PC6, PC7 - disable PU (PP) mode
	GPIOC->DDR = 0; // PC0..PC7 - input mode
}

@inline void usb_send_packet(uint8_t EP_num)
{
	GPIOC->ODR |= 0x40; // set PC6
	GPIOC->CR1 |= 0xC0; // PC6, PC7 - PP (PU) mode
	GPIOC->CR2 |= 0xC0; // PC6, PC7 - 10 MHz mode (external INTR enable)
	GPIOC->DDR |= 0xC0; // PC6, PC7 - output mode

	ll_usb_tx_count = usb.EP[EP_num].tx_length;
	ll_usb_tx_buffer_pointer = usb.EP[EP_num].tx_buffer;
	ll_usb_tx();

	GPIOC->CR2 &= (uint8_t)~0xC0; // PC6, PC7 - disable external INTR (2 MHz)
	GPIOC->CR1 &= (uint8_t)~0xC0; // PC6, PC7 - disable PU (PP) mode
	GPIOC->DDR = 0; // PC0..PC7 - input mode
}

@inline void usb_copy_rx_packet(uint8_t EP_num)
{
	usb.EP[EP_num].rx_buffer[0] = ll_usb_rx_buffer[2];
	usb.EP[EP_num].rx_buffer[1] = ll_usb_rx_buffer[3];
	usb.EP[EP_num].rx_buffer[2] = ll_usb_rx_buffer[4];
	usb.EP[EP_num].rx_buffer[3] = ll_usb_rx_buffer[5];
	usb.EP[EP_num].rx_buffer[4] = ll_usb_rx_buffer[6];
	usb.EP[EP_num].rx_buffer[5] = ll_usb_rx_buffer[7];
	usb.EP[EP_num].rx_buffer[6] = ll_usb_rx_buffer[8];
	usb.EP[EP_num].rx_buffer[7] = ll_usb_rx_buffer[9];
	usb.EP[EP_num].rx_buffer[8] = ll_usb_rx_buffer[10];
}

void usb_rx_ok(void)
{
	switch (ll_usb_rx_buffer[1])
	{
		case USB_PID_SETUP:
			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
			{
				usb.stage = USB_STAGE_SETUP;
				usb.active_EP_num = 0;//(usb_rx_buffer[2] & 0x80)?1:0;
			} else usb.stage = USB_STAGE_NONE;
			break;
		
		case USB_PID_OUT:
			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
			{
				usb.stage = USB_STAGE_OUT;
				usb.active_EP_num = (uint8_t)((ll_usb_rx_buffer[2] & 0x80)?1:0);
			} else usb.stage = USB_STAGE_NONE;
			break;
		
		case USB_PID_IN:
			if ((ll_usb_rx_buffer[2] & 0x7F) == usb.device_address)
			{
				usb.active_EP_num = (uint8_t)((ll_usb_rx_buffer[2] & 0x80)?1:0);
				if (usb.EP[usb.active_EP_num].tx_state == USB_EP_DATA_READY) {
					usb_send_packet(usb.active_EP_num);
					usb.EP[usb.active_EP_num].tx_state = USB_EP_NO_DATA;
					if (usb.setup_address) {
						usb.device_address = usb.setup_address;
						usb.setup_address = 0;
					}
				}	else {
					usb_send_nack();
				}
			}
			usb.stage = USB_STAGE_NONE;
			break;
		
		case USB_PID_DATA0: // Data received
		case USB_PID_DATA1: // Data received
			if (usb.stage != USB_STAGE_NONE) {
				if (usb.EP[usb.active_EP_num].rx_state == USB_EP_NO_DATA) // if EP ready
				{
					usb.EP[usb.active_EP_num].rx_state = USB_EP_DATA_READY;
					usb_send_ack();
					if (usb.active_EP_num == 0) usb.EP0_data_stage = usb.stage; // USB_STAGE_SETUP or USB_STAGE_OUT
					usb.EP[usb.active_EP_num].rx_length = (uint8_t)(14 - ll_usb_rx_count);
					if (usb.EP[usb.active_EP_num].rx_length > 3) {
						usb.EP[usb.active_EP_num].rx_length -= 3;
						usb_copy_rx_packet(usb.active_EP_num);
					} else usb.EP[usb.active_EP_num].rx_length = 0;
				}
				usb.stage = USB_STAGE_NONE;
			}
			break;

		//case USB_PID_ACK:
		//case USB_PID_NACK:		
		default:
			break;
	}
#if (USB_CLOCK_HSI == 1)
	if (usb.trimming_stage == HSI_TRIMMER_ENABLE)
		usb.trimming_stage = HSI_TRIMMER_STARTED;
#endif
}

void usb_calc_crc16(uint8_t * buffer, uint8_t length)
{
	uint16_t crc = 0xFFFF;
	uint8_t index;
	uint8_t i;

	for (index = 0; index < length; index++)
	{
		crc ^= *buffer++;

		for (i = 8; i--;)
		{
			if ((crc & BIT(0)) != 0)
			{
				crc >>= 1;
				crc ^= 0xA001;
			} else {
				crc >>= 1;
			}
		}
	}

	crc = ~crc;

	*buffer++ = (uint8_t) crc;
	*buffer = (uint8_t) (crc >> 8);
}

int8_t USB_Send_Data(uint8_t * buffer, uint8_t length, uint8_t EP_num)
{
	uint8_t i;
	uint8_t flag = 0;
	
	if (EP_num == 0) { // EP 0 - CONTROL
		while (usb.EP[0].tx_state == USB_EP_DATA_READY) {} // wait for prev transmission
		usb.EP[0].tx_data_sync = USB_PID_DATA1;
	} else { // EP 1 - INTR
		if (usb.dev_state != USB_STATE_CONFIGURED) return -2;
		if (length > 8) return -3; // 8 bytes max for INTR EP
		usb.EP[1].tx_state = USB_EP_NO_DATA; // drop old packet
	}
	
	if (length == 0) flag = 1;	// Just send an empty packet
	else
	while (length > 0)
	{
		usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
		usb.EP[EP_num].tx_buffer[1] = usb.EP[EP_num].tx_data_sync;
		
		if ((length == 8)&&(EP_num == 0)) flag = 1;	// If the length of last DATA packet is 8, then finialize the transcation by an empty packet
		
		if (length > 8)
		{
			usb.EP[EP_num].tx_length = 12; // 2+8+2

			for (i = 2; i < 10; i++)
				usb.EP[EP_num].tx_buffer[i] = *buffer++;
			length -= 8;
		}	else {
			usb.EP[EP_num].tx_length = (uint8_t)(4 + length);
			for (i = 2; i < 2 + length; i++)
				usb.EP[EP_num].tx_buffer[i] = *buffer++;
			length = 0;
		}

		// calculate CRC
		usb_calc_crc16(&usb.EP[EP_num].tx_buffer[2], (uint8_t) (usb.EP[EP_num].tx_length - 4));

		// toggle data0 data1
		if (usb.EP[EP_num].tx_data_sync == USB_PID_DATA1) 
			usb.EP[EP_num].tx_data_sync = USB_PID_DATA0;
		else
			usb.EP[EP_num].tx_data_sync = USB_PID_DATA1;

		// data is available to send out 
		usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
		// wait for transmission and then start the next
		if (EP_num == 0)
		{
			while (usb.EP[EP_num].tx_state == USB_EP_DATA_READY) {}
		}
	}
	
	if (flag) { // Send an empty packet
		usb.EP[EP_num].tx_length = 4;
		usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
		usb.EP[EP_num].tx_buffer[1] = usb.EP[EP_num].tx_data_sync;
		usb.EP[EP_num].tx_buffer[2] = 0;
		usb.EP[EP_num].tx_buffer[3] = 0;
	
		if (usb.EP[EP_num].tx_data_sync == USB_PID_DATA1)
			usb.EP[EP_num].tx_data_sync = USB_PID_DATA0;
		else
			usb.EP[EP_num].tx_data_sync = USB_PID_DATA1;
	
		usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
	}
	return 0;
}

void USB_Send_STALL(uint8_t EP_num)
{
	usb.EP[EP_num].tx_length = 2;
	usb.EP[EP_num].tx_buffer[0] = USB_SYNC_BYTE;
	usb.EP[EP_num].tx_buffer[1] = USB_PID_STALL;
	usb.EP[EP_num].tx_state = USB_EP_DATA_READY;
}

@inline void usb_control_error(void)
{
	USB_Send_STALL(0);
}

void USB_loop(void)
{
	if ((GPIOC->IDR & 0xC0) == 0) {
		usb.reset_counter++;
		if (usb.reset_counter > USB_RESET_DELAY) {
			USB_Reset();
			return;
		}
	} else usb.reset_counter = 0;

	if (usb.EP[0].rx_state == USB_EP_DATA_READY)
	{
		if (usb.EP0_data_stage == USB_STAGE_SETUP) // EP0 Setup stage
		{
			t_USB_SetupReq *p_USB_SetupReq = (t_USB_SetupReq*)(usb.EP[0].rx_buffer);
			switch (p_USB_SetupReq->bmRequest & 0x1F)
			{
				case USB_REQ_RECIPIENT_DEVICE: // Device request
				{
					switch (p_USB_SetupReq->bRequest)
					{
						case USB_REQ_GET_DESCRIPTOR: // GET_DESCRIPTOR
						{
							switch (p_USB_SetupReq->wValue_HI)
							{
								case USB_DESC_TYPE_DEVICE:	// Device desc
								{
									USB_Send_Data(usb_device_descriptor, (uint8_t)MIN(p_USB_SetupReq->wLength_LO, SIZE_DEVICE_DESCRIPTOR), 0);
									break;
								}
								case USB_DESC_TYPE_CONFIGURATION:	// Configuration desc
								{
									USB_Send_Data(usb_configuration_descriptor, (uint8_t)MIN(p_USB_SetupReq->wLength_LO, SIZE_CONFIGURATION_DESCRIPTOR), 0);
									break;
								}
								case USB_DESC_TYPE_STRING: // String desc
								{
									if (p_USB_SetupReq->wValue_LO < LENGTH_STRING_DESCRIPTOR) {
										USB_Send_Data(USB_String_Descriptors[p_USB_SetupReq->wValue_LO], 
												(uint8_t)MIN(p_USB_SetupReq->wLength_LO, USB_String_Descriptors_Length[p_USB_SetupReq->wValue_LO]), 0);
									} else {
										usb_control_error();
									}
									break;
								}
								default:
								{
									usb_control_error();
									break;
								}
							}
							break;
						}
						case USB_REQ_SET_ADDRESS:	// SET_ADDRESS
						{
							if ((p_USB_SetupReq->wIndex_LO == 0) && (p_USB_SetupReq->wLength_LO == 0)) {
								if (usb.dev_state == USB_STATE_CONFIGURED) {
									usb_control_error();
								} else {
									usb.setup_address = (uint8_t)(p_USB_SetupReq->wValue_LO & 0x7F);
									USB_Send_Data(NULL, 0, 0);
									if (usb.setup_address) 	usb.dev_state  = USB_STATE_ADDRESSED;
									else 										usb.dev_state  = USB_STATE_DEFAULT; 
								}
							} else {
								usb_control_error();
							}
							break;
						}
						case USB_REQ_SET_CONFIGURATION:	// SET_CONFIGURATION
						{
							if (p_USB_SetupReq->wValue_LO <= USB_MAX_NUM_CONFIGURATION)
							{
								switch (usb.dev_state)
								{
									case USB_STATE_ADDRESSED:
									{
										if (p_USB_SetupReq->wValue_LO) 
										{
											usb.dev_config = p_USB_SetupReq->wValue_LO; // set new configuration
											usb.dev_state = USB_STATE_CONFIGURED;
											if (USB_Class_Init_callback(usb.dev_config) < 0) usb_control_error();
											else USB_Send_Data(NULL, 0, 0);
#if (USB_CLOCK_HSI == 1)
											if (usb.trimming_stage == HSI_TRIMMER_STARTED) 
												usb.trimming_stage = HSI_TRIMMER_WRITE_TRIM_VAL;
#endif
										} else {
											USB_Send_Data(NULL, 0, 0);
										}
										break;
									}
									case USB_STATE_CONFIGURED:
									{
										if (p_USB_SetupReq->wValue_LO == 0) 
										{
											usb.dev_state = USB_STATE_ADDRESSED;
											usb.dev_config = 0;
											USB_Class_DeInit_callback();
											USB_Send_Data(NULL, 0, 0);
										} else
										if (p_USB_SetupReq->wValue_LO != usb.dev_config) 
										{
											USB_Class_DeInit_callback();
											usb.dev_config = p_USB_SetupReq->wValue_LO; // set new configuration
											if (USB_Class_Init_callback(usb.dev_config) < 0) usb_control_error();
											else USB_Send_Data(NULL, 0, 0);
										} else {
											USB_Send_Data(NULL, 0, 0);
										}
										break;
									}
									default:
									{
										usb_control_error();
										break;
									}
								}
							} else {
								usb_control_error();
							}
							break;
						}
						case USB_REQ_GET_CONFIGURATION: // GET_CONFIGURATION
						{
							if (p_USB_SetupReq->wLength_LO == 1) 
							{
								switch (usb.dev_state)  
								{
									case USB_STATE_ADDRESSED:
									case USB_STATE_CONFIGURED:
									{
										USB_Send_Data(&usb.dev_config, 1, 0);
										break;
									}
									default:
									{
										usb_control_error();
										break;
									}
								}
							} else usb_control_error();
							break;
						}
						
						case USB_REQ_GET_STATUS: // GET_STATUS
						{
							switch (usb.dev_state) 
							{
								case USB_STATE_ADDRESSED:
								case USB_STATE_CONFIGURED:
								{
									usb.dev_config_status = 0;
									#if (USB_SELF_POWERED == 1)
										usb.dev_config_status |= USB_CONFIG_SELF_POWERED;
									#endif
									if (usb.dev_remote_wakeup)
										usb.dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;
									USB_Send_Data((uint8_t*)&usb.dev_config_status, 2, 0);
									break;
								}
								
								default :
									usb_control_error();
									break;
							}
							break;
						}
						case USB_REQ_SET_FEATURE: // SET_FEATURE
						{
							if (p_USB_SetupReq->wValue_LO == USB_FEATURE_REMOTE_WAKEUP)
							{
								usb.dev_remote_wakeup = 1;  
								USB_Setup_Request_callback(p_USB_SetupReq);
								USB_Send_Data(NULL, 0, 0);
							}
							break;
						}
						case USB_REQ_CLEAR_FEATURE: // CLEAR_FEATURE
						{
							switch (usb.dev_state)
							{
								case USB_STATE_ADDRESSED:
								case USB_STATE_CONFIGURED:
									if (p_USB_SetupReq->wValue_LO == USB_FEATURE_REMOTE_WAKEUP) 
									{
										usb.dev_remote_wakeup = 0; 
										USB_Setup_Request_callback(p_USB_SetupReq);
										USB_Send_Data(NULL, 0, 0);
									}
									break;
									
								default :
									 usb_control_error();
									break;
							}
							break;
						}
						default:
						{
							usb_control_error();
							break;
						}
					}
					break;
				}
				
				case USB_REQ_RECIPIENT_INTERFACE: // Interface request
				{
					if (usb.dev_state == USB_STATE_CONFIGURED)
					{
						if (p_USB_SetupReq->wIndex_LO <= USB_MAX_NUM_INTERFACES) 
						{
							if (USB_Setup_Request_callback(p_USB_SetupReq) < 0) usb_control_error();
						} else usb_control_error();
					} else usb_control_error();
					break;
				}
				
				case USB_REQ_RECIPIENT_ENDPOINT: // Endpoint request
				{
					if ((p_USB_SetupReq->bmRequest & 0x60) == 0x20) // Check if it is a class request
					{
						USB_Setup_Request_callback(p_USB_SetupReq);
					}
					/* TODO!
					switch (p_USB_SetupReq->bRequest) 
					{
						case USB_REQ_SET_FEATURE:
						{
							switch (usb.dev_state) 
							{
								case USBD_STATE_ADDRESSED:          
									if ((p_req->wIndex_LO != 0x00) && (p_req->wIndex_LO != 0x80)) 
									{
										USBD_LL_StallEP(pdev , p_req->wIndex_LO);
									}
									break;	
									
								case USBD_STATE_CONFIGURED:   
									if (p_USB_SetupReq->wValue_LO == USB_FEATURE_EP_HALT)
									{
										if ((p_USB_SetupReq->wIndex_LO != 0x00) && (p_USB_SetupReq->wIndex_LO != 0x80)) 
										{ 
											USBD_LL_StallEP(pdev , p_USB_SetupReq->wIndex_LO);
										}
									}
									if (USB_Setup_Request_callback(p_USB_SetupReq) < 0) usb_control_error();
									break;
									
								default:                         
									usb_control_error();
									break;    
							}
							break;
						}
							
						case USB_REQ_CLEAR_FEATURE:
						{
							switch (usb.dev_state) 
							{
							case USBD_STATE_ADDRESSED:          
								if ((p_USB_SetupReq->wIndex_LO != 0x00) && (p_USB_SetupReq->wIndex_LO != 0x80)) 
								{
									USBD_LL_StallEP(pdev , ep_addr);
								}
								break;	
								
							case USBD_STATE_CONFIGURED:   
								if (req->wValue == USB_FEATURE_EP_HALT)
								{
									if ((p_USB_SetupReq->wIndex_LO & 0x7F) != 0x00) 
									{        
										USBD_LL_ClearStallEP(pdev , p_USB_SetupReq->wIndex_LO);
										USB_Setup_Request_callback(p_USB_SetupReq);
									}
								}
								break;
								
							default:                         
								usb_control_error();
								break;    
							}
							break;
						}
							
						case USB_REQ_GET_STATUS:
						{						
							switch (pdev->dev_state) 
							{
							case USBD_STATE_ADDRESSED:          
								if ((p_USB_SetupReq->wIndex_LO & 0x7F) != 0x00) 
								{
									USBD_LL_StallEP(pdev , p_USB_SetupReq->wIndex_LO);
								}
								break;	
								
							case USBD_STATE_CONFIGURED:
								pep = ((p_USB_SetupReq->wIndex_LO & 0x80) == 0x80) ? &pdev->ep_in[p_USB_SetupReq->wIndex_LO & 0x7F]:\
																									 &pdev->ep_out[p_USB_SetupReq->wIndex_LO & 0x7F];
								if (USBD_LL_IsStallEP(pdev, ep_addr))
								{
									pep->status = 0x0001;     
								}
								else
								{
									pep->status = 0x0000;  
								}
								
								USBD_CtlSendData (pdev, (uint8_t *)&pep->status, 2);
								break;
								
							default:                         
								usb_control_error();
								break;
							}
							break;
						}
						default:
							break;
					}*/
					break;
				}
				
				default:
					usb_control_error();
					break;
			}
			usb.EP[0].rx_state = USB_EP_NO_DATA;
		} else { // EP0 Data stage
			USB_EP0_RxReady_callback(usb.EP[0].rx_buffer);
			usb.EP[0].rx_state = USB_EP_NO_DATA;
		}
	}
	
	if (usb.EP[1].rx_state == USB_EP_DATA_READY) {
		USB_EP1_RxReady_callback(usb.EP[1].rx_buffer);
		usb.EP[1].rx_state = USB_EP_NO_DATA;
	}
}

void USB_slow_loop(void)
{
#if (USB_CLOCK_HSI == 1)
	if (usb.trimming_stage == HSI_TRIMMER_DISABLE) return;
	if (usb.trimming_stage == HSI_TRIMMER_STARTED)
	{
		usb.delay_counter++;
		if (usb.delay_counter == USB_CONNECT_TIMEOUT)
		{
			usb.delay_counter = 0;
			usb.HSI_Trim_val++;
			usb.HSI_Trim_val &= 0x0F;
			CLK->HSITRIMR = (uint8_t)((CLK->HSITRIMR & (~0x0F)) | usb.HSI_Trim_val);
			USB_disconnect();
			USB_Reset();
			usb.trimming_stage = HSI_TRIMMER_RECONNECT_DELAY;
		}
	} else
	if (usb.trimming_stage == HSI_TRIMMER_RECONNECT_DELAY)
	{
		usb.delay_counter++;
		if (usb.delay_counter == USB_RECONNECT_DELAY)
		{
			usb.delay_counter = 0;
			usb.trimming_stage = HSI_TRIMMER_ENABLE;
			USB_connect();
		}
	} else
	if (usb.trimming_stage == HSI_TRIMMER_WRITE_TRIM_VAL)
	{
		FLASH_Unlock(FLASH_MEMTYPE_DATA);
		*p_HSI_TRIM_VAL = usb.HSI_Trim_val;
		*p_HSI_TRIMING_DONE = MAGIC_VAL;
		usb.trimming_stage = HSI_TRIMMER_DISABLE;
	}
#endif
}
