#include "main.h"
#include "usb.h"
#include "init.h"
#include "peripheral.h"
#include "HIDClassCommon.h"

/// GLOBAL VARS ////////////////////////////////////////////

volatile uint8_t g_systimer_400Hz_flag;
t_HID_Dev HID_Dev;
t_KeyCode* g_KeyCode = (t_KeyCode*)(KEY_SETTINGS_START_ADDR); // настройки клавиш в EEPROM

/// CALLBACKS //////////////////////////////////////////////

/*
 Write_key_settings - отложенная запись настроек клавиши.
*/
void Write_key_settings(void)
{
	if (HID_Dev.Key_settings_to_write.write_flag) { // если флаг выставлен
		if (HID_Dev.Key_settings_to_write.key_num < BTN_CNT) { // и номер правильный
			FLASH_Unlock(FLASH_MEMTYPE_DATA); // пишем в EEPROM
			g_KeyCode[HID_Dev.Key_settings_to_write.key_num].UsagePage = HID_Dev.Key_settings_to_write.KeyCode.UsagePage;
			FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
			g_KeyCode[HID_Dev.Key_settings_to_write.key_num].Modifiers = HID_Dev.Key_settings_to_write.KeyCode.Modifiers;
			FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
			g_KeyCode[HID_Dev.Key_settings_to_write.key_num].KeyCode_LO = HID_Dev.Key_settings_to_write.KeyCode.KeyCode_LO;
			FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
			g_KeyCode[HID_Dev.Key_settings_to_write.key_num].KeyCode_HI = HID_Dev.Key_settings_to_write.KeyCode.KeyCode_HI;
			FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
			FLASH_Lock(FLASH_MEMTYPE_DATA);
		}
		HID_Dev.Key_settings_to_write.write_flag = 0; // сброс флага
	}
}

/*
 USB_EP0_RxReady_callback предназначен для обработки данных,
 принятых EP0 в процессе Data stage. В данном примере,
 происходит обработка байта, устанавливающего значения 
 светодиодов первой клавиатуры (STD keyboard), а также 
 обработка пакетов записи настроек клавиши и установки 
 номера активной клавиши для чтения настроек.
 Для всех пакетов:
 BYTE 0 - Report ID (определяет функцию)
 BYTE 1..7 - данные
*/
void USB_EP0_RxReady_callback(uint8_t *p_data, uint8_t length)
{
	if (length == 0) return;
	switch(p_data[0]) // ReportID
	{
		case STD_KEYBOARD_REPORT_ID: // установка состояний светодиодов
			if (length < 2) break;
			if (p_data[1] & HID_KEYBOARD_LED_NUMLOCK) // если бит Num Lock выставлен
																Led_setmode(LED_0, LED_ON); // зажигаем светодиод LED_0
			else											Led_setmode(LED_0, LED_OFF); // иначе гасим
			if (p_data[1] & HID_KEYBOARD_LED_CAPSLOCK) // если бит Caps Lock выставлен
																Led_setmode(LED_1, LED_ON); // зажигаем светодиод LED_1
			else											Led_setmode(LED_1, LED_OFF); // иначе гасим
			if (p_data[1] & HID_KEYBOARD_LED_SCROLLLOCK) // если бит Scroll lock выставлен
																Led_setmode(LED_2, LED_ON); // зажигаем светодиод LED_2
			else											Led_setmode(LED_2, LED_OFF); // иначе гасим
			break;
		case CONFIGURE_KEYS_REPORT_ID: // запись настроек клавиши в EEPROM
			if (length < 6) break;
			if (p_data[1] < BTN_CNT) {
				if (HID_Dev.Key_settings_to_write.write_flag == 0) {
					HID_Dev.Key_settings_to_write.key_num = p_data[1];
					HID_Dev.Key_settings_to_write.KeyCode.UsagePage = p_data[2];
					HID_Dev.Key_settings_to_write.KeyCode.Modifiers = p_data[3];
					HID_Dev.Key_settings_to_write.KeyCode.KeyCode_LO = p_data[4];
					HID_Dev.Key_settings_to_write.KeyCode.KeyCode_HI = p_data[5];
					HID_Dev.Key_settings_to_write.write_flag = 6;
				}
			}
			break;
		case READ_KEYS_REPORT_ID: // установка номера активной клавиши для чтения настроек
			if (length < 2) break;
			if (p_data[1] < BTN_CNT) {
				HID_Dev.Key_settings.key_num = p_data[1];
				HID_Dev.Key_settings.KeyCode = g_KeyCode[HID_Dev.Key_settings.key_num];
			}
			break;
	}
}

