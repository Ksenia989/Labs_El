unit detailYearInformation;

{$mode objfpc}{$H+}

(*
Модуль, отвечающий за показ года с максимальной и минимальной
температурой.
На форме расположены CheckBOx'ы, в которых выберается день и месяц,
и в данном модуле осуществляется поиск года, в котором температура была
соответственно максимальна и минимальная, и выводит детальную информацию
об данных результатах на экран
*)

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, ExtCtrls, linkedLIst, infoAboutPeriod;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    ComboBoxDay : TComboBox;
    ComboBoxMonth : TComboBox;
    Label2: TLabel;
    DetailInfo: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    YearNumberMin: TLabel;
    DetailMin: TLabel;
    MaxYearLabel: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation
uses mainForm;

{$R *.lfm}

{ TForm1 }

(*
процедура, отвечающая за вывод детальной информации о уже найденном дне
*)
procedure getDetailDayDescription(currentList : list; dayList : list; var label1 : TLabel; var label2 : TLabel);
var
  nightList : list;
  curDay, curMonth, curYear : word;
begin
   // если день не найден
   if (dayList = nil) then
  begin
    showMessage('Не найдено информации о подобном дне в любом году!');
  end
  else
    // если день найден
    begin
      // поиск по такой же дате, как dayList
      nightList := searchListElementByDate(currentList, dayList^.date, 'Ночь');
      // декодирование даты
      decodeDate(dayList^.date, curYear, curMonth, curDay);
      label1.Caption := curYear.ToString;
      // показ детальной информации (модуль infoAboutPeriod)
      showInfo(label2, dayList, nightList);
  end;

end;

(*
процедура, осуществляющая поиск года с максимальной и минимальной температурой
*)
procedure TForm1.Button1Click(Sender: TObject);
var
  currentList : list;
  dayList, nightList : list;
  date : TDateTime;
  day, month : TDateTime;
  selectedDayIndex, selectedMonthIndex : integer;
begin
  // получаем значения из основного модуля MainForm
  currentList := weatherForecast.getCommonWeather();
  // +1, так как счёт начинается с 0
  // забираем занчения из ComboBox'ов
  selectedDayIndex := ComboBoxDay.ItemIndex + 1;
  selectedMonthIndex := ComboBoxMonth.ItemIndex + 1;
  // ищем элементы
  // ищем максимальный элемент по дате
  dayList := searchMaxListElementByDayMonth(currentList,
                              selectedDayIndex, selectedMonthIndex);
  getDetailDayDescription(currentList, dayList, label3, label4);
  // поиск минимального элемента по дню
  dayList := searchMinListElementByDayMonth(currentList,
                              selectedDayIndex, selectedMonthIndex);
  // вывод информации о дне
  getDetailDayDescription(currentList, dayList, YearNumberMin, DetailMin);
end;

end.

