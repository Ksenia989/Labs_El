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
  labell.caption := dateToStr(date)
                 + #13#10
                 + 'День:'
                 + '  Температура = ' + day^.temperature.toString
                 + '  Влажность = ' + day^.humidity.toString
                 + '  Атм. давление = ' + day^.atmospherePressure.toString
                 + #13#10
                 + 'Ночь:'
                 + '  Температура = ' + night^.temperature.toString
                 + '  Влажность = ' + night^.humidity.toString
                 + '  Атм. давление = ' + night^.atmospherePressure.toString
                 + #13#10;

end;

procedure TdatailPeriodInfo.Button1Click(Sender: TObject);
var
  dayList, nightlist, listTemplate : list;
  dateSelected : TDate;
begin
  dateSelected := dateFrom.Date;
  listTemplate := WeatherForecast.getCommonWeather(); // todo по дню и ночи поиск
  dayList := searchListElementByDate(listTemplate, dateSelected, 'День');
  nightList := searchListElementByDate(listTemplate, dateSelected, 'Ночь');
  showInfo(label4, date, dayList, nightList);

end;
end.

