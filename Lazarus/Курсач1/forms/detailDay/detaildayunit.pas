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
  MainForm;

{ TmakeSearch }

procedure TmakeSearch.DateEdit1Change(Sender: TObject);
begin

end;

procedure TmakeSearch.showDayInfoClick(Sender: TObject);
var
  d1 : TDateTime;
  currentlist : list;
  // выборка по дню
begin
  //WeatherForecast.c
  currentlist := WeatherForecast.getCommonWeather();
  searchListElementByDate(currentList, dateSelect.Date);
  //drawCharts();
end;

end.

