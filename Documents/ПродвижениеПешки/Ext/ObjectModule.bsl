﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	Движения.СостояниеФигур.Записывать = Истина;
	Движение = Движения.СостояниеФигур.Добавить();
	Движение.Период = Дата;
	Движение.Партия = Партия;
	Движение.Фигура = Пешка;
	Движение.Взята = Ложь;
	Движение.ЗамененаНаТип = НовыйТип;
	Движение.ЗамененаНаСимвол = Механика.ПолучитьСимволФигуры(НовыйТип, Пешка.Цвет);
КонецПроцедуры