/*
	EVENT_KEY_pressed - событие "кнопка нажата". key_num - номер нажатой кнопки
	EVENT_KEY_released - событие "кнопка отпущена". key_num - номер отпущенной кнопки
*/
void EVENT_KEY_pressed(uint8_t key_num) { }
void EVENT_KEY_released(uint8_t key_num) { }

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
 более пяти клавиш, передаются только скан-коды первых
 (по очереди) пяти клавиш.
 USB пакеты от расширенных клавиатур не имеют модификаторов,
 а также могут иметь расширенные скан-коды (16 бит вместо 8).
 См. типы USB_KeyboardReport_EXT1_Data_t и USB_KeyboardReport_EXT2_Data_t.
 Для более подробной информации см. документ 
 http://www.usb.org/developers/hidpage/Hut1_12v2.pdf
 Скан-коды там же.
 ***********************************************************
 Для настройки клавиши, нужно:
 1) Отправить Report (HID SET_REPORT) третьей клавиатуре (USAGE_PAGE 0x1, USAGE 0x80):
	Byte0 = CONFIGURE_KEYS_REPORT_ID
	Byte1 = номер клавиши
	Byte2 = UsagePage
	  = STD_KEYBOARD_USAGE_PAGE - первая клавиатура
		= EXT1_KEYBOARD_USAGE_PAGE - вторая клавиатура
		= EXT2_KEYBOARD_USAGE_PAGE - третья клавиатура
		Другие значения означают отсутствие принадлежности к HID клавиатрурам.
	Byte3 = биты модификаторов
	Byte4 = KeyCode_LO, младший байт скан-кода
	Byte5 = KeyCode_HI, старший байт скан-кода (только для второй клавиатуры)
 2) Подождать ~100мс, пока настройки не запишутся в EEPROM, 
	после чего проверить записанную настройку.
	При записи настроек в EEPROM, USB устройство может "отвалиться",
	т.к. во время записи прерывания работают с задержкой. В этом
	случае нужно дождаться повторного определения устройства в системе
	и снова попытаться проверить записанную настройку.
 ***********************************************************
 Для чтения настроек клавиши, нужно:
 1) Отправить Report (HID SET_REPORT) третьей клавиатуре (USAGE_PAGE 0x1, USAGE 0x80):
	Byte0 = READ_KEYS_REPORT_ID
	Byte1 = номер клавиши
 2) Отправить запрос HID GET_REPORT с ReportID = READ_KEYS_REPORT_ID
 и считать Report, в котором будут настройки указанной клавиши:
	Byte0 = READ_KEYS_REPORT_ID
	Byte1 = номер клавиши
	Byte2 = UsagePage
	Byte3 = биты модификаторов
	Byte4 = KeyCode_LO, младший байт скан-кода
	Byte5 = KeyCode_HI, старший байт скан-кода
