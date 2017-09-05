﻿program 
  WayMemorizer;

const
	n = 1;
	tableWidth = 7;

type
    way = record
		startPoint : string;
		endPoint : string;
		wayNumber : integer;
	end;
	
	stringArray = array[0..2] of string;
	
	stringValues = record
	    valuesArray : stringArray; 
	end;
	
	wayArray = array[0..n] of way;

var 
	myWay : way;
	myWayArray : wayArray;
	intPointer : ^integer;
	strArrPointer : ^stringValues;
	
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
    	for i := 1 to 3 do 
    		begin
    		    writePlainSymbolOrValue(plainSymbol, valuesPointer, i);
        		if (i <> 3) then write(divider);			
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
	    writePart('╔', '═', '╤', '╗', strArrPointer);
    end;

procedure writeTableWithValues(myWayArray : wayArray);
    var 
        i : integer;
	begin
	    writePart('╔', '═', '╤', '╗', nil);
	    for i:= 0 to n do
	        begin
	            writePart(myWayArray[i]);
	            writePart('║', '─', '┼', '║', nil);
	        end;
	    writePart('╚', '═', '╧', '╝', nil);    
	end;

begin
	readValues();
	writeTableWithValues(myWayArray);
// todo подготовить входные данные из файла
end.