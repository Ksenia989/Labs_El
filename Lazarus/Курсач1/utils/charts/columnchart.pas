unit columnChart;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, linkedList,  ExtCtrls, Graphics;

{public declarations}
procedure draw(image : TImage; currentList : list
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

procedure writecColoursAndNames(image : TImage; i : Integer; colour: TColor; s : string);
var
  y : integer;
  x : integer;
begin
  image.Canvas.Brush.Color := colour;
  x := 120;
  y := 45 + (i * 20 + (i-1) * 10 );
  image.Canvas.brush.Style := bsSolid;
  image.Canvas.Brush.Color := selectColours(i);
  Image.Canvas.Rectangle(x - 25, y - 25, x, y);
  image.Canvas.Brush.Color := clwhite;
  Image.Canvas.TextOut(x + 10, y - 22, s);
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
begin
  image.canvas.Font.Color:= clblack;
  image.Canvas.Line(15, 153, 135, 153);
  image.Canvas.Line(125, 148, 135, 153);
  image.Canvas.Line(125, 159, 135, 153);
  image.canvas.Font.Size := 7;
  image.canvas.TextOut(137, 143, 'Сутки');
end;

procedure draw(image : TImage; currentList : list
                     ; header : string);
var
  sum : integer;
  i : integer;
  inputHeight, calculatedHeight: integer;
  maxSize : integer;
  x, y : integer;
  stringPerCents : string;
  name : String;
begin
  Image.Canvas.Brush.Color := clWhite;
  image.Canvas.Rectangle(0, 0, image.Width, image.Height);
  Image.Canvas.TextOut(20,10, header);
  image.Color := clwhite;
  sum := 0;
    sum := currentList^.temperature + currentList ^.next^.temperature;
    maxsize := 140;
    x := 20;
    y := 150;
      for i := 1 to 2 do
        begin
          inputHeight := currentList^.temperature;
          calculatedHeight := round(maxSize * (inputHeight / sum));
          image.Canvas.Brush.Color := selectColours(i);
          Image.Canvas.Rectangle(x + 25,y - calculatedHeight, x, y);
          stringPerCents :=  intToStr(round(inputHeight / sum * 100)) + '%';
          image.Canvas.Brush.Color := clwhite;
          Image.Canvas.TextOut(x, y - calculatedHeight - 30,stringPerCents);
          x := x + 30;
          if (i = 1) then name := 'День' else name := 'Ночь';
          writecColoursAndNames(image, i, image.Canvas.Brush.Color, name);
          currentList := currentList^.next;
        end;
      writeScale(image);
      writeTemperature(image);
end;

end.

