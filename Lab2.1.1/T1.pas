program 
  WayMemorizer;

const
	n := 7;

type
	wayArray : array[0..n] of way;

var 
	way : record
		startPoint : string;
		endPoint : string;
		wayNumber : integer;
	end;
	myWayArray : wayArray;


	
procedure readValues();
	var i : integer;
	begin
		for i := 0; i < 9 do
		begin
			writeln('Write startPoint, please');
			read(way.startPoint);
			writeln('Write endPoint, please');
			read(way.endPoint);
			writeln('Write wayNumber, please');
			read(way.wayNumber);
			wayArray[i] := way;
		end;
	end;

procedure writeTableWithValues(myWayArray : wayArray);
	begin
		
	end;

begin
	readValues();
	writeTableWithValues(wayArray);

end.