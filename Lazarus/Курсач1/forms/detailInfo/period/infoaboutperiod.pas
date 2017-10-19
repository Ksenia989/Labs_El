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
  dayArray : array [0 .. 6] of TImage;

implementation

{$R *.lfm}

{ TdatailPeriodInfo }

procedure showInfo(var labell : TLabel; date : TDate; day : list; night : list);
begin
  labell.Font.Size := 10;;
  labell.caption := '   ' + dateToStr(date)
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

procedure TdatailPeriodInfo.Button1Click(Sender: TObject);
var
  dayList, nightlist, listTemplate : list;
  dateSelected : TDateTime;
begin
  dateSelected := dateFrom.Date;
  listTemplate := WeatherForecast.getCommonWeather(); // todo по дню и ночи поиск
  dayList := searchListElementByDate(listTemplate, dateSelected, 'День');
  nightList := searchListElementByDate(listTemplate, dateSelected, 'Ночь');
  showInfo(label4, date, dayList, nightList);

end;
end.

