﻿
Процедура ОбработкаПроведения(Отказ, Режим)

	ФигураНаКлеткеНазначения = Механика.НайтиФигуруПоКлетке(Дата, КлеткаНазначение, Партия);
	Если ЗначениеЗаполнено(ФигураНаКлеткеНазначения) Тогда
		Сообщить("Клетка назначения (" 
					+ Строка(КлеткаНазначение) 
					+ ") занята фигурой (" 
					+ Строка(ФигураНаКлеткеНазначения) 
					+ ") необходим документ Взятия фигуры.");   
		Отказ = Истина;
	КонецЕсли;

	
	//регистр СостояниеПартии
	Движения.СостояниеПартии.Записывать = Истина;
	Движение = Движения.СостояниеПартии.Добавить();
	Движение.Период = Дата;
	Движение.Партия = Партия;
	Движение.Фигура = Неопределено;
	Движение.Клетка = КлеткаИсточник;
		
	
	Движение = Движения.СостояниеПартии.Добавить();
	Движение.Период = Дата;
	Движение.Партия = Партия;
	Движение.Фигура = Фигура;
	Движение.Клетка = КлеткаНазначение;

	
	// регистр ХодыИгроков
	Движения.ХодыИгроков.Записывать = Истина;
	Движение = Движения.ХодыИгроков.Добавить();
	Движение.Период 	= Дата;
	Движение.Партия 	= Партия;
	Движение.Источник 	= КлеткаИсточник;
	Движение.Назначение = КлеткаНазначение;
	Движение.Фигура 	= Фигура;
	Движение.Игрок 		= Игрок;
	
	Если Отказ Тогда
		Если ЗначениеЗаполнено(ДополнительноеДействие) Тогда
			допДок = ДополнительноеДействие.Ссылка.ПолучитьОбъект();
			допДок.УстановитьПометкуУдаления(Истина);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	Если ПараметрыЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда
		Если ЗначениеЗаполнено(ДополнительноеДействие) Тогда
			допДок = ДополнительноеДействие.Ссылка.ПолучитьОбъект();
			допДок.УстановитьПометкуУдаления(Истина);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

