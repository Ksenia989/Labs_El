unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids, Menus, ColorBox,
  LinkedList;

type

  { TWeatherForecast }

  //TStringGrid = class(grids.TStringGrid)
  //private
  //  procedure GetCbxItems(ACol, ARow: Integer; Items: TStrings);
  //end;

  TWeatherForecast = class(TForm)
    About: TButton;
    DecrementRaws: TButton;
    CleanTable: TButton;
    searchDetailInformation: TButton;
    dataFromTemplate: TButton;
    IncrementRaws: TButton;
    Label1: TLabel;
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
    procedure DecrementRawsClick(Sender: TObject);
    procedure CleanTableClick(Sender: TObject);
    procedure IncrementRawsClick(Sender: TObject);
    procedure dataFromTemplateClick(Sender: TObject);
    procedure EscapeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OpenClick(Sender: TObject);
    procedure SaveFileClick(Sender: TObject);
    procedure SaveInLinkedListClick(Sender: TObject);
    procedure searchDetailInformationClick(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);

  private
    { private declarations }

  public
    { public declarations }
    function getCommonWeather() : list;
  end;

var
  WeatherForecast: TWeatherForecast;


implementation
uses About,
     detailDayUnit;

{$R *.lfm}

const
  filename : string = '';

var
  commonWeather : list;
  tableChanged : boolean;
  textfile : text;

{ TWeatherForecast }

procedure TWeatherForecast.FormShow(Sender: TObject);
//var
  //inplace : TInplaceEditList;
begin
  StringGrid1.Cells[0,0]:= 'Дата';
  StringGrid1.Cells[1,0]:= 'День/Ночь';
  StringGrid1.Cells[2,0]:= 'Температура воздуха, C';
  StringGrid1.Cells[3,0]:= 'Влажность воздуха, %';
  StringGrid1.Cells[4,0]:= 'Атмосферное давление, мм.рт.ст';

  // Меняем ширину столбцоы
  StringGrid1.ColWidths[0]:= 100;
  StringGrid1.ColWidths[1]:= 100;
  StringGrid1.ColWidths[2]:= 170;
  StringGrid1.ColWidths[3]:= 150;
  StringGrid1.ColWidths[4]:= 230;

  //inplace := TInplaceEditList.Create(Self);
  ////inplace.DropDownRows := 5;
  //inplace.OnGetPickListitems := GetCbxItems;
  //Result := inplace;
end;

//procedure TStringGrid.GetCbxItems(ACol, ARow: Integer; Items: TStrings);
//begin
//  Items.Clear;
//  // Хоть дя каждого столбца разные данные
//  case ACol of
//  1 :
//  begin
//    Items.Add('Вариант 1');
//    Items.Add('Вариант 2');
//    Items.Add('Вариант 3');
//  end;
//  else
//  begin
//    Items.Add('Поле 1');
//    Items.Add('Поле 2');
//    Items.Add('Поле 3');
//  end;
//  end;
//end;

//function TStringGrid.GetEditStyle(ACol, ARow: Integer): TEditStyle;
//begin
//  Result := esPickList;
//end;

function TWeatherForecast.getCommonWeather() : list;
begin
  getCommonWeather := commonWeather;
end;

(*
    Запись в текстовый файл
*)
procedure writeToTextFile(filename : String);
var
  fullFileName : string;
  temp : list;
    begin
         temp := commonWeather;
         fullFileName := filename + '.txt';
         assign(textfile, fullFileName);
         rewrite(textfile);
         while (temp <> nil)do
            begin
                write(textfile, dateToStr(temp^.date));
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
procedure readFromTextFile(filename : String);
var
  fullFileName : string;
  temperature, humidity, atmospherePressure : integer;
  dayForSelect : String;
  date : TDateTime;
  dayOrNight : string;
  a : string;
    begin
      fullFileName := filename;
      assign(textfile, fullFileName);
      reset(textFile);
      while (not (eof(textFile))) do
        begin
          read(textfile, dayForSelect);
          date := strTODateTime(dayForSelect);
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

procedure fillData();
var
  temp : list;
  i : integer;
  a : string;
begin
  i := 1;
  temp := commonWeather;
  weatherForecast.StringGrid1.RowCount := 1;
  while (temp <> nil) do
  begin
    weatherForecast.StringGrid1.RowCount := weatherForecast.StringGrid1.RowCount + 1;
    weatherForecast.StringGrid1.Cells[0, i] := dateTimeTOStr(temp^.date, false);
    a := temp^.dayOrNight;
    weatherForecast.StringGrid1.Cells[1, i] := a;
    str(temp^.temperature, a);
    weatherForecast.StringGrid1.Cells[2, i] := a;
    str(temp^.humidity, a);
    weatherForecast.StringGrid1.Cells[3, i] := a;
    str(temp^.atmospherePressure, a);
    weatherForecast.StringGrid1.Cells[4, i] := a;
    inc(i);
    temp := temp^.next;
  end;
end;

procedure TWeatherForecast.OpenClick(Sender: TObject);
begin
 if OpenDialog1.Execute then begin //если диалог выполнен
 //присваиваем переменной myfile адрес и имя выбранного файла:
 fileName := OpenDialog1.FileName;
 //читаем этот файл в Memo:
 readFromTextFile(fileName);
 fillData();
 tableChanged := False; //файл только открыт, изменений еще нет
 end;
end;

procedure TWeatherForecast.AboutClick(Sender: TObject);
begin
  AboutProgram.showModal;
end;

procedure TWeatherForecast.DecrementRawsClick(Sender: TObject);
begin
  if (StringGrid1.RowCount = 1) then //do nothin
  else
     StringGrid1.RowCount := StringGrid1.RowCount - 1;
end;

procedure TWeatherForecast.CleanTableClick(Sender: TObject);
begin
  StringGrid1.RowCount := 1;
end;

procedure TWeatherForecast.IncrementRawsClick(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

procedure TWeatherForecast.dataFromTemplateClick(Sender: TObject);
var
  filename : string;
begin
  commonWeather := nil;
  filename := 'D:\Home\Desktop\Repos\Labs_El\Lazarus\Курсач1\dataTemplate.txt';
  readFromTextFile(fileName);
  fillData();
  tableChanged := False;
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
  day : TDateTime;
  dayOrNight : string;
begin
  n := StringGrid1.RowCount;
  for i := 0 to n - 2 do
  begin
    day := strToDateTime(StringGrid1.Cells[0, i + 1]);
    dayOrNight := StringGrid1.Cells[1, i + 1];
    val(StringGrid1.Cells[2, i + 1], temperature, errCode);
    val(StringGrid1.Cells[3, i + 1], humidity, errCode);
    val(StringGrid1.Cells[4, i + 1], atmospherePressure, errCode);
    LinkedList.add(commonWeather, day, dayOrNight, temperature, humidity, atmospherePressure
                                        );
  end;
end;

procedure TWeatherForecast.searchDetailInformationClick(Sender: TObject);
begin
  makeSearch.showModal;
end;

procedure TWeatherForecast.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if (ACol = 0) then value := '99.99.9999';
end;

end.

