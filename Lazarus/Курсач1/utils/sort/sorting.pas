unit sorting;

{$mode objfpc}{$H+}

(*
Модуль, отвечающий за сортировку
Реализует сортировку по дате и по температуре
*)

interface

uses
  Classes, SysUtils, Grids;

procedure sortInteger(var grid : TStringGrid; sortIndex : integer);
procedure sortDate(var grid : TStringGrid; sortIndex : integer);

implementation

{sortIndex - в какой колонке находится}
(*
Продедура, реализующая сортировку по температуре
*)
procedure sortInteger(var grid : TStringGrid; sortIndex : integer);
var
  i, j : integer;
  errCode : integer;
  v1, v2,k : integer;// для обмена
begin
  // проходим по всем элементам
  for i := 1 to grid.RowCount - 2 do
    for j := 1 to grid.RowCount - 2 do
      begin
        val(grid.cells[sortIndex, j], v1, errCode);
        val(grid.cells[sortIndex, j + 1], v2, errCode);
        if (v1 > v2) then
        begin
          // меняем переменные местами
          k := v1;
          v1 := v2;
          v2 := k;
        end;
      end;
end;

(*
Продедура, реализующая сортировку по дате
*)
procedure sortDate(var grid : TStringGrid; sortIndex : integer);
var
  i, j : integer;
  k : tDate;
  d1, d2 : TDate;
begin
  // для того, чтобы меньше писать
  with grid do
  begin
  for i := 1 to RowCount - 2 do
    for j := 1 to RowCount - 2 do
      begin
        // задаём формат даты
        d1 := strToDate(cells[sortIndex, j], 'dd/mm/yy', '.');
        d2 := strToDate(cells[sortIndex, j + 1], 'dd/mm/yy', '.');
        if (d1 > d2) then
        begin
          // меняе местами
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

