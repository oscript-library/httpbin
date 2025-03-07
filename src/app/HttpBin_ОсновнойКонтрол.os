#Использовать "../internal"

Перем Помощник; // см. ПомощникПодготовкиОтветов
Перем КаталогШаблонов; // Строка

#Область ТочкиМаршрута

&Отображение("./src/app/view/index.html")
&ТочкаМаршрута("/")
&GET
Процедура Главная(Ответ) Экспорт

КонецПроцедуры

&Отображение("./src/app/view/moby.html")
&ТочкаМаршрута("html")
&GET
Процедура ТочкаHtml(Ответ) Экспорт

КонецПроцедуры

&ТочкаМаршрута("robots.txt")
&GET
Процедура ТочкаRobots(Ответ) Экспорт

	Ответ.ТелоТекст = Помощник.ТекстRobots;

КонецПроцедуры

&ТочкаМаршрута("deny")
&GET
Процедура ТочкаDeny(Ответ) Экспорт

	Ответ.ТелоТекст = Помощник.ASCII_Deny;
	Ответ.Заголовки.Удалить("Content-Type");

КонецПроцедуры

&ТочкаМаршрута("ip")
&GET
Процедура ТочкаIP(Запрос, Ответ) Экспорт
	
	Адрес = Помощник.ЗначениеЗаголовка(Запрос.Заголовки, "X-Forwarded-For");
	Если Не ЗначениеЗаполнено(Адрес) Тогда
		Адрес = Запрос.АдресУдаленногоУзла;
	КонецЕсли;

	Подстрока = "::ffff:"; // BSLLS:UsingHardcodeNetworkAddress-off
	Если СтрНачинаетсяС(Адрес, Подстрока) Тогда
		Адрес = Сред(Адрес, СтрДлина(Подстрока) + 1);
	КонецЕсли;

	Результат = Новый Соответствие();
	Результат.Вставить("origin", Адрес);

	Помощник.ЗаполнитьОтветJson(Ответ, Результат);

КонецПроцедуры

&ТочкаМаршрута("uuid")
&GET
Процедура ТочкаUuid(Ответ) Экспорт

	Данные = Новый Структура("uuid", Строка(Новый УникальныйИдентификатор()));

	Помощник.ЗаполнитьОтветJson(Ответ, Данные);

КонецПроцедуры

&ТочкаМаршрута("uuid/{Количество}")
&GET
Процедура ТочкаUuidN(Ответ, Знач Количество) Экспорт

	Количество = Помощник.ВЧисло(Количество);

	Массив = Новый Массив();
	Пока Количество > 0 Цикл
		Количество = Количество - 1;
		Массив.Добавить(Строка(Новый УникальныйИдентификатор()));
	КонецЦикла;

	Данные = Новый Структура("uuid", Массив);

	Помощник.ЗаполнитьОтветJson(Ответ, Данные);

КонецПроцедуры

&ТочкаМаршрута("headers")
&GET
Процедура ТочкаHeaders(Запрос, Ответ) Экспорт

	Данные = Помощник.ПолучитьДанныеЗапроса("headers", Запрос);
	Помощник.ЗаполнитьОтветJson(Ответ, Данные);

КонецПроцедуры

&ТочкаМаршрута("user-agent")
&GET
Процедура ТочкаUserAgent(Запрос, Ответ) Экспорт

	UserAgent = Помощник.ЗначениеЗаголовка(Запрос.Заголовки, "User-Agent");
	
	Результат = Новый Соответствие();
	Результат.Вставить("user-agent", UserAgent);

	Помощник.ЗаполнитьОтветJson(Ответ, Результат);

КонецПроцедуры

&ТочкаМаршрута("get")
&GET
Процедура ТочкаGet(Запрос, Ответ) Экспорт
	ПередатьДанныеВОтветJsonGet(Запрос, Ответ);
КонецПроцедуры

&ТочкаМаршрута("anything")
Процедура ТочкаAnything(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ) Экспорт
	
	Данные = Помощник.ПолучитьДанныеЗапроса("args, data, files, form, headers, json, method, origin, url", 
		Запрос, 
		ДанныеФормы, 
		ТелоЗапросОбъект);
	
	Помощник.ЗаполнитьОтветJson(Ответ, Данные);

КонецПроцедуры

&ТочкаМаршрута("post")
&POST
Процедура ТочкаPost(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ) Экспорт
	ПередатьПолныеДанныеВОтветJson(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ);
КонецПроцедуры

