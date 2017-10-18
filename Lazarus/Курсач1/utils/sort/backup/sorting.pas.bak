unit sorting;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

implementation

procedure sort(var arr : array of string);
var
  i, j : integer;
  k : String;
begin
  for i := 1 to length(arr) - 1 do
    for j := 1 to length(arr) - i do
      if arr[j] > arr[j + 1] then
      begin
        k := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := k
      end;
end;

end.

