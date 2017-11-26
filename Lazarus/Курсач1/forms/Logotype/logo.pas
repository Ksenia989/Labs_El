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
    procedure Timer1StopTimer(Sender: TObject);
    //procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  StartPicture: TStartPicture;

implementation
uses mainform;

{$R *.lfm}

{ TStartPicture }

procedure TStartPicture.Timer1StopTimer(Sender: TObject);
begin
   Application.CreateForm(TWeatherForecast, WeatherForecast);
  WeatherForecast.ShowModal;
end;

end.

