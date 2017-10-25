unit infoAboutPeriod;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, ExtCtrls, LinkedList, MainForm;

type

  { TdatailPeriodInfo }

  TdatailPeriodInfo = class(TForm)
    Button1: TButton;
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
    additionInfo: TImage;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  datailPeriodInfo: TdatailPeriodInfo;
  dayArray : array [0 .. 6] of Tlabel;
  dayArrayList : array [0..6, 0..1] of List;

implementation

{$R *.lfm}

{ TdatailPeriodInfo }

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

procedure showInfo(var labell : TLabel; day : list; night : list);
begin
  labell.Font.Size := 10;;
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

procedure fillDate();
var
  i : integer;
  x, x1 : TDateTime;
  dayList, nightList, listTemplate : list;
begin   // todo проверка, что что - то  (одна из дат) не введена
  i := 0;
  x := datailPeriodInfo.dateFrom.Date;
  x1 := datailPeriodInfo.dateTo.date;
  listTemplate := WeatherForecast.getCommonWeather();
  while (x <= x1) do
  begin
    dayList := searchListElementByDate(listTemplate, x, 'День');
    nightList := searchListElementByDate(listTemplate, x, 'Ночь');
    if ((dayList <> nil) and (nightList <> nil)) then
    begin
      dayArrayList[i, 0] := dayList;
      dayArrayList[i, 1] := nightList;
    end
    else
    showMessage('Недостаточно данных!');
    x := x + 1;
    inc (i);
  end;
end;

procedure writeTemperature(var image : Timage);
begin
  image.canvas.Font.Color:= clblack;
  image.Canvas.Line(47, 6, 47, 270);
  image.Canvas.Line(42, 24, 47, 6);
  image.Canvas.Line(52, 24, 47, 6);
  image.canvas.Font.Size := 7;
  image.canvas.TextOut(25, 4, 't °C');
end;

procedure writeScale(var image : Timage);
const
  zeroPointerHeight : integer = 135;
begin
  image.canvas.Font.Color:= clblack;
  image.Canvas.Line(47, zeroPointerHeight, 540, zeroPointerHeight);
  image.Canvas.Line(525, zeroPointerHeight - 6, 540, zeroPointerHeight);
  image.Canvas.Line(525, zeroPointerHeight + 6, 540, zeroPointerHeight);
  image.canvas.Font.Size := 7;
  image.canvas.TextOut(542, 146, 'Сутки');
  image.canvas.Font.Color:= clwhite;
end;

procedure writeChertochki(var image : TImage);
var
  maxHeight : integer;
  i : integer;
  oneScale : integer;
  p1, p2 : TPoint;
begin
  image.Canvas.Brush.Color := clwhite;
  maxHeight := 255;
  p1.x := 45;
  p1.y := maxHeight;
  p2.x := 50;
  p2.y := p1.y;
  oneScale := maxHeight div 85;
  for i := -40 to 35 do
  begin
    image.canvas.line(p1, p2);
    p1.y := p1.y - oneScale;
    p2.y := p2.y - oneScale;
    if (i mod 5 = 0) then
       image.canvas.TextOut(p1.x - 20, p1.y - 3, i.ToString);
  end;
end;

procedure drawCanvas();
begin
  datailPeriodInfo.majorChart.canvas.Font.Color:= clblack;
  datailPeriodInfo.majorChart.canvas.Font.Size := 7;
  writeScale(datailPeriodInfo.majorChart);
  writeTemperature(datailPeriodInfo.majorChart);
  writeChertochki(datailPeriodInfo.majorChart);
end;

function drawImage(day : list; width : integer) : integer;
var
  maxHeight: integer;
  currentHeight : integer;
  oneDegreeHeight : integer;
  degreesCount : integer;
begin   // todo возвращать сложный тип
  maxHeight := 255;
  degreesCount := 85;
  oneDegreeHeight := maxHeight div degreesCount;
  //dayTemperature
  currentHeight := maxHeight - oneDegreeHeight * abs(((-40) - (day^.temperature)));
  datailPeriodInfo.majorChart.Canvas.Brush.Color := clRed;
  datailPeriodInfo.majorChart.Canvas.EllipseC(width, currentHeight, 4, 4);
  drawImage := currentHeight;
end;

procedure TdatailPeriodInfo.Button1Click(Sender: TObject);
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
  majorchart.Canvas.Brush.Color := clWhite;
  majorchart.Canvas.Rectangle(0, 0, majorchart.Width, majorchart.Height);
  majorchart.Canvas.Brush.Color := clwhite;
  drawCanvas();
  initialize();
  fillDate();
  i := 0;
  startDate := datailPeriodInfo.dateFrom.Date;
  endDate := datailPeriodInfo.dateTo.date;

  startPosition := 47;
  endPosition := 470;
  daysPerWeek := 7;

  oneScaleToRightPosition := (endPosition - startPosition) div daysPerWeek;
  currentWidth := startPosition;

  // + 1 т.к. для одного дня уже посчитали
  currentWidth := currentWidth + oneScaleToRightPosition;
  dayHeight := drawImage(dayArrayList[i, 0], currentWidth);
  nightHeight := drawImage(dayArrayList[i, 1], currentWidth);
  startDate := startDate + 1;

  while (startDate <= endDate) do    // todo проработать ситуацию, когда нет следующей точки
  begin
    showInfo(dayArray[i], dayArrayList[i, 0], dayArrayList[i, 1]);

    currentWidth :=  currentWidth + oneScaleToRightPosition;
    nextDayPoint := drawImage(dayArrayList[i + 1, 0], currentWidth);
    datailPeriodInfo.majorChart.Canvas.Line(currentWidth - oneScaleToRightPosition, dayHeight, currentWidth, nextDayPoint);

    nextNightPoint := drawImage(dayArrayList[i + 1, 1], currentWidth);
    datailPeriodInfo.majorChart.Canvas.Line(currentWidth - oneScaleToRightPosition, nightHeight, currentWidth, nextNightPoint);

    dayHeight := nextDayPoint;
    nightHeight := nextNightPoint;

    startDate := startDate + 1;
    inc(i);
  end;
  showInfo(dayArray[i], dayArrayList[i, 0], dayArrayList[i, 1]);
end;
end.

