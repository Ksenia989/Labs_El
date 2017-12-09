program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, MainForm, About, LinkedList, detailDayUnit,
infoAboutPeriod, fileSaver, sorting, logo,
detailYearInformation
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;

  Application.Initialize;
  logo.StartPicture := logo.TStartPicture.Create(Application);
  logo.StartPicture.Show;
  logo.StartPicture.Update;
  while logo.StartPicture.Timer1.Enabled do
    Application.ProcessMessages;
  Application.CreateForm(TWeatherForecast, WeatherForecast);
  Application.CreateForm(TaboutProgram, aboutProgram);
  Application.CreateForm(TdetailDayInfo, detailDayInfo);
  Application.CreateForm(TdatailPeriodInfo, datailPeriodInfo);
  Application.CreateForm(TStartPicture, StartPicture);
  Application.CreateForm(TForm1, Form1);
  logo.StartPicture.Hide;
  logo.StartPicture.Free;
  Application.Run;
end.

