unit detailYearInformation;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, linkedLIst, infoAboutPeriod;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
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

procedure getDetailDayDescription(currentList : list; dayList : list; var label1 : TLabel; var label2 : TLabel);
var
  nightList : list;
  curDay, curMonth, curYear : word;
begin
   if (dayList = nil) then
  begin
    showMessage('Не найдено информации о подобном дне в любом году!');
  end
  else
    begin
      // поиск по такой же дате, как dayList
      nightList := searchListElementByDate(currentList, dayList^.date, 'Ночь');
      decodeDate(dayList^.date, curYear, curMonth, curDay);
      label1.Caption := curYear.ToString;
      showInfo(label2, dayList, nightList);
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  currentList : list;
  dayList, nightList : list;
  date : TDateTime;
  day, month : TDateTime;
  selectedDayIndex, selectedMonthIndex : integer;
begin
  currentList := weatherForecast.getCommonWeather();
  // +1, так как счёт начинается с 0
  selectedDayIndex := ComboBoxDay.ItemIndex + 1;
  selectedMonthIndex := ComboBoxMonth.ItemIndex + 1;
  dayList := searchMaxListElementByDayMonth(currentList,
                              selectedDayIndex, selectedMonthIndex);
   getDetailDayDescription(currentList, dayList, label3, label4);

   dayList := searchMinListElementByDayMonth(currentList,
                              selectedDayIndex, selectedMonthIndex);
   getDetailDayDescription(currentList, dayList, YearNumberMin, DetailMin);
end;

end.

