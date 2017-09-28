UNIT
  FileSaver;

INTERFACE
    uses PersonHandler;	
    
    var
        textfile : text;   
        typeFile : file of PersonHandler.name;
        charFile : file of char;
    
function readFromTextFile() : nameArray;
procedure writeToTextFile();
function readFromTypeFile() : nameArray;
procedure writeToTypeFile();
function readFromCharFile() : nameArray;
procedure writeToCharFile();
	
IMPLEMENTATION
    uses PersonHandler;	

(*
    Запись в текстовый файл
*)
procedure writeToTextFile();
    var 
        i : integer;
    begin
        rewrite(textfile);
        for i:=0 to PersonHandler.n - 1 do
            begin
                write(textfile,myNameArray[i].firtsName);
                writeln(textfile);
                write(textfile,myNameArray[i].lastName);
                write(textfile, #13#10);
                write(textfile,myNameArray[i].phoneNumber);
                write(textfile, #13#10);
                write(textfile,myNameArray[i].bDay.day);
                write(textfile, #13#10);
                write(textfile,myNameArray[i].bDay.month);
                write(textfile, #13#10);
                write(textfile,myNameArray[i].bDay.year);
                write(textfile, #13#10);
                write(textfile, #13#10);
            end;
        close(textfile);
    end;

(*
    Чтение из текстового файла
*)    
function readFromTextFile() : nameArray;
    var
        k : integer;
        newNameArray : nameArray;
    begin
        reset(textfile);
         for k:=0 to PersonHandler.n - 1 do
            begin
             read(textfile,newNameArray[k].firtsName);
             readln(textfile);
             readln(textfile, newNameArray[k].lastName);
             readln(textfile, newNameArray[k].phoneNumber);
             readln(textfile, newNameArray[k].bDay.day);
             readln(textfile, newNameArray[k].bDay.month);
             readln(textfile, newNameArray[k].bDay.year);
             readln(textfile);
        end;
        close(textfile);
        readFromTextFile := newNameArray;
    end;

(*
    Запись в типизированнЫй файл
*)
procedure writeToTypeFile();
var 
    i : integer;
begin
    Rewrite(typeFile);
        for i:=0 to PersonHandler.n - 1 do
                write(typeFile, myNameArray[i]);
    close(typeFile);
    
end;

(*
    Чтение из типизированного файла
*)
function readFromTypeFile() : nameArray;
var 
    i : integer;
    newNameArray : nameArray;
begin
    reset(typeFile); // и для чтения, и для записи
    for i:=0 to PersonHandler.n - 1 do
        read(typeFile, newNameArray[i]);
    close(typeFile);
    readFromTypeFile := newNameArray;
end;

(*
    Функция для извлечения значений - строк из файла символов
 *)
procedure readSymbols(var finalString : string[20]);
var
    i : integer;
    c : char;
begin
    while (c <> #13) do
    begin
        read(charFile, c);
        finalString := finalString + c;        
    end;
    writeln();
end;

(*
    Процедура для извлечения цифры из файла символов
 *)
procedure readSymbols(var resultVar : integer);
var
    i : integer;
    c : char;
    err : integer;
    finalString : string[20];
begin
    finalString := '';
    while (c <> #13) do
    begin
        read(charFile, c);
        finalString := finalString + c;        
    end;
    val(finalString, resultVar, err);
end;


(*
    Чтение из символьного файла
*)
function readFromCharFile() : nameArray;
var
    i : integer;
    newNameArray : nameArray;
    emptyStr : string[20];
begin
    reset(charFile);       
    for i := 0 to PersonHandler.n - 1 do
        begin
             readSymbols(newNameArray[i].firtsName);
             readSymbols(newNameArray[i].lastName);
             readSymbols(newNameArray[i].phoneNumber);
             readSymbols(newNameArray[i].bDay.day);
             readSymbols(newNameArray[i].bDay.month);
             readSymbols(newNameArray[i].bDay.year);
             readSymbols(emptyStr);
        end;
    close(charFile);
    readFromCharFile := newNameArray;
end;

(*
    Процедура для посимвольной записи строки в файл
*)
procedure writeChars(s : string);
var 
    i : integer;
begin
    for i := 1 to length(s) do
    begin
        write(charFile, s[i]);
    end;
    write(charFile, #13);
    write(charFile, #10);
end;

procedure writeEnter();
begin
    write(charFile, #13);
    write(charFile, #10);
end;

(*
    Запись в символьный файл
*)
procedure writeToCharFile();
var
    i : integer;
begin
    rewrite(charFile);        
    for i := 0 to PersonHandler.n - 1 do
        begin
             writeChars(myNameArray[i].firtsName);
             writeChars(myNameArray[i].lastName);
             writeChars(myNameArray[i].phoneNumber);
             writeChars(myNameArray[i].bDay.day.ToString);
             writeChars(myNameArray[i].bDay.month.ToString);
             writeChars(myNameArray[i].bDay.year.ToString);
             writeEnter();
        end;
    close(charFile);
end;

(*
     Инициализация
*)    
BEGIN
  assign(textfile, 'textfile.txt');
  assign(typeFile, 'typeFile.txt');
  assign(charFile, 'charFile.txt');
END.