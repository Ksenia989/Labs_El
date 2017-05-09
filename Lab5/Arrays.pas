program 
	ArrayProbe;
const
	n = 10;
type
	tArray = array [0..n] of real;
var
	myArray : tArray;
	firstPositiveElement : real;
	indexOfFirstPositiveElement : integer;
	i, j : integer;
	elementFounded : boolean;
	a, b : integer;
	sum : real;

function inInterval(a : integer; b : integer; element : real) : boolean;
	Begin
		if ((element >= a) and (element <= b)) then 
			Begin
				inInterval := true;
			End
		else 
			Begin
				inInterval := false;
			End;
	End;
	
procedure getFirstPositiveInteger(arr : tArray; Var firstPositiveInteger : real);
  Var
		i : integer;
  Begin
	i := 0;
	elementFounded := false;
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
  End;
  
procedure bubbleSorting(Var myArray : tArray);
	Begin
	  for i : integer := 0 to n do
	  for j : integer := n - 1 downto i do
		Begin
		  if (myArray[j] < myArray[j + 1]) then
			Begin
				swap(myArray[j], myArray[j + 1]);
			End;
		End;
	End;
	
procedure arrayReader(Var myArrray : tArray);
	Begin
		for i : integer := 0 to n do
			Begin
				read(myArray[i]);
			End;
	End;

procedure elementsSumAfterFirstPositiveValue(myArray : tArray; Var sum : real);
	Begin
		sum := 0;
		for i : integer := indexOfFirstPositiveElement + 1 to n do
			Begin
				sum += myArray[i];
			End;
	End;

procedure printFirstPositiveInteger(firstPositiveElement : real);
	Begin
		if (elementFounded = false) then 
			Begin 
				writeLn('Positive element is not found');
	  		end 
	  	else
	  		Begin
				writeLn('FirstPositiveNumber = ', firstPositiveElement);
	  		End;
	End;

procedure checkIntervalBoards(a, b : integer);
	Begin
		if (a > b) then
	  		begin
				writeLn('Нижняя граница больше верхней границы');
	  	end;
	End;

procedure modifyArrayElementsWhichLieWithinIntervalFirst(Var myArray : tArray);
	var
		insertIndex : integer;
	Begin
		insertIndex := 0;
		for j : integer := 0 to n do
			for i : integer := insertIndex to n do
				Begin
					if (inInterval(a, b, myArray[i]) = true) then
						Begin
							swap(myArray[insertIndex], myArray[i]);
							inc(insertIndex);
						End;
				End;
		writeLn();
	End;

begin
	writeLn('Введите элементы массива');
	arrayReader(myArray);
	getFirstPositiveInteger(myArray, firstPositiveElement);
	printFirstPositiveInteger(firstPositiveElement);	
	elementsSumAfterFirstPositiveValue(myArray, sum);
	writeLn('Сумма элементов массива после первого положительного индекса равна ', sum);
	writeLn('Вывод массива со значениями сначала в интервале от a до b, а потом с остальными ');
	writeLn('Введите элементы a, b - интервалы ');
	readLn(a, b);
	checkIntervalBoards(a, b);
	// TODO: придумать название поудачнее
	modifyArrayElementsWhichLieWithinIntervalFirst(myArray);
	writeLn('Массив со значениями сначала в интервале от a до b, а потом с остальными ', myArray);
	writeLn('Сортировка массива методом пузырька ');
	bubbleSorting(myArray);
	writeLn('Отсортированный массив ', myArray);
 End.
