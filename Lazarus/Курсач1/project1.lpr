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
  Application.CreateForm(TWeatherForecast, WeatherForecast);
  Application.CreateForm(TaboutProgram, aboutProgram);
  Application.CreateForm(TdetailDayInfo, detailDayInfo);
  Application.CreateForm(TdatailPeriodInfo, datailPeriodInfo);
  Application.CreateForm(TStartPicture, StartPicture);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

