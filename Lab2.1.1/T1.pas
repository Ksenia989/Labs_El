program 
  WayMemorizer;

const
	n = 1;
	tableWidth = 15;

type
    way = record
		startPoint : string;
		endPoint : string;
		wayNumber : integer;
	end;
	
	stringArray = array[0..3] of string;
	
	stringValues = record
	    valuesArray : stringArray; 
	end;
	
	wayArray = array[0..n] of way;

var 
	myWay : way;
	myWayArray : wayArray;
	intPointer : ^integer;
	strArrPointer : ^stringValues;
	selectedWay : integer;
	
function readWayNumber() : integer;
	var resulter : integer;
    begin
        intPointer := NIL;
        while (intPointer = nil) do
        begin
            try
			    write('Write wayNumber, please : ');
			    readln(resulter);
			except on System.Exception do
			    begin
			        writeln('It"s a wrong number, try again!');
			        writeln();
			        readWayNumber();
			    end;
            end;
            writeln();
            intPointer := @resulter;
            readWayNumber := resulter;
        end;
    end;

procedure readValues();
	var i : integer;
	begin
		for i := 0 to n do
		begin
		    writeln('Hi! It"s route # ', i, ', please, type it"s coordinates and way number');
			write('Write startPoint, please : ');
			readln(myWay.startPoint);
			write('Write endPoint, please : ');
			readln(myWay.endPoint);
		    myWay.wayNumber := readWayNumber();
			myWayArray[i] := myWay;
		end;
	end;

procedure writePlainSymbolOrValue(plainSymbol : string; valuesPointer : ^stringValues; i : integer);
    var 
        j : integer;
    begin
        if (valuesPointer = nil) then //write just plain symbol
            for j := 1 to tableWidth do
        	    write(plainSymbol)
        else
            write(valuesPointer^.valuesArray[i]);        	    
    end;

procedure writePart(beginning : string; plainSymbol : string; divider : string; endSymbol : string; valuesPointer : ^stringValues);
    var i, j : integer;
    begin
     	write(beginning);
    	for i := 0 to 2 do 
    		begin
    		    writePlainSymbolOrValue(plainSymbol, valuesPointer, i);
        		if (i <> 2) then write(divider);			
    		end;
        writeLn(endSymbol);
    end;
    
procedure writePart(myWay : way);
    var 
        strArray : stringValues;
    begin
        str(myWay.startPoint : tableWidth, strArray.valuesArray[0]);
	    str(myWay.endPoint : tableWidth, strArray.valuesArray[1]);
	    str(myWay.wayNumber : tableWidth, strArray.valuesArray[2]);
	    strArrPointer := @strArray;
	    writePart('║', '', '│', '║', strArrPointer);
    end;

procedure writeHeader();
    var 
        strArray : stringValues;
    begin
        str('Start Point' : tableWidth, strArray.valuesArray[0]);
	    str('End Point' : tableWidth, strArray.valuesArray[1]);
	    str('Way Number' : tableWidth, strArray.valuesArray[2]);
	    strArrPointer := @strArray;
	    writePart('║', '', '│', '║', strArrPointer);
	    writePart('╟', '─', '┼', '╢', nil);
	end;

procedure writeTableWithValues(myWayArray : wayArray);
    var 
        i : integer;
        wayHeader : way;
	begin
        writePart('╔', '═', '╤', '╗', nil);
        writeHeader();
	    for i:= 0 to n do
	        begin
	            writePart(myWayArray[i]);
	            if (i < n) then writePart('╟', '─', '┼', '╢', nil);
	        end;
	    writePart('╚', '═', '╧', '╝', nil);    
	end;
	
procedure makeBubbleSorting(Var myArray : wayArray);
	Begin
	  for i : integer := 0 to n do
	  for j : integer := n - 1 downto i do
		Begin
		  if (myArray[j].wayNumber < myArray[j + 1].wayNumber) then
			Begin
				swap(myArray[j], myArray[j + 1]);
			End;
		End;
	End;
	
procedure displayOneRaw(w : way);
    begin
        writeln('-----Selected raw-----');
        writeln('Start Point = ', w.startPoint );
	    writeln('End Point = ', w.endPoint);
	    writeln('Way Number = ', w.wayNumber); 
        writeln('---End Of Selected raw---');
    end;	
	
procedure selectWay(myWayArray : wayArray; numberForSearch : integer);
    var 
        i : integer;
        isRawsWithSuchNumber : boolean;
    begin
        isRawsWithSuchNumber := false;
        for i := 0 to n do
            begin
                if (myWayArray[i].wayNumber = numberForSearch) then
                    begin
                        displayOneRaw(myWayArray[i]);
                        isRawsWithSuchNumber := true;
                    end;
            end;
            if (isRawsWithSuchNumber = false) then
                begin
                    writeln('There"s no raws with this number')
                end;
    end;
    
begin
	readValues();
	writeTableWithValues(myWayArray);
// todo подготовить входные данные из файла
// todo Записывать даннные в бд
    makeBubbleSorting(myWayArray);
    writeln('Sorted Array');
    writeTableWithValues(myWayArray);
    writeln('Type the number of way for displaying information about it');
    read(selectedWay);
    selectWay(myWayArray, selectedWay);
end.