#include "usb.h"

const unsigned char usb_device_descriptor[SIZE_DEVICE_DESCRIPTOR] =
{
	SIZE_DEVICE_DESCRIPTOR, // Size of the Descriptor in Bytes
	USB_DESC_TYPE_DEVICE, // Device Descriptor (0x01)
	0x10, 
	0x01, // USB 1.1 = 0x0110; USB 1.0 = 0x0100
	0x00, // Class Code
	0x00, // Subclass Code
	0x00, // Protocol Code
	0x08, // Maximum Packet Size for Zero Endpoint
	0x3B, // VID_L
	0x04, // VID_H
	0x25, // PID_L
	0x03,	// PID_H
	0x00, // bcdDevice rel. 2.00
	0x02,	// bcdDevice rel. 2.00
	0x01, // Index of Manufacturer String Descriptor
	0x02, // Index of Product String Descriptor
	0x03, // Index of Serial Number String Descriptor
	0x01, // Number of Possible Configurations
};

const unsigned char usb_configuration_descriptor[SIZE_CONFIGURATION_DESCRIPTOR] =
{ 
	0x09, // Size of Descriptor in Bytes
	USB_DESC_TYPE_CONFIGURATION, // Configuration Descriptor (0x02)
	LOBYTE(SIZE_CONFIGURATION_DESCRIPTOR), // Total length of config desc in bytes - LO
	HIBYTE(SIZE_CONFIGURATION_DESCRIPTOR), // Total length of config desc in bytes - HI
	0x01, // Number of Interfaces
	0x01, // Value to use as an argument to select this configuration
	0x00, // Index of String Descriptor describing this configuration
#if (USB_SELF_POWERED == 1)
	0xC0, // D7 Reserved, set to 1.(USB 1.0 Bus Powered),D6 Self Powered,D5 Remote Wakeup,D4..0 Reserved, set to 0.
#else
	0x80, // D7 Reserved, set to 1.(USB 1.0 Bus Powered),D6 Self Powered,D5 Remote Wakeup,D4..0 Reserved, set to 0.
#endif
	0x32, // Maximum Power Consumption in 2mA units
	
	// Interface descriptor
	0x09, // Size of Descriptor in Bytes (9 Bytes)
	USB_DESC_TYPE_INTERFACE, // Interface Descriptor (0x04)
	INTERFACE_ID_HIDDev, // Number of Interface
	0x00, // Value used to select alternative setting
	0x01, // Number of Endpoints used for this interface
	0x03, // Class Code
	0x01, // Subclass Code - boot interface
	0x01, // Protocol Code - keyboard
	0x00, // Index of String Descriptor Describing this interface
	
	// HID descriptor
	SIZE_HID_DESCRIPTOR, // Size of Descriptor in Bytes (9 Bytes)
	TYPE_HID_DESCRIPTOR, // HID descriptor (0x21)
	//0x11, // BCD representation of HID version - LO
	0x10, // BCD representation of HID version - LO
	0x01, // BCD representation of HID version - HI
	0x00, // Target country code
	0x01, // Number of HID Report (or other HID class) Descriptor infos to follow
	TYPE_REPORT_DESCRIPTOR, // Descriptor type: report
	LOBYTE(SIZE_REPORT_DESCRIPTOR), // total length of report descriptor - LO
	HIBYTE(SIZE_REPORT_DESCRIPTOR),  // total length of report descriptor - HI
	
	// Endpoint descriptor
	0x07, // Size of Descriptor in Bytes (7 Bytes)
	USB_DESC_TYPE_ENDPOINT, // Endpoint descriptor (0x05)
	0x81, // IN endpoint number 1 (0x81)
	0x03, // attrib: Interrupt endpoint
	0x08, // maximum packet size - LO
	0x00, // maximum packet size - HI
	0x20,  // poll interval (ms)
};

