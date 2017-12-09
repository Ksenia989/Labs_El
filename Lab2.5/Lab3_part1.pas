Program 
    Sets;

uses System;

Const 
  n : integer = 14;

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
    (' c = $fa12387932cf;'),
    (' a = $1111;'),
    (' v = $sdjk;'),
    (' x = $cvg;'),
    (' b = $11ffff;'),
    ('Var'),
    ('  rightIdentifiersSet, secondVariable, sadf, r ightIdentifiersSet : stringSet;'),
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
        // ������ foreach
        begin
          justString := stt.Trim(new Char[2](';', ','));
          if (justString in strSet) then
            writeln(justString);
        end; 
  end;  
end;

function rightIdentificator(justString : String) : boolean;
var i : integer;
begin
    rightIdentificator := true;
    for i := 1 to length(justString) do
    begin
        if (not(justString[i] in ['a'..'z','A'..'Z','_'])) then
        rightIdentificator := false;
    end;
end;

function right16xSet(justString : String) : boolean;
var i : integer;
begin
    right16xSet := true;
    for i := 1 to length(justString) do
    begin
        if (not(justString[i] in ['a'..'f','A'..'F','0'..'9','$'])) then
        right16xSet := false;
    end;
end;
  
Begin
  writeln('������ ��������');
  // ��������� �������������
  rightIdentifiersSet := [];
  sixteenConstSet := [];

  // ���� �� ���� �������
  for i := 1 to n do 
  begin
  // �������� 16 - � ���������
  ind := pos('$', programArray[i]); 
  if (ind <> 0) then
  begin
    substringLength := length(programArray[i]) - ind;
    substring := copy(programArray[i], ind, substringLength);
    if (right16xSet(substring)) then
    begin
        sixteenConstSet := sixteenConstSet + [substring];
        sixteenConstValue += 1;
    end;
  end;
  end; 

  // �������� ���������� ��������������
  for i := 1 to n - 1 do
  begin
    ind := pos('var', programArray[i]);
    if (ind = 0) then
      ind := pos('Var', programArray[i]);
    
    if (ind <> 0) then
    begin
      // �������� ���������, ���������� ��������������
      // ��������� ������� ���������
      ind := pos(':', programArray[i + 1]);// �������� ���� : � ������ ����� ���
      // �������� ������ �� ���������
      substring := programArray[i + 1].substring(1, ind); // ������ ���� (v1, v2)
      foreach stt : string in 
        substring.split(new string[1](', '), StringSplitOptions.RemoveEmptyEntries) do
        // ������ foreach
        begin
          justString := stt.Trim(new Char[3](' ', ':', ';'));
          if (rightIdentificator(justString)) then 
          begin
            rightIdentifiersSet := rightIdentifiersSet + [justString];
            rightIdentifiersValue += 1;  
          end;
        end;
        
      ind := 0;  
    end;
    
  end;
  
  //����� ���������� ������
  writeln();
  writeln('���������� 16 - � �������� = ', sixteenConstValue);
  writeInformationAboutSet(sixteenConstSet);
  
  //����� ���������� ������
  writeln();
  writeln('���������� ������ ��������������� = ', rightIdentifiersValue);
  writeInformationAboutSet(rightIdentifiersSet);
End.