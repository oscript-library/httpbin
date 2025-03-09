#Использовать asserts
#Использовать 1connector
#Использовать compressor
#Использовать ".."

Перем HttpBin; // см. HttpBin
Перем СервисЗапущен;

Процедура ПередЗапускомТестов() Экспорт

	СервисЗапущен = Ложь;

	HttpBin = Новый HttpBin();
	HttpBin.Запустить();

	СервисЗапущен = Истина;

КонецПроцедуры

Процедура ПослеЗапускаТестов() Экспорт
	HttpBin.Остановить();
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	Если Не СервисЗапущен Тогда
		ВызватьИсключение "Сервис не запущен";
	КонецЕсли;
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Html() Экспорт

	Ответ = ВызватьМетодGET("html");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер()).Равно(3741);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Robots() Экспорт

	Ответ = ВызватьМетодGET("robots.txt");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер()).Равно(29);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Deny() Экспорт

	Ответ = ВызватьМетодGET("deny");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Не_().Заполнено();
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер()).Равно(238);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_IP() Экспорт

	Ответ = ВызватьМетодGET("ip");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()["origin"]).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Uuid() Экспорт

	Ответ = ВызватьМетодGET("uuid");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()["uuid"]).Заполнено();
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Uuid5() Экспорт

	Ответ = ВызватьМетодGET("uuid/5");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()["uuid"].Количество()).Равно(5);
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Headers() Экспорт

	Ответ = ВызватьМетодGET("headers");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()["headers"]).Заполнено();
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_UserAgent() Экспорт

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("User-Agent", "WINOW");

	Ответ = ВызватьМетодGET("user-agent", Заголовки);

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()["user-agent"]).Равно("WINOW");
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Get() Экспорт

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("User-Agent", "WINOW");

	Ответ = ВызватьМетодGET("get?param=value");
	Результат = Ответ.Json();
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["args"], "args").Заполнено();
	Ожидаем.Что(Результат["headers"], "headers").Заполнено();
	Ожидаем.Что(Результат["origin"], "origin").Заполнено();
	Ожидаем.Что(Результат["url"], "url").Заполнено();
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Anything_GET() Экспорт

	Ответ = ВызватьМетодGET("anything");
	Результат = Ответ.Json();
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["method"]).Равно("GET");
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Anything_POST() Экспорт

	Ответ = ВызватьМетод("POST", "anything");
	Результат = Ответ.Json();
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["method"]).Равно("POST");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Anything_PUT() Экспорт

	Ответ = ВызватьМетод("PUT", "anything");
	Результат = Ответ.Json();
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["method"]).Равно("PUT");
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Post_ТелоСтрока() Экспорт

	Тело = "name=Jack&age=20";

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Content-Type", "application/x-www-form-urlencoded");

	ПараметрыКоннектора = ПараметрыКоннектора(Заголовки);
	Ответ = ВызватьМетод("POST", "post", Тело, ПараметрыКоннектора);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["form"]).Заполнено();
	Ожидаем.Что(Результат["form"]["name"]).Равно("Jack");
	Ожидаем.Что(Результат["form"]["age"]).Равно("20");
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Post_ТелоДвоичныеДанные() Экспорт

	Тело = ПолучитьДвоичныеДанныеИзСтроки("name=Jack&age=20");

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Content-Type", "application/x-www-form-urlencoded");

	ПараметрыКоннектора = ПараметрыКоннектора(Заголовки);
	Ответ = ВызватьМетод("POST", "post", Тело, ПараметрыКоннектора);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["form"]).Заполнено();
	Ожидаем.Что(Результат["form"]["name"]).Равно("Jack");
	Ожидаем.Что(Результат["form"]["age"]).Равно("20");
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Post_ТелоСтрокаJson() Экспорт

	Тело = "{ 'name': 'Jack', 'age': 20 }";

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Content-Type", "application/json");

	ПараметрыКоннектора = ПараметрыКоннектора(Заголовки);
	Ответ = ВызватьМетод("POST", "post", Тело, ПараметрыКоннектора);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["json"]).Заполнено();
	Ожидаем.Что(Результат["json"]["name"]).Равно("Jack");
	Ожидаем.Что(Результат["json"]["age"]).Равно(20);
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Post_ТелоСтрокаБезТипа() Экспорт

	Тело = "HTTPBIN";

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Content-Type", "text/html");

	ПараметрыКоннектора = ПараметрыКоннектора(Заголовки);
	
	Ответ = ВызватьМетод("POST", "post", Тело, ПараметрыКоннектора);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["data"]).Равно(Тело);
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Post_Multipart() Экспорт

	Данные = Новый Соответствие();
	Данные.Вставить("Name", "Jack");

	Файлы = Новый Массив();

	Файл = Новый Структура();
	Файл.Вставить("Имя", "Text");
	Файл.Вставить("Данные", ПолучитьДвоичныеДанныеИзСтроки("HTTPBIN"));
	Файл.Вставить("ИмяФайла", "httpbin.txt");
	Файл.Вставить("Тип", "text/plain");
	Файлы.Добавить(Файл);

	Файл = Новый Структура();
	Файл.Вставить("Имя", "Binary");
	Файл.Вставить("Данные", Base64Значение(Base64ZipФайла()));
	Файл.Вставить("ИмяФайла", "httpbin.zip");
	Файл.Вставить("Тип", "application/octet-stream");
	Файлы.Добавить(Файл);

	ПараметрыКоннектора = ПараметрыКоннектора();
	ПараметрыКоннектора.Вставить("Файлы", Файлы);

	Ответ = ВызватьМетод("POST", "post", Данные, ПараметрыКоннектора);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["form"]["Name"]).Равно("Jack");
	Ожидаем.Что(Результат["files"]["Text"]).Равно("HTTPBIN");

	ДанныеВDataURI = СтрШаблон("data:application/octet-stream;base64,%1", Base64ZipФайла());
	Ожидаем.Что(Результат["files"]["Binary"]).Равно(ДанныеВDataURI);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Put() Экспорт

	ДвоичныеДанные = ПолучитьДвоичныеДанныеИзСтроки("HTTPBIN");

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Content-Type", "application/octet-stream");

	ПараметрыКоннектора = ПараметрыКоннектора(Заголовки);
	Ответ = ВызватьМетод("PUT", "put", ДвоичныеДанные, ПараметрыКоннектора);

	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["data"]).Равно("HTTPBIN");
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Patch() Экспорт

	Тело = "id=123";

	Ответ = ВызватьМетод("PATCH", "patch", Тело);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["form"]["id"]).Равно("123");
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Delete() Экспорт

	Тело = "id=123";

	Ответ = ВызватьМетод("DELETE", "delete", Тело);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["form"]["id"]).Равно("123");
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Redirect() Экспорт

	Ответ = ВызватьМетодGET("redirect/3");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_RedirectTo_GET() Экспорт

	ПараметрыЗапроса = Новый Структура("url, status_code", URL("get"), 301);
	Ответ = ВызватьМетодGET("redirect-to", , ПараметрыЗапроса);

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_RedirectTo_POST() Экспорт

	Данные = Новый Структура("url, status_code", URL("get"), 301);
	Ответ = ВызватьМетод("POST", "redirect-to", Данные);

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_RelativeRedirect() Экспорт

	Ответ = ВызватьМетодGET("relative-redirect/3");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_AbsoluteRedirect() Экспорт

	Ответ = ВызватьМетодGET("absolute-redirect/3");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Status301() Экспорт

	Ответ = ВызватьМетодGET("status/301");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Status401() Экспорт

	Ответ = ВызватьМетодGET("status/401");

	Ожидаем.Что(Ответ.КодСостояния).Равно(401);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
	Ожидаем.Что(Ответ.Заголовки["WWW-Authenticate"]).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Status402() Экспорт

	Ответ = ВызватьМетодGET("status/402");

	Ожидаем.Что(Ответ.КодСостояния).Равно(402);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
	Ожидаем.Что(Ответ.Заголовки["x-more-info"]).Заполнено();
	Ожидаем.Что(Ответ.Текст()).Равно("Fuck you, pay me!");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Status406() Экспорт

	Ответ = ВызватьМетодGET("status/406");
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(406);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["message"]).Равно("Client did not request a supported media type.");
	Ожидаем.Что(Результат["accept"]).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Status407() Экспорт

	Ответ = ВызватьМетодGET("status/407");

	Ожидаем.Что(Ответ.КодСостояния).Равно(407);
	Ожидаем.Что(Ответ.Заголовки["Proxy-Authenticate"]).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Status418() Экспорт

	Ответ = ВызватьМетодGET("status/418");

	Ожидаем.Что(Ответ.КодСостояния).Равно(418);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Не_().Заполнено();
	Ожидаем.Что(Ответ.Заголовки["x-more-info"]).Заполнено();
	Ожидаем.Что(Ответ.Текст()).Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Status_Random() Экспорт

	Ответ = ВызватьМетодGET("status/401:0.5,406:0.8,418:1");

	Ожидаем.Что("401,406,418").Содержит(Формат(Ответ.КодСостояния, "ЧГ"));

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_ResponseHeaders() Экспорт

	Ответ = ВызватьМетодGET("response-headers?HeaderName=hello");
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["HeaderName"]).Равно("hello");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Cookies() Экспорт

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Cookie", "name=httpbin");

	Ответ = ВызватьМетодGET("cookies", Заголовки);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["cookies"]["name"]).Равно("httpbin");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_CookiesSet() Экспорт

	Ответ = ВызватьМетодGET("cookies/set/name/httpbin");
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["cookies"]["name"]).Равно("httpbin");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_CookiesDelete() Экспорт

	Ответ = ВызватьМетодGET("cookies/delete?name=");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_FormsPost() Экспорт

	Ответ = ВызватьМетодGET("forms/post");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер()).Равно(1397);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_BasicAuth() Экспорт

	Base64 = Base64Строка(ПолучитьДвоичныеДанныеИзСтроки("user:secret"));

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Authorization", СтрШаблон("Basic %1", Base64));

	Ответ = ВызватьМетодGET("basic-auth/user/secret", Заголовки);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["authenticated"]).Равно(Истина);
	Ожидаем.Что(Результат["user"]).Равно("user");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_BasicAuth_401() Экспорт

	Base64 = Base64Строка(ПолучитьДвоичныеДанныеИзСтроки("user:wrong"));

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Authorization", СтрШаблон("Basic %1", Base64));

	Ответ = ВызватьМетодGET("basic-auth/user/secret", Заголовки);

	Ожидаем.Что(Ответ.КодСостояния).Равно(401);
	Ожидаем.Что(Ответ.Заголовки["WWW-Authenticate"]).Равно("Basic realm=""Fake Realm""");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_HiddenBasicAuth() Экспорт

	Base64 = Base64Строка(ПолучитьДвоичныеДанныеИзСтроки("user:secret"));

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Authorization", СтрШаблон("Basic %1", Base64));

	Ответ = ВызватьМетодGET("hidden-basic-auth/user/secret", Заголовки);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Результат["authenticated"]).Равно(Истина);
	Ожидаем.Что(Результат["user"]).Равно("user");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_HiddenBasicAuth_404() Экспорт

	Base64 = Base64Строка(ПолучитьДвоичныеДанныеИзСтроки("user:wrong"));

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Authorization", СтрШаблон("Basic %1", Base64));

	Ответ = ВызватьМетодGET("hidden-basic-auth/user/secret", Заголовки);

	Ожидаем.Что(Ответ.КодСостояния).Равно(404);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Bearer() Экспорт

	Токен = "mF_9.B5f-4.1JqM";

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Authorization", СтрШаблон("Bearer %1", Токен));

	Ответ = ВызватьМетодGET("bearer", Заголовки);

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Json()["authenticated"]).Равно(Истина);
	Ожидаем.Что(Ответ.Json()["token"]).Равно(Токен);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Bearer_401() Экспорт

	Ответ = ВызватьМетодGET("bearer");

	Ожидаем.Что(Ответ.КодСостояния).Равно(401);
	Ожидаем.Что(Ответ.Заголовки["WWW-Authenticate"]).Равно("Bearer");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Delay() Экспорт

	ЗадержкаСекунд = 0.5;
	ЗадержкаМиллисекунд = ЗадержкаСекунд * 1000;
	Погрешность = 150;

	НачалоЗамера = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Ответ = ВызватьМетодGET("delay/" + ЗадержкаСекунд);
	ПрошлоМиллисекунд = ТекущаяУниверсальнаяДатаВМиллисекундах() - НачалоЗамера;

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(ПрошлоМиллисекунд).Больше(ЗадержкаМиллисекунд);
	Ожидаем.Что(ПрошлоМиллисекунд).Меньше(ЗадержкаМиллисекунд + Погрешность);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Base64() Экспорт

	Ответ = ВызватьМетодGET("base64/SFRUUEJJTiBpcyBhd2Vzb21l");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Текст()).Равно("HTTPBIN is awesome");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Base64_Incorrect() Экспорт

	Ответ = ВызватьМетодGET("base64/123");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Текст()).Содержит("Incorrect Base64 data try");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Cache() Экспорт

	Ответ = ВызватьМетодGET("cache");

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Заголовки["Last-Modified"], "Last-Modified").Заполнено();
	Ожидаем.Что(Ответ.Заголовки["ETag"], "ETag").Заполнено();

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Cache_IfModifiedSince() Экспорт

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("If-Modified-Since", "Wed, 21 Oct 2015 07:28:00 GMT");

	Ответ = ВызватьМетодGET("cache", Заголовки);

	Ожидаем.Что(Ответ.КодСостояния).Равно(304);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Cache_IfNoneMatch() Экспорт

	Заголовки = Новый Соответствие();
	Заголовки.Вставить("If-None-Match", "*");

	Ответ = ВызватьМетодGET("cache", Заголовки);

	Ожидаем.Что(Ответ.КодСостояния).Равно(304);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_CacheControl() Экспорт

	Секунд = 3600;
	СекундТекст = Формат(Секунд, "ЧГ=");

	Ответ = ВызватьМетодGET("cache/" + СекундТекст);

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Cache-Control"]).Равно(СтрШаблон("public, max-age=%1", СекундТекст));

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_ETag_IfNoneMatch() Экспорт

	ETag = СтрЗаменить(Новый УникальныйИдентификатор(), "-", "");

	ТестовыеЗначения = Новый Соответствие();
	ТестовыеЗначения.Вставить(304, Новый Массив());
	ТестовыеЗначения.Вставить(200, Новый Массив());

	ТестовыеЗначения[304].Добавить(ETag);
	ТестовыеЗначения[304].Добавить(СтрШаблон("W/""67ab43"", ""54ed21"", ""%1""", ETag));
	ТестовыеЗначения[304].Добавить("*");
	ТестовыеЗначения[200].Добавить(Неопределено);
	ТестовыеЗначения[200].Добавить("bfc13a64729c4290ef5b2c2730249c88ca92d82d");
	ТестовыеЗначения[200].Добавить("W/""67ab43"", ""54ed21"", ""7892dd""");

	Для Каждого КлючИЗначение Из ТестовыеЗначения Цикл
		КодСостояния = КлючИЗначение.Ключ;

		Для Каждого ТестовоеЗначение Из КлючИЗначение.Значение Цикл

			Заголовки = Новый Соответствие();

			Если Не ТестовоеЗначение = Неопределено Тогда
				Заголовки.Вставить("If-None-Match", ТестовоеЗначение);
			КонецЕсли;

			Ответ = ВызватьМетодGET("etag/" + ETag, Заголовки);

			Ожидаем.Что(Ответ.КодСостояния, ТестовоеЗначение).Равно(КодСостояния);
			Ожидаем.Что(Ответ.Заголовки["ETag"]).Равно(ETag);

			Если КодСостояния = 200 Тогда
				Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
			Иначе
				Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
			КонецЕсли;

		КонецЦикла;
	КонецЦикла;

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_ETag_IfMatch() Экспорт

	ETag = СтрЗаменить(Новый УникальныйИдентификатор(), "-", "");

	ТестовыеЗначения = Новый Соответствие();
	ТестовыеЗначения.Вставить(412, Новый Массив());
	ТестовыеЗначения.Вставить(200, Новый Массив());

	ТестовыеЗначения[200].Добавить(ETag);
	ТестовыеЗначения[200].Добавить(СтрШаблон("W/""67ab43"", ""54ed21"", ""%1""", ETag));
	ТестовыеЗначения[200].Добавить("*");
	ТестовыеЗначения[200].Добавить(Неопределено);
	ТестовыеЗначения[412].Добавить("bfc13a64729c4290ef5b2c2730249c88ca92d82d");
	ТестовыеЗначения[412].Добавить("W/""67ab43"", ""54ed21"", ""7892dd""");

	Для Каждого КлючИЗначение Из ТестовыеЗначения Цикл
		КодСостояния = КлючИЗначение.Ключ;

		Для Каждого ТестовоеЗначение Из КлючИЗначение.Значение Цикл

			Заголовки = Новый Соответствие();
			
			Если Не ТестовоеЗначение = Неопределено Тогда
				Заголовки.Вставить("If-Match", ТестовоеЗначение);
			КонецЕсли;

			Ответ = ВызватьМетодGET("etag/" + ETag, Заголовки);

			Ожидаем.Что(Ответ.КодСостояния, ТестовоеЗначение).Равно(КодСостояния);

			Если КодСостояния = 200 Тогда
				Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
				Ожидаем.Что(Ответ.Заголовки["ETag"]).Равно(ETag);
			Иначе
				Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
			КонецЕсли;

		КонецЦикла;
	КонецЦикла;

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_EncodingUTF8() Экспорт

	Ответ = ВызватьМетодGET("encoding/utf8");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер()).Равно(14240);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Bytes() Экспорт

	Ответ = ВызватьМетодGET("bytes/128");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/octet-stream");
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер()).Равно(128);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Links_СоСмещением() Экспорт

	Ответ = ВызватьМетодGET("links/3/2");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
	Ожидаем.Что(Ответ.Текст()).Содержит("</a> 2 <a");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Links_БезСмещения() Экспорт

	Ответ = ВызватьМетодGET("links/3");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("text/html");
	Ожидаем.Что(Ответ.Текст()).Содержит("<a href='/links/3/1'>1</a>");

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Image_СЗаголовкомAccept() Экспорт

	ТестовыеЗначения = Новый Массив();
	ТестовыеЗначения.Добавить("image/webp;image/webp;10568");
	ТестовыеЗначения.Добавить("image/svg+xml;image/svg+xml;0");
	ТестовыеЗначения.Добавить("image/jpeg;image/jpeg;35588");
	ТестовыеЗначения.Добавить("image/png;image/png;8090");
	ТестовыеЗначения.Добавить("image/*;image/png;8090");
	ТестовыеЗначения.Добавить("*/*;image/png;8090");

	Для Каждого ТестовоеЗначение Из ТестовыеЗначения Цикл

		Подстроки = СтрРазделить(ТестовоеЗначение, ";", Истина);
		Accept = Подстроки[0];
		ContentType = Подстроки[1];
		Размер = Число(Подстроки[2]);

		Заголовки = Новый Соответствие();
		Заголовки.Вставить("Accept", Accept);

		Ответ = ВызватьМетодGET("image", Заголовки);
		
		Ожидаем.Что(Ответ.КодСостояния, Accept).Равно(200);
		Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно(ContentType);
		
		Если Размер > 0 Тогда
			Ожидаем.Что(Ответ.ДвоичныеДанные().Размер(), ContentType).Равно(Размер);
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Image_БезЗаголовкаAccept() Экспорт
	
	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Accept", ""); // Иначе коннектор устанавливает */* по умолчанию

	Ответ = ВызватьМетодGET("image", Заголовки);

	Ожидаем.Что(Ответ.КодСостояния).Равно(406);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_ImagePng() Экспорт

	ContentType = "image/png";
	Размер = 8090;

	Ответ = ВызватьМетодGET("image/png");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно(ContentType);
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер(), ContentType).Равно(Размер);
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_ImageJpeg() Экспорт

	ContentType = "image/jpeg";
	Размер = 35588;

	Ответ = ВызватьМетодGET("image/jpeg");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно(ContentType);
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер(), ContentType).Равно(Размер);
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_ImageWebp() Экспорт

	ContentType = "image/webp";
	Размер = 10568;

	Ответ = ВызватьМетодGET("image/webp");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно(ContentType);
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер(), ContentType).Равно(Размер);
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_ImageSvg() Экспорт

	ContentType = "image/svg+xml";

	Ответ = ВызватьМетодGET("image/svg");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно(ContentType);
	
КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Xml() Экспорт

	Ответ = ВызватьМетодGET("xml");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("application/xml");
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер()).Равно(523);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Json() Экспорт

	Ответ = ВызватьМетодGET("json");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Содержит("application/json");
	Ожидаем.Что(Ответ.ДвоичныеДанные().Размер()).Равно(323);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_GZip() Экспорт

	Ответ = ВызватьМетодGET("gzip");

	Парсер = Новый ПарсерJSON();
	Json = Парсер.ПрочитатьJSON(Ответ.Текст());

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Json["gzipped"]).Равно(Истина);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Deflate() Экспорт

	Ответ = ВызватьМетодGET("deflate");

	Компресор = Новый DeflateКомпрессор();
	ДвоичныеДанные = Компресор.Распаковать(Ответ.ДвоичныеДанные());
	ТестJson = ПолучитьСтрокуИзДвоичныхДанных(ДвоичныеДанные);
	Парсер = Новый ПарсерJSON();
	Json = Парсер.ПрочитатьJSON(ТестJson);

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Заголовки["Content-Encoding"]).Равно("deflate");
	Ожидаем.Что(Json["deflated"]).Равно(Истина);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Brotli() Экспорт

	Ответ = ВызватьМетодGET("brotli");

	Компресор = Новый BrotliКомпрессор();
	ДвоичныеДанные = Компресор.Распаковать(Ответ.ДвоичныеДанные());
	ТестJson = ПолучитьСтрокуИзДвоичныхДанных(ДвоичныеДанные);
	Парсер = Новый ПарсерJSON();
	Json = Парсер.ПрочитатьJSON(ТестJson);

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Заголовки["Content-Encoding"]).Равно("br");
	Ожидаем.Что(Json["brotli"]).Равно(Истина);

