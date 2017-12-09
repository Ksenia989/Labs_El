unit MainForm;

(*Главная форма программы.
Практически не содержит логики. Только обрабатывает вызванные события, вызывая
сторонние модули согласно принципу нисходящего проектирования*)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids, Menus, Buttons, LCLType, ActnList,
  LinkedList, logo;

{ TWeatherForecast }
  type

  TWeatherForecast = class(TForm)
    About: TButton;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    RemoveSelected: TAction;
    RemoveEmplyString: TAction;
    KillAllTable: TAction;
    AddEmptyString: TAction;
    Button1: TButton;
    Editing: TMenuItem;
    DelectSelected: TMenuItem;
    AddRaw: TMenuItem;
    deleteItAll: TMenuItem;
    MenuItem3: TMenuItem;
    Save: TAction;
    Open1: TAction;
    ActionList1: TActionList;
    deleteSelected: TButton;
    DateSorting: TMenuItem;
    ImageList1: TImageList;
    Image1: TImage;
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
    procedure AddEmptyStringExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure EscapeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DateSortingClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure KillAllTableExecute(Sender: TObject);
    procedure maxYeraTemperatureClick(Sender: TObject);
    procedure Open1Execute(Sender: TObject);
    procedure RemoveEmplyStringExecute(Sender: TObject);
    procedure RemoveSelectedExecute(Sender: TObject);
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
     DetailDayUnit, fileSaver, InfoAboutPeriod, detailYearInformation;

{$R *.lfm}

const
  filename : string = ''; // переменная, хранящая имя файла

var
  commonWeather : list;
  textfile : text;

{ TWeatherForecast }

(*
  Вспомогательная функция, заносящая данные в список из StringGrid
*)
procedure saveToListFromStringGrid(var weatherList : list; grid : TStringGrid);
var
  i : integer;
  // коды ошибок
  errCode1, errCode2, errCode3 : integer;
  rowsNumber : integer;
  temperature, humidity, atmospherePressure : integer;
  day : TDateTime;
  settings : TFormatSettings;
  dayOrNight : string;
begin
  // todo удаление всех элементов из листа
  weatherList := nil; // заново записываем
  rowsNumber := grid.RowCount;
  // описываем формат даты
  settings.DateSeparator:='.'; // разделитель даты - точка
  settings.LongDateFormat:='dd.mm.yyyy';
  settings.ShortDateFormat:='dd.mm.yyyy';
  // проходим по всем элементам в StringGrid
  for i := 0 to rowsNumber - 2 do
  begin
    day := strToDateTime(grid.Cells[0, i + 1], settings);
    dayOrNight := grid.Cells[1, i + 1];
    val(grid.Cells[2, i + 1], temperature, errCode1);
    val(grid.Cells[3, i + 1], humidity, errCode2);
    val(grid.Cells[4, i + 1], atmospherePressure, errCode3);
    // если есть ошибки, то не добавляем переменную в список.
    // таким образом, в списке окажутся только верные данные
  if ((errCode1 <> 0) or (errCode2 <> 0) or (errCode3 <> 0)) then
    showMessage('Данные имели неверный формат! Операция добавлеия не выполнена')
  else
  // если с данными всё в порядке - добавляем в список
  // проверка данных на удовлетворение критериям осуществляется
  // внутри процедуры добавления
  LinkedList.add(weatherList, day, dayOrNight,
                                temperature, humidity, atmospherePressure);
  end;
end;

(*
Процедура, отвечающая за начальную инициализацию.
Присваивает StringGrid заголовки, устанавливает ширину столбцов.*)
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

(*
Процедура, отвечающая за сортировку по дате
*)
procedure TWeatherForecast.DateSortingClick(Sender: TObject);
begin
    StringGrid1.SortColRow(true, 0);
end;

procedure TWeatherForecast.Image1Click(Sender: TObject);
begin

end;

(*
Процедура, отвечающая за удаление всех элементов из таблицы
*)
procedure TWeatherForecast.KillAllTableExecute(Sender: TObject);
begin
  StringGrid1.RowCount := 1;
  commonWeather := nil;
end;

(*
Процедура, отвечающая за сортировку по температуре
*)
procedure TWeatherForecast.temperatureSortingClick(Sender: TObject);
begin
  StringGrid1.SortColRow(true, 2);
end;

(*
Функци, отвечающая за получение объекта списка с погодой.
Имеет модификатор public, т.к. используется в других модулях
*)
function TWeatherForecast.getCommonWeather() : list;
begin
  getCommonWeather := commonWeather;
end;

(*
Функци, отвечающая за получение объекта StringGrid с данными.
Имеет модификатор public, т.к. используется в других модулях
*)
function TWeatherForecast.getStringGrid() : TStringGrid;
begin
  getStringGrid := StringGrid1;
end;

(*
Процедура, отвечающая за наполнение списка из компонента StringGrid
*)
procedure fillStringGridFromList();
var
  temp : list;
  i : integer;
  a : string;
  settings : TFormatSettings;
begin
  i := 1;
  // промежуточная переменная, помогающая пройти по списку, не потеряв его начало
  temp := commonWeather;
  weatherForecast.StringGrid1.RowCount := 1;
  // описываем формат даты
  settings.DateSeparator:='.';
  settings.LongDateFormat:='dd.mm.yyyy';
  settings.ShortDateFormat:='dd.mm.yyyy';
  // проходим по всем элементам списка, испльзуя цикл
  while (temp <> nil) do
  begin
    // увеличиваем количество строк в StringGrid, т.к. туда
    // добавляются данные
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
    // увеличиваем счётчик
    inc(i);
    // переходим на следующий элемент в списке
    temp := temp^.next;
  end;
end;

