#Использовать autumn
#Использовать autumn-cli
#Использовать "."
#Использовать "../core"

Процедура УстановитьКорневойКаталог()
	ТекущийКаталог = Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "../..")).ПолноеИмя;
	УстановитьТекущийКаталог(ТекущийКаталог);
КонецПроцедуры

УстановитьКорневойКаталог();

Поделка = Новый Поделка;
Поделка.ЗапуститьПриложение();