КонецПроцедуры

&Тест
Процедура Должен_ПроверитьТочкуМаршрута_Zstd() Экспорт

	Ответ = ВызватьМетодGET("zstd");

	Компресор = Новый ZStdКомпрессор();
	ДвоичныеДанные = Компресор.Распаковать(Ответ.ДвоичныеДанные());
	ТестJson = ПолучитьСтрокуИзДвоичныхДанных(ДвоичныеДанные);
	Парсер = Новый ПарсерJSON();
	Json = Парсер.ПрочитатьJSON(ТестJson);

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.Заголовки["Content-Type"]).Равно("application/json");
	Ожидаем.Что(Ответ.Заголовки["Content-Encoding"]).Равно("zstd");
	Ожидаем.Что(Json["zstd"]).Равно(Истина);

КонецПроцедуры

Функция ВызватьМетодGET(АдресРсесурса, Заголовки = Неопределено, ПараметрыЗапроса = Неопределено)
	
	Ответ = КоннекторHTTP.Get(URL(АдресРсесурса), ПараметрыЗапроса, ПараметрыКоннектора(Заголовки));
	Возврат Ответ;

КонецФункции

Функция ВызватьМетод(Метод, АдресРсесурса, Данные = Неопределено, ДополнительныеПараметры = Неопределено)

	Если ДополнительныеПараметры = Неопределено Тогда
		ДополнительныеПараметры = Новый Структура();
	КонецЕсли;
	
	Если Не Данные = Неопределено Тогда
		ДополнительныеПараметры.Вставить("Данные", Данные);
		HttpBin.УстановитьЗадержкуПередЧтениемСокета(400);
	КонецЕсли;

	Ответ = КоннекторHTTP.ВызватьМетод(Метод, URL(АдресРсесурса), ДополнительныеПараметры);
	HttpBin.УстановитьЗадержкуПередЧтениемСокета(65);

	Возврат Ответ;

КонецФункции

Функция URL(АдресРсесурса)
	Возврат СтрШаблон("%1/%2", HttpBin.URL(), АдресРсесурса);
КонецФункции

Функция ПараметрыКоннектора(Заголовки = Неопределено)
	ПараметрыКоннектора = Новый Структура();
	ПараметрыКоннектора.Вставить("Таймаут", 5);

	Если Не Заголовки = Неопределено Тогда
		ПараметрыКоннектора.Вставить("Заголовки", Заголовки);
	КонецЕсли;

	Возврат ПараметрыКоннектора;
КонецФункции

Функция Base64ZipФайла()
	Возврат "UEsDBAoAAAAAAEAIalpdCci4BwAAAAcAAAALAAAAaHR0cGJpbi50eHRIVFRQQklOUEsBAh8ACgAAAAAAQAhqWl0JyLgHAAAABwAAAAsAJAAAAAAAAAAgAAAAAAAAAGh0dHBiaW4udHh0CgAgAAAAAAABABgAYXX04T6R2wFhdfThPpHbAdjuOJY+kdsBUEsFBgAAAAABAAEAXQAAADAAAAAAAA==";
КонецФункции