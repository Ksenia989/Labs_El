unit detailDayUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, EditBtn, ExtCtrls, LinkedList;

type

  { TmakeSearch }

  TmakeSearch = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    showDayInfo: TButton;
    dateSelect: TDateEdit;
    dayForSearchMessage: TLabel;
    procedure showDayInfoClick(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  makeSearch: TmakeSearch;

implementation

{$R *.lfm}

uses
  MainForm, ColumnChart;

{ TmakeSearch }

procedure TmakeSearch.DateEdit1Change(Sender: TObject);
begin

end;

procedure TmakeSearch.showDayInfoClick(Sender: TObject);
var
  dayList, nightlist, listTemplate : list;
begin
  listTemplate := WeatherForecast.getCommonWeather(); // todo по дню и ночи поиск
  dayList := searchListElementByDate(listTemplate, dateSelect.Date, 'День');
  nightList := searchListElementByDate(listTemplate, dateSelect.Date, 'Ночь');
  dayList^.next := nightList;
  draw(Image1, dayList, 'Температура');
end;

end.

