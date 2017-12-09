unit detailDayUnit;

{$mode objfpc}{$H+}

(*
Модуль, отвечающий за детальную информацию об одном дне
С построеним графиков по дню и ночи
*)

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
    Image4: TImage;
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

(*
Основная процедура, осуществляющая отрисовку трёх диаграмм по найденному дню
*)
procedure TdetailDayInfo.showDayInfoClick(Sender: TObject);
var
  dayList, nightlist, listTemplate : list;
begin
  // инициализация
  nightList := nil;
  dayList := nil;

  // получение информации о погоде
  listTemplate := WeatherForecast.getCommonWeather();
  // ищем дневные данные
  dayList := searchListElementByDate(listTemplate, dateSelect.Date, 'День');
  // ищем ночные данные
  nightList := searchListElementByDate(listTemplate, dateSelect.Date, 'Ночь');
  // если поиск информации завершился неудачей, то выводим сообщение
  if ((nightList = nil) or (dayList = nil)) then
  begin
    ShowMessage('Нет информации о таком дне, попробуйте снова!');
  end
  else
  // если иноформация успешно найдена, то испльзуем универсальный построитель
  // графиков. На вход передаём данные для построения.
  // сама процедура отрисовки находится в модуле ColumnChart
  begin
    draw(Image1, dayList^.temperature, nightlist^.temperature, 'Температура');
    draw(Image2, dayList^.humidity, nightlist^.humidity, 'Влажность');
    draw(Image3, dayList^.atmospherePressure, nightList^.atmospherePressure, 'Атм. давление');
  end;
end;

end.

