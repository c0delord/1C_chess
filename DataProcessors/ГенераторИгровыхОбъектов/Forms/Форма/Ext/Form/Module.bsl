﻿

&НаКлиенте
Процедура УдалитьКлетки(Команда)
	ОчиститьСправочник("Клетки");
КонецПроцедуры


&НаКлиенте
Процедура УдалитьФигуры(Команда)
	ОчиститьСправочник("Фигуры");
КонецПроцедуры


&НаСервере
Процедура ОчиститьСправочник(_Название)
	Выборка = Справочники[_Название].Выбрать();
	Пока Выборка.Следующий() Цикл
		элем = Выборка.Ссылка.ПолучитьОбъект();
		элем.Удалить();
	КонецЦикла;
КонецПроцедуры


&НаСервере
Процедура СоздатьФигуру(_Тип, _Цвет, _Ценность, _Вертикаль, _Горизонталь, _МассивКлеток)
	КлеткаПоУмолчанию = Неопределено;
	Клетки = _МассивКлеток.НайтиСтроки(Новый Структура("Горизонталь,Вертикаль", _Горизонталь, _Вертикаль));
	Если Клетки.Количество() = 1 Тогда
		КлеткаПоУмолчанию = Клетки[0];
	Иначе
        ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Ошибка поиска клетки: %1%2'"), _Горизонталь, _Вертикаль);
	КонецЕсли;
	
	новаяФигура = Справочники.Фигуры.СоздатьЭлемент();
	новаяФигура.Тип = _Тип;
	новаяФигура.Наименование = Строка(_Тип);
	новаяФигура.Цвет = _Цвет;
	новаяФигура.Ценность = _Ценность;
	новаяФигура.Символ = Механика.ПолучитьСимволФигуры(_Тип, _Цвет);
	новаяФигура.КлеткаПоУмолчанию = КлеткаПоУмолчанию.Ссылка;
	новаяФигура.Записать();
КонецПроцедуры


&НаСервере
Процедура СоздатьКлеткиНаСервере()
	ОчиститьСправочник("Клетки");
	
	цветБелый = Перечисления.Цвета.Белый;
	цветЧерный = Перечисления.Цвета.Черный;
	
	Для _вертикаль = 1 По 8 Цикл
		Для _горизонталь = 1 По 8 Цикл
			новаяКлетка = Справочники.Клетки.СоздатьЭлемент();
			новаяКлетка.Вертикаль = Механика.ЧисловВСимвол(_вертикаль);
			новаяКлетка.Горизонталь = _горизонталь;
			новаяКлетка.Наименование = новаяКлетка.Вертикаль + новаяКлетка.Горизонталь;
			
			Если (_вертикаль % 2) = (_горизонталь % 2) Тогда
				новаяКлетка.Цвет = цветЧерный; 
			Иначе
				новаяКлетка.Цвет = цветБелый;
			КонецЕсли;
			новаяКлетка.Записать();
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры


&НаКлиенте
Процедура СоздатьКлетки(Команда)
	СоздатьКлеткиНаСервере();
КонецПроцедуры


&НаСервере
Процедура СоздатьФигурыНаСервере()
	ОчиститьСправочник("Фигуры");
	
		Запрос = Новый Запрос();
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Клетки.Ссылка КАК Ссылка,
		|	Клетки.Горизонталь КАК Горизонталь,
		|	Клетки.Вертикаль КАК Вертикаль
		|ИЗ
		|	Справочник.Клетки КАК Клетки";	
	Клетки = Запрос.Выполнить().Выгрузить();
	
	
	_фигура = Перечисления.ТипыФигур.Ладья;
	_цвет	= Перечисления.Цвета.Белый;
	СоздатьФигуру(Перечисления.ТипыФигур.Ладья, Перечисления.Цвета.Белый, 5.0, "A", 1, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Ладья, Перечисления.Цвета.Белый, 5.0, "H", 1, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Конь, Перечисления.Цвета.Белый, 3.0, "B", 1, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Конь, Перечисления.Цвета.Белый, 3.0, "G", 1, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Слон, Перечисления.Цвета.Белый, 3.0, "C", 1, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Слон, Перечисления.Цвета.Белый, 3.0, "F", 1, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Ферзь, Перечисления.Цвета.Белый, 10.0, "D", 1, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Король, Перечисления.Цвета.Белый, 0.0, "E", 1, Клетки);
	Для _вертикаль = 1 По 8 Цикл
		СоздатьФигуру(Перечисления.ТипыФигур.Пешка, Перечисления.Цвета.Белый, 1.0, Механика.ЧисловВСимвол(_вертикаль), 2, Клетки);
	КонецЦикла;
		
	СоздатьФигуру(Перечисления.ТипыФигур.Ладья, Перечисления.Цвета.Черный, 5.0, "A", 8, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Ладья, Перечисления.Цвета.Черный, 5.0, "H", 8, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Конь, Перечисления.Цвета.Черный, 3.0, "B", 8, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Конь, Перечисления.Цвета.Черный, 3.0, "G", 8, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Слон, Перечисления.Цвета.Черный, 3.0, "C", 8, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Слон, Перечисления.Цвета.Черный, 3.0, "F", 8, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Ферзь, Перечисления.Цвета.Черный, 10.0, "D", 8, Клетки);
	СоздатьФигуру(Перечисления.ТипыФигур.Король, Перечисления.Цвета.Черный, 0.0, "E", 8, Клетки);
	Для _вертикаль = 1 По 8 Цикл
		СоздатьФигуру(Перечисления.ТипыФигур.Пешка, Перечисления.Цвета.Черный, 1.0, Механика.ЧисловВСимвол(_вертикаль), 7, Клетки);
	КонецЦикла;

КонецПроцедуры


&НаКлиенте
Процедура СоздатьФигуры(Команда)
	СоздатьФигурыНаСервере();
КонецПроцедуры