(*
    Процедура, отвечающая за показ информации о приложении
*)
procedure TWeatherForecast.AboutClick(Sender: TObject);
begin
  AboutProgram.showModal;
end;

(*
   Процедура, отвечающая за увеличение количества строк на 1
*)
procedure TWeatherForecast.AddEmptyStringExecute(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

(*
   Процедура, отвечающая за сохранение в список из компонента StringGrid
*)
procedure TWeatherForecast.Button1Click(Sender: TObject);
begin
  saveToListFromStringGrid(commonWeather, weatherForecast.StringGrid1);
end;

(*
   Процедура, отвечающая за удаление из компонента StringGrid
*)
procedure deleteFromGrid();
var
  selectedFrom : longint;
  selectedTo : longint;
begin
  // Выбираем, что удалить (что выделено мышкой)
  selectedFrom := WeatherForecast.StringGrid1.Selection.Top;
  selectedTo := WeatherForecast.StringGrid1.Selection.Bottom;
  // если выбранное количество записей больше 30, то выводим сообщение об ошибке
  if (selectedTo - selectedFrom > 30 ) then
    showMessage('Выбрано слишком большое количество записей для удаления!')
  else
     begin
       // запускаем процедуру удаления (в модуле list)
       deleteFromList(commonWeather, selectedFrom, selectedTo);
       // отображаем новый лист, с уже удалёнными записями
       fillStringGridFromList();
    end;
  showMessage('Выбранные записи удалены!');
end;

(*
   Процедура, отвечающая за открытие файла и занесение его в список.
   А из списка - в таблицу
*)
procedure TWeatherForecast.Open1Execute(Sender: TObject);
begin
  //если диалог выполнен
  if OpenDialog1.Execute then
  begin
    // присваиваем переменной myfile адрес и имя выбранного файла:
    fileName := OpenDialog1.FileName;
    // читаем этот файл в список
    // при загрузке файла - сразу сохраняем данные
    readFromTextFileToList(textFile, fileName, commonWeather);
    // заполняем stringGrid данными из списка
    fillStringGridFromList();
  end;
end;

(*
   Процедура, отвечающая за удаление одной строки из StringGrid
*)
procedure TWeatherForecast.RemoveEmplyStringExecute(Sender: TObject);
begin
  if (StringGrid1.RowCount = 1) then
  else
     begin
       StringGrid1.RowCount := StringGrid1.RowCount - 1;
     end;
end;

(*
    Процедура, отвечающая за удаление данных из StringGrid и из списка
*)
procedure TWeatherForecast.RemoveSelectedExecute(Sender: TObject);
begin
  deleteFromGrid();
end;

(*
   Процедура, отвечающая за сохранение файла
*)
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

// Файл новый, переменная myfile еще пуста. Дальше есть два варианта:
// пользователь выберет или укажет файл в диалоге, или не сделает этого}
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

(*
   Процедура, выполняемая при выходе
   Спрашивает у пользователя - хочет ли он выйти. Если да, то
   запрашивает, хочет ли он сохраинить файл.
*)
procedure TWeatherForecast.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  case Application.MessageBox('Выйти из приложения?', 'Выход',
   MB_YESNO+MB_ICONQUESTION) of
   // если пользователь хочет выйти
   IDYES :
     begin
       case Application.MessageBox('Сохранить?', 'Сохранение',
       MB_YESNO+MB_ICONQUESTION) of
       // если пользователь хочет сохранить файл
       IDYES :
         begin
           // процедура, выполняющая сохранение в список с погодой из компонента
           // StringGrid
           saveToListFromStringGrid(commonWeather, weatherForecast.StringGrid1);
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
           else
             begin
               ShowMessage('Вы не указали имя файла, файл не сохранен!');
               CanClose := false;
             end;
         end;
       IDNO :
         // случай, если пользователь выбрал не сохраянять программу
         begin
           CanClose := true;
         end;
       end;
     end;
   // если пользователь отменил выход, то возвращаемся в программу
   IDNO :
     begin
       CanClose := false;
     end;
  end;
end;

(*
   Процедура, отвечающая за закрытие файла по кнопке
*)
procedure TWeatherForecast.EscapeClick(Sender: TObject);
begin
  WeatherForecast.Close;
end;

(*
   Процедура, отвечающая за вызов формы с детальной информацией по дню недели
*)
procedure TWeatherForecast.searchDetailInformationClick(Sender: TObject);
begin
  detailDayInfo.showModal;
end;

(*
   Процедура, отвечающая за присваивание маски 0 колонке в StringGrid.
   Создано для удобства - чтобы пользователь не вводил каждый раз точки при вводе
   дня
*)
procedure TWeatherForecast.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if (ACol = 0) then value := '99.99.9999';
end;

(*
   Процедура, отвечающая за доблавение checkBox в 1 колонку в StringGrid, т.к.
   она должна иметь строго определённые значения
*)
procedure TWeatherForecast.StringGrid1SelectEditor(Sender: TObject; aCol, aRow: Integer;
  var Editor: TWinControl);
begin
  // выбираем первую колонку
  if aCol = 1 then begin
    Editor := StringGrid1.EditorByStyle(cbsPickList);
    // присваиваем значения первой колонке - они могут быть по выбору - только
    // день или ночь
    TCustomComboBox(Editor).Items.CommaText := 'День, Ночь';
  end;
end;

(*
  Процедура, отвечающая за выхов формы, в которой строится график температуры
  по определённому периоду
  Ограничения : период не больше недели
*)
procedure TWeatherForecast.weekForekastClick(Sender: TObject);
begin
  datailPeriodInfo.showModal;
end;

(*
  Выборка года, в котором температура в определённый день была максимальной
  (Вызов формы)
*)
procedure TWeatherForecast.maxYeraTemperatureClick(Sender: TObject);
begin
  Form1.showModal;
end;

end.

