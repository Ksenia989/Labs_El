unit LinkedList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

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


{public declarations}
procedure add(var listForAdd : List; date : TDateTime; dayOrNight : String;
                             temperature : integer;
                             humidity : integer; atmospherePressure : integer
                             );
function searchListElementByDate(currentList : list; date : TDateTime) : list;


implementation

procedure readValue(var target : list; date : TDateTime; temperature : integer; humidity : integer;
                             atmospherePressure : integer; dayOrNight : string);
begin
  target^.date := date;
  target^.temperature := temperature;
  target^.humidity := humidity;
  target^.atmospherePressure := atmospherePressure;
  target^.dayOrNight := dayOrNight;
end;

procedure add(var listForAdd : List; date : TDateTime; dayOrNight : String;
                             temperature : integer;
                             humidity : integer; atmospherePressure : integer
                             );
var
  temp:List;
begin
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
end;

function searchListElementByDate(currentList : list; date : TDateTime) : list;
var
  founded : boolean;
  temp : List;
  res : List;
begin
  temp := currentList;
  founded := false;
  while ((founded = false) and (currentList^.next <> nil)) do
  begin
    if (date = temp^.date) then
    begin
      founded := true;
      res := temp;
    end;
    temp := currentList^.next;
  end;
  searchListElementByDate := temp;
end;
end.

