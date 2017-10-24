unit detailDayUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, EditBtn, ExtCtrls, LinkedList;

type

  { TdetailDayInfo }

  TdetailDayInfo = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    showDayInfo: TButton;
    dateSelect: TDateEdit;
    dayForSearchMessage: TLabel;
    procedure showDayInfoClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  detailDayInfo: TdetailDayInfo;

implementation

{$R *.lfm}

uses
  MainForm, ColumnChart;

{ TdetailDayInfo }

procedure TdetailDayInfo.showDayInfoClick(Sender: TObject);
var
  dayList, nightlist, listTemplate : list;
begin
  listTemplate := WeatherForecast.getCommonWeather();
  dayList := searchListElementByDate(listTemplate, dateSelect.Date, 'День');
  nightList := searchListElementByDate(listTemplate, dateSelect.Date, 'Ночь');
  draw(Image1, dayList^.temperature, nightlist^.temperature, 'Температура');
  draw(Image2, dayList^.humidity, nightlist^.humidity, 'Влажность');
  draw(Image3, dayList^.atmospherePressure, nightList^.atmospherePressure, 'Атм. давление');
end;

end.

