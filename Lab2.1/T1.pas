program 
  WayMemorizer;

const
	n = 7;
	tableWidth = 15;

type
    range = record
            beginning : longint;
            ending : longint;
        end;

    birthDay = record
		    day : integer;
		    month : integer;
		    year : integer;
		end;

    name = record
		firtsName : string;
		lastName : string;
		phoneNumber : string;
		bDay : birthDay;
	end;
	
	stringArray = array[0..5] of string;
	
	stringValues = record
	        valuesArray : stringArray; 
	    end;
	
	nameArray = array[0..n] of name;
	
const
    monthRange : range = (beginning : 1; ending : 31);
    dayRange : range = (beginning : 1; ending : 12);
    yearRange : range = (beginning : 1000; ending : 2018);
    myConstNames : nameArray
		= ((firtsName:'Торгаева'; lastName:'Ксения'; phoneNumber:'89106303727'; bDay:(day:30; month:9 ;year:1943)),
		        (firtsName : 'Сарычев'; lastName : 'Андрей'; phoneNumber : '89106302983'; bDay:(day:15; month:3 ;year:1963)),
		        (firtsName : 'Кракозяброва'; lastName : 'Алина'; phoneNumber : '88762567893'; bDay:(day:20; month:9 ;year:1963)),
		        (firtsName : 'Толстозубова'; lastName : 'Анна'; phoneNumber : '87542885697'; bDay:(day:23; month:9 ;year:1938)),
		        (firtsName : 'Терёхина'; lastName : 'Елена'; phoneNumber : '89066486342'; bDay:(day:4; month:7 ;year:1956)),
		        (firtsName : 'Воскобойник'; lastName : 'Виктор'; phoneNumber : '891579867646'; bDay:(day:4; month:9 ;year:1943)),
		        (firtsName : 'Мазуров'; lastName : 'Дмитрий'; phoneNumber : '89107666789'; bDay:(day:21; month:2 ;year:1998)),
		        (firtsName : 'Саликов'; lastName : 'Вадим'; phoneNumber : '891068665470'; bDay:(day:6; month:12 ;year:1968)));

var   
	myName : name;
	myNameArray : nameArray;
	strArrPointer : ^stringValues;
	selectedName : integer; 
	
(*
    Функция, считывающая номера в числовых значениях
*)
function readNumber(numberRange : range) : integer;
	var resulter : integer;
    begin
        try
		    write('Введите номер, пожалуйста : ');
			readln(resulter);
	    except on System.Exception do
	        begin
		        writeln('Это неверный номер, введите другой!');
		        readNumber(numberRange);
		    end;
        end;
        
        if ((resulter < numberRange.beginning) or (resulter > numberRange.ending)) then 
            begin
                writeln('Неверное число. Введите число от ', numberRange.beginning,' до ', numberRange.ending);
                readNumber(numberRange);
            end;
            
        readNumber := resulter;
    end;

(*
    Процедура,считывающая все значения в записи
*)
procedure readValues();
	var i : integer;
	begin
		for i := 0 to n do
		begin
		    writeln('Привет! Это имя # ', i, ', пожалуйста, напишете значения');
			write('Имя : ');
			readln(myName.firtsName);
			write('Фамилия : ');
			readln(myName.lastName);
			write('Номер телефона : ');
			readln(myName.phoneNumber);
			write('День рождения : ');
		    myName.bDay.day := readNumber(dayRange);
		    write('Месяц рождения : ');
		    myName.bDay.month := readNumber(monthRange);
		    write('Год рождения : ');
		    myName.bDay.year := readNumber(yearRange);
			myNameArray[i] := myName;
		end;
	end;

(*
    Процедура, печатающая таблицу с без значений ╟------┼------╢
*)
procedure writePlainSymbolOrValue(plainSymbol : string; valuesPointer : ^stringValues; i : integer);
    var 
        j : integer;
    begin
        if (valuesPointer = nil) then
            for j := 1 to tableWidth do
        	    write(plainSymbol)
        else
            write(valuesPointer^.valuesArray[i]);        	    
    end;

(*
    Процедура, печатающая часть таблицы (1 строку) в зависимости от входных данных
*)
procedure writePart(beginning : string; plainSymbol : string; divider : string; endSymbol : string; valuesPointer : ^stringValues);
    var 
        i, j : integer;
    const
        columnsNumber : integer = 5;
    begin
     	write(beginning);
    	for i := 0 to columnsNumber do 
    		begin
    		    writePlainSymbolOrValue(plainSymbol, valuesPointer, i);
        		if (i <> columnsNumber) then write(divider);			
    		end;
        writeLn(endSymbol);
    end;

