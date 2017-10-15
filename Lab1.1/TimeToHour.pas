program TimeToHour;

var
    min, hours : integer;
    
begin
    Write('Write input minutes ');
    ReadLn(min);

    //Вычисление часов
    hours := min div 60;
    min := min - hours * 60;

    Write(hours, ' hours, ', min, ' minutes');
end.