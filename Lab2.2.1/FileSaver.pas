UNIT
  FileSaver;
  
INTERFACE
var  
    f : text;   
procedure readFromUntypeFile();
procedure WriteToUntypeFile();
	
IMPLEMENTATION
uses PersonHandler;	
procedure writeToUntypeFile();
    var 
        i : integer;
    begin
        assign(f,'file.txt');
        rewrite(f);
        for i:=1 to PersonHandler.n do
            begin
                write(f,myNameArray[i].firtsName);
                write(f, #13#10);
                write(f,myNameArray[i].lastName);
                write(f, #13#10);
                write(f,myNameArray[i].phoneNumber);
                write(f, #13#10);
                write(f,myNameArray[i].bDay.day);
                write(f, #13#10);
                write(f,myNameArray[i].bDay.month);
                write(f, #13#10);
                write(f,myNameArray[i].bDay.year);
                write(f, #13#10);
                write(f, #13#10);
            end;
        close(f);
    end;
    
procedure readFromUntypeFile();
    var
        k : integer;
    begin
        reset(f);
        k:=0;
         for i:=1 to PersonHandler.n do
            begin
             read(f,myNeNameArray[i].firtsName);
//                write(f, #13#10);
                read(f,myNameArray[i].lastName);
//                write(f, #13#10);
                read(f,myNameArray[i].phoneNumber);
//                write(f, #13#10);
                read(f,myNameArray[i].bDay.day);
//                write(f, #13#10);
                read(f,myNameArray[i].bDay.month);
//                write(f, #13#10);
                read(f,myNameArray[i].bDay.year);
        end;
        close(f);
    end;
    
BEGIN
END.