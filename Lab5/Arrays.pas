program 
    ArrayProbe;
const
    n = 4;
var
    myArray : array [0..n] of real;
    firstPositiveElement : real;
    indexOfFirstPositiveElement : integer;
    i, j : integer;
    elementFounded : boolean;
    a, b : integer;

function inInterval(a : integer; b : integer; element : real) : boolean;
    Begin
        if ((element >= a) and (element <= b)) then 
            Begin
                inInterval := true;
            End
            else inInterval := false;
    End;
//procedure getFirstPositiveInteger()
begin
    writeLn('Введите элементы массива');
    for i := 0 to n do
    read(myArray[i]);
    writeLn();
    elementFounded := false;
    
    //firstPositiveElement := getFirstPositiveInteger;
    // Calculating of first positive number
    i := 0;
    while ((i < n) and (elementFounded = false)) do
    begin
        if (myArray[i] > 0) then 
            Begin 
                firstPositiveElement := myArray[i];
                elementFounded := true;
                indexOfFirstPositiveElement := i;
            End;
        inc(i);      
    end;
    if (elementFounded = false) then 
      Begin 
        writeLn('Positive elemnt is not found');
      end;
    writeLn('FirstPositiveNumber = ', firstPositiveElement);
    
    var 
      sum : real;
    sum := 0;
    for i := indexOfFirstPositiveElement + 1 to n do
        sum += myArray[i];

    writeLn('Сумма элементов массива после первого положительного индекса равна ', sum);
    writeLn('Введите элементы a, b - интервалы');
    readLn(a, b);
    if (a > b) then
      begin
        writeLn('Нижняя граница больше верхней границы');
      end;
      var
        insertIndex : integer;
      
      insertIndex := 0;
      for j := 0 to n do
      for i := insertIndex to n do
        Begin
            if (inInterval(a, b, myArray[i]) = true) then
                Begin
                    swap(myArray[insertIndex], myArray[i]);
                    inc(insertIndex);
                End;
        end;
        writeLn('Массив со значениями сначала в интервале от a до b, а потом с остальными', myArray);
    writeLn('Bubble sorting');
    for i := 0 to n do
      for j := n - 1 downto i do
        Begin
          if (myArray[j] < myArray[j + 1]) then
            Begin
              swap(myArray[j], myArray[j + 1]);
            End;
        End;
    writeLn(myArray);
 End.
