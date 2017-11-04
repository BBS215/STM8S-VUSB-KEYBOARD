#ifndef USB_DESC_H_
#define USB_DESC_H_

#include "stm8s.h"

/// SETTINGS ///////////////////////////////////////////////
#define SIZE_DEVICE_DESCRIPTOR 					18
#define SIZE_CONFIGURATION_DESCRIPTOR 	34
#define SIZE_REPORT_DESCRIPTOR 					117
#define SIZE_HID_DESCRIPTOR 						9

#define INTERFACE_ID_HIDDev 						0
#define STD_KEYBOARD_REPORT_ID 					41
#define EXT1_KEYBOARD_REPORT_ID 				42
#define EXT2_KEYBOARD_REPORT_ID 				43

#define LENGTH_STRING_DESCRIPTOR 				4
#define SIZE_STRING_LANGID 							4
#define SIZE_STRING_VENDOR             	38
#define SIZE_STRING_PRODUCT            	48
#define SIZE_STRING_SERIAL             	18
///////////////////////////////////////////////////////////;

#define LOBYTE(x)  ((uint8_t)(x & 0x00FF))
#define HIBYTE(x)  ((uint8_t)((x & 0xFF00) >> 8))

#define  USB_DESC_TYPE_DEVICE                              1
#define  USB_DESC_TYPE_CONFIGURATION                       2
#define  USB_DESC_TYPE_STRING                              3
#define  USB_DESC_TYPE_INTERFACE                           4
#define  USB_DESC_TYPE_ENDPOINT                            5
#define  USB_DESC_TYPE_DEVICE_QUALIFIER                    6
#define  USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION           7
#define  USB_DESC_TYPE_BOS                                 0x0F

#define  TYPE_HID_DESCRIPTOR 						0x21
#define  TYPE_REPORT_DESCRIPTOR 				0x22

extern const unsigned char usb_device_descriptor[SIZE_DEVICE_DESCRIPTOR];
extern const unsigned char usb_configuration_descriptor[SIZE_CONFIGURATION_DESCRIPTOR];
extern const unsigned char usb_report_descriptor[SIZE_REPORT_DESCRIPTOR];
extern const unsigned char USB_HID_descriptor[SIZE_HID_DESCRIPTOR];
extern const unsigned char* USB_String_Descriptors[LENGTH_STRING_DESCRIPTOR];
extern const unsigned char USB_String_Descriptors_Length[LENGTH_STRING_DESCRIPTOR];

#endif // USB_DESC_H_