&ТочкаМаршрута("put")
&PUT
Процедура ТочкаPut(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ) Экспорт
	ПередатьПолныеДанныеВОтветJson(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ);
КонецПроцедуры

&ТочкаМаршрута("patch")
&PATCH
Процедура ТочкаPatch(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ) Экспорт
	ПередатьПолныеДанныеВОтветJson(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ);
КонецПроцедуры

&ТочкаМаршрута("delete")
&DELETE
Процедура ТочкаDelete(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ) Экспорт
	ПередатьПолныеДанныеВОтветJson(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ);
КонецПроцедуры

&ТочкаМаршрута("redirect/{Количество}")
&GET
Процедура ТочкаRedirect(ПараметрыЗапросаИменные, Ответ, Количество) Экспорт

	ПередаватьАбсолютныйПуть = НРег(ПараметрыЗапросаИменные.Получить("absolute")) = "true";

	Redirect(Количество, ПередаватьАбсолютныйПуть, Ответ);

КонецПроцедуры

&ТочкаМаршрута("redirect-to")
Процедура ТочкаRedirectTo(Запрос, ДанныеФормы, Ответ) Экспорт

	Данные = Помощник.ПолучитьДанныеЗапроса("args, form", Запрос, ДанныеФормы);
	
	Если Запрос.Метод = "GET" Тогда
		URL = Данные["args"].Получить("url");
		КодСостояния = Помощник.ВЧисло(Данные["args"].Получить("status_code"));
	Иначе
		URL = Данные["form"].Получить("url");
		КодСостояния = Помощник.ВЧисло(Данные["form"].Получить("status_code"));
	КонецЕсли;

	Если КодСостояния >= 300 И КодСостояния < 400 Тогда
		Ответ.УстановитьСостояние(КодСостояния);
	Иначе
		Ответ.УстановитьСостояние(302);
	КонецЕсли;
	
	Ответ.Заголовки["Location"] = URL;

КонецПроцедуры

&ТочкаМаршрута("relative-redirect/{Количество}")
&GET
Процедура ТочкаRelativeRedirect(Ответ, Количество) Экспорт
	
	Redirect(Количество, Ложь, Ответ);

КонецПроцедуры

&ТочкаМаршрута("absolute-redirect/{Количество}")
&GET
Процедура ТочкаAbsoluteRedirect(Ответ, Количество) Экспорт
	
	Redirect(Количество, Истина, Ответ);

КонецПроцедуры

&ТочкаМаршрута("status/{КодыСостояний}")
Процедура ТочкаStatus(Ответ, КодыСостояний) Экспорт
	
	Если Не СтрНайти(КодыСостояний, ",") Тогда
		
		КодСостояния = Помощник.ВЧисло(КодыСостояний);
		Если КодСостояния = 0 Тогда
			Ответ.УстановитьСостояние(400);
			Ответ.ТелоТекст = "Invalid status code";
		КонецЕсли;

	Иначе

		ВзвешенныйСписок = Новый Массив();
		Для каждого Строка Из СтрРазделить(КодыСостояний, ",") Цикл
			Подстроки = СтрРазделить(Строка, ":");
			Если Подстроки.Количество() = 1 Тогда
				КодСостояния = Строка;
				Вес = 1;
			Иначе
				КодСостояния = Подстроки[0];
				Вес = Помощник.ВЧисло(Подстроки[1]);
			КонецЕсли;

			КодСостояния = Помощник.ВЧисло(КодСостояния);
			Если КодСостояния = 0 Тогда
				Ответ.УстановитьСостояние(400);
				Ответ.ТелоТекст = "Invalid status code";
				Возврат;
			КонецЕсли;	

			ВзвешенныйСписок.Добавить(Новый Структура("Значение, Вес", КодСостояния, Вес));
		КонецЦикла;

		КодСостояния = Помощник.ВыбратьСлучайныйЭлементСУчетомВеса(ВзвешенныйСписок);

	КонецЕсли;

	Помощник.ЗаполнитьОтветПоСостоянию(Ответ, КодСостояния);

КонецПроцедуры

&ТочкаМаршрута("response-headers")
&GET
&POST
Процедура ТочкаResponseHeaders(Запрос, Ответ) Экспорт

	Ответ.УстановитьТипКонтента("json");

	Данные = Новый Соответствие();
	Помощник.ДополнитьСоответствие(Данные, Ответ.Заголовки);
	Помощник.ДополнитьСоответствие(Данные, Запрос.ПараметрыИменные);

	Помощник.ЗаполнитьОтветJson(Ответ, Данные);

