Program 
    MatrixPower;

Const
    // ���������,������������ ���������� ����� � �������� � ���������� �������
    n : integer = 4;
    
Type
    // ��� - ������� ��������� 
    t = 0..n-1;
    TMiniArray = array[t] of real;
    TArray = array [t, t] of real;     
    
Var
    // �������� �������
    myMatrix : TArray;
    res : integer;

(*
    �������, �����������, �� �������� �� ������� ��������� ������� ���������.
    ���� ��������, �� �� ��� �� ��������� ��� ������������, �.�. �� ��� ����������� 
*)
function elemGlavnDiagMensheZadannogo(indexForReplacement : integer
                            ; i : integer; j : integer) : boolean;
begin
    elemGlavnDiagMensheZadannogo := not((i < indexForReplacement) and (i = j));
                                    //���� ������� �� �����������,�� �� ��� �� ����
end;

(*
    �������, ����������� ����� �������� �� ��������� �������
*)
function foundWithUpBoard(upBoard : real; var myMatrix : TArray
                                        ; indexForReplacement : integer) : real;
var
    i, j : integer;
    max : real;
    xj, xi : integer; // ����������� ������������ �������
begin
    max := -maxReal;
    for i := 0 to n - 1 do
    for j := 0 to n - 1 do
    begin
        if(elemGlavnDiagMensheZadannogo(indexForReplacement, i, j) 
                                    and (myMatrix[i, j] <= upBoard) 
                                    and (myMatrix[i, j] >= max)) then
        begin
            xi := i;
            xj := j;
            max := myMatrix[i, j];
        end;
    end;
    swap(myMatrix[xi, xj], myMatrix[indexForReplacement, indexForReplacement]);
    foundWithUpBoard := max;
end;

(*
    ���������, ������������ ���������� �������� �� ������� ���������   
*)
procedure replaceElements(var myMatrix : TArray);
var 
    upBoard : real;
    indexForReplacement : integer;
begin
    upBoard := maxReal;
    for indexForReplacement := 0 to n - 1 do
        upBoard := foundWithUpBoard(upBoard, myMatrix, indexForReplacement);
end;

(*
    ���������,��������� ������� �� ������
*)
procedure writeMatrix(m : TArray);
var
    i, j : integer;
begin
    for i := 0 to n - 1 do
    begin
    for j := 0 to n - 1 do
        write(m[i, j], ' ');
        writeln();
    end;
    writeln();
end;

(*
   ���������, ����������� ������� ���������� ���������� � �������� ���������
*)
procedure fillMatrix(var myMatrix : Tarray);
var
    i, j : integer;
begin
    for i := 0 to n - 1 do
        for j := 0 to n - 1 do
        myMatrix[i, j] := random(-10, 1);
end;

function readByRaws(arr : TMiniArray) : boolean;
var 
    i : integer;
begin
   for i := 0 to n - 1 do
   begin
        // do somethingWItharray   
   end;
end;

(*
    ���������,��������� ����� ������ � ���� ������
          , ���� ��� �� �������� �� ������ �������������� ��������
*)
 procedure writeIfNotPlus(myMatrix : TArray; var res : integer);
 var
    i, j : integer;
    isNegative : boolean;
    counter : integer;
 begin
    i := 0;
    res := -1;
    isNegative := false;// ���� �� - �������������
    while ((i <= n - 1) and (res = -1)) do// ������ �� �������
    begin
       counter := 0; 
       for j := 0 to n - 1 do 
       begin
       if (myMatrix[i, j] < 0) then
           inc(counter)
       end;
       if (counter = n) then // ������ ������
           res := i;
       i := i + 1;
    end;
    
    for i := 0 to n-1 do
        readByRaws(myMatrix[i]); 
 end;
  
begin
    writeln('�������� �������');
    fillMatrix(myMatrix);
    writeMatrix(myMatrix);
    writeln('������� � ��������������� ����������');
    replaceElements(myMatrix);
    writeMatrix(myMatrix);
    writeln('������� ������, �� ���������� �� ������ �������������� ��������');
    writeIfNotPlus(myMatrix, res);
    if (res <> -1) then writeln('������ ������ = ', res)
    else
    writeln('��� ������ ������ � �������������� ����������');
end.