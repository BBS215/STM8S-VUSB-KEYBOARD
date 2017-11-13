#include "main.h"
#include "usb.h"
#include "init.h"
#include "peripheral.h"
#include "HIDClassCommon.h"

/// GLOBAL VARS ////////////////////////////////////////////

volatile uint8_t g_systimer_flag;
t_HID_Dev HID_Dev;

/// CALLBACKS //////////////////////////////////////////////

/*
 USB_EP0_RxReady_callback предназначен для обработки данных,
 принятых EP0 в процессе Data stage. В данном примере,
 происходит обработка байта, устанавливающего значения 
 светодиодов первой клавиатуры (STD keyboard).
 BYTE 0 - Report ID (должен совпадать)
 BYTE 1 - LED DATA
*/
void USB_EP0_RxReady_callback(uint8_t *p_data)
{
	if (p_data[0] == STD_KEYBOARD_REPORT_ID) { // проверка ReportID
		if (p_data[1] & HID_KEYBOARD_LED_NUMLOCK) // если бит Num Lock выставлен
															Led_setmode(LED_0, LED_ON); // зажигаем светодиод LED_0
		else											Led_setmode(LED_0, LED_OFF); // иначе гасим
		if (p_data[1] & HID_KEYBOARD_LED_CAPSLOCK) // если бит Caps Lock выставлен
															Led_setmode(LED_1, LED_ON); // зажигаем светодиод LED_1
		else											Led_setmode(LED_1, LED_OFF); // иначе гасим
		if (p_data[1] & HID_KEYBOARD_LED_SCROLLLOCK) // если бит Scroll lock выставлен
															Led_setmode(LED_2, LED_ON); // зажигаем светодиод LED_2
		else											Led_setmode(LED_2, LED_OFF); // иначе гасим
	}
}

/*
 Обработчик KEY_changed предназначен для того, чтобы
 определить изменившуюся клавишу, и выставить флаг изменения
 для клавиатуры, которой принадлежит изменившаяся клавиша.
 В данном примере все клавиши принадлежат первой клавиатуре 
 (STD keyboard)
*/
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
			HID_Dev.STD_KB_Report_changed_flag = 1; // состояние клавиш первой клавиатуры изменилось
			break;
			//HID_Dev.EXT1_KB_Report_changed_flag = 1; // состояние клавиш второй клавиатуры изменилось
			//break;
			//HID_Dev.EXT2_KB_Report_changed_flag = 1; // состояние клавиш третьей клавиатуры изменилось
			//break;
		default: // для левых кнопок, которые не относятся к клавиатурам
			break;
	}
}

/*
	EVENT_KEY_pressed - событие "кнопка нажата". key_num - номер нажатой клавиши
	EVENT_KEY_released - событие "кнопка отпущена". key_num - номер отпущенной клавиши
*/
void EVENT_KEY_pressed(uint8_t key_num) { KEY_changed(key_num); }
void EVENT_KEY_released(uint8_t key_num) { KEY_changed(key_num); }