КонецПроцедуры

&ТочкаМаршрута("cookies")
&GET
Процедура ТочкаCookies(КукиЗапроса, Ответ) Экспорт

	Куки = Новый Соответствие();
	Для Каждого Элемент Из КукиЗапроса.Получить() Цикл
		Куки.Вставить(Элемент.Ключ, Элемент.Значение.Значение);
	КонецЦикла;
	Куки.Удалить("SessionID");

	Помощник.ЗаполнитьОтветJson(Ответ, Новый Структура("cookies", Куки));

КонецПроцедуры

&ТочкаМаршрута("cookies/set/{Имя}/{Значение}")
&GET
Процедура ТочкаSetCookie(Ответ, Имя, Значение) Экспорт
	
	Ответ.Куки.Добавить(Имя, Значение);
	Ответ.Перенаправить("/cookies");

КонецПроцедуры

&ТочкаМаршрута("cookies/set")
&GET
Процедура ТочкаSetCookies(ПараметрыЗапросаИменные, Ответ) Экспорт
	
	Для Каждого Параметр Из ПараметрыЗапросаИменные Цикл
		Ответ.Куки.Добавить(Параметр.Ключ, Параметр.Значение);
	КонецЦикла;

	Ответ.Перенаправить("/cookies");

КонецПроцедуры

&ТочкаМаршрута("cookies/delete")
&GET
Процедура ТочкаDeleteCookies(ПараметрыЗапросаИменные, Ответ) Экспорт
	
	Для Каждого Параметр Из ПараметрыЗапросаИменные Цикл
		Кука = Ответ.Куки.Добавить(Параметр.Ключ, "");
		Кука.ДатаИстечения = Дата(1970, 1, 1);
	КонецЦикла;

	Ответ.Перенаправить("/cookies");

КонецПроцедуры

&Отображение("./src/app/view/forms-post.html")
&ТочкаМаршрута("forms/post")
&GET
Процедура ТочкаFormsPost(Ответ) Экспорт

	Ответ.Модель = Новый Структура();
	Ответ.Модель.Вставить("Адрес", "/post");

КонецПроцедуры

&ТочкаМаршрута("basic-auth/{ИмяПользователя}/{Пароль}")
&GET
Процедура ТочкаBasicAuth(Запрос, Ответ, ИмяПользователя, Пароль) Экспорт
	
	ДанныеАутентификации = Помощник.ДанныеАутентификации(Запрос);

	Если ДанныеАутентификации.Тип = "basic"
		И ДанныеАутентификации.ИмяПользователя = ИмяПользователя
		И ДанныеАутентификации.Пароль = Пароль Тогда
		Помощник.ЗаполнитьОтветJson(Ответ, Новый Структура("authenticated, user", Истина, ИмяПользователя));
	Иначе
		Помощник.ЗаполнитьОтветПоСостоянию(Ответ, 401);
	КонецЕсли;

КонецПроцедуры

&ТочкаМаршрута("hidden-basic-auth/{ИмяПользователя}/{Пароль}")
&GET
Процедура ТочкаHiddenBasicAuth(Запрос, Ответ, ИмяПользователя, Пароль) Экспорт
	
	ДанныеАутентификации = Помощник.ДанныеАутентификации(Запрос);

	Если ДанныеАутентификации.Тип = "basic"
		И ДанныеАутентификации.ИмяПользователя = ИмяПользователя
		И ДанныеАутентификации.Пароль = Пароль Тогда
		Помощник.ЗаполнитьОтветJson(Ответ, Новый Структура("authenticated, user", Истина, ИмяПользователя));
	Иначе
		Ответ.УстановитьСостояние(404);
	КонецЕсли;

КонецПроцедуры

&ТочкаМаршрута("bearer")
&GET
Процедура ТочкаBearer(Запрос, Ответ) Экспорт
	
	ДанныеАутентификации = Помощник.ДанныеАутентификации(Запрос);

	Если ДанныеАутентификации.Тип = "bearer" Тогда
		Помощник.ЗаполнитьОтветJson(Ответ, Новый Структура("authenticated, token", Истина, ДанныеАутентификации.Токен));
	Иначе
		Ответ.Заголовки["WWW-Authenticate"] = "Bearer";
		Ответ.УстановитьСостояние(401);
	КонецЕсли;

КонецПроцедуры