(*
    Процедура, печатающая строку со значениями ╟  92 ┼ Ksenya ╢
*)    
procedure writePart(myName : name);
    var 
        strArray : stringValues;
    begin
        str(myName.firtsName : tableWidth, strArray.valuesArray[0]);
	    str(myName.lastName : tableWidth, strArray.valuesArray[1]);
	    str(myName.phoneNumber : tableWidth, strArray.valuesArray[2]);
	    str(myName.bDay.day : tableWidth, strArray.valuesArray[3]);
	    str(myName.bDay.month : tableWidth, strArray.valuesArray[4]);
	    str(myName.bDay.year : tableWidth, strArray.valuesArray[5]);
	    strArrPointer := @strArray;
	    writePart('║', '', '│', '║', strArrPointer);
    end;

(*
    Процедура, печатающая заголовок
*)
procedure writeHeader();
    var 
        strArray : stringValues;
    begin
        str('Имя' : tableWidth, strArray.valuesArray[0]);
	    str('Фамилия' : tableWidth, strArray.valuesArray[1]);
	    str('Номер телефона' : tableWidth, strArray.valuesArray[2]);
	    str('День рождения' : tableWidth, strArray.valuesArray[3]);
	    str('Месяц рождения' : tableWidth, strArray.valuesArray[4]);
	    str('Год рождения' : tableWidth, strArray.valuesArray[5]);
	    strArrPointer := @strArray;
	    writePart('║', '', '│', '║', strArrPointer);
	    writePart('╟', '─', '┼', '╢', nil);
	end;

(*
    Процедура, печатающая таблицу со значениями целиком
*)
procedure writeTableWithValues(myNameArray : nameArray);
    var 
        i : integer;
	begin
        writePart('╔', '═', '╤', '╗', nil);
        writeHeader();
	    for i:= 0 to n do
	        begin
	            writePart(myNameArray[i]);
	            if (i < n) then writePart('╟', '─', '┼', '╢', nil);
	        end;
	    writePart('╚', '═', '╧', '╝', nil);    
	end;

(*
    Процедура, осуществляющая пузырьковую сортировку
*)	
procedure makeBubbleSorting(Var myArray : nameArray);
	Begin
	  for i : integer := 0 to n do
	  for j : integer := n - 1 downto i do
		Begin
		  if (myArray[j].lastName < myArray[j + 1].lastName) then
			Begin
				swap(myArray[j], myArray[j + 1]);
			End;
		End;
	End;

(*
    Процедура, выводящая одну запись о человеке на экран
*)	
procedure displayOneRaw(n : name);
    begin
        writeln();
        writeln('-----Выбранная запись-----');
        writeln('Имя = ', n.firtsName );
        writeln('Фамилия = ', n.firtsName );
	    writeln('Номер телефона = ', n.phoneNumber);
	    writeln('День рождения = ', n.bDay.day);
	    writeln('Месяц рождения = ', n.bDay.month);
	    writeln('Год рождения = ', n.bDay.year); 
        writeln('---Конец выбранной записи---');
        writeln();
    end;	

(*
    Процедура, осуществляющая выборку из исходной таблицы
*)	
procedure selectPerson(myNameArray : nameArray; numberForSearch : integer);
    var 
        i : integer;
        isRawsWithSuchNumber : boolean;
    begin
        isRawsWithSuchNumber := false;
        for i := 0 to n do
            begin
                if (myNameArray[i].bDay.month = numberForSearch) then
                    begin
                        displayOneRaw(myNameArray[i]);
                        isRawsWithSuchNumber := true;
                    end;
            end;
            if (isRawsWithSuchNumber = false) then
                begin
                    writeln('Нет записи с подобным месяцем!')
                end;
    end;
    
begin
	myNameArray := myConstNames;
	writeTableWithValues(myNameArray);
    makeBubbleSorting(myNameArray);
    writeln('Отсортированный массив');
    writeTableWithValues(myNameArray);
    while (true) do begin
        writeln('Напечатайте, пожалуйста, номер месяца для выборки данных');
        selectedName := readNumber(monthRange);
        selectPerson(myNameArray, selectedName);
    end;
end.