/*
 BTN_USB_send_Loop - функция отправки USB пакетов со 
 скан-кодами нажатых клавиш. Для стандартной клавиатуры,
 кроме скан-кодов, также отправляются биты "модификаторов" -
 CTRL, SHIFT, ALT, WIN. Если клавиша нажата - в байте 
 модификаторов выставляется нужный бит.
 USB пакет от стандартной клавиатуры, представляет из себя 
 ReportID, 1 байт для модификаторов, и 5 байт для скан-кодов
 нажатых клавиш. См. тип USB_KeyboardReport_STD_Data_t. Если
 одновременно нажаты менее пяти клавиш, в свободных местах
 для скан-кодов должны быть нули. Если одновременно нажаты 
 более пяти клавиш, передаются только скан-коды первых (по очереди)
 пяти клавиш.
 USB пакеты от расширенных клавиатур не имеют модификаторов,
 а также могут иметь расширенные скан-коды (16 бит вместо 8).
 См. типы USB_KeyboardReport_EXT1_Data_t и USB_KeyboardReport_EXT2_Data_t.
 Для более подробной информации см. документ 
 http://www.usb.org/developers/hidpage/Hut1_12v2.pdf
 Скан-коды там же.
 В данном примере 4 клавиши являются модификаторами (WIN, CTRL, SHIFT, ALT),
 и 4-м клавишам назначены скан-коды кнопок "1", "2", "3" и "4".
 Для изменения назначения клавиши, нужно:
 1) В бработчике KEY_changed переопределить флаг
 2) В ф-ции BTN_USB_send_Loop, в обработке флага нужной клавиатуры,
 поместить назначение скан-кода для данной клавиши, в соответствии с примером.
 3) Проверить, чтобы другие клавиатуры не использовали эту клавишу.
*/
void BTN_USB_send_Loop(void)
{
	uint8_t KeyCodesMAX;
	uint8_t key_mask = Buttons_get_mask(); // считываем битовую маску нажатых клавиш
	uint8_t UsedKeyCodes = 0; // счётчик использованных скан-кодов
	
	// STD Keyboard (Usage Page 0x7)
	if (HID_Dev.STD_KB_Report_changed_flag) { // если состояние клавиш данной клавиатуры изменилось - формируем и отправляем USB пакет
		KeyCodesMAX = 5; // в данной клавиатуре одновременно могут быть нажаты до 5 клавиш (без учёта модификаторов)
		HID_Dev.STD_KB_Report.Modifier = 0; // сбрасываем байт модификаторов
		if (key_mask & (1 << BTN_0)) // если нажата клавиша BTN_0
			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTGUI; // выставляем бит "LEFTGUI" (WIN) в байте модификаторов
		if (key_mask & (1 << BTN_1)) // аналогично для других клавиш
			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTCTRL;
		if (key_mask & (1 << BTN_6))
			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTSHIFT;
		if (key_mask & (1 << BTN_7))
			HID_Dev.STD_KB_Report.Modifier |= HID_KEYBOARD_MODIFIER_LEFTALT;
			
		if (key_mask & (1 << BTN_2)) { // если нажата клавиша BTN_2
			HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = HID_KEYBOARD_SC_1_AND_EXCLAMATION; // записываем в пакет скан-код кнопки "1" (Usage Page 0x7)
			if (UsedKeyCodes >= KeyCodesMAX) goto STD_Send; // если все 5 байт под скан-коды уже использованы - 
																											// пропускаем остальные клавиши и переходим к отправке пакета
		}
		if (key_mask & (1 << BTN_3)) { // аналогично для других клавиш
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
		// установка неиспользованных скан-кодов в 0
		while(UsedKeyCodes < KeyCodesMAX) HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = 0;
	STD_Send:
		// отправка USB пакета и сброс флага изменения клавиатуры при успешной отправке
		if (USB_Send_Data((uint8_t*)&HID_Dev.STD_KB_Report, sizeof(HID_Dev.STD_KB_Report), 1) == 0)
			HID_Dev.STD_KB_Report_changed_flag = 0;
		return;
	}
	
	// EXT1 Keyboard (Usage Page 0xC)
	// в данной клавиатуре одновременно может быть нажата только одна клавиша
	if (HID_Dev.EXT1_KB_Report_changed_flag) {
		/*if (key_mask & (1 << BTN_3)) { // пример для BTN_3
			HID_Dev.EXT1_KB_Report.KeyCode_LO = LOBYTE(0x????); // младший байт скан-кода, из Usage Page 0xC
			HID_Dev.EXT1_KB_Report.KeyCode_HI = HIBYTE(0x????); // старший байт скан-кода, из Usage Page 0xC
			goto EXT1_Send; // сразу переходим к отправке
		}*/
		/*if (key_mask & (1 << BTN_4)) { // пример для BTN_4
			HID_Dev.EXT1_KB_Report.KeyCode_LO = LOBYTE(0x????); // младший байт скан-кода, из Usage Page 0xC
			HID_Dev.EXT1_KB_Report.KeyCode_HI = HIBYTE(0x????); // старший байт скан-кода, из Usage Page 0xC
			goto EXT1_Send; // сразу переходим к отправке
		}*/
		// установка неиспользованных скан-кодов в 0
		HID_Dev.EXT1_KB_Report.KeyCode_LO = 0; 
		HID_Dev.EXT1_KB_Report.KeyCode_HI = 0;
	EXT1_Send:
		// отправка USB пакета и сброс флага изменения клавиатуры при успешной отправке
		if (USB_Send_Data((uint8_t*)&HID_Dev.EXT1_KB_Report, sizeof(HID_Dev.EXT1_KB_Report), 1) == 0)
			HID_Dev.EXT1_KB_Report_changed_flag = 0;
		return;
	}
	
	// EXT2 Keyboard (Usage Page 0x1)
	if (HID_Dev.EXT2_KB_Report_changed_flag) {
		KeyCodesMAX = 7; // в данной клавиатуре одновременно могут быть нажаты до 7 клавиш
		/*if (key_mask & (1 << BTN_1)) { // пример для BTN_1
			HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = 0x??; // скан-код, из Usage Page 0x1
			if (UsedKeyCodes >= KeyCodesMAX) goto EXT2_Send; // если все 7 байт под скан-коды уже использованы - 
																											// пропускаем остальные клавиши и переходим к отправке пакета
		}*/
		/*if (key_mask & (1 << BTN_2)) { // пример для BTN_2
			HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = 0x??; // скан-код, из Usage Page 0x1
			if (UsedKeyCodes >= KeyCodesMAX) goto EXT2_Send; // если все 7 байт под скан-коды уже использованы - 
																											// пропускаем остальные клавиши и переходим к отправке пакета
		}*/
		// установка неиспользованных скан-кодов в 0
		while(UsedKeyCodes < KeyCodesMAX) HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = 0;
	EXT2_Send:
		// отправка USB пакета и сброс флага изменения клавиатуры при успешной отправке
		if (USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 1) == 0)
			HID_Dev.EXT2_KB_Report_changed_flag = 0;
		return;
	}
}

