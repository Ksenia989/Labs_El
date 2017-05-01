program PrintFunctionTable;

const
  LEFT_BORDER : integer = -7;
  RIGHT_BORDER : integer = 3;
var
  intervalBeginning, y , intervalEnding, step : real;
  width : integer;
  
  procedure writeHeader(width : integer);
  var interval : integer;
  begin
    write('╔');
    for i : integer := 1 to width + 5 do 
    write('═');
    write('╤');
    for i : integer := 1 to width + 5 do 
    write('═');
    writeLn('╗');
    write('║');
    if (width mod 2 = 0) then interval := (width + 5) div 2
    else interval := ((width + 5) div 2) - 1;
    for i : integer := 1 to interval do 
    write(' ');
    write('X');
    for i : integer := 1 to ((width + 5) div 2) do 
    write(' ');
    write('│');
    if (width mod 2 = 0) then interval := (width + 5) div 2
    else interval := ((width + 5) div 2) - 1;
    for i : integer := 1 to interval do 
    write(' ');
    write('Y');
    for i : integer := 1 to ((width + 5) div 2) do 
    write(' ');
    writeLn('║');   
  end;
  
  procedure writeLine(width : integer);
    begin
      write('╟');
      for i : integer := 1 to width + 5 do 
      write('─');
      write('┼');
      for i : integer := 1 to width + 5 do 
      write('─');
      writeLn('╢');
    end;
  
  procedure writeXYValue(x, y : real; width : integer);
    begin 
      write('║ ');
      write(x : (width + 3) : width);
      write(' │ ');
      write(y : (width + 3) : width);
      writeLn(' ║');
    end;
    
    procedure writeEnding(width : integer);
      begin
      write('╚');
      for i : integer := 1 to width + 5 do 
      write('═');
      write('╧');
      for i : integer := 1 to width + 5 do 
      write('═');
      writeLn('╝');
      end;
    
begin
  writeLn('Введите левую границу, правую границу и шаг'); 
  read(intervalBeginning, intervalEnding, step);
  if (intervalBeginning > intervalEnding) then
    begin 
      writeLn('Ошибка - верхняя граница меньше нижней границы, введите корректные данные'); 
      readLn(intervalBeginning, intervalEnding); 
    end;
  
  // корректировка данных
  if ((intervalBeginning < LEFT_BORDER) and (intervalEnding < LEFT_BORDER)) then begin writeln('Числа вне диапазона'); exit; end;
  if ((intervalBeginning > RIGHT_BORDER) and (intervalEnding > RIGHT_BORDER)) then begin writeln('Числа вне диапазона'); exit; end;
  if ((intervalBeginning < LEFT_BORDER) and (intervalBeginning < RIGHT_BORDER)) then
    intervalBeginning := LEFT_BORDER;
  if ((intervalEnding > RIGHT_BORDER) and (intervalEnding > LEFT_BORDER)) then
    intervalEnding := RIGHT_BORDER;
    
  writeLn('Отредактированная длина');
  writeln('x = ', intervalBeginning,' y = ', intervalEnding);
  
  writeln('Введите точность числа (число знаков после ",")');
  width := -1;
  while (width < 0) do
    begin
      readLn(width);
      if (width < 0) then writeln('Длина не может быть отрицательной');
    end;
    
  writeHeader(width);
  writeLine(width);
  
  // вывод значений
  while(intervalBeginning <= intervalEnding) do
    begin
    if (intervalBeginning <= -6) then
      y := 2
      else if (intervalBeginning <= -2) then
        y := 0.25 * intervalBeginning + 0.5
        else if (intervalBeginning <= 0) then
          y := -sqrt(4 - sqr(intervalBeginning + 2))
          else if (intervalBeginning <= 2) then
            Y := sqrt(4 - sqr(intervalBeginning))
            else y := -intervalBeginning + 2;
     writeXYValue(intervalBeginning, y, width);
     if (intervalBeginning <= (intervalEnding - step)) then writeLine(width);
     intervalBeginning := intervalBeginning + step;
    end;
  writeEnding(width); 
end.