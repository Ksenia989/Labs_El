unit infoAboutPeriod;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, ExtCtrls;

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

procedure showInfo(var labell : TLabel; day : TDate);
begin
  labell.caption := dateToStr(day)
                 + #13#10
                 + 'День'
                 + #13#10
                 + 'Ночь'
                 + #13#10;

end;

procedure TdatailPeriodInfo.Button1Click(Sender: TObject);
begin
  showInfo(label4, dateFrom.Date);
end;

end.

