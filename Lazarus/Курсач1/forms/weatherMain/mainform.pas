unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids, Menus, Buttons, LCLType, ActnList, StdActns,
  LinkedList, logo;

{ TWeatherForecast }
  type

  TWeatherForecast = class(TForm)
    About: TButton;
    Action1: TAction;
    Save: TAction;
    Open1: TAction;
    ActionList1: TActionList;
    deleteSelected: TButton;
    DateSorting: TMenuItem;
    ImageList1: TImageList;
    Image1: TImage;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
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
    SaveFile: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    maxYeraTemperature: TButton;

    procedure AboutClick(Sender: TObject);
    procedure DecrementRawsClick(Sender: TObject);
    procedure CleanTableClick(Sender: TObject);
    procedure deleteSelectedClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure IncrementRawsClick(Sender: TObject);
    procedure EscapeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DateSortingClick(Sender: TObject);
    procedure maxYeraTemperatureClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Open1Execute(Sender: TObject);
    procedure SaveExecute(Sender: TObject);
    procedure temperatureSortingClick(Sender: TObject);
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

procedure TWeatherForecast.FormCreate(Sender: TObject);
var
  i : integer;
begin
  Application.CreateForm(TStartPicture, startPicture);

  //for i := 0 to 10000 do
  //begin
  //   startPicture.ShowModal;
  //  startPicture.FormShow(startPicture);
  //end;
  ////startPicture.Clo
  //startPicture.Close;
end;

procedure TWeatherForecast.Image1Click(Sender: TObject);
begin

end;

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
end;

(*
  Выборка года, в котором температура в определённый день была максимальной
*)
procedure TWeatherForecast.maxYeraTemperatureClick(Sender: TObject);
begin
  //
end;

procedure TWeatherForecast.temperatureSortingClick(Sender: TObject);
begin
  sortInteger(StringGrid1, 2);
end;

function TWeatherForecast.getCommonWeather() : list;
begin
  getCommonWeather := commonWeather;
end;

function TWeatherForecast.getStringGrid() : TStringGrid;
begin
  getStringGrid := StringGrid1;
end;

procedure fillStringGridFromList();
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

procedure TWeatherForecast.AboutClick(Sender: TObject);
begin
  AboutProgram.showModal;
end;

procedure TWeatherForecast.DecrementRawsClick(Sender: TObject);
begin
  if (StringGrid1.RowCount = 1) then
  else
     begin
       StringGrid1.RowCount := StringGrid1.RowCount - 1;
     end;
end;

procedure TWeatherForecast.CleanTableClick(Sender: TObject);
begin
  StringGrid1.RowCount := 1;
  commonWeather := nil;
end;

procedure deleteFromGrid();
var
  selectedFrom : longint;
  selectedTo : longint;
begin
  selectedFrom := WeatherForecast.StringGrid1.Selection.Top;
  selectedTo := WeatherForecast.StringGrid1.Selection.Bottom;
  if (selectedTo - selectedFrom > 30 ) then
    showMessage('Выбрано слишком большое количество записей для удаления!')
  else
     begin
       deleteFromList(commonWeather, selectedFrom, selectedTo);
       // отображаем новый лист
       fillStringGridFromList();
    end;
  showMessage('Выбранные записи удалены!');
end;

procedure TWeatherForecast.deleteSelectedClick(Sender: TObject);
begin
  deleteFromGrid();
end;

procedure TWeatherForecast.MenuItem1Click(Sender: TObject);
begin
  deleteFromGrid();
end;

procedure TWeatherForecast.Open1Execute(Sender: TObject);
begin
  //если диалог выполнен
  if OpenDialog1.Execute then
  begin
    // присваиваем переменной myfile адрес и имя выбранного файла:
    fileName := OpenDialog1.FileName;
    // читаем этот файл в список
    readFromTextFileToList(textFile, fileName, commonWeather);
    // заполняем stringGrid данными из списка
    fillStringGridFromList();
  end;
end;

(*
  Вспомогательная функция, заносящая данные в список
*)
procedure saveToListFromStringGrid(var weatherList : list; grid : TStringGrid);
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
    LinkedList.add(weatherList, day, dayOrNight,
                                temperature, humidity, atmospherePressure);
  end;
end;

procedure TWeatherForecast.SaveExecute(Sender: TObject);
begin
  saveToListFromStringGrid(commonWeather, weatherForecast.StringGrid1);
  //Если файл уже открывался, и в переменной myfile
  //есть его адрес и имя, просто перезаписываем этот файл:
  if fileName <> '' then
  begin
    writeToTextFile(textfile, filename, commonWeather);
    Exit; //выходим после сохранения
  end;

{Файл новый, переменная myfile еще пуста. Дальше есть два варианта:
пользователь выберет или укажет файл в диалоге, или не сделает этого}
//если выбрал файл:
if WeatherForecast.SaveDialog1.Execute then
  begin
    //прописываем адрес и имя файла в переменную:
    fileName := WeatherForecast.SaveDialog1.FileName;
    //сохраняем табличку в указанный файл:
    writeToTextFile(textfile, filename, commonWeather);
    showMessage('Таблица успешно сохранена!');
  end
//если не выбрал файл:
else ShowMessage('Вы не указали имя файла, файл не сохранен!');
end;

procedure TWeatherForecast.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  case Application.MessageBox('Выйти из приложения?', 'Выход',
   MB_YESNO+MB_ICONQUESTION) of
   IDYES :
     begin
         saveToListFromStringGrid(commonWeather, weatherForecast.StringGrid1);
  //Если файл уже открывался, и в переменной myfile
  //есть его адрес и имя, просто перезаписываем этот файл:
  if fileName <> '' then
  begin
    writeToTextFile(textfile, filename, commonWeather);
    Exit; //выходим после сохранения
  end;

{Файл новый, переменная myfile еще пуста. Дальше есть два варианта:
пользователь выберет или укажет файл в диалоге, или не сделает этого}
//если выбрал файл:
if WeatherForecast.SaveDialog1.Execute then
  begin
    //прописываем адрес и имя файла в переменную:
    fileName := WeatherForecast.SaveDialog1.FileName;
    //сохраняем табличку в указанный файл:
    writeToTextFile(textfile, filename, commonWeather);
    showMessage('Таблица успешно сохранена!');
  end
//если не выбрал файл:
else ShowMessage('Вы не указали имя файла, файл не сохранен!');

       CanClose := true;
     end;
   IDNO :
     begin
       CanClose := false;
     end;
  end;
end;

procedure TWeatherForecast.IncrementRawsClick(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

procedure TWeatherForecast.EscapeClick(Sender: TObject);
begin
  WeatherForecast.Close;
end;

procedure TWeatherForecast.searchDetailInformationClick(Sender: TObject);
begin
  saveToListFromStringGrid(commonWeather, weatherForecast.StringGrid1);
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
  saveToListFromStringGrid(commonWeather, weatherForecast.StringGrid1);
  datailPeriodInfo.showModal;
end;

end.