&ТочкаМаршрута("delay/{Секунд}")
Процедура ТочкаDelay(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ, Секунд) Экспорт

	Секунд = Помощник.ВЧисло(Секунд);
	Приостановить(Секунд * 1000);

	ПередатьПолныеДанныеВОтветJson(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ);

КонецПроцедуры

&ТочкаМаршрута("base64/{Строка}")
&GET
Процедура ТочкаBase64(Ответ, Строка) Экспорт

	Попытка
		Ответ.ТелоТекст = ПолучитьСтрокуИзДвоичныхДанных(Base64Значение(Строка));
	Исключение
		Ответ.ТелоТекст = "Incorrect Base64 data try: SFRUUEJJTiBpcyBhd2Vzb21l";
	КонецПопытки;

КонецПроцедуры

&ТочкаМаршрута("cache")
&GET
Процедура ТочкаCache(Запрос, Ответ) Экспорт

	ЕстьЗаголовки = Помощник.ЗначениеЗаголовка(Запрос.Заголовки, "If-Modified-Since") <> Неопределено
		Или Помощник.ЗначениеЗаголовка(Запрос.Заголовки, "If-None-Match") <> Неопределено;

	Если Не ЕстьЗаголовки Тогда
		Ответ.Заголовки["Last-Modified"] = Помощник.HttpДата();
		Ответ.Заголовки["ETag"] = СтрЗаменить(Новый УникальныйИдентификатор(), "-", "");

		ПередатьДанныеВОтветJsonGet(Запрос, Ответ);
	Иначе
		Ответ.УстановитьСостояние(304);
	КонецЕсли;

КонецПроцедуры

&ТочкаМаршрута("cache/{Секунд}")
&GET
Процедура ТочкаУстановитьCacheControl(Запрос, Ответ, Секунд) Экспорт

	Секунд = Помощник.ВЧисло(Секунд);

	Ответ.Заголовки["Cache-Control"] = СтрШаблон("public, max-age=%1", Формат(Секунд, "ЧГ="));

	ПередатьДанныеВОтветJsonGet(Запрос, Ответ);

КонецПроцедуры

&ТочкаМаршрута("etag/{ETag}")
&GET
Процедура ТочкаETag(Запрос, Ответ, ETag) Экспорт

	ЗаголовокIfNoneMatch = Помощник.ЗначениеЗаголовка(Запрос.Заголовки, "If-None-Match");
	ЗаголовокIfMatch = Помощник.ЗначениеЗаголовка(Запрос.Заголовки, "If-Match");

	ЗначенияIfNoneMatch = Помощник.РаспаристьМногозначныйЗаголовок(ЗаголовокIfNoneMatch);
	ЗначенияIfMatch = Помощник.РаспаристьМногозначныйЗаголовок(ЗаголовокIfMatch);

	Если ЗначениеЗаполнено(ЗначенияIfNoneMatch) Тогда
		Если ЗначенияIfNoneMatch.Найти(ETag) <> Неопределено Или ЗначенияIfNoneMatch.Найти("*") <> Неопределено Тогда
			Ответ.УстановитьСостояние(304);
			Ответ.Заголовки["ETag"] = ETag;
			Возврат;
		КонецЕсли;
	ИначеЕсли ЗначениеЗаполнено(ЗначенияIfMatch) Тогда
		Если ЗначенияIfMatch.Найти(ETag) = Неопределено И ЗначенияIfMatch.Найти("*") = Неопределено Тогда
			Ответ.УстановитьСостояние(412);
			Возврат;
		КонецЕсли;		
	КонецЕсли;
	
	Ответ.Заголовки["ETag"] = ETag;

	ПередатьДанныеВОтветJsonGet(Запрос, Ответ);

КонецПроцедуры

&Отображение("./src/app/view/UTF-8-demo.txt")
&ТочкаМаршрута("encoding/utf8")
&GET
Процедура ТочкаEncodingUTF8(Запрос, Ответ) Экспорт

КонецПроцедуры

