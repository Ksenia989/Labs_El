program 
  WayMemorizer;

const
	n = 1;
	tableWidth = 15;

type
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

var 
	myName : name;
	myNameArray : nameArray;
	strArrPointer : ^stringValues;
	selectedName : integer;
	
function readNumber() : integer;
	var resulter : integer;
    begin
        try
		    write('Write number, please : ');
			readln(resulter);
	    except on System.Exception do
		    begin
			    writeln('It"s a wrong number, try again!');
			    readNumber();
		    end;
        end;
        writeln();
        readNumber := resulter;
    end;

procedure readValues();
	var i : integer;
	begin
		for i := 0 to n do
		begin
		    writeln('Hi! It"s name # ', i, ', please, type it"s valuesr');
			write('Write firtsName, please : ');
			readln(myName.firtsName);
			write('Write lastName, please : ');
			readln(myName.lastName);
			write('Write phoneNumber, please : ');
			readln(myName.phoneNumber);
			write('Write day of birthday, please : ');
		    myName.bDay.day := readNumber();
		    write('Write month of birthday, please : ');
		    myName.bDay.month := readNumber();
		    write('Write year of birthday, please : ');
		    myName.bDay.year := readNumber();
			myNameArray[i] := myName;
		end;
	end;

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

procedure writeHeader();
    var 
        strArray : stringValues;
    begin
        str('Firts Name' : tableWidth, strArray.valuesArray[0]);
	    str('Last Name' : tableWidth, strArray.valuesArray[1]);
	    str('Phone Number' : tableWidth, strArray.valuesArray[2]);
	    str('Birthday Day' : tableWidth, strArray.valuesArray[3]);
	    str('Birthday Month' : tableWidth, strArray.valuesArray[4]);
	    str('Birthday Year' : tableWidth, strArray.valuesArray[5]);
	    strArrPointer := @strArray;
	    writePart('║', '', '│', '║', strArrPointer);
	    writePart('╟', '─', '┼', '╢', nil);
	end;

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
	
procedure displayOneRaw(n : name);
    begin
        writeln('-----Selected raw-----');
        writeln('Firts Name = ', n.firtsName );
        writeln('Last Name = ', n.firtsName );
	    writeln('Phone Number = ', n.phoneNumber);
	    writeln('Birthday Day = ', n.bDay.day);
	    writeln('Birthday Month = ', n.bDay.month);
	    writeln('Birthday Year = ', n.bDay.year); 
        writeln('---End Of Selected raw---');
    end;	
	
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
                    writeln('There"s no raws with this month!')
                end;
    end;
    
begin
	readValues();
	writeTableWithValues(myNameArray);
// todo подготовить входные данные из файла
// todo Записывать даннные в бд
    makeBubbleSorting(myNameArray);
    writeln('Sorted Array');
    writeTableWithValues(myNameArray);
    writeln('Type the month for displaying information about person');
    selectedName := readNumber();
    selectPerson(myNameArray, selectedName);
end.