/*
	USB_Class_Init_callback вызывается при инициализации
	USB устройства драйвером.
*/
int8_t USB_Class_Init_callback(uint8_t dev_config)
{
	uint8_t i;
	for(i=0;i<sizeof(HID_Dev);i++) ((uint8_t*)&HID_Dev)[i] = 0; // типа memset
	// запись нужных ReportID в отправляемые пакеты
	HID_Dev.STD_KB_Report.ReportID = STD_KEYBOARD_REPORT_ID;
	HID_Dev.EXT1_KB_Report.ReportID = EXT1_KEYBOARD_REPORT_ID;
	HID_Dev.EXT2_KB_Report.ReportID = EXT2_KEYBOARD_REPORT_ID;
	// установка всех флагов изменения в "1" для отправки пакетов с начальным состоянием клавиш
	HID_Dev.STD_KB_Report_changed_flag = 1; 
	HID_Dev.EXT1_KB_Report_changed_flag = 1;
	HID_Dev.EXT2_KB_Report_changed_flag = 1;
	return 0;
}

/*
	USB_Class_DeInit_callback вызывается при сбросе
	USB устройства драйвером.
*/
int8_t USB_Class_DeInit_callback(void)
{
	return 0;
}

/*
	USB_Setup_Request_callback вызывается для обработки USB запросов,
	не включенных в стандартный USB стэк.
*/
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
							// Это принудительный запрос USB пакета с состоянием клавиш.
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
								// Это SETUP STAGE перед отправкой (хостом) пакета с состояниями 
								// светодиодов первой клавиатуры, см. USB_EP0_RxReady_callback
								return USB_Send_Data(NULL, 0, 0); // типа ACK
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
							// Это запрос Report дескиптора HID устройства
							return USB_Send_Data(usb_report_descriptor, (uint8_t)MIN(p_req->wLength_LO, SIZE_REPORT_DESCRIPTOR), 0);
						}
					} else 
					if (p_req->wValue_HI == TYPE_HID_DESCRIPTOR) // 0x21
					{
							// Это запрос HID дескиптора USB устройства
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

/*
 USB_EP1_RxReady_callback предназначен для обработки данных,
 принятых EP1. В данном примере не используется.
*/
void USB_EP1_RxReady_callback(uint8_t *p_data)
{
	// Nothing. Really.
}

/// MAIN ///////////////////////////////////////////////////

void main(void)
{
	Check_OPTION_BYTE();
	disableInterrupts();
	Init_Clock();
	Init_GPIO();
	Leds_init();
	Buttons_init();
	SYSTimer_Init();
	USB_Init();
	enableInterrupts();
	USB_connect(); // подключение подтяжки 1K5

	while(1)
	{
		USB_loop(); // "быстрый" цикл USB, для обработки запросов
		if (g_systimer_flag) { // 100 Hz call
			g_systimer_flag = 0;
			Buttons_loop(); // опрос кнопок
			BTN_USB_send_Loop(); // отправка USB пакетов с состоянием клавиш
			USB_slow_loop(); // "медленный" цикл USB для настройки HSI генератора
		}
	}
}





