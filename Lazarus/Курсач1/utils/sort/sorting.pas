unit sorting;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Grids;

procedure sortInteger(var grid : TStringGrid; sortIndex : integer);
procedure sortDate(var grid : TStringGrid; sortIndex : integer);

implementation

{sortIndex - в какой колонке находится}
procedure sortInteger(var grid : TStringGrid; sortIndex : integer);
var
  i, j : integer;
  k : integer;
  errCode : integer;
  v1, v2 : integer;
begin
  with grid do
  begin
  for i := 1 to RowCount - 2 do
    for j := 1 to RowCount - 2 do
      begin
      val(cells[sortIndex, j], v1, errCode);
      val(cells[sortIndex, j + 1], v2, errCode);
      if (v1 > v2) then
      begin
        k := v1;
        v1 := v2;
        v2 := k;
        // преобразуем в строку значение
        cells[sortIndex, j] := v1.ToString;
        cells[sortIndex, j + 1] := v2.toString;
      end;
      end;
  end;
end;

procedure sortDate(var grid : TStringGrid; sortIndex : integer);
var
  i, j : integer;
  k : tDate;
  d1, d2 : TDate;
begin
  with grid do
  begin
  for i := 1 to RowCount - 2 do
    for j := 1 to RowCount - 2 do
      begin
      d1 := strToDate(cells[sortIndex, j], 'dd/mm/yy', '.');
      d2 := strToDate(cells[sortIndex, j + 1], 'dd/mm/yy', '.');
      if (d1 > d2) then
      begin
        k := d1;
        d1 := d2;
        d2 := k;
        // преобразуем дату в строку и ячейку
        cells[sortIndex, j] := dateToStr(d1);
        cells[sortIndex, j + 1] := dateToStr(d2);
      end;
      end;
  end;
end;

end.

