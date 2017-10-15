program 
    menu;
    
uses PersonHandler, FileSaver;

(*
    Отображение меню
 *)
procedure showMenu();
    var symbol : char;
    begin
        isArray := false;
        
        while (symbol <> 'q') do
        begin
            writeln('Меню');
            writeln('Выберете дальнейшие действия');
            writeln('1 - ввести данные про персону самостоятельно');
            writeln('2 - взять данные из константы');
            writeln('3 - взять данные из файла');
            writeln('4 - записать данные в файл');
            writeln('5 - вывести таблицу с данными');
            writeln('6 - отсортировать данные');
            writeln('7 - Выбрать запись с человеком по месяцу');
            writeln('q - выход');
            writeln();
            
            readln(symbol);
            
            case symbol of
            '1' : 
                begin
                    myNameArray := readValues();
                    isArray := true;
                end;
            '2' :
                begin
//                    myNameArray := myConstNames;
                    isArray := true;
                end;
            '3' :
                begin
                    myNameArray := readFromTextFile();
                    isArray := true;
                end;
                
            '4' : 
                writeToTextFile();
            '5' :
                writeTableWithValues(myNameArray, FileSaver.rawsNumber - 1);
            '6' :
                makeSorting();
            '7' : 
                selectPerson();
             
            else writeln('нет такого символа');
            end;
        end;
    end;

    
begin
    showMenu();
end.