unit LinkedList;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils;

type
  list = ^TLinkedList;
  TLinkedList = record
    date : String[20];
    temperature : real;
    humidity : real;
    atmospherePressure : real;
    next : list;
  end;

procedure add(var listForAdd : List; date : String; temperature : real;
                             humidity : real; atmospherePressure : real);

implementation

procedure readValue(var target : list; date : String; temperature : real; humidity : real;
                             atmospherePressure : real);
begin
  target^.date := date;
  target^.temperature := temperature;
  target^.humidity := humidity;
  target^.atmospherePressure := atmospherePressure;
end;

procedure add(var listForAdd : List; date : String; temperature : real;
                             humidity : real; atmospherePressure : real);
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
  readValue(temp, date, temperature, humidity, atmospherePressure);
end;

function size(currentList : List) : integer;
    var
        i : integer;
    begin
        while (currentList <> nil) do
        begin
            currentList := currentList^.next;
            inc(i);
        end;
    end;
end.

