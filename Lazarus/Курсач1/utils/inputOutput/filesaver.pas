unit fileSaver;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LinkedList;

{public declarations}
procedure writeToTextFile(var textFile : text; filename : String; commonWeather : list);
procedure readFromTextFile(var textFile : text; filename : String; var commonWeather : list);

implementation

(*
    Запись в текстовый файл
*)
procedure writeToTextFile(var textFile : text; filename : String; commonWeather : list);
var
  fullFileName : string;
  temp : list;
  settings : TFormatSettings;
    begin
         temp := commonWeather;
         fullFileName := filename + '.txt';
         assign(textfile, fullFileName);
         rewrite(textfile);
         settings.DateSeparator:='.';
         settings.LongDateFormat:='dd.mm.yyyy';
         settings.ShortDateFormat:='dd.mm.yyyy';
         while (temp <> nil)do
            begin
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
        close(textfile);
    end;

(*
    Чтение из текстового файла
*)
procedure readFromTextFile(var textFile : text; filename : String; var commonWeather : list);
var
  fullFileName : string;
  temperature, humidity, atmospherePressure : integer;
  dayForSelect : String;
  date : TDateTime;
  dayOrNight : string;
  a : string;
  settings : TFormatSettings;
    begin
      fullFileName := filename;
      assign(textfile, fullFileName);
      reset(textFile);
      settings.DateSeparator:='.';
      settings.LongDateFormat:='dd.mm.yyyy';
      settings.ShortDateFormat:='dd.mm.yyyy';
      while (not (eof(textFile))) do
        begin
          read(textfile, dayForSelect);
          date := strToDateTime(dayForSelect, settings);
          readln(textfile);
          readln(textfile, dayOrNight);
          read(textfile, temperature);
          read(textfile, humidity);
          read(textfile, atmospherePressure);
          readln(textFile);
          readln(textFile, a);
          add(commonWeather, date, dayOrNight, temperature, humidity,
                                atmospherePressure)
        end;
      close(textfile);
    end;

end.

