﻿
Процедура ОбработкаПроведения(Отказ, Режим)

	Движения.СостояниеПартии.Записывать = Истина;
	Для Каждого элем Из Доска Цикл
		Движение = Движения.СостояниеПартии.Добавить();
		Движение.Период = Дата;
		Движение.Партия = Партия;
		Движение.Клетка = элем.Клетка;
		Движение.Фигура = элем.Фигура;
	КонецЦикла;	
	
	Движения.СостояниеФигур.Записывать = Истина;
	Для Каждого элем Из Доска Цикл
		Если ЗначениеЗаполнено(элем.Фигура) Тогда
			Движение = Движения.СостояниеФигур.Добавить();
			Движение.Взята	= Ложь;
			Движение.Период = Дата;
			Движение.Партия = Партия;
			Движение.Фигура = элем.Фигура;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры
