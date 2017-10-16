unit infoAboutPeriod;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn;

type

  { TdatailPeriodInfo }

  TdatailPeriodInfo = class(TForm)
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  datailPeriodInfo: TdatailPeriodInfo;

implementation

{$R *.lfm}

end.

