![Image](https://github.com/user-attachments/assets/b518861e-2c68-45c0-8d50-50ad293a37b8)

**Информация о версии**
**Платформа**: 1С:Предприятие 8.3 (8.3.13.1690) (Учебная версия)
**Конфигурация**: Управление шахматной партией (1.0)
**Используются Управляемые формы.**

**Предупреждение**

Реализовано:
- Генерация элементов из справочников: фигуры, клетки;
- Документы, обозначающие перемещение фигур, повышение пешек, взятия фигур;
- Регистры, фиксирующие состояния игровых партий, регистры замен фигур;
- Отчет, отражающий состояние партии, подсказки возможных ходов.

В планах:
- Ограничение доступа к партиям, ходам по сессии пользователя;
- "Взятие на проходе" (рубка пешки при переходе через битое поле);
- Условия завершения игровой партии;
- Привести в порядок формировие документов на основании.

Инструкция по эксплуатации:
При первом запуске необходимо убедиться в наличие игровых объектов, их можно сгенерировать при помощи обработки Генератор игровых объектов. 
![Image](https://github.com/user-attachments/assets/6ce29dda-a269-4845-901c-bc37739087c1)


Для начала игры необходимо создать элемент справочника Партия:
![Image](https://github.com/user-attachments/assets/7b42485b-a5ad-4e64-8a6b-44defd40eadf)

После создания партии необхоидмо провести документ Создание партии, указав партию.
Таблица клеток и фигур заполнится автоматически:
![Image](https://github.com/user-attachments/assets/1f14a6a1-3155-4a16-a8bb-d4b43d1e0a8e)
При жалании можно изменить состав фигур, указанных в табличной части документа Создание партии.

Для управления состоянием игры можно запустить обработку Игровая комната, после указать партию:
https://github.com/user-attachments/assets/8b898d74-4650-47ec-8170-0175a55aae4d