&ТочкаМаршрута("bytes/{КоличествоБайт}")
&GET
Процедура ТочкаBytes(ПараметрыЗапросаИменные, Ответ, КоличествоБайт) Экспорт

	КоличествоБайт = Помощник.ВЧисло(КоличествоБайт);

	НачальноеЧисло = ПараметрыЗапросаИменные.Получить("seed");
	Если Не НачальноеЧисло = Неопределено Тогда
		НачальноеЧисло = Помощник.ВЧисло(НачальноеЧисло);		
		ГенераторСлучайныхЧисел = Новый ГенераторСлучайныхЧисел(НачальноеЧисло);
	Иначе	
		ГенераторСлучайныхЧисел = Новый ГенераторСлучайныхЧисел();
	КонецЕсли;

	ПотокДанных = Новый ПотокВПамяти();
	ЗаписьДанных = Новый ЗаписьДанных(ПотокДанных);

	Для Сч = 1 По КоличествоБайт Цикл
		Байт = ГенераторСлучайныхЧисел.СлучайноеЧисло(0, 255);
		ЗаписьДанных.ЗаписатьБайт(Байт);
	КонецЦикла;

	ЗаписьДанных.Закрыть();

	Ответ.Заголовки.Вставить("Content-Type", "application/octet-stream");
	Ответ.ТелоДвоичныеДанные = ПотокДанных.ЗакрытьИПолучитьДвоичныеДанные();

КонецПроцедуры

&ТочкаМаршрута("links/{Количество}/{Смещение}")
&GET
Процедура ТочкаLinks(Ответ, Количество, Смещение) Экспорт

	Количество = Помощник.ВЧисло(Количество);
	Смещение = Помощник.ВЧисло(Смещение);

	Html = Новый Массив();
	Html.Добавить("<html><head><title>Links</title></head><body>");

	ШаблонСсылки = "<a href='/links/%1/%2'>%2</a> ";
	ФорматЧисла = "ЧГ=";

	Для Сч = 1 По Количество Цикл
		Если Сч = Смещение Тогда
			Html.Добавить(Формат(Сч, ФорматЧисла) + " ");
		Иначе
			Ссылка = СтрШаблон(ШаблонСсылки, 
				Формат(Количество, ФорматЧисла), 
				Формат(Сч, ФорматЧисла));

			Html.Добавить(Ссылка);
		КонецЕсли;
	КонецЦикла;

	Html.Добавить("</body></html>");

	Ответ.ТелоТекст = СтрСоединить(Html, "");

КонецПроцедуры

&ТочкаМаршрута("links/{Количество}")
&GET
Процедура ТочкаLinksRedirect(Ответ, Количество) Экспорт

	Количество = Помощник.ВЧисло(Количество);
	
	URL = СтрШаблон("/links/%1/0", Формат(Количество, "ЧГ="));
	Ответ.Перенаправить(URL);

КонецПроцедуры

&ТочкаМаршрута("image")
&GET
Процедура ТочкаImage(Запрос, Ответ) Экспорт

	Accept = Помощник.ЗначениеЗаголовка(Запрос.Заголовки, "Accept");

	Если Accept = "image/webp" Тогда
		ТочкаImageWebp(Ответ);
	ИначеЕсли Accept = "image/svg+xml" Тогда
		ТочкаImageSvg(Ответ);
	ИначеЕсли Accept = "image/jpeg" Тогда
		ТочкаImageJpeg(Ответ);
	ИначеЕсли Accept = "image/png" 
		Или Accept = "image/*"
		Или Accept = "*/*" Тогда
		ТочкаImagePng(Ответ);
	Иначе
		Помощник.ЗаполнитьОтветПоСостоянию(Ответ, 406);
	КонецЕсли;

КонецПроцедуры

&ТочкаМаршрута("image/png")
&GET
Процедура ТочкаImagePng(Ответ) Экспорт
	ОтдатьФайл("images/pig_icon.png", "image/png", Ответ);
КонецПроцедуры

&ТочкаМаршрута("image/jpeg")
&GET
Процедура ТочкаImageJpeg(Ответ) Экспорт
	ОтдатьФайл("images/jackal.jpg", "image/jpeg", Ответ);
КонецПроцедуры

&ТочкаМаршрута("image/webp")
&GET
Процедура ТочкаImageWebp(Ответ) Экспорт
	ОтдатьФайл("images/wolf_1.webp", "image/webp", Ответ);
КонецПроцедуры

&ТочкаМаршрута("image/svg")
&GET
Процедура ТочкаImageSvg(Ответ) Экспорт
	ОтдатьФайл("images/svg_logo.svg", "image/svg+xml", Ответ);
КонецПроцедуры

&Отображение("./src/app/view/sample.xml")
&ТочкаМаршрута("xml")
&GET
Процедура ТочкаXML(Ответ) Экспорт
	Ответ.Заголовки["Content-Type"] = "application/xml";
КонецПроцедуры

