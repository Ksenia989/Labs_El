unit infoAboutPeriod;

{$mode objfpc}{$H+}

(*
Модуль, отвечающий за показ детальной информации по выбранному периоду.
Ограничением является количество дней - не более недели.
Так же в модуле осуществлено построение графика с дневной и ночной погодой.
*)

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, ExtCtrls, LinkedList, MainForm;

type

  { TdatailPeriodInfo }

  TdatailPeriodInfo = class(TForm)
    Image1: TImage;
    ShowPeriodInfo: TButton;
    dateFrom: TDateEdit;
    dateTo: TDateEdit;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    majorChart: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ShowPeriodInfoClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  datailPeriodInfo: TdatailPeriodInfo;
  dayArray : array [0 .. 6] of Tlabel;
  dayArrayList : array [0..6, 0..1] of List;

{ public declarations }
procedure showInfo(var labell : TLabel; day : list; night : list);

implementation

{$R *.lfm}

{ TdatailPeriodInfo }

(*
Процедура, отвечающая за первоначальную инициализацию компонентов программы.
*)
procedure initialize();
begin
  dayArray[0] := datailPeriodInfo.Label4;
  dayArray[1] := datailPeriodInfo.label5;
  dayArray[2] := datailPeriodInfo.label6;
  dayArray[3] := datailPeriodInfo.label7;
  dayArray[4] := datailPeriodInfo.label8;
  dayArray[5] := datailPeriodInfo.label9;
  dayArray[6] := datailPeriodInfo.label10;
end;

(*
Процедура, отвечающая за показ детальной информации.
Компоненту TLabel передаётся значения из списка, соответствующее выбранному дню
Является процедурой с публичным доступом, т.к. переиспользуется в других модулях.
*)
procedure showInfo(var labell : TLabel; day : list; night : list);
begin
  // установка размера шрифдта
  labell.Font.Size := 10;
  // на компоненте отображаются значения, соответствующие выбранному дню
  labell.caption := '   ' + dateToStr(day^.date)
                 + #13#10
                 + 'День:'
                 + #13#10
                 + '  Температура = ' + day^.temperature.toString
                 + #13#10
                 + '  Влажность = ' + day^.humidity.toString
                 + #13#10
                 + '  Атм. давление = ' + day^.atmospherePressure.toString
                 + #13#10
                 + 'Ночь:'
                 + #13#10
                 + '  Температура = ' + night^.temperature.toString
                 + #13#10
                 + '  Влажность = ' + night^.humidity.toString
                 + #13#10
                 + '  Атм. давление = ' + night^.atmospherePressure.toString
                 + #13#10;

end;

(*
Процедура, осуществляющая поиск одного элемента даты,
который отвечает за дневные и ночные данные
*)
procedure fillDate();
var
  i : integer;
  dateFrom, dateTo : TDateTime;
  dayList, nightList, listTemplate : list;
begin   // todo проверка, что что - то  (одна из дат) не введена
  i := 0;
  dateFrom := datailPeriodInfo.dateFrom.Date;
  dateTo := datailPeriodInfo.dateTo.date;
  // компонента, содержащая значения из списка со значениями погоды в разные дни
  listTemplate := WeatherForecast.getCommonWeather();
  if (listTemplate = nil) then showMessage('Введите данные для прогноза!')
  else
  // цикл по элементам
  while (dateFrom <= dateTo) do
    begin
      // сначала дни не найдены - списки пустые
      dayList := nil;
      nightList := nil;
      // поиск дневной и ночной температуры для определённого дня
      // если дневная или ночная температура не найдены, то выводим сообщение о
      // недостаточности даннчх
      dayList := searchListElementByDate(listTemplate, dateFrom, 'День');
      nightList := searchListElementByDate(listTemplate, dateFrom, 'Ночь');
      // сообщение о недостаточности данных
      if ((dayList <> nil) and (nightList <> nil)) then
      begin
        // заносим в глобальные перменные, осуществляющие хранение дневной и
        // ночной температуры (элементов списка)
        dayArrayList[i, 0] := dayList;
        dayArrayList[i, 1] := nightList;
      end
      else
        showMessage('Недостаточно данных!');
      // если всё хорошо, то идём дальше по списку
      dateFrom := dateFrom + 1;
      inc (i);
    end;
end;

(*
Процедура, выводящая линии графика
*)
procedure writeTemperature(var image : Timage);
begin
  // цвет - чёрный
  image.canvas.Font.Color:= clblack;
  image.Canvas.Line(47, 6, 47, 270);
  image.Canvas.Line(42, 24, 47, 6);
  image.Canvas.Line(52, 24, 47, 6);
  // шрифдт - 7
  image.canvas.Font.Size := 7;
  // выводим надпись t °C
  image.canvas.TextOut(25, 4, 't °C');
end;

(*
Процедура, отвечающая за рисование надписи "сутки" на горизонтальном графике
*)
procedure writeScale(var image : Timage);
const
  // высота нулевого значения
  zeroPointerHeight : integer = 135;
begin
  // цвет - чёрный
  image.canvas.Font.Color:= clblack;
  image.Canvas.Line(47, zeroPointerHeight, 540, zeroPointerHeight);
  image.Canvas.Line(525, zeroPointerHeight - 6, 540, zeroPointerHeight);
  image.Canvas.Line(525, zeroPointerHeight + 6, 540, zeroPointerHeight);
  image.canvas.Font.Size := 7;
  // вывод надписи "сутки"
  image.canvas.TextOut(542, 146, 'Сутки');
  // цвет - белый
  image.canvas.Font.Color:= clwhite;
end;

