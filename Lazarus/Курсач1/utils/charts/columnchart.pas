unit columnChart;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, linkedList,  ExtCtrls, Graphics;

{public declarations}
procedure draw(image : TImage; val1 : integer; val2 : integer
                     ; header : string);

implementation

function selectColours(i : integer) : TColor;
var
  coloursArray : array[0 .. 1] of TColor;
begin
  coloursArray[0] := clBlue;
  coloursArray[1] := clRed;
  selectColours := coloursArray[i mod 2];
end;

procedure writecColoursAndNames(image : TImage; i : integer; colour: TColor; s : string);
var
  y : integer;
  x : integer;
begin
  image.Canvas.Brush.Color := colour;
  x := 120;   // todo расстояние между графиком
  y := 15 + (i * 20);
  image.Canvas.brush.Style := bsSolid;
  image.Canvas.Brush.Color := selectColours(i);
  Image.Canvas.Rectangle(x - 10, y - 10, x, y);
  image.Canvas.Brush.Color := clwhite;
  Image.Canvas.TextOut(x + 5, y - 10, s);
end;

procedure writeTemperature(image : Timage);
begin
  image.canvas.Font.Color:= clblack;
  image.Canvas.Line(15, 22, 15, 153);
  image.Canvas.Line(10, 35, 15, 22);
  image.Canvas.Line(20, 35, 15, 22);
  image.canvas.Font.Size := 7;
  image.canvas.TextOut(5, 10, 't °C');
end;

procedure writeScale(image : Timage);
const
  height : integer = 85;
  width : integer = 135;
begin
  image.canvas.Font.Color:= clblack;
  image.Canvas.Line(15, height, width, height);
  image.Canvas.Line(125, height - 6, width, height);
  image.Canvas.Line(125, height + 6, width, height);
  image.canvas.Font.Size := 7;
  image.canvas.TextOut(width + 2, height + 2, 'Сутки');
end;

procedure draw(image : TImage; val1 : integer; val2 : integer
                     ; header : string);
var
  i : integer;
  calculatedHeight: integer;
  x, y : integer;
  name : String;
  value : String;
  sum : integer;
  maxHeight, minHeight : integer;
begin
  Image.Canvas.Brush.Color := clWhite;
  image.Canvas.Rectangle(0, 0, image.Width, image.Height);
  Image.Canvas.TextOut(30,10, header);
  image.Color := clwhite;
  minHeight := 60;
  maxHeight := 140;
  sum := abs(val1) + abs(val2);
  x := 20;
  y := 85; // середина шкалы

    for i := 1 to 2 do
    begin
      if (val1 > 0) then
        calculatedHeight := y - round((maxheight - minHeight) * val1 / sum)
      else
         calculatedHeight := y + round((maxheight - minHeight) * abs(val1) / sum);

      image.Canvas.Brush.Color := selectColours(i);
      // 135 - это середина шкалы
      Image.Canvas.Rectangle(x + 25, y, x, calculatedHeight);
      // На линии отметки с температурой
      image.canvas.Line(14, calculatedHeight, 17, calculatedHeight);
      // текст - температура
      str(val1, value);
      image.Canvas.Brush.Color := clwhite;
      image.canvas.Font.Color:= clblack;
      image.canvas.Font.Size := 6;
      image.canvas.textOut(2, calculatedHeight - 7, value);

      image.Canvas.Brush.Color := clwhite;
      x := x + 30;
      if (i = 1) then name := 'День' else name := 'Ночь';
      writecColoursAndNames(image, i, image.Canvas.Brush.Color, name);
      val1 := val2;
    end;
    writeScale(image);
    writeTemperature(image);
end;

end.

