program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, MainForm, About, LinkedList, detailDayUnit,
infoAboutPeriod, fileSaver, sorting, savingFileHandler, saveOrNotForm
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TWeatherForecast, WeatherForecast);
  Application.CreateForm(TaboutProgram, aboutProgram);
  Application.CreateForm(TdetailDayInfo, detailDayInfo);
  Application.CreateForm(TdatailPeriodInfo, datailPeriodInfo);
  Application.CreateForm(TExitWithSave, ExitWithSave);
  Application.Run;
end.

