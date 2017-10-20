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

procedure TdatailPeriodInfo.Button1Click(Sender: TObject);
var
  i : integer;
  x, x1 : TDateTime;

begin
  initialize();
  fillDate();
  i := 0;
    x := datailPeriodInfo.dateFrom.Date;
  x1 := datailPeriodInfo.dateTo.date;
  while (x <= x1) do
  begin
    showInfo(dayArray[i], dayArrayList[i, 0], dayArrayList[i, 1]);
    x := x + 1;
    inc (i);
  end;
end;
end.