&ТочкаМаршрута("json")
&GET
Процедура ТочкаJson(Ответ) Экспорт

	Ответ.УстановитьТипКонтента("json");
	Ответ.ТелоТекст = "{
	|	""title"": ""Sample Slide Show"",
	|	""date"": ""date of publication"",
	|	""author"": ""Yours Truly"",
	|	""slides"": [
	|		{
	|			""type"": ""all"", ""title"": ""Wake up to WonderWidgets!""
	|		},
	|		{
	|			""type"": ""all"",
	|			""title"": ""Overview"",
	|			""items"": [
	|				""Why <em>WonderWidgets</em> are great"",
	|				""Who <em>buys</em> WonderWidgets""
	|			]
	|		}
	|	]
	|}";

КонецПроцедуры

&ТочкаМаршрута("gzip")
&GET
Процедура ТочкаGZip(Запрос, Ответ) Экспорт
	Данные = Помощник.ПолучитьДанныеЗапроса("gzipped, headers, method, origin", Запрос);
	Помощник.ЗаполнитьОтветJson(Ответ, Данные, "gzip");
КонецПроцедуры

&ТочкаМаршрута("deflate")
&GET
Процедура ТочкаDeflate(Запрос, Ответ) Экспорт
	Данные = Помощник.ПолучитьДанныеЗапроса("deflated, headers, method, origin", Запрос);
	Помощник.ЗаполнитьОтветJson(Ответ, Данные, "deflate");
КонецПроцедуры

&ТочкаМаршрута("brotli")
&GET
Процедура ТочкаBrotli(Запрос, Ответ) Экспорт
	Данные = Помощник.ПолучитьДанныеЗапроса("brotli, headers, method, origin", Запрос);
	Помощник.ЗаполнитьОтветJson(Ответ, Данные, "brotli");
КонецПроцедуры

&ТочкаМаршрута("zstd")
&GET
Процедура ТочкаZStd(Запрос, Ответ) Экспорт
	Данные = Помощник.ПолучитьДанныеЗапроса("zstd, headers, method, origin", Запрос);
	Помощник.ЗаполнитьОтветJson(Ответ, Данные, "zstd");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&Контроллер("/")
Процедура ПриСозданииОбъекта(&Пластилин("ПомощникПодготовкиОтветов") ПомощникПодготовкиОтветов)

	Помощник = ПомощникПодготовкиОтветов;
	КаталогШаблонов = "./src/app/view";

КонецПроцедуры

Процедура Redirect(Количество, ПередаватьАбсолютныйПуть, Ответ)
	
	Количество = Помощник.ВЧисло(Количество);

	Если Количество <= 0 Тогда
		Ответ.УстановитьСостояние(404);
		Возврат;
	КонецЕсли;

	Если Количество = 1 Тогда
		Путь = "/get";
	Иначе
		Путь = СтрШаблон("/%1-redirect/%2", 
			?(ПередаватьАбсолютныйПуть, "absolute", "relative"),
			Формат(Количество - 1, "ЧГ="));	
	КонецЕсли;

	Если ПередаватьАбсолютныйПуть Тогда
		Адрес = Помощник.ПолучитьURL(Путь);
	Иначе
		Адрес = Путь;
	КонецЕсли;

	Ответ.Перенаправить(Адрес);

КонецПроцедуры

Процедура ПередатьДанныеВОтветJsonGet(Запрос, Ответ)
	Данные = Помощник.ПолучитьДанныеЗапроса("args, headers, origin, url", Запрос);
	Помощник.ЗаполнитьОтветJson(Ответ, Данные);
КонецПроцедуры

Процедура ПередатьПолныеДанныеВОтветJson(Запрос, ДанныеФормы, ТелоЗапросОбъект, Ответ)
	Данные = Помощник.ПолучитьДанныеЗапроса("args, data, files, form, headers, json, origin, url", 
		Запрос, 
		ДанныеФормы, 
		ТелоЗапросОбъект);
	
	Помощник.ЗаполнитьОтветJson(Ответ, Данные);
КонецПроцедуры

Процедура ОтдатьФайл(Путь, ТипКонтента, Ответ)

	Разделитель = ПолучитьРазделительПути();
	ПутьКФайлу = КаталогШаблонов + Разделитель + Путь;

	Ответ.Заголовки["Content-Type"] = ТипКонтента;
	Ответ.ТелоДвоичныеДанные = Новый ДвоичныеДанные(ПутьКФайлу);	

КонецПроцедуры

#КонецОбласти