// USB HID device Configuration Descriptor
const unsigned char USB_HID_descriptor[SIZE_HID_DESCRIPTOR] =
{
	// HID descriptor
	SIZE_HID_DESCRIPTOR, // Size of Descriptor in Bytes (9 Bytes)
	TYPE_HID_DESCRIPTOR, // HID descriptor (0x21)
	0x10, // BCD representation of HID version - LO
	0x01, // BCD representation of HID version - HI
	0x00, // Target country code
	0x01, // Number of HID Report (or other HID class) Descriptor infos to follow
	TYPE_REPORT_DESCRIPTOR, // Descriptor type: report
	LOBYTE(SIZE_REPORT_DESCRIPTOR), // total length of report descriptor - LO
	HIBYTE(SIZE_REPORT_DESCRIPTOR),  // total length of report descriptor - HI
};

// HID keyboard
const unsigned char usb_report_descriptor[SIZE_REPORT_DESCRIPTOR] = // 66+27+24+32
{
//////////////// KEYBOARD page 07 /////////////////////////////////////////////////
  0x05, 0x01,                    // USAGE_PAGE (Generic Desktop)
  0x09, 0x06,                    // USAGE (Keyboard)
  0xa1, 0x01,                    // COLLECTION (Application)
  0x85, STD_KEYBOARD_REPORT_ID,  //   REPORT_ID
  0x05, 0x07,                    //   USAGE_PAGE (Keyboard)
  0x19, 0xe0,                    //   USAGE_MINIMUM (Keyboard LeftControl)
  0x29, 0xe7,                    //   USAGE_MAXIMUM (Keyboard Right GUI)
  0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
  0x25, 0x01,                    //   LOGICAL_MAXIMUM (1)
  0x75, 0x01,                    //   REPORT_SIZE (1)
  0x95, 0x08,                    //   REPORT_COUNT (8)
  0x81, 0x02,                    //   INPUT (Data,Var,Abs)
  0x95, 0x01,                    //   REPORT_COUNT (1)
  0x75, 0x08,                    //   REPORT_SIZE (8)
  0x81, 0x03,                    //   INPUT (Cnst,Var,Abs)
  0x05, 0x08,                    //   USAGE_PAGE (LEDs)
  0x19, 0x01,                    //   USAGE_MINIMUM (Num Lock)
  0x29, 0x05,                    //   USAGE_MAXIMUM (Kana)
  0x95, 0x05,                    //   REPORT_COUNT (5)
  0x75, 0x01,                    //   REPORT_SIZE (1)
  0x91, 0x02,                    //   OUTPUT (Data,Var,Abs)
  0x95, 0x01,                    //   REPORT_COUNT (1)
  0x75, 0x03,                    //   REPORT_SIZE (3)
  0x91, 0x03,                    //   OUTPUT (Cnst,Var,Abs)
  0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
  0x26, 0xe7, 0x00,              //   LOGICAL_MAXIMUM (231)
  0x05, 0x07,                    //   USAGE_PAGE (Keyboard)
  0x19, 0x00,                    //   USAGE_MINIMUM (Reserved (no event indicated))
  0x29, 0xe7,                    //   USAGE_MAXIMUM (Keyboard Right GUI)
  0x95, 0x05,                    //   REPORT_COUNT (5)
  0x75, 0x08,                    //   REPORT_SIZE (8)
  0x81, 0x00,                    //   INPUT (Data,Ary,Abs)
  0xc0,                          // END_COLLECTION
//////////////// KEYBOARD page 0x0C /////////////////////////////////////////////////
  0x05, 0x0c,                    // USAGE_PAGE (Consumer Devices)
  0x09, 0x01,                    // USAGE (Consumer Control)
  0xa1, 0x01,                    // COLLECTION (Application)
  0x85, EXT1_KEYBOARD_REPORT_ID, //   REPORT_ID
	0x75, 0x10,                    //   REPORT_SIZE (16)
	0x95, 0x01,                    //   REPORT_COUNT (1)
  0x16, 0x00, 0x00,              //   LOGICAL_MINIMUM (0)
  0x26, 0x9c, 0x02,              //   LOGICAL_MAXIMUM (668)
  0x1A, 0x00, 0x00,              //   USAGE_MINIMUM (Undefined)
  0x2A, 0x9c, 0x02,              //   USAGE_MAXIMUM (AC Distribute Vertically)
  0x81, 0x00,                    //   INPUT (Data,Ary,Abs)
  0xc0,                          // END_COLLECTION
//////////////// KEYBOARD page 01 /////////////////////////////////////////////////
  0x05, 0x01,                    // USAGE_PAGE (Generic Desktop)
  0x09, 0x80,                    // USAGE (System Control)
  0xa1, 0x01,                    // COLLECTION (Application)
  0x85, EXT2_KEYBOARD_REPORT_ID, //   REPORT_ID
	0x75, 0x08,                    //   REPORT_SIZE (8)
  0x95, 0x07,                    //   REPORT_COUNT (7)
  0x15, 0x00,				             //   LOGICAL_MINIMUM (0)
  0x26, 0x8d, 0x00,              //   LOGICAL_MAXIMUM (141)
  0x19, 0x00,				             //   USAGE_MINIMUM (Undefined)
  0x29, 0x8d,				             //   USAGE_MAXIMUM (System Menu Down)
  0x81, 0x00,                    //   INPUT (Data,Ary,Abs)
		0x06, 0x00, 0xff,              //   USAGE_PAGE (Vendor Defined Page 1)
    0x09, 0x01,                    //   USAGE (Vendor Usage 1)
    0x85, CONFIGURE_KEYS_REPORT_ID,//   REPORT_ID
    0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
    0x26, 0xff, 0x00,              //   LOGICAL_MAXIMUM (255)
    0x75, 0x08,                    //   REPORT_SIZE (8)
    0x95, 0x05,                    //   REPORT_COUNT (5)
    0x91, 0x82,                    //   OUTPUT (Data,Var,Abs,Vol)
    0x09, 0x02,                    //   USAGE (Vendor Usage 2)
    0x85, READ_KEYS_REPORT_ID,     //   REPORT_ID
    0x95, 0x01,                    //   REPORT_COUNT (1)
    0x91, 0x82,                    //   OUTPUT (Data,Var,Abs,Vol)
    0x09, 0x02,                    //   USAGE (Vendor Usage 2)
    0x95, 0x05,                    //   REPORT_COUNT (5)
    0x81, 0x00,                    //   INPUT (Data,Ary,Abs)
  0xc0                           // END_COLLECTION
};

