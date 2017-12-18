unit LinkedList;

{$mode objfpc}{$H+}

(*
Модуль, отвечающий за взаимодействие со списком - добавление,
удаление, поиск
*)

interface

uses
  Classes, SysUtils, Dialogs;

type
  list = ^TLinkedList;
  TLinkedList = record
    date : TDateTime;
    temperature : integer;
    humidity : integer;
    atmospherePressure : integer;
    dayOrNight : string;
    next : list;
  end;

type
  TArray30 = array [0..30] of integer;


{public declarations}
procedure add(var listForAdd : List; date : TDateTime; dayOrNight : String;
                             temperature : integer;
                             humidity : integer; atmospherePressure : integer
                             );
function searchListElementByDate(currentList : list; date : TDateTime
                             ; dayOrNight : string) : list;

procedure deleteFromList(var list1 : list; fromIndex : integer; toIndex : integer);
function searchMaxListElementByDayMonth(curList : list; dayIndex : integer; monthIndex : integer) : list;
function searchMinListElementByDayMonth(curList : list; dayIndex : integer; monthIndex : integer) : list;

implementation

(*
Функция, осуществляющая поиск максимального элемента в списке
При неудачном поиске возвращает nil
*)
function searchMaxListElementByDayMonth(curList : list; dayIndex : integer; monthIndex : integer) : list;
var
  founded : boolean;
  max : list;
  curDay, curMonth, curYear : word;
  temperature : integer;
begin
  founded := false;
  // вернуть Nil при неудачном поиске
  max := nil;
  // высчитываем максимальный элемент
  temperature := -maxint;
  // условием продолжения цикла является то, что элемент не найден и
  // в листе есть ещё элементы
  while((curList^.next <> nil) and (not founded)) do
  begin
    // декодируем дату - разбиваем на год, месяц и день
    decodeDate(curList^.date, curYear, curMonth, curDay);
    // если нашли дату, в которой температура максимальна, то она - результат
    if ((curDay = dayIndex) and (curMonth = monthIndex) and (curList^.temperature > temperature)) then
    begin
      // нашли новый максимум
      max := curList;
      founded := true;
    end;
    // переходим на следующий элемент
    curList := curList^.next;
  end;
  // присваиваем функции результат
  searchMaxListElementByDayMonth := max;
end;

(*
Функция, осуществляющая поиск минимального элемента в списке
При неудачном поиске возвращает nil
*)
function searchMinListElementByDayMonth(curList : list; dayIndex : integer; monthIndex : integer) : list;
var
  founded : boolean;
  min : list;
  curDay, curMonth, curYear : word;
  temperature : integer;
begin
  // в начале программы элемент не найден
  founded := false;
  // если не нашли минимум - то он останется наллом
  min := nil;
  temperature := maxint;
  // условиме окончания является отсутствие следующего элемента или
  // его нахождение в данном списке
  while((curList^.next <> nil) and (not founded)) do
  begin
    // декодируем дату - разбиваем на год, месяц и день
    decodeDate(curList^.date, curYear, curMonth, curDay);
    // если нашли дату, в которой температура минимальна, то она - результат
    if ((curDay = dayIndex) and (curMonth = monthIndex) and (curList^.temperature < temperature)) then
    begin
      // нашли новый минимум
      min := curList;
      founded := true;
    end;
    // переходим на следующий элемент
    curList := curList^.next;
  end;
  // присваиваем функции результат
  searchMinListElementByDayMonth := min;
end;

(*
Процедура, отвечающая за занесение значений, представленных простыми типами, в список
*)
procedure readValue(var target : list; date : TDateTime; temperature : integer; humidity : integer;
                             atmospherePressure : integer; dayOrNight : string);
begin
  // перекладываем поля в переменные
  target^.date := date;
  target^.temperature := temperature;
  target^.humidity := humidity;
  target^.atmospherePressure := atmospherePressure;
  target^.dayOrNight := dayOrNight;
end;

