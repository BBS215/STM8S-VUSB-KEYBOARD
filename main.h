#ifndef MAIN_H_
#define MAIN_H_

#include "stm8s.h"

typedef struct
{
	uint8_t ReportID;
	uint8_t Modifier; // Keyboard modifier byte, indicating pressed modifier keys (a combination of HID_KEYBOARD_MODIFER_* masks).
	uint8_t Reserved; // Reserved for OEM use, always set to 0.
	uint8_t KeyCode[5]; // Key codes of the currently pressed keys.
} USB_KeyboardReport_STD_Data_t;

typedef struct
{
	uint8_t ReportID;
	uint8_t KeyCode_LO;
	uint8_t KeyCode_HI;
} USB_KeyboardReport_EXT1_Data_t; // HID KB page 0xC

typedef struct
{
	uint8_t ReportID;
	uint8_t KeyCode[7]; // Key codes of the currently pressed keys.
} USB_KeyboardReport_EXT2_Data_t; // HID KB page 0x1

typedef struct s_HID_Dev 
{
  uint8_t             	Protocol;   
  uint8_t             	IdleState;  
  uint8_t             	AltSetting;
	USB_KeyboardReport_STD_Data_t		STD_KB_Report;
	uint8_t													STD_KB_Report_changed_flag;
	USB_KeyboardReport_EXT1_Data_t	EXT1_KB_Report;
	uint8_t													EXT1_KB_Report_changed_flag;
	USB_KeyboardReport_EXT2_Data_t	EXT2_KB_Report;
	uint8_t													EXT2_KB_Report_changed_flag;
} t_HID_Dev;

#endif // MAIN_H_
