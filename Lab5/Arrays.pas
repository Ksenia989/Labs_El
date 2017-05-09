program ideone;
const
    n = 10;
var
    myArray : array [0..n] of real;
    firstPositiveElement : real;
    i : integer;
    elementFounded : boolean;
begin
    writeLn('Введите элементы массива');
    for i := 0 to (myArray.length() - 1) do
    read(myArray[i]);
    writeLn();
    
    // Calculating of first positive number
    i := 10;
    while ((i <> myArray.length() - 1) or (elementFounded))
    begin
        if (array[i] > 0) then 
            Begin 
                firstPositiveElement := myArray[i];
                elementFounded := true;
            End;
        inc(i);
        if (i = myArray.length() - 1) then writeLn('Positive lement is not found');
    end;
 End.
