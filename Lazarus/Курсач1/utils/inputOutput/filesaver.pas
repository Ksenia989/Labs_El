unit fileSaver;

{$mode objfpc}{$H+}

(*
Модуль, отвечающий за сохранение файла и открытие файла
*)

interface

uses
  Classes, SysUtils, LinkedList;

{public declarations}
procedure writeToTextFile(var textFile : text; filename : String; commonWeather : list);
procedure readFromTextFileToList(var textFile : text; filename : String; var commonWeather : list);

implementation

(*
    Процедура, отвечающая за запись в текстовый файл
*)
procedure writeToTextFile(var textFile : text; filename : String; commonWeather : list);
var
  temp : list;
  settings : TFormatSettings;
    begin
         // временная переменная для того, чтобы начало списка не потерялось
         temp := commonWeather;
         //если нет расширения *.txt то добавляем его:
         if (not fileName.Contains('.txt')) then
            filename := filename + '.txt';
         // ассоциируем имя файла с физическим файлом
         assign(textfile, filename);
         // открываем файл для чтения
         rewrite(textfile);
         // задаём разделители для даты и её формат
         settings.DateSeparator:='.';
         settings.LongDateFormat:='dd.mm.yyyy';
         settings.ShortDateFormat:='dd.mm.yyyy';
         // проходим по всем элементам списка
         while (temp <> nil)do
            begin
                // записываем в файл с разделителями в виде Enter
                write(textfile, dateTimeToStr(temp^.date, settings, false));
                write(textfile, #13#10);
                write(textfile, temp^.dayOrNight);
                write(textfile, #13#10);
                write(textfile, temp^.temperature);
                write(textfile, #13#10);
                write(textfile, temp^.humidity);
                write(textfile, #13#10);
                write(textfile, temp^.atmospherePressure);
                write(textfile, #13#10);
                write(textfile, #13#10);
                temp := temp^.next;
            end;
        // закрываем файл
        close(textfile);
    end;

(*
    Процедура, осуществляющая чтение из текстового файла
*)
procedure readFromTextFileToList(var textFile : text; filename : String; var commonWeather : list);
var
  fullFileName : string;
  temperature, humidity, atmospherePressure : integer;
  dayForSelect : String;
  date : TDateTime;
  dayOrNight : string;
  a : string;
  settings : TFormatSettings;
    begin
      // сначала список пустой
      commonWeather := nil;
      fullFileName := filename;
      // ассоциируем имя файла с физическим файлом
      assign(textfile, fullFileName);
      // открываем файл
      reset(textFile);
      // задаём разделители для даты и её формат не чтение
      settings.DateSeparator:='.';
      settings.LongDateFormat:='dd.mm.yyyy';
      settings.ShortDateFormat:='dd.mm.yyyy';
      // проходим по всем элементам файла, пока он не закончится
      while (not (eof(textFile))) do
        begin
          // считываем все поля
          read(textfile, dayForSelect);
          date := strToDateTime(dayForSelect, settings);
          readln(textfile);
          readln(textfile, dayOrNight);
          read(textfile, temperature);
          read(textfile, humidity);
          read(textfile, atmospherePressure);
          readln(textFile);
          readln(textFile, a);
          // добавляем объект с данными полями в список
          // использован модуль List
          add(commonWeather, date, dayOrNight, temperature, humidity,
                                atmospherePressure)
        end;
      // закрываем файл
      close(textfile);
    end;

end.

