Program 
    MatrixPower;

uses System;

Const 
  n : integer = 10;

Type
  tArray = array [1..n] of String;
  stringSet = set of String;  
Var
  rightIdentifiersSet : stringSet;
  sixteenConstSet : stringSet;
  i : integer;
  rightIdentifiersValue : integer;
  sixteenConstValue : integer;
  substring : String;
  ind : integer;
  substringLength : integer;
  justString : string;

Const
    programArray  : tArray =
    (('Program '),
    ('  ThisProgram'),
    ('Const'),
    (' c = $fa12387932cs;'),
    ('Var'),
    ('  rightIdentifiersSet, secondVariable : stringSet;'),
    ('  i : integer;'),
    (''),
    ('Begin'),
    ('End;'));

procedure writeInformationAboutSet(strSet : stringSet);
var 
  i : integer;
begin
  for i := 1 to n do
  begin
  foreach stt : string in 
        programArray[i].split(new char[1](' '), StringSplitOptions.RemoveEmptyEntries) do
        // внутри foreach
        begin
          justString := stt.Trim(new Char[2](';', ','));
          if (justString in strSet) then
            writeln(justString);
        end; 
  end;  
end;
  
Begin
  writeln('Начало подсчёта');
  // начальная инициализация
  rightIdentifiersSet := [];
  sixteenConstSet := [];

  // цикл по всем строкам
  for i := 1 to n do 
  begin
  // Выбираем 16 - е константы
  ind := pos('$', programArray[i]); 
  if (ind <> 0) then
  begin
    substringLength := length(programArray[i]) - ind;
    substring := copy(programArray[i], ind, substringLength);
    sixteenConstSet := sixteenConstSet + [substring];
    sixteenConstValue += 1;
  end;
  end; 

  // Выбираем правильные идентефикаторы
  for i := 1 to n - 1 do
  begin
    ind := pos('var', programArray[i]);
    if (ind = 0) then
      ind := pos('Var', programArray[i]);
    
    if (ind <> 0) then
    begin
      // выделяем подстроку, содержащую идентификаторы
      // вычисляем позицию двоеточия
      ind := pos(':', programArray[i + 1]);// отнимаем само : и пробел перед ним
      // получаем строку до двоеточия
      substring := programArray[i + 1].substring(1, ind); // строка вида (v1, v2)
      foreach stt : string in 
        substring.split(new string[1](', '), StringSplitOptions.RemoveEmptyEntries) do
        // внутри foreach
        begin
          justString := stt.Trim(new Char[3](' ', ':', ';'));
          rightIdentifiersSet := rightIdentifiersSet + [justString];
          rightIdentifiersValue += 1;  
        end;
        
      ind := 0;  
    end;
    
  end;
  
  //Вывод полученных данных
  writeln();
  writeln('Количество 16 - х констант = ', sixteenConstValue);
  writeInformationAboutSet(sixteenConstSet);
  
  //Вывод полученных данных
  writeln();
  writeln('Количество верных идентификаторов = ', rightIdentifiersValue);
  writeInformationAboutSet(rightIdentifiersSet);
End.