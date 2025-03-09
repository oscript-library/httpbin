// BSLLS:UsingHardcodeNetworkAddress-off

#Использовать autumn
#Использовать winow
#Использовать compressor
#Использовать 1connector

Перем Поделка; // Ссылка на объект Поделка (autumn)
Перем ВебСервер; // Ссылка на объект ПрикладнойВебСервер (winow)
Перем НастройкиВебСервера; // Ссылка на объект Настройки (winow)
Перем ЗапускательВебПриложения; // Ссылка на объект ЗапускательВебПриложения (winow)

Перем ЗапускатьВФоне; // Булево
Перем ОжидатьЗапуск; // Булево
Перем ТаймаутОжидания; // Количество

#Область ПрограммныйИнтерфейс

// Запускает сервис
//
// Возвращаемое значение:
//   ЭтотОбъект
Функция Запустить() Экспорт

	Если ЗапускатьВФоне Тогда
		ФоновыеЗадания.Выполнить(ЗапускательВебПриложения, "Запустить");

		Если ОжидатьЗапуск Тогда
			НачатьОжиданиеЗапуска();
		КонецЕсли;
	Иначе
		ЗапускательВебПриложения.Запустить();
	КонецЕсли;

	Возврат ЭтотОбъект;
	
КонецФункции

// Останавливает сервис
//
// Возвращаемое значение:
//   ЭтотОбъект
Функция Остановить() Экспорт
	ВебСервер.Стоп();
	Возврат ЭтотОбъект;
КонецФункции

// Возвращает адрес сервиса
//
// Возвращаемое значение:
//   Строка
Функция URL() Экспорт
	Возврат СтрШаблон("http://%1:%2", НастройкиВебСервера.ИмяХоста, НастройкиВебСервера.Порт);
КонецФункции

// Устанавливает порт сервиса
//
// Параметры:
//   Порт - Число - Номер порта
//
// Возвращаемое значение:
//   ЭтотОбъект
Функция УстановитьПорт(Порт) Экспорт
	НастройкиВебСервера.Порт = Порт;
	Возврат ЭтотОбъект;
КонецФункции

// Устанавливает хост сервиса
//
// Параметры:
//   Хост - Строка - Имя хоста / ip адрес
//
// Возвращаемое значение:
//   ЭтотОбъект
Функция УстановитьХост(Хост) Экспорт
	НастройкиВебСервера.ИмяХоста = Хост;
	Возврат ЭтотОбъект;
КонецФункции

// Запуск сервиса будет выполнен в фоновом режиме
//
// Параметры:
//  Флаг - Булево
//
// Возвращаемое значение:
//   ЭтотОбъект
Функция ЗапускатьВФоне(Флаг = Истина) Экспорт
	ЗапускатьВФоне = Флаг;
	Возврат ЭтотОбъект;
КонецФункции

// Ожидать завершение запуска сервиса, запущенного в фоновом режиме
//
// Параметры:
//  Флаг - Булево
//
// Возвращаемое значение:
//   ЭтотОбъект
Функция ОжидатьЗапуск(Флаг = Истина) Экспорт
	ОжидатьЗапуск = Флаг;
	Возврат ЭтотОбъект;
КонецФункции

// Устанавливает таймаут ожидания запуска сервиса, запущенного в фоновом режиме
//
// Параметры:
//  Таймаут - Количество - Таймаут в секундах
//
// Возвращаемое значение:
//   ЭтотОбъект
Функция УстановитьТаймаутОжидания(Таймаут) Экспорт
	ТаймаутОжидания = Таймаут;
	Возврат ЭтотОбъект;
КонецФункции

// Устанавливает задержку перед чтением сокета
//
// Параметры:
//   Задержка - Число - Задержка в миллисекундах (По умолчанию 65 мс)
//
// Возвращаемое значение:
//   ЭтотОбъект
Функция УстановитьЗадержкуПередЧтениемСокета(Задержка) Экспорт
	НастройкиВебСервера.ЗадержкаПередЧтениемСокета = Задержка;
	Возврат ЭтотОбъект;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Cервис тестирования HTTP клиента.
//
// Сервис по умолчанию запускается по адресу 127.0.0.1:3334 в фоновом режиме 
// и с ожиданием завершения запуска сервиса.
//
// Параметры:
//  ПоделкаОсени - Объект - Ссылка на объект Поделка (autumn)
&Желудь
Процедура ПриСозданииОбъекта(&Пластилин("Поделка") ПоделкаОсени = Неопределено)

	ТаймаутОжиданияПоУмолчанию = 5;

	Если ПоделкаОсени = Неопределено Тогда
		УстановитьКорневойКаталог();

		Поделка = Новый Поделка;
		Поделка.ЗапуститьПриложение();
	Иначе
		Поделка = ПоделкаОсени;
	КонецЕсли;

	ВебСервер = Поделка.НайтиЖелудь("ВебСервер");
	НастройкиВебСервера = Поделка.НайтиЖелудь("Настройки");
	ЗапускательВебПриложения = Поделка.НайтиЖелудь("ЗапускательВебПриложения");

	НастройкиВебСервера.РазмерБуфера = 0;

	УстановитьХост("127.0.0.1");
	УстановитьПорт(3334);
	УстановитьЗадержкуПередЧтениемСокета(65);
	ЗапускатьВФоне();
	ОжидатьЗапуск();
	УстановитьТаймаутОжидания(ТаймаутОжиданияПоУмолчанию);
	
КонецПроцедуры

Процедура НачатьОжиданиеЗапуска()

	Попытка
		КоннекторHTTP.Head(URL(), Новый Структура("Таймаут", ТаймаутОжидания));
	Исключение
		ВызватьИсключение СтрШаблон(
			"Не удалось запустить веб-сервер по адресу %1:%2 в течение %3 сек.",
			НастройкиВебСервера.ИмяХоста,
			НастройкиВебСервера.Порт,
			ТаймаутОжидания);
	КонецПопытки;

КонецПроцедуры

Процедура УстановитьКорневойКаталог()
	ТекущийКаталог = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "../../..")).ПолноеИмя;
	УстановитьТекущийКаталог(ТекущийКаталог);
КонецПроцедуры

#КонецОбласти