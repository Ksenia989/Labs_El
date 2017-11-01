unit logo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TStartPicture }

  TStartPicture = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  StartPicture: TStartPicture;

implementation

{$R *.lfm}

{ TStartPicture }

procedure TStartPicture.FormShow(Sender: TObject);
begin
  //startPicture.OnShowModalFinished:=;
end;

end.