(*
Процедура, отвечающая за рисование чёрточек
*)
procedure writeChertochki(var image : TImage);
var
  maxHeight : integer;
  i : integer;
  oneScale : integer;
  p1, p2 : TPoint;
begin
  // цвет фона - белый
  image.Canvas.Brush.Color := clwhite;
  // максимальная высота
  maxHeight := 255;
  p1.x := 45;
  p1.y := maxHeight;
  p2.x := 50;
  p2.y := p1.y;
  // высота одной чёрточки
  oneScale := maxHeight div 85;
  // рисовать чёрточки
  for i := -40 to 35 do
  begin
    // провести линию от одной точки до другой
    image.canvas.line(p1, p2);
    p1.y := p1.y - oneScale;
    p2.y := p2.y - oneScale;
    // через каждый 5 чёрточек написать результат
    if (i mod 5 = 0) then
       image.canvas.TextOut(p1.x - 20, p1.y - 3, i.ToString);
  end;
end;

(*
Процедура, отвечающая за рисование линий графиками со всеми подписями и
чёрточками
*)
procedure drawCanvas();
begin
  datailPeriodInfo.majorChart.canvas.Font.Color:= clblack;
  datailPeriodInfo.majorChart.canvas.Font.Size := 7;
  // тут рисуются основные компоненты графика
  // вызываются подпрограммы, описанные выше
  writeScale(datailPeriodInfo.majorChart);
  writeTemperature(datailPeriodInfo.majorChart);
  writeChertochki(datailPeriodInfo.majorChart);
end;

(*
функця, реализующая рисование круга на высоте с температурой (указателя температуры)
*)
function drawImage(day : list; width : integer) : integer;
var
  maxHeight: integer;
  currentHeight : integer;
  oneDegreeHeight : integer;
  degreesCount : integer;
begin
  // максимальная высота
  maxHeight := 255;
  degreesCount := 85;
  // высота одного градуса
  oneDegreeHeight := maxHeight div degreesCount;
  // нужная высота определяется формулой:
  currentHeight := maxHeight - oneDegreeHeight * abs(((-40) - (day^.temperature)));
  // цвет - красный
  datailPeriodInfo.majorChart.Canvas.Brush.Color := clRed;
  // рисование круга, отвечающего за погоду
  datailPeriodInfo.majorChart.Canvas.EllipseC(width, currentHeight, 4, 4);
  drawImage := currentHeight;
end;

(*
Процедура, полностью рисующая график и отображающая детальную
информацию по каждому дню
*)
procedure TdatailPeriodInfo.ShowPeriodInfoClick(Sender: TObject);
var
  i : integer;
  startDate, endDate : TDate;
  currentWidth : integer;
  oneScaleToRightPosition : integer;
  startPosition, endPosition : integer;
  daysPerWeek : integer;
  dayHeight, nextDayPoint : integer;
  nightHeight, nextNightPoint : integer;
begin
  // цвет - белый
  majorchart.Canvas.Brush.Color := clWhite;
  majorchart.Canvas.Rectangle(0, 0, majorchart.Width, majorchart.Height);
  majorchart.Canvas.Brush.Color := clwhite;

  i := 0;
  // чтение начальной и конечной даты в пеменные (из компонентов)
  datailPeriodInfo.dateFrom.DateFormat:='dd.mm.yyyy';
  startDate := datailPeriodInfo.dateFrom.Date;
  endDate := datailPeriodInfo.dateTo.date;

  if(endDate - startDate > 7) then
  showMessage('Слишком большой диапазон!')
  else
  begin
  // рисование основных компонентов
  drawCanvas();
  initialize();
  fillDate();

  // начальная инициализация данными
  startPosition := 47;
  endPosition := 470;
  daysPerWeek := 7;

  // рассчёт пикселей между днями недели
  oneScaleToRightPosition := (endPosition - startPosition) div daysPerWeek;
  currentWidth := startPosition;

  // + 1 т.к. для одного дня уже посчитали
  currentWidth := currentWidth + oneScaleToRightPosition;
  // рисование изображение для первого и второго дня
  dayHeight := drawImage(dayArrayList[i, 0], currentWidth);
  nightHeight := drawImage(dayArrayList[i, 1], currentWidth);
  startDate := startDate + 1;

  // пока дни не закончились, рисовать
  while (startDate <= endDate) do
  begin
    showInfo(dayArray[i], dayArrayList[i, 0], dayArrayList[i, 1]);

    // для дневной погоды
    currentWidth :=  currentWidth + oneScaleToRightPosition;
    // нарисовать круг
    nextDayPoint := drawImage(dayArrayList[i + 1, 0], currentWidth);
    // соеднить со следующим
    datailPeriodInfo.majorChart.Canvas.Line(currentWidth - oneScaleToRightPosition, dayHeight, currentWidth, nextDayPoint);

    // для ночной погоды
    nextNightPoint := drawImage(dayArrayList[i + 1, 1], currentWidth);
    // соединить два круга
    datailPeriodInfo.majorChart.Canvas.Line(currentWidth - oneScaleToRightPosition, nightHeight, currentWidth, nextNightPoint);

    dayHeight := nextDayPoint;
    nightHeight := nextNightPoint;

    // переход на следующую дату
    startDate := startDate + 1;
    inc(i);
  end;
  // показ детальной ионформации в компоненте Label по определённому дню
  showInfo(dayArray[i], dayArrayList[i, 0], dayArrayList[i, 1]);
  end;
end;

procedure TdatailPeriodInfo.FormCreate(Sender: TObject);
begin
  datailPeriodInfo.dateFrom.set;
    datailPeriodInfo.dateFrom.DateFormat:='dd.mm.yyyy';
end;

end.
