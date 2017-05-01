program 
  informationAboutCountry;

var
  country: integer;

begin
  writeLn('Выберете страну');
  writeLn('1.Чили');
  writeLn('2.Чад');
  writeLn('3.Китай');
  writeLn('4.Россия');
  writeLn('5.США');
  writeLn('6.Норвегия');
  writeLn('7.Индия');
  writeLn('8.Австралия');
  
  readLn(country);
  case (country) of
    1 : 
      writeln('Континент - Южная Америка');
    5 : 
      writeln('Континент - Северная Америка');
    8 : 
      writeln('Континент - Австралия');
    2 : 
      writeln('Континент - Африка');
    3, 4, 7, 6 : 
      writeln('Континент - Евразия');
  else 
    writeln('Нет информации о такой стране');
  end;
end.