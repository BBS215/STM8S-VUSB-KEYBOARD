#ifndef MAIN_H_
#define MAIN_H_

#include "stm8s.h"

#define KEY_SETTINGS_START_ADDR (EEPROM_START_ADDR+2)
#define STD_KEYBOARD_USAGE_PAGE 						0x7
//#define STD_KEYBOARD_MODIFIERS_USAGE_PAGE 	0xF
#define EXT1_KEYBOARD_USAGE_PAGE 						0xC
#define EXT2_KEYBOARD_USAGE_PAGE 						0x1

typedef struct
{
	uint8_t UsagePage;
	uint8_t Modifiers;
	uint8_t KeyCode_LO;
	uint8_t KeyCode_HI;
} t_KeyCode;

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

typedef struct
{
	uint8_t ReportID;
	uint8_t	key_num;
	t_KeyCode KeyCode; // Settings of the active key.
} t_Key_settings;

typedef struct
{
	uint8_t write_flag;
	uint8_t	key_num;
	t_KeyCode KeyCode;
} t_Key_settings_to_write;

typedef struct
{
	uint8_t ReportID;
	uint8_t	cmd;
	union {
		struct {
			uint8_t HI_byte;
			uint8_t LO_byte;
		} addr_8;
		uint16_t addr_16;
	} addr;
	union {
		struct {
			uint8_t HI_byte;
			uint8_t LO_byte;
		} data_8;
		uint16_t data_16;
	} data;
} t_Debug_dev_report;

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
	t_Key_settings				Key_settings;
	t_Key_settings_to_write	Key_settings_to_write;
	uint16_t 							prev_key_mask;
	t_Debug_dev_report		DEBUG_DEV_report;
} t_HID_Dev;

#endif // MAIN_H_
