unit LinkedList;

{$mode objfpc}{$H+}

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

function searchMaxListElementByDayMonth(curList : list; dayIndex : integer; monthIndex : integer) : list;
var
  founded : boolean;
  max : list;
  curDay, curMonth, curYear : word;
  temperature : integer;
begin
  founded := false;
  max := nil;
  // minint = -maxint
  temperature := -maxint;
  while((curList^.next <> nil) and (not founded)) do
  begin
    decodeDate(curList^.date, curYear, curMonth, curDay);
    if ((curDay = dayIndex) and (curMonth = monthIndex) and (curList^.temperature > temperature)) then
    begin
      max := curList;
      founded := true;
    end;
    curList := curList^.next;
  end;
  searchMaxListElementByDayMonth := max;
end;

function searchMinListElementByDayMonth(curList : list; dayIndex : integer; monthIndex : integer) : list;
var
  founded : boolean;
  min : list;
  curDay, curMonth, curYear : word;
  temperature : integer;
begin
  founded := false;
  min := nil;
  // minint = -maxint
  temperature := maxint;
  while((curList^.next <> nil) and (not founded)) do
  begin
    decodeDate(curList^.date, curYear, curMonth, curDay);
    if ((curDay = dayIndex) and (curMonth = monthIndex) and (curList^.temperature < temperature)) then
    begin
      min := curList;
      founded := true;
    end;
    curList := curList^.next;
  end;
  searchMinListElementByDayMonth := min;
end;

procedure readValue(var target : list; date : TDateTime; temperature : integer; humidity : integer;
                             atmospherePressure : integer; dayOrNight : string);
begin
  target^.date := date;
  target^.temperature := temperature;
  target^.humidity := humidity;
  target^.atmospherePressure := atmospherePressure;
  target^.dayOrNight := dayOrNight;
end;

procedure add(var listForAdd : List;
              date : TDateTime;
              dayOrNight : String;
              temperature : integer;
              humidity : integer;
              atmospherePressure : integer
              );
var
  temp:List;
begin
  if (not ((dayOrNight = 'День') or (dayOrNight = 'Ночь'))
       or (temperature < -50) or (temperature > 50)
       or (atmospherePressure < 720) or (atmospherePressure > 790)
       or (humidity < 0) or (humidity > 100)
       or (date < 40848) or (date > 43463))// c 1 января 1900 года до декабря 2018
  then
    showMessage('Данные в таблице не прошли по ограничениям. Проверьте их и попробуйте снова.')
  else
  begin
    //if ((dayOrNight <> 'День') or (dayOrNight <> 'Ночь') or () or () or () or ());
  // если список пуст, то создаём его первый элемент
  if (listForAdd = nil) then
  begin
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
    new(temp^.next);
    temp := temp^.next;
  end;
    // сейчас указатель на следующий элемент пуст - его нет
    temp^.next := nil;
    // заносим значения в зависимости от реализации.
    readValue(temp, date, temperature, humidity, atmospherePressure, dayOrNight);
    showMessage('Обновление данных выполнено успешно!.')
  end;
end;

procedure deleteByIndex(var list1 : list; indexForDeliting : integer);
var
  i : integer;
  temp : list;
begin
  temp := list1;  // Запоминаем начало
  i := 1; // индекс с 1, т.к. в гриде строки нумеруются с одного
  if (indexForDeliting = 1) then
    list1 := list1^.next
  else
  begin
  while(list1 <> nil) do
    begin
      if (i = indexForDeliting - 1) then // мы на предыдущем элементе
        begin
          // todo освободить память temp.next
          list1^.next := list1^.next^.next;
        end;
      list1 := list1^.next;
      inc(i)
    end;
  list1 := temp;
  end;
end;

procedure deleteFromList(var list1 : list; fromIndex : integer; toIndex : integer);
var
  i : integer;
begin
  for i := toIndex downto fromIndex do
    deleteByIndex(list1, i);
end;

function searchListElementByDate(currentList : list; date : TDateTime; dayOrNight : string) : list;
var
  founded : boolean;
  temp : List;
begin
  searchListElementByDate := nil;
  temp := currentList;
  founded := false;
  while ((founded = false) and (temp^.next <> nil)) do
  begin
    if ((date = temp^.date) and (temp^.dayOrNight = dayOrNight)) then
    begin
      founded := true;
      searchListElementByDate := temp;
    end;
    temp := temp^.next;
  end;
  if ((date = temp^.date) and (temp^.dayOrNight = dayOrNight)) then
    searchListElementByDate := temp;
end;
end.

