program
  functionCalculator;

var
  x, y : real;

begin
  writeLn('������� �������� �, ������� ���������� ��������� ');
  readLn(x);
  
  if (x >= -2) then
    begin
      if (x < 0) then
        y := - sqrt(4 - sqr(x + 2)) + 2 // 3 �������
      else
        begin
          if (x < 2) then
            y := sqrt(4 - sqr(x)) // 4 �������
            else
              y := -x + 2; // 5 �������
        end;
    end
    else 
      begin
        if (x >= -6) then // 2 �������
          y := 0.25 * x + 0.5
          else 
          y := 2; // 1 �������
      end;
  writeLn('��������� = ', y);    
end.
    