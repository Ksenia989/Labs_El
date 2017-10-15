program
  functionCalculator;

var
  x, y : real;

begin
  writeLn('¬ведите значение х, которое необходимо вычислить ');
  readLn(x);
  
  if (x >= -2) then
    begin
      if (x < 0) then
        y := - sqrt(4 - sqr(x + 2)) + 2 // 3 участок
      else
        begin
          if (x < 2) then
            y := sqrt(4 - sqr(x)) // 4 участок
            else
              y := -x + 2; // 5 участок
        end;
    end
    else 
      begin
        if (x >= -6) then // 2 участок
          y := 0.25 * x + 0.5
          else 
          y := 2; // 1 участок
      end;
  writeLn('–езультат = ', y);    
end.
    