(*
Процедура, осуществляющая валидацию исходных данных.
При успешной валидации, они заносятся в список.
При неуспешной выходит сообщение об ошибке
*)
procedure add(var listForAdd : List;
              date : TDateTime;
              dayOrNight : String;
              temperature : integer;
              humidity : integer;
              atmospherePressure : integer
              );
var
  // переменная для удобства
  temp : List;
begin
  // валидация исходных данных согласно заданию
  if (not ((dayOrNight = 'День') or (dayOrNight = 'Ночь'))
       or (temperature < -50) or (temperature > 50)
       or (atmospherePressure < 720) or (atmospherePressure > 790)
       or (humidity < 0) or (humidity > 100)
       or (date < 40848) or (date > 43463))// c 1 января 1900 года до декабря 2018
  then
    // сообщение об ошбике, если валидация прошла неуспешно
    showMessage('Данные в таблице не прошли по ограничениям. Проверьте их и попробуйте снова.')
  else
  begin
  // если список пуст, то создаём его первый элемент
  if (listForAdd = nil) then
  begin
    // выделяем память под новый элемент
    new(listForAdd);
    temp := listForAdd;
  end
  else
  begin
    temp := listForAdd;
    // перенос указателя на последний элемент
    while (temp^.next <> nil) do
      begin
        temp:=temp^.next;
      end;
    // выделение памяти под следующий элемент
    new(temp^.next);
    // переход на следующий элемент
    temp := temp^.next;
  end;
    // сейчас указатель на следующий элемент пуст - его нет
    temp^.next := nil;
    // заносим значения в список по полям
    readValue(temp, date, temperature, humidity, atmospherePressure, dayOrNight);
  end;
end;

(*
Процедура, отвечающая за удаление элемента по индексу
*)
procedure deleteByIndex(var list1 : list; indexForDeliting : integer);
var
  i : integer;
  // временная переменная для удобства
  temp : list;
begin
  temp := list1;  // Запоминаем начало
  i := 1; // индекс с 1, т.к. в гриде строки нумеруются с одного
  // удаление первого элемента
  if (indexForDeliting = 1) then
    list1 := list1^.next
  else
  begin
  // если элемент не первый, то
  // производим процедуру удаления
  while(list1 <> nil) do
    begin
      if (i = indexForDeliting - 1) then // мы на предыдущем элементе
        begin
          // переносим указатели на последующий элемнет
          list1^.next := list1^.next^.next;
        end;
      list1 := list1^.next;
      // увеличиваем счётчик элементов
      // данное действие нам, чтобы отсчитывать строки в компоненте StringGrid
      inc(i)
    end;
  // возвращаем голову списка в исхоное состояние
  list1 := temp;
  end;
end;

(*
Процедура, осуществляющая проксирование удаления - от определённого индекса до определённого
Для удобочитаемости декомпозирована
*)
procedure deleteFromList(var list1 : list; fromIndex : integer; toIndex : integer);
var
  i : integer;
begin
  for i := toIndex downto fromIndex do
    deleteByIndex(list1, i);
end;

(*
Функция, осуществляющая поиск элемента по дате.
Если элемент не найден, возвращается nil.
Если элемент найден - возвращаем его
*)
function searchListElementByDate(currentList : list; date : TDateTime; dayOrNight : string) : list;
var
  // булевская переменная, отвечающая за то, что элемент найден
  founded : boolean;
  temp : List;
begin
  // если переменная не найдена, то Nil
  searchListElementByDate := nil;
  temp := currentList;
  // сначала элемент не найден
  founded := false;
  // условием завершения цикла является нахождение элемента или то, что список закончился
  while ((founded = false) and (temp^.next <> nil)) do
  begin
    // если у элементов совпадает дата и день или ночь, то нужный элемент найден!
    if ((date = temp^.date) and (temp^.dayOrNight = dayOrNight)) then
    begin
      // говорим, что элемент найен
      founded := true;
      searchListElementByDate := temp;
    end;
    // переходим на следующий элемент
    temp := temp^.next;
  end;
  // присваиваем функции значение найденного элемента
  if ((date = temp^.date) and (temp^.dayOrNight = dayOrNight)) then
    searchListElementByDate := temp;
end;
end.

