unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids, Menus, ColorBox, Buttons,
  LinkedList, savingFileHandler;

{ TWeatherForecast }
  type

  TWeatherForecast = class(TForm)
    About: TButton;
    deleteSelected: TButton;
    DateSorting: TMenuItem;
    temperatureSorting: TMenuItem;
    SortingButton: TMenuItem;
    weekForekast: TButton;
    DecrementRaws: TButton;
    CleanTable: TButton;
    searchDetailInformation: TButton;
    IncrementRaws: TButton;
    menuM: TMainMenu;
    MenuFile: TMenuItem;
    Escape: TMenuItem;
    Open: TMenuItem;
    SaveAs: TMenuItem;
    SaveFile: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;

    procedure AboutClick(Sender: TObject);
    procedure DecrementRawsClick(Sender: TObject);
    procedure CleanTableClick(Sender: TObject);
    procedure deleteSelectedClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure IncrementRawsClick(Sender: TObject);
    procedure EscapeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DateSortingClick(Sender: TObject);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure temperatureSortingClick(Sender: TObject);
    procedure OpenClick(Sender: TObject);
    procedure SaveFileClick(Sender: TObject);
    procedure searchDetailInformationClick(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure StringGrid1SelectEditor(Sender: TObject; aCol, aRow: Integer;
      var Editor: TWinControl);
    procedure weekForekastClick(Sender: TObject);

  private
    { private declarations }

  public
    { public declarations }
    function getCommonWeather() : list;
    function getStringGrid() : TStringGrid;
  end;

var
  WeatherForecast: TWeatherForecast;


implementation
uses About,
     DetailDayUnit, fileSaver, InfoAboutPeriod, sorting;

{$R *.lfm}

const
  filename : string = '';

var
  commonWeather : list;
  tableChanged : boolean;
  textfile : text;

{ TWeatherForecast }

procedure TWeatherForecast.FormShow(Sender: TObject);
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
end;

procedure TWeatherForecast.DateSortingClick(Sender: TObject);
begin
  sortDate(stringGrid1, 0);
  //SaveInLinkedListClick
  tableChanged := true;
end;

procedure TWeatherForecast.StringGrid1EditingDone(Sender: TObject);
begin
  tableChanged := true;
end;

procedure TWeatherForecast.temperatureSortingClick(Sender: TObject);
begin
  sortInteger(StringGrid1, 2);
  //SaveInLinkedListClick
  tableChanged := true;
end;

function TWeatherForecast.getCommonWeather() : list;
begin
  getCommonWeather := commonWeather;
end;

function TWeatherForecast.getStringGrid() : TStringGrid;
begin
  getStringGrid := StringGrid1;
end;

procedure fillData();
var
  temp : list;
  i : integer;
  a : string;
  settings : TFormatSettings;
begin
  i := 1;
  temp := commonWeather;
  weatherForecast.StringGrid1.RowCount := 1;
  settings.DateSeparator:='.';
  settings.LongDateFormat:='dd.mm.yyyy';
  settings.ShortDateFormat:='dd.mm.yyyy';
  while (temp <> nil) do
  begin
    weatherForecast.StringGrid1.RowCount := weatherForecast.StringGrid1.RowCount + 1;
    weatherForecast.StringGrid1.Cells[0, i] := dateToStr(temp^.date, settings);
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
 readFromTextFile(textFile, fileName, commonWeather);
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
  commonWeather := nil;
  tableChanged := true;
end;

procedure TWeatherForecast.deleteSelectedClick(Sender: TObject);
var
  selectedFrom,
  selectedTo : Longint;
  arrayOfItemsForDeliting : TArray30; // Индексы удаляемых строк
begin
  selectedFrom := WeatherForecast.StringGrid1.Selection.Top;
  selectedTo := WeatherForecast.StringGrid1.Selection.Bottom;
  if (selectedTo - selectedFrom > 30 ) then
    showMessage('Выбрано слишком большое количество записей для удаления!')
  else
     begin
       // todo Выделить массив из индексов
       deleteFromList(commonWeather, selectedFrom, selectedTo);
       //WeatherForecast.StringGrid1.deleteRow todo
       // отображаем новый лист
       fillData();
    end;
  showMessage('Выбранные записи удалены!');
end;


(*
  Вспомогательная функция, заносящая данные в список
*)
procedure saveInLList(var weatherList : list; grid : TStringGrid);
var
  i : integer;
  errCode : integer;
  rowsNumber : integer;
  temperature, humidity, atmospherePressure : integer;
  day : TDateTime;
  settings : TFormatSettings;
  dayOrNight : string;
begin
  // todo удаление всех элементов из листа
  weatherList := nil; // заново записываем

  rowsNumber := grid.RowCount;
  settings.DateSeparator:='.';
  settings.LongDateFormat:='dd.mm.yyyy';
  settings.ShortDateFormat:='dd.mm.yyyy';
  for i := 0 to rowsNumber - 2 do
  begin
    day := strToDateTime(grid.Cells[0, i + 1], settings);
    dayOrNight := grid.Cells[1, i + 1];
    val(grid.Cells[2, i + 1], temperature, errCode);
    val(grid.Cells[3, i + 1], humidity, errCode);
    val(grid.Cells[4, i + 1], atmospherePressure, errCode);
    LinkedList.add(weatherList, day, dayOrNight, temperature, humidity, atmospherePressure
                                        );
  end;
end;

procedure saveInFileProxy(var commonWeather : list; grid : TStringGrid);
begin
  saveInLList(commonWeather, grid);
  tableChanged := true;
end;

procedure save();
begin
//если изменений не было, выходим
  if (tableChanged) then
       saveInFileProxy(commonWeather, WeatherForecast.getStringGrid());
  //Если файл уже открывался, и в переменной myfile
  //есть его адрес и имя, просто перезаписываем этот файл:
  if fileName <> '' then
  begin
    writeToTextFile(textfile, filename, commonWeather);
    tableChanged := false;
    Exit; //выходим после сохранения
  end;

{Файл новый, переменная myfile еще пуста. Дальше есть два варианта:
пользователь выберет или укажет файл в диалоге, или не сделает этого}
//если выбрал файл:
if WeatherForecast.SaveDialog1.Execute then
  begin
    //прописываем адрес и имя файла в переменную:
    fileName := WeatherForecast.SaveDialog1.FileName;
    //если нет расширения *.txt то добавляем его:
    writeToTextFile(textfile, filename, commonWeather);
    //сохраняем табличку в указанный файл:
    tableChanged := False;
    showMessage('Таблица успешно сохранена!');
  end
//если не выбрал файл:
else ShowMessage('Вы не указали имя файла, файл не сохранен!');
end;

procedure TWeatherForecast.FormCloseQuery(Sender: TObject; var CanClose: boolean
  );
begin
   if (tableChanged) then save();
end;

procedure TWeatherForecast.IncrementRawsClick(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
  tableChanged := true;
end;

procedure TWeatherForecast.EscapeClick(Sender: TObject);
begin
  WeatherForecast.Close;
end;


procedure TWeatherForecast.SaveFileClick(Sender: TObject);
begin
  save();
end;

procedure TWeatherForecast.searchDetailInformationClick(Sender: TObject);
begin
  detailDayInfo.showModal;
end;

procedure TWeatherForecast.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if (ACol = 0) then value := '99.99.9999';
end;

procedure TWeatherForecast.StringGrid1SelectEditor(Sender: TObject; aCol, aRow: Integer;
  var Editor: TWinControl);
begin
  if aCol=1 then begin
    Editor := StringGrid1.EditorByStyle(cbsPickList);
    TCustomComboBox(Editor).Items.CommaText := 'День, Ночь';
  end;
end;

procedure TWeatherForecast.weekForekastClick(Sender: TObject);
begin
  datailPeriodInfo.showModal;
end;

end.