const unsigned char String_LangID[SIZE_STRING_LANGID] = {
	SIZE_STRING_LANGID,
	USB_DESC_TYPE_STRING,
	0x09, 0x04	//En-US
};

const unsigned char String_Vendor[SIZE_STRING_VENDOR] =
{
    SIZE_STRING_VENDOR, // Size of Vendor string
    USB_DESC_TYPE_STRING,  // bDescriptorType
    // Manufacturer: "STMicroelectronics"
    'S', 0, 'T', 0, 'M', 0, 'i', 0, 'c', 0, 'r', 0, 'o', 0, 'e', 0,
    'l', 0, 'e', 0, 'c', 0, 't', 0, 'r', 0, 'o', 0, 'n', 0, 'i', 0,
    'c', 0, 's', 0
};

const unsigned char String_Product[SIZE_STRING_PRODUCT] =
{
    SIZE_STRING_PRODUCT,          // bLength
    USB_DESC_TYPE_STRING,        // bDescriptorType
    'S', 0, 'T', 0, 'M', 0, '8', 0, ' ', 0, 'V', 0, 'U', 0,
    'S', 0, 'B', 0, ' ', 0, 'H', 0, 'I', 0, 'D', 0, ' ', 0,
    'd', 0,'e',0, 'm', 0, 'o', 0, ' ', 0, 'k', 0, 'i', 0, 't', 0 , ' ', 0
};

const unsigned char String_Serial[SIZE_STRING_SERIAL] =
{
    SIZE_STRING_SERIAL,           // bLength
    USB_DESC_TYPE_STRING,       // bDescriptorType
    '0', 0, '0', 0, '0', 0, '0', 0, '0', 0, '0', 0, '0', 0, '1', 0
};

const unsigned char* USB_String_Descriptors[LENGTH_STRING_DESCRIPTOR] = {
	String_LangID,
	String_Vendor,
	String_Product,
	String_Serial
};

const unsigned char USB_String_Descriptors_Length[LENGTH_STRING_DESCRIPTOR] = {
	SIZE_STRING_LANGID,
	SIZE_STRING_VENDOR,
	SIZE_STRING_PRODUCT,
	SIZE_STRING_SERIAL
};

