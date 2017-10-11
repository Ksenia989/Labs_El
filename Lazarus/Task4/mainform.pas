unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids;

type

  { TWeatherForecast }

  TWeatherForecast = class(TForm)
    About: TButton;
    Button1: TButton;
    Button4: TButton;
    SaveInRecord: TButton;
    OpenDialog1: TOpenDialog;
    Save: TButton;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;

    procedure AboutClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure SaveInRecordClick(Sender: TObject);

  private
    { private declarations }

  public
    { public declarations }
  end;

var
  WeatherForecast: TWeatherForecast;

implementation
uses unit1;
{$R *.lfm}

type
    TWeatherParameters = record
    date : String[20]; // todo для даты
    temperature : real;
    humidity : real;
    atmospherePressure : real;
    end;

const
  n : integer = 0;

var
  commonWeather : TWeatherParameters;
  tableChanged : boolean;
  weatherArray : array of TWeatherParameters;

{ TWeatherForecast }

procedure TWeatherForecast.FormCreate(Sender: TObject);
begin

end;

procedure TWeatherForecast.FormShow(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:= 'День';
  StringGrid1.Cells[1,0]:= 'Температура воздуха, C';
  StringGrid1.Cells[2,0]:= 'Влажность воздуха, %';
  StringGrid1.Cells[3,0]:= 'Атмосферное давление, мм.рт.ст';

  // Меняем высоту
  StringGrid1.ColWidths[0]:= 100;
  StringGrid1.ColWidths[1]:= 150;
  StringGrid1.ColWidths[2]:= 150;
  StringGrid1.ColWidths[3]:= 190;
end;

procedure TWeatherForecast.AboutClick(Sender: TObject);
begin
  AboutProgram.showModal;
end;

procedure TWeatherForecast.Button1Click(Sender: TObject);
begin
  if (StringGrid1.RowCount = 1) then //do nothin
   else
     StringGrid1.RowCount := StringGrid1.RowCount - 1;
end;

procedure TWeatherForecast.Button4Click(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

procedure TWeatherForecast.SaveClick(Sender: TObject);
begin

end;

procedure TWeatherForecast.SaveInRecordClick(Sender: TObject);
var
  i : integer;
  errCode : integer;
begin
  n := StringGrid1.RowCount;
  setLength(weatherArray, n - 1);
  for i := 0 to n - 2 do // -1 т.к. отнимаем заглавие
  begin
    weatherArray[i].date := StringGrid1.Cells[0, i + 1];
    val(StringGrid1.Cells[1, i + 1], weatherArray[i].temperature, errCode);
    val(StringGrid1.Cells[2, i + 1], weatherArray[i].humidity, errCode);
    val(StringGrid1.Cells[3, i + 1], weatherArray[i].atmospherePressure, errCode);
  end;
end;

end.

