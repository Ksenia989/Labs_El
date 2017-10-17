unit infoAboutPeriod;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, ExtCtrls;

type

  { TdatailPeriodInfo }

  TdatailPeriodInfo = class(TForm)
    DateEdit1: TDateEdit;
    Thursday: TImage;
    majorChart: TImage;
    Monday: TImage;
    Tuersday: TImage;
    Wednesday: TImage;
    Friday: TImage;
    Saturday: TImage;
    Sunday: TImage;
    additionInfo: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
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

procedure TdatailPeriodInfo.FormCreate(Sender: TObject);
  procedure initializeWeekDays;
  begin
    dayArray[0] := monday;
    dayArray[1] := Tuersday;
    dayArray[2] := Wednesday;
    dayArray[3] := Thursday;
    dayArray[4] := Friday;
    dayArray[5] := Saturday;
    dayArray[6] := Sunday;
  end;
begin
  initializeWeekDays;

end;

end.