*/
void BTN_USB_send_Loop(void)
{
	uint8_t i;
	uint8_t KeyCodesMAX;
	uint16_t key_mask = Buttons_get_mask(); // считываем битовую маску нажатых клавиш
	uint8_t UsedKeyCodes = 0; // счётчик использованных скан-кодов
	
	if (HID_Dev.prev_key_mask != key_mask) { // если состояние кнопок изменилось
		for(i=0;i<BTN_CNT;i++) { // ищем изменившиеся клавиши и выставляем нужные флаги
			if ((HID_Dev.prev_key_mask ^ key_mask) & (1 << i)) {
				switch(g_KeyCode[i].UsagePage)
				{
					case STD_KEYBOARD_USAGE_PAGE: // UsagePage клавиши соответствует первой клавиатуре
						HID_Dev.STD_KB_Report_changed_flag = 1; // состояние клавиш первой клавиатуры изменилось
						break;
					case EXT1_KEYBOARD_USAGE_PAGE: // UsagePage клавиши соответствует второй клавиатуре
						HID_Dev.EXT1_KB_Report_changed_flag = 1; // состояние клавиш второй клавиатуры изменилось
						break;
					case EXT2_KEYBOARD_USAGE_PAGE: // UsagePage клавиши соответствует третьей клавиатуре
						HID_Dev.EXT2_KB_Report_changed_flag = 1; // состояние клавиш третьей клавиатуры изменилось
						break;
				}
			}
		}
		HID_Dev.prev_key_mask = key_mask; // сохраняем состояние кнопок
	}
	
	// STD Keyboard (Usage Page 0x7)
	if (HID_Dev.STD_KB_Report_changed_flag) { // если состояние клавиш данной клавиатуры изменилось - формируем и отправляем USB пакет
		KeyCodesMAX = 5; // в данной клавиатуре одновременно могут быть нажаты до 5 клавиш (без учёта модификаторов)
		HID_Dev.STD_KB_Report.Modifier = 0; // сбрасываем байт модификаторов
		for(i=0;i<BTN_CNT;i++) { // формируем байт модификаторов
			if (key_mask & (1 << i)) { // если нажата клавиша i
				if (g_KeyCode[i].UsagePage == STD_KEYBOARD_USAGE_PAGE) { // и UsagePage клавиши соответствует первой клавиатуре
					HID_Dev.STD_KB_Report.Modifier |= g_KeyCode[i].Modifiers; // применяем маску модификаторов данной клавиши
				}
			}
		}
		
		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
			if (key_mask & (1 << i)) { // если нажата клавиша i
				if (g_KeyCode[i].UsagePage == STD_KEYBOARD_USAGE_PAGE) { // и UsagePage клавиши соответствует первой клавиатуре
					HID_Dev.STD_KB_Report.KeyCode[UsedKeyCodes++] = g_KeyCode[i].KeyCode_LO; // записываем в пакет скан-код кнопки
					if (UsedKeyCodes >= KeyCodesMAX) // если все 5 байт под скан-коды уже использованы
						goto STD_Send;	// пропускаем остальные клавиши и переходим к отправке пакета
				}
			}
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
		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
			if (key_mask & (1 << i)) { // если нажата клавиша i
				if (g_KeyCode[i].UsagePage == EXT1_KEYBOARD_USAGE_PAGE) { // UsagePage клавиши соответствует второй клавиатуре
					HID_Dev.EXT1_KB_Report.KeyCode_LO = g_KeyCode[i].KeyCode_LO; // записываем в пакет младший байт скан-кода
					HID_Dev.EXT1_KB_Report.KeyCode_HI = g_KeyCode[i].KeyCode_HI; // записываем в пакет старший байт скан-кода
					goto EXT1_Send; // сразу переходим к отправке
				}
			}
		}
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
		for(i=0;i<BTN_CNT;i++) { // для всех клавиш
			if (key_mask & (1 << i)) { // если нажата клавиша i
				if (g_KeyCode[i].UsagePage == EXT2_KEYBOARD_USAGE_PAGE) { // UsagePage клавиши соответствует третьей клавиатуре
					HID_Dev.EXT2_KB_Report.KeyCode[UsedKeyCodes++] = g_KeyCode[i].KeyCode_LO; // записываем в пакет скан-код кнопки
					if (UsedKeyCodes >= KeyCodesMAX) // если все 7 байт под скан-коды уже использованы
						goto EXT2_Send;	// пропускаем остальные клавиши и переходим к отправке пакета
				}
			}
		}
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
	HID_Dev.Key_settings.ReportID = READ_KEYS_REPORT_ID;
	// инициализация пакета с настройками клавиши
	//HID_Dev.Key_settings.key_num = 0; // активная клавиша 0
	HID_Dev.Key_settings.KeyCode = g_KeyCode[HID_Dev.Key_settings.key_num];
	HID_Dev.Key_settings_to_write.write_flag = 0; // флаг отложенной записи настроек
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
						//if (p_req->wValue_HI == HID_REPORT_FEATURE)
						if ((p_req->wValue_HI == HID_REPORT_FEATURE)||(p_req->wValue_HI == HID_REPORT_INPUT))
						{
							// Это принудительный запрос USB пакета с состоянием клавиш, либо чтение настроек активной клавиши
							switch(p_req->wValue_LO) // ReportID
							{
								case STD_KEYBOARD_REPORT_ID: // STD Keyboard
									return USB_Send_Data((uint8_t*)&HID_Dev.STD_KB_Report, sizeof(HID_Dev.STD_KB_Report), 0);
								case EXT1_KEYBOARD_REPORT_ID: // EXT1 Keyboard
									return USB_Send_Data((uint8_t*)&HID_Dev.EXT1_KB_Report, sizeof(HID_Dev.EXT1_KB_Report), 0);
								case EXT2_KEYBOARD_REPORT_ID: // EXT2 Keyboard
									return USB_Send_Data((uint8_t*)&HID_Dev.EXT2_KB_Report, sizeof(HID_Dev.EXT2_KB_Report), 0);
								case READ_KEYS_REPORT_ID: // Read key settings
									return USB_Send_Data((uint8_t*)&HID_Dev.Key_settings, sizeof(HID_Dev.Key_settings), 0);
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
							switch(p_req->wValue_LO) // ReportID
							{
								case CONFIGURE_KEYS_REPORT_ID: // запись настроек клавиши
									// Это SETUP STAGE перед отправкой (хостом) пакета с 
									// установками клавиши, см. USB_EP0_RxReady_callback
									if (HID_Dev.Key_settings_to_write.write_flag) break; // если отложенная запись уже назначена - отвечаем ошибкой
								case STD_KEYBOARD_REPORT_ID: // установка состояний светодиодов
									// Это SETUP STAGE перед отправкой (хостом) пакета с состояниями 
									// светодиодов первой клавиатуры, см. USB_EP0_RxReady_callback
								case READ_KEYS_REPORT_ID: // чтение настроек клавиши
									// Это SETUP STAGE перед отправкой (хостом) пакета с 
									// номером активной клавиши, см. USB_EP0_RxReady_callback
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
					uint16_t wLength = (uint16_t)p_req->wLength_LO | (uint16_t)((uint16_t)p_req->wLength_HI << 8);
					if (p_req->wValue_HI == TYPE_REPORT_DESCRIPTOR) // 0x22
					{
						if (p_req->wIndex_LO == INTERFACE_ID_HIDDev) {
							// Это запрос Report дескиптора HID устройства
							return USB_Send_Data(usb_report_descriptor, (uint8_t)MIN(wLength, SIZE_REPORT_DESCRIPTOR), 0);
						}
					} else 
					if (p_req->wValue_HI == TYPE_HID_DESCRIPTOR) // 0x21
					{
							// Это запрос HID дескиптора USB устройства
						return USB_Send_Data(USB_HID_descriptor, (uint8_t)MIN(wLength, SIZE_HID_DESCRIPTOR), 0);
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
void USB_EP1_RxReady_callback(uint8_t *p_data, uint8_t length)
{
	// Nothing. Really.
}

/// MAIN ///////////////////////////////////////////////////

void main(void)
{
	uint8_t counter = 0;	
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
		if (g_systimer_400Hz_flag) { // 400 Hz call
			g_systimer_400Hz_flag = 0;
			Buttons_loop(); // опрос кнопок
			counter++;
			if (counter >= 4) { // 100 Hz call
				counter = 0;
				BTN_USB_send_Loop(); // отправка USB пакетов с состоянием клавиш
				USB_slow_loop(); // "медленный" цикл USB для настройки HSI генератора и EP1 watchdog
				Write_key_settings(); // отложенная запись настроек клавиш в EEPROM
			}
		}
	}
}





