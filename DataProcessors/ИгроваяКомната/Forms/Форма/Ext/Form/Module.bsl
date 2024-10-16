﻿&НаСервере
Процедура УстановитьЦвет(_область, _вертикаль, _цвет)
	строкаОбл = Механика.СимволВЧисло(_вертикаль) + 1;
	_область.Область(1,строкаОбл,1,строкаОбл).ЦветФона = _цвет;
КонецПроцедуры

&НаСервере
Функция ОбновитьДанныеНаСервере(_фигура = Неопределено, _источник = Неопределено)
	табДок 				= Новый ТабличныйДокумент;
	обр 				= РеквизитФормыВЗначение("Объект");
	Макет 				= обр.ПолучитьМакет("МакетПоле");
	показатьВараинты	= ЗначениеЗаполнено(_фигура) И ЗначениеЗаполнено(_источник); 
	
	Область = Макет.ПолучитьОбласть("КрайДоски");
	табДок.Вывести(Область);
	
	партия	= Объект.Партия;
	Запрос 	= Новый Запрос;
	Запрос.УстановитьПараметр("Партия", партия);
	Запрос.Текст =  "ВЫБРАТЬ
	                |	СостояниеПартииСрезПоследних.Фигура КАК Фигура,
	                |	СостояниеПартииСрезПоследних.Клетка.Горизонталь КАК КлеткаГоризонталь,
	                |	СостояниеПартииСрезПоследних.Клетка.Вертикаль КАК КлеткаВертикаль,
	                |	СостояниеПартииСрезПоследних.Клетка КАК Клетка,
	                |	СостояниеПартииСрезПоследних.Клетка.Цвет КАК КлеткаЦвет,
	                |	ВЫБОР
	                |		КОГДА СостояниеФигурСрезПоследних.ЗамененаНаСимвол <> """"
	                |			ТОГДА СостояниеФигурСрезПоследних.ЗамененаНаСимвол
	                |		ИНАЧЕ СостояниеПартииСрезПоследних.Фигура.Символ
	                |	КОНЕЦ КАК СимволФигуры
	                |ИЗ
	                |	РегистрСведений.СостояниеПартии.СрезПоследних(, Партия = &Партия) КАК СостояниеПартииСрезПоследних
	                |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СостояниеФигур.СрезПоследних КАК СостояниеФигурСрезПоследних
	                |		ПО СостояниеПартииСрезПоследних.Партия = СостояниеФигурСрезПоследних.Партия
	                |			И СостояниеПартииСрезПоследних.Фигура = СостояниеФигурСрезПоследних.Фигура
	                |
	                |УПОРЯДОЧИТЬ ПО
	                |	КлеткаВертикаль УБЫВ,
	                |	КлеткаГоризонталь УБЫВ
	                |ИТОГИ
	                |	МАКСИМУМ(Фигура),
	                |	МАКСИМУМ(Клетка),
	                |	МАКСИМУМ(КлеткаЦвет),
	                |	МАКСИМУМ(СимволФигуры)
	                |ПО
	                |	КлеткаГоризонталь,
	                |	КлеткаВертикаль";
	
	Если показатьВараинты Тогда
		Запрос.Текст = Запрос.Текст + "
					|;
					|
					|////////////////////////////////////////////////////////////////////////////////
					|ВЫБРАТЬ
					|	СостояниеПартииСрезПоследних.Фигура КАК Фигура,
					|	СостояниеПартииСрезПоследних.Клетка.Горизонталь КАК КлеткаГоризонталь,
					|	СостояниеПартииСрезПоследних.Клетка.Вертикаль КАК КлеткаВертикаль,
					|	СостояниеПартииСрезПоследних.Клетка КАК Клетка
					|ИЗ
					|	РегистрСведений.СостояниеПартии.СрезПоследних(, Партия = &Партия) КАК СостояниеПартииСрезПоследних
					|;
					|
					|////////////////////////////////////////////////////////////////////////////////
					|ВЫБРАТЬ
					|	ВЫБОР
					|		КОГДА ХодыИгроков.Регистратор ЕСТЬ NULL
					|			ТОГДА ИСТИНА
					|		ИНАЧЕ ЛОЖЬ
					|	КОНЕЦ КАК ЭтоПервыйХод,
					|	Фигуры.Ссылка КАК Фигура,
					|	СостояниеФигурСрезПоследних.ЗамененаНаТип КАК ЗамененаНаТип
					|ИЗ
					|	Справочник.Фигуры КАК Фигуры
					|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ХодыИгроков КАК ХодыИгроков
					|		ПО (Фигуры.Ссылка = ХодыИгроков.Фигура)
					|			И (ХодыИгроков.Партия = &Партия)
					|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СостояниеФигур.СрезПоследних КАК СостояниеФигурСрезПоследних
					|		ПО (СостояниеФигурСрезПоследних.Фигура = Фигуры.Ссылка
					|				И СостояниеФигурСрезПоследних.Партия = &Партия)
					|;
					|
					|////////////////////////////////////////////////////////////////////////////////
					|ВЫБРАТЬ
					|	ВЫБОР
					|		КОГДА &Игрок = Партии.Хозяин
					|			ТОГДА Партии.ЦветХозяин
					|		КОГДА &Игрок = Партии.Гость
					|			ТОГДА Партии.ЦветГость
					|	КОНЕЦ КАК ЦветИгрока
					|ИЗ
					|	Справочник.Партии КАК Партии
					|ГДЕ
					|	(Партии.Хозяин = &Игрок
					|			ИЛИ Партии.Гость = &Игрок)
					|	И Партии.Ссылка = &Партия";
		Запрос.УстановитьПараметр("Игрок", ПараметрыСеанса.ТекущийПользователь);
	КонецЕсли;
	
	МассивРезультатов 	= Запрос.ВыполнитьПакет();
	выборкаГруппировка 	= МассивРезультатов[0];
	выборкаСостояние 	= Неопределено;
	выборкаСтатусыФигур	= Неопределено;
	цветИгрока			= Неопределено;
	Если показатьВараинты Тогда
		выборкаСостояние 	= МассивРезультатов[1].Выгрузить();
		выборкаСтатусыФигур = МассивРезультатов[2].Выгрузить();
		выборкаЦветИгрока	= МассивРезультатов[3].Выгрузить();
		
		цветИгрока			= выборкаЦветИгрока[0].ЦветИгрока;
	КонецЕсли;
			
	Выборка = выборкаГруппировка.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока Выборка.Следующий() Цикл
		Если Выборка.КлеткаГоризонталь % 2 = 0 Тогда
			Область = Макет.ПолучитьОбласть("РядЧетный");
		Иначе
			Область = Макет.ПолучитьОбласть("РядНечетный");
		КонецЕсли;
		Область.параметры.Номер = Выборка.КлеткаГоризонталь; 
		
		
		ВыборкаРяд = Выборка.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам); 
		Пока ВыборкаРяд.Следующий() Цикл
			//
			типХода 	= Механика.ОпределитьТипХода(_фигура, _источник, ВыборкаРяд.Клетка, выборкаСостояние, выборкаСтатусыФигур, цветИгрока); 
			расшифровка	= Механика.СоздатьСтруктуруРасшифровки( типХода, 
																_источник,	
																ВыборкаРяд.Клетка, 
																_фигура,
																ВыборкаРяд.Фигура,
																партия);
			
			Если типХода = Перечисления.ТипыКоманд.ПеремещениеФигуры Тогда
				Если ВыборкаРяд.КлеткаЦвет = Перечисления.Цвета.Белый Тогда
					УстановитьЦвет(Область, ВыборкаРяд.КлеткаВертикаль, WebЦвета.СветлоЗеленый);
				ИначеЕсли ВыборкаРяд.КлеткаЦвет = Перечисления.Цвета.Черный Тогда
					УстановитьЦвет(Область, ВыборкаРяд.КлеткаВертикаль, WebЦвета.ТемноЗеленый);
				КонецЕсли;
			ИначеЕсли типХода = Перечисления.ТипыКоманд.ВзятиеФигуры Тогда
				УстановитьЦвет(Область, ВыборкаРяд.КлеткаВертикаль, WebЦвета.Киноварь);
			КонецЕсли;
			//
			Если ЗначениеЗаполнено(ВыборкаРяд.Фигура) Тогда
				Область.параметры[ВыборкаРяд.КлеткаВертикаль] = ВыборкаРяд.СимволФигуры;
			КонецЕсли;
			//
			Область.параметры[ВыборкаРяд.КлеткаВертикаль+"_расшифровка"] = расшифровка;
		КонецЦикла;
		табДок.Вывести(Область);
	КонецЦикла;
	
	
	Область = Макет.ПолучитьОбласть("КрайДоски");
	табДок.Вывести(Область);
	
	Поле = табДок;
КонецФункции

&НаКлиенте
Процедура ОбновитьДанные(Команда)
	ОбновитьДанныеНаСервере();	
КонецПроцедуры

&НаСервере
Процедура ПолеОбработкаРасшифровкиНаСервере(_расшифровка)
	Если _расшифровка.Тип = Перечисления.ТипыКоманд.ПеремещениеФигуры Тогда
		ОбработкаПеремещениеФигуры(_расшифровка.Фигура, _расшифровка.Назначение, _расшифровка.Источник, _расшифровка.Партия);
	ИначеЕсли _расшифровка.Тип = Перечисления.ТипыКоманд.ВзятиеФигуры Тогда
		ОбработкаВзятиеФигуры(_расшифровка.ФигураИсточник, _расшифровка.ФигураНазначение, _расшифровка.КлеткаНазначение, _расшифровка.КлеткаИсточник, _расшифровка.Партия);
	ИначеЕсли _расшифровка.Тип = Перечисления.ТипыКоманд.ВыборКлетки Тогда
		ОбработкаВыбораКлетки(_расшифровка.Источник);
	КонецЕсли;		
КонецПроцедуры

&НаСервере
Процедура ОбработкаВыбораКлетки(_источник)
	Запрос = Новый Запрос;
	Запрос.Текст =  "ВЫБРАТЬ
					|	СостояниеПартииСрезПоследних.Фигура КАК Фигура,
					|	СостояниеПартииСрезПоследних.Партия КАК Партия,
					|	СостояниеПартииСрезПоследних.Клетка КАК Клетка,
					|	СостояниеПартииСрезПоследних.Период КАК Период
					|ИЗ
					|	РегистрСведений.СостояниеПартии.СрезПоследних(
					|			,
					|			Партия = &Партия
					|				И Клетка = &Клетка) КАК СостояниеПартииСрезПоследних";
			
	Запрос.УстановитьПараметр("Партия", Объект.Партия);
	Запрос.УстановитьПараметр("Клетка", _источник);
	РезультатЗапроса = Запрос.Выполнить();	
	Выборка = РезультатЗапроса.Выбрать();
			
	Если Выборка.Следующий() Тогда
		ОбновитьДанныеНаСервере(Выборка.Фигура, _источник);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОбработкаПеремещениеФигуры(_фигура, _назначение, _источник, _партия)
	отображать 						= Константы.ОтображатьДокументы.Получить();
	
	докПеремещения 					= Документы.ПеремещениеФигуры.СоздатьДокумент();
	докПеремещения.Дата 			= ТекущаяДата();
	докПеремещения.Партия 			= _партия;
	докПеремещения.Игрок 			= ПараметрыСеанса.ТекущийПользователь;
	докПеремещения.Фигура			= _фигура;
	докПеремещения.КлеткаИсточник 	= _источник;
	докПеремещения.КлеткаНазначение = _назначение;
	
	докПеремещения.Записать(РежимЗаписиДокумента.Проведение);
	
	ОбновитьДанныеНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбработкаВзятиеФигуры(_фигура_источник, _фигура_назначение, _клетка_назначение, _клетка_источник, _партия)
	отображать 						= Константы.ОтображатьДокументы.Получить();

	докПеремещения 					= Документы.ПеремещениеФигуры.СоздатьДокумент();
	докПеремещения.Дата 			= ТекущаяДата();
	докПеремещения.Партия 			= _партия;
	докПеремещения.Игрок 			= ПараметрыСеанса.ТекущийПользователь;
	докПеремещения.Фигура			= _фигура_источник;
	докПеремещения.КлеткаИсточник 	= _клетка_источник;
	докПеремещения.КлеткаНазначение = _клетка_назначение;	
	докПеремещения.Записать(РежимЗаписиДокумента.Запись);
	
	докВзятия	= Документы.ВзятиеФигуры.СоздатьДокумент();
	докВзятия.Заполнить(докПеремещения.Ссылка);
	докВзятия.Записать(РежимЗаписиДокумента.Проведение);
	
	докПеремещения.ДополнительноеДействие 	= докВзятия.Ссылка;
	докПеремещения.Дата 					= ТекущаяДата() + 1;
	докПеремещения.Записать(РежимЗаписиДокумента.Проведение);
	
	ОбновитьДанныеНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПолеОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка, ДополнительныеПараметры)
	СтандартнаяОбработка = Ложь;
	ПолеОбработкаРасшифровкиНаСервере(Расшифровка);
КонецПроцедуры
