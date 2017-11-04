#include "main.h"
#include "usb.h"
#include "init.h"
#include "peripheral.h"
#include "HIDClassCommon.h"

/// GLOBAL VARS ////////////////////////////////////////////

volatile uint8_t g_systimer_flag;
t_HID_Dev HID_Dev;

/// CALLBACKS //////////////////////////////////////////////

void USB_EP0_RxReady_callback(uint8_t *p_data)
{
	if (p_data[0] == STD_KEYBOARD_REPORT_ID) {
		if (p_data[1] & HID_KEYBOARD_LED_NUMLOCK) // Num Lock
															Led_setmode(LED_0, LED_ON); 
		else											Led_setmode(LED_0, LED_OFF);
		if (p_data[1] & HID_KEYBOARD_LED_CAPSLOCK) // Caps Lock
															Led_setmode(LED_1, LED_ON); 
		else											Led_setmode(LED_1, LED_OFF);
		if (p_data[1] & HID_KEYBOARD_LED_SCROLLLOCK) // Scroll lock
															Led_setmode(LED_2, LED_ON); 
		else											Led_setmode(LED_2, LED_OFF);
	}
}

void KEY_changed(uint8_t key_num)
{
	switch(key_num) {
		case BTN_0: // used in STD keyboard
		case BTN_1: // used in STD keyboard
		case BTN_2: // used in STD keyboard
		case BTN_3: // used in STD keyboard
		case BTN_4: // used in STD keyboard
		case BTN_5: // used in STD keyboard
		case BTN_6: // used in STD keyboard
		case BTN_7: // used in STD keyboard
			HID_Dev.STD_KB_Report_changed_flag = 1; // STD keyboard
			break;
			//HID_Dev.EXT1_KB_Report_changed_flag = 1; // EXT1 keyboard
			//break;
			//HID_Dev.EXT2_KB_Report_changed_flag = 1; // EXT2 keyboard
			//break;
		default:
			break;
	}
}

void EVENT_KEY_pressed(uint8_t key_num) { KEY_changed(key_num); }
void EVENT_KEY_released(uint8_t key_num) { KEY_changed(key_num); }

void BTN_USB_send_Loop(void)
{
	uint8_t KeyCodesMAX;
	uint8_t key_mask = Buttons_get_mask();
	uint8_t UsedKeyCodes = 0;
	
	// STD Keyboard
	if (HID_Dev.STD_KB_Report_changed_flag) {
		KeyCodesMAX = 5;
		HID_Dev.STD_KB_Report.Modifier = 0;
		if (key_mask & (1 << BTN_0))
			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTGUI;
		if (key_mask & (1 << BTN_1))
			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTCTRL;
		if (key_mask & (1 << BTN_6))
			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTSHIFT;
		if (key_mask & (1 << BTN_7))
			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTALT;
			
		if (key_mask & (1 << BTN_2)) {
			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_1_AND_EXCLAMATION;
			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send;
		}
		if (key_mask & (1 << BTN_3)) {
			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_2_AND_AT;
			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send;
		}
		if (key_mask & (1 << BTN_4)) {
			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_3_AND_HASHMARK;
			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send;
		}
		if (key_mask & (1 << BTN_5)) {
			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_4_AND_DOLLAR;
			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send;
		}
		while(UsedKeyCodes < KeyCodesMAX) HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = 0;
	STD_Send:
		if (USB_Send_Data((uint8_t*)&HID_Dev.STD_KB_Report, sizeof(HID_Dev.STD_KB_Report), 1) == 0)
			HID_Dev.STD_KB_Report_changed_flag = 0;
		return;
	}
	
	// EXT1 Keyboard
	if (HID_Dev.EXT1_KB_Report_changed_flag) {
		/*if (key_mask & (1 << BTN_3)) {
			HID_Dev.EXT1_KB_Report.KeyCode_LO = LOBYTE(0x????);
			HID_Dev.EXT1_KB_Report.KeyCode_HI = HIBYTE(0x????);
			goto EXT1_Send;
		}*/
		/*if (key_mask & (1 << BTN_4)) {
			HID_Dev.EXT1_KB_Report.KeyCode_LO = LOBYTE(0x????);
			HID_Dev.EXT1_KB_Report.KeyCode_HI = HIBYTE(0x????);
			goto EXT1_Send;
		}*/
		HID_Dev.EXT1_KB_Report.KeyCode_LO = 0;
		HID_Dev.EXT1_KB_Report.KeyCode_HI = 0;
	EXT1_Send:
		if (USB_Send_Data((uint8_t*)&HID_Dev.EXT1_KB_Report, sizeof(HID_Dev.EXT1_KB_Report), 1) == 0)
			HID_Dev.EXT1_KB_Report_changed_flag = 0;
		return;
	}
	
	// EXT2 Keyboard
	if (HID_Dev.EXT2_KB_Report_changed_flag) {
		KeyCodesMAX = 7;
		/*if (key_mask & (1 << BTN_1)) {
			HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = 0x??;
			if (UsedKeyCodes >= KeyCodesMAX) goto EXT2_Send;
		}*/
		/*if (key_mask & (1 << BTN_2)) {
			HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = 0x??;
			if (UsedKeyCodes >= KeyCodesMAX) goto EXT2_Send;
		}*/
		while(UsedKeyCodes < KeyCodesMAX) HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = 0;
	EXT2_Send:
		if (USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 1) == 0)
			HID_Dev.EXT2_KB_Report_changed_flag = 0;
		return;
	}
}

