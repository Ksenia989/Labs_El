unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids, Menus,
  LinkedList;

type

  { TWeatherForecast }

  TWeatherForecast = class(TForm)
    About: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    menuM: TMainMenu;
    MenuItem1: TMenuItem;
    Escape: TMenuItem;
    Open: TMenuItem;
    SaveAs: TMenuItem;
    SaveFile: TMenuItem;
    SaveInLinkedList: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;

    procedure AboutClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure EscapeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure OpenClick(Sender: TObject);
    procedure SaveFileClick(Sender: TObject);
    procedure SaveInLinkedListClick(Sender: TObject);

  private
    { private declarations }

  public
    { public declarations }
  end;

var
  WeatherForecast: TWeatherForecast;

implementation
uses About;
{$R *.lfm}
const
  filename : string = '';

var
  commonWeather : list;
  tableChanged : boolean;
  //fileName : String;
  textfile : text;

{ TWeatherForecast }

(*
    Запись в текстовый файл
*)
procedure writeToTextFile(filename : String);
var
  fullFileName : string;
    begin
         fullFileName := filename + '.txt';
         assign(textfile, fullFileName);
         rewrite(textfile);
         while (commonWeather^.next <> nil)do
            begin
                write(textfile, commonWeather^.date);
                write(textfile, #13#10);
                write(textfile, commonWeather^.temperature);
                write(textfile, #13#10);
                write(textfile, commonWeather^.humidity);
                write(textfile, #13#10);
                write(textfile, commonWeather^.atmospherePressure);
                write(textfile, #13#10);
                write(textfile, #13#10);
            end;
        close(textfile);
    end;

(*
    Чтение из текстового файла
*)
function readFromTextFile() : list;
    begin
        assign(textfile, 'textfile.txt');
        reset(textfile);
        while (not (eof(textFile))) do
            begin
             read(textfile, commonWeather^.date);
             read(textfile, commonWeather^.temperature);
             read(textfile, commonWeather^.humidity);
             read(textfile, commonWeather^.atmospherePressure);
             readln(textfile);
        end;
        close(textfile);
        readFromTextFile := commonWeather;
    end;

procedure TWeatherForecast.FormShow(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:= 'Дата';
  StringGrid1.Cells[1,0]:= 'Температура воздуха, C';
  StringGrid1.Cells[2,0]:= 'Влажность воздуха, %';
  StringGrid1.Cells[3,0]:= 'Атмосферное давление, мм.рт.ст';

  // Меняем высоту
  StringGrid1.ColWidths[0]:= 100;
  StringGrid1.ColWidths[1]:= 150;
  StringGrid1.ColWidths[2]:= 150;
  StringGrid1.ColWidths[3]:= 190;
end;

procedure TWeatherForecast.MenuItem1Click(Sender: TObject);
begin

end;

procedure TWeatherForecast.OpenClick(Sender: TObject);
begin    // ToDo
 if OpenDialog1.Execute then begin //если диалог выполнен
 //присваиваем переменной myfile адрес и имя выбранного файла:
 fileName := OpenDialog1.FileName;
 //читаем этот файл в Memo:
 //todo

 tableChanged := False; //файл только открыт, изменений еще нет
 end;
end;

procedure TWeatherForecast.AboutClick(Sender: TObject);
begin
  AboutProgram.showModal;
end;

procedure TWeatherForecast.Button1Click(Sender: TObject);
begin
  if (StringGrid1.RowCount = 1) then //do nothin
   else
     StringGrid1.RowCount := StringGrid1.RowCount - 1;
end;

procedure TWeatherForecast.Button2Click(Sender: TObject);
begin
  StringGrid1.RowCount := 1;
end;

procedure TWeatherForecast.Button3Click(Sender: TObject);
var
  temp : list;
  i, j : integer;
  a : string[20];
begin
  i := 1;
  j := i;
  temp := commonWeather;
  StringGrid1.RowCount := 1;
  while (temp <> nil) do
  begin
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
    StringGrid1.Cells[0, i] := temp^.date;
    str(temp^.temperature, a);
    StringGrid1.Cells[1, i] := a;
    str(temp^.humidity, a);
    StringGrid1.Cells[2, i] := a;
    str(temp^.atmospherePressure, a);
    StringGrid1.Cells[3, i] := a;
    inc(i);
    temp := temp^.next;
  end;
end;

procedure TWeatherForecast.Button4Click(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

procedure TWeatherForecast.EscapeClick(Sender: TObject);
begin
  WeatherForecast.Close;
end;

procedure TWeatherForecast.SaveFileClick(Sender: TObject);
begin
    //если изменений не было, выходим
    //if (not tableChanged) then Exit;
    //Если файл уже открывался, и в переменной myfile
    //есть его адрес и имя, просто перезаписываем этот файл:
    if fileName <> '' then
    begin
      writeToTextFile(filename);
      tableChanged := false;
      Exit; //выходим после сохранения
    end;
 {Файл новый, переменная myfile еще пуста. Дальше есть два варианта:
 пользователь выберет или укажет файл в диалоге, или не сделает этого}
 //если выбрал файл:
 if SaveDialog1.Execute then
    begin
      //прописываем адрес и имя файла в переменную:
      fileName := SaveDialog1.FileName;
      //если нет расширения *.txt то добавляем его:
      writeToTextFile(filename);
      //сохраняем табличку в указанный файл:
      tableChanged := False;
    end
 //если не выбрал файл:
 else ShowMessage('Вы не указали имя файла, файл не сохранен!');
end;

procedure TWeatherForecast.SaveInLinkedListClick(Sender: TObject);
var
  i : integer;
  errCode : integer;
  n : integer;
  temperature, humidity, atmospherePressure : integer;
  date : string;
begin
  n := StringGrid1.RowCount;
  for i := 0 to n - 2 do
  begin
    date := StringGrid1.Cells[0, i + 1];
    val(StringGrid1.Cells[1, i + 1], temperature, errCode);
    val(StringGrid1.Cells[2, i + 1], humidity, errCode);
    val(StringGrid1.Cells[3, i + 1], atmospherePressure, errCode);
    LinkedList.add(commonWeather, date,  temperature, humidity, atmospherePressure);
  end;
end;

end.

