program 
  informationAboutCountry;

var
  country: integer;

begin
  writeLn('�������� ������');
  writeLn('1.����');
  writeLn('2.���');
  writeLn('3.�����');
  writeLn('4.������');
  writeLn('5.���');
  writeLn('6.��������');
  writeLn('7.�����');
  writeLn('8.���������');
  
  readLn(country);
  case (country) of
    1 : 
      writeln('��������� - ����� �������');
    5 : 
      writeln('��������� - �������� �������');
    8 : 
      writeln('��������� - ���������');
    2 : 
      writeln('��������� - ������');
    3, 4, 7, 6 : 
      writeln('��������� - �������');
  else 
    writeln('��� ���������� � ����� ������');
  end;
end.