int8_t USB_Class_Init_callback(uint8_t dev_config)
{
	uint8_t i;
	for(i=0;i<sizeof(HID_Dev);i++) ((uint8_t*)&HID_Dev)[i] = 0;
	HID_Dev.STD_KB_Report.ReportID = STD_KEYBOARD_REPORT_ID;
	HID_Dev.EXT1_KB_Report.ReportID = EXT1_KEYBOARD_REPORT_ID;
	HID_Dev.EXT2_KB_Report.ReportID = EXT2_KEYBOARD_REPORT_ID;
	HID_Dev.STD_KB_Report_changed_flag = 1;
	HID_Dev.EXT1_KB_Report_changed_flag = 1;
	HID_Dev.EXT2_KB_Report_changed_flag = 1;
	return 0;
}

int8_t USB_Class_DeInit_callback(void)
{
	return 0;
}

int8_t USB_Setup_Request_callback(t_USB_SetupReq *p_req)
{
	switch (p_req->bmRequest & USB_REQ_TYPE_MASK)
  {
		case USB_REQ_TYPE_CLASS:
		{
			switch (p_req->bRequest)
			{
				case HID_REQ_GET_REPORT: // 0x01
				{
					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) // HID Device
					{
						if (p_req->wValue_HI == HID_REPORT_FEATURE)
						{
							switch(p_req->wValue_LO) // ReportID
							{
								case STD_KEYBOARD_REPORT_ID: // STD Keyboard
									return USB_Send_Data((uint8_t*)&HID_Dev.STD_KB_Report, sizeof(HID_Dev.STD_KB_Report), 0);
								case EXT1_KEYBOARD_REPORT_ID: // EXT1 Keyboard
									return USB_Send_Data((uint8_t*)&HID_Dev.EXT1_KB_Report, sizeof(HID_Dev.EXT1_KB_Report), 0);
								case EXT2_KEYBOARD_REPORT_ID: // EXT2 Keyboard
									return USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 0);
							}
						}
					}
					break;
				}
				
				case HID_REQ_SET_REPORT: // 0x09
				{
					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) // HID Device
					{
						if (p_req->wValue_HI == HID_REPORT_OUTPUT)
						{
							if (p_req->wValue_LO == STD_KEYBOARD_REPORT_ID) // ReportID
							{
								return USB_Send_Data(NULL, 0, 0);
							}
						}
					}
					break;
				}
				
				case HID_REQ_SET_PROTOCOL: // 0x0B
					HID_Dev.Protocol = p_req->wValue_LO;
					return USB_Send_Data(NULL, 0, 0);
					
				case HID_REQ_GET_PROTOCOL: // 0x03
					return USB_Send_Data(&HID_Dev.Protocol, 1, 0);
					
				case HID_REQ_SET_IDLE: // 0x0A
					HID_Dev.IdleState = p_req->wValue_HI;
					return USB_Send_Data(NULL, 0, 0);
					
				case HID_REQ_GET_IDLE: // 0x02
					return USB_Send_Data(&HID_Dev.IdleState, 1, 0);
			}
			break;
		}
    
		case USB_REQ_TYPE_STANDARD:
		{
			switch (p_req->bRequest)
			{
				case USB_REQ_GET_DESCRIPTOR:
				{
					if (p_req->wValue_HI == TYPE_REPORT_DESCRIPTOR) // 0x22
					{
						if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
							return USB_Send_Data(usb_report_descriptor, (uint8_t)MIN(p_req->wLength_LO, SIZE_REPORT_DESCRIPTOR), 0);
						}
					} else 
					if (p_req->wValue_HI == TYPE_HID_DESCRIPTOR) // 0x21
					{
						return USB_Send_Data(USB_HID_descriptor, (uint8_t)MIN(p_req->wLength_LO, SIZE_HID_DESCRIPTOR), 0);
					}
					break;
				}
					
				case USB_REQ_GET_INTERFACE:
				{
					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
						return USB_Send_Data(&HID_Dev.AltSetting, 1, 0);
					}
					break;
				}
					
				case USB_REQ_SET_INTERFACE:
				{
					if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
						HID_Dev.AltSetting = p_req->wValue_LO;
						return USB_Send_Data(NULL, 0, 0);
					}
					break;
				}
			}
		}
  }
	return -1;
}

void USB_EP1_RxReady_callback(uint8_t *p_data)
{
	// Nothing. Really.
}

/// MAIN ///////////////////////////////////////////////////

void main(void)
{
	disableInterrupts();
	Init_Clock();
	Init_GPIO();
	Leds_init();
	Buttons_init();
	SYSTimer_Init();
	USB_Init();
	enableInterrupts();
	USB_connect();

	while(1)
	{
		USB_loop();
		if (g_systimer_flag) { // 100 Hz call
			g_systimer_flag = 0;
			Buttons_loop();
			BTN_USB_send_Loop();
			USB_slow_loop();
		}
	}
}





