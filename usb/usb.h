#ifndef USB_H_
#define USB_H_

#include "usb_desc.h"

/// SETTINGS ///////////////////////////////////////////////
#define USB_MAX_NUM_CONFIGURATION 	1
#define USB_MAX_NUM_INTERFACES 			1
#define USB_SELF_POWERED						0
#define USB_CLOCK_HSI								1		// 0 - HSE XTAL 16 MHz; 1 - HSI
#define USB_CONNECT_TIMEOUT					700 // 100Hz * 7 sec
#define USB_RECONNECT_DELAY					100 // 100Hz * 1 sec
#define USB_CONNECT_PORT						GPIOA
#define USB_CONNECT_PIN							GPIO_PIN_3
#define EEPROM_START_ADDR						0x4000
#define MAGIC_VAL										0x11
#define USB_RESET_DELAY							3000	// 5-7ms
////////////////////////////////////////////////////////////

#ifndef NULL
 #define NULL (void*)0
#endif
#define MIN(A,B)							((A<=B)?A:B)

enum usb_states_list
{
	USB_STAGE_NONE = 0,
	USB_STAGE_SETUP,
	USB_STAGE_OUT
};

enum usb_packets_id_list
{
	USB_PID_OUT = 	0xE1,
	USB_PID_IN = 		0x69,
	USB_PID_SETUP = 0x2D,
	USB_PID_DATA0 = 0xC3,
	USB_PID_DATA1 = 0x4B,
	USB_PID_ACK = 	0xD2,
	USB_PID_NACK = 	0x5A,
	USB_PID_STALL = 0x1E
};

#define  USB_SYNC_BYTE                       						0x80

#define  USB_REQ_RECIPIENT_DEVICE                       0x00
#define  USB_REQ_RECIPIENT_INTERFACE                    0x01
#define  USB_REQ_RECIPIENT_ENDPOINT                     0x02
#define  USB_REQ_RECIPIENT_MASK                         0x03

#define  USB_REQ_GET_STATUS                             0x00
#define  USB_REQ_CLEAR_FEATURE                          0x01
#define  USB_REQ_SET_FEATURE                            0x03
#define  USB_REQ_SET_ADDRESS                            0x05
#define  USB_REQ_GET_DESCRIPTOR                         0x06
#define  USB_REQ_SET_DESCRIPTOR                         0x07
#define  USB_REQ_GET_CONFIGURATION                      0x08
#define  USB_REQ_SET_CONFIGURATION                      0x09
#define  USB_REQ_GET_INTERFACE                          0x0A
#define  USB_REQ_SET_INTERFACE                          0x0B
#define  USB_REQ_SYNCH_FRAME                            0x0C

#define	 USB_STATE_DEFAULT                              1
#define  USB_STATE_ADDRESSED                            2
#define  USB_STATE_CONFIGURED                           3
//#define  USB_STATE_SUSPENDED                            4

#define  USB_REQ_TYPE_STANDARD                          0x00
#define  USB_REQ_TYPE_CLASS                             0x20
#define  USB_REQ_TYPE_VENDOR                            0x40
#define  USB_REQ_TYPE_MASK                              0x60

#define  USB_FEATURE_EP_HALT                            0
#define  USB_FEATURE_REMOTE_WAKEUP                      1
#define  USB_FEATURE_TEST_MODE                          2

#define  USB_CONFIG_SELF_POWERED                        1
#define  USB_CONFIG_REMOTE_WAKEUP                       2

#define  HID_REQ_SET_PROTOCOL          									0x0B
#define  HID_REQ_GET_PROTOCOL          									0x03
#define  HID_REQ_SET_IDLE              									0x0A
#define  HID_REQ_GET_IDLE              									0x02
#define  HID_REQ_SET_REPORT            									0x09
#define  HID_REQ_GET_REPORT            									0x01

//HID Report Types
#define  HID_REPORT_INPUT   														0x01
#define  HID_REPORT_OUTPUT   														0x02
#define  HID_REPORT_FEATURE   													0x03

typedef struct usb_setup_req 
{
	uint8_t   bmRequest; // 0
  uint8_t   bRequest;  // 1
	uint8_t 	wValue_LO; // 2
	uint8_t   wValue_HI; // 3
	uint8_t   wIndex_LO; // 4
	uint8_t   wIndex_HI; // 5
	uint8_t   wLength_LO; // 6
	uint8_t   wLength_HI; // 7
} t_USB_SetupReq;

typedef enum e_usb_ep_state
{
	USB_EP_NO_DATA = 0,
	USB_EP_DATA_READY
} t_usb_ep_state;

typedef struct s_USB_EP 
{
	uint8_t 								rx_buffer[12];
	uint8_t 								rx_length;
	volatile t_usb_ep_state rx_state;
	uint8_t 								tx_buffer[12];
	uint8_t 								tx_length;
	uint8_t									tx_data_sync;
	volatile t_usb_ep_state tx_state;
} t_USB_EP;

enum e_hsi_trimmer_stage
{
	HSI_TRIMMER_ENABLE = 0,
	HSI_TRIMMER_STARTED,
	HSI_TRIMMER_RECONNECT_DELAY,
	HSI_TRIMMER_WRITE_TRIM_VAL,
	HSI_TRIMMER_DISABLE
};

struct usb_type
{
	volatile uint8_t stage;
	volatile uint8_t device_address;
	uint8_t setup_address;
	uint8_t active_EP_num;
	uint8_t dev_state;
	uint8_t dev_config;
	uint8_t EP0_data_stage;
	t_USB_EP EP[2];
	uint16_t reset_counter;
	uint16_t dev_config_status;
	uint8_t dev_remote_wakeup;
#if (USB_CLOCK_HSI == 1)
	enum e_hsi_trimmer_stage trimming_stage;
	uint16_t delay_counter;
	uint8_t HSI_Trim_val;
#endif
};

/// FUNCS

void USB_Init(void);
void USB_loop(void);
void USB_connect(void);
void USB_disconnect(void);
void USB_slow_loop(void);
int8_t USB_Send_Data(uint8_t * buffer, uint8_t length, uint8_t EP_num);
void USB_EP0_RxReady_callback(uint8_t *p_data);
void USB_EP1_RxReady_callback(uint8_t *p_data);
int8_t USB_Setup_Request_callback(t_USB_SetupReq *p_req);
int8_t USB_Class_Init_callback(uint8_t dev_config);
int8_t USB_Class_DeInit_callback(void);

#endif /* USB_H_ */
