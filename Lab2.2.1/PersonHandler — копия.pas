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
            
            if ((isArray = false) and (symbol in ['4', '5', '6', '7'])) then 
                begin
                    writeln('Сначала заполните массив данными!');
                    showMenu();
                end;
            
            case symbol of
            '1' : 
                begin
                    myNameArray := readValues();
                    isArray := true;
                end;
            '2' :
                begin
                    myNameArray := myConstNames;
                    isArray := true;
                end;
//            '3' : 
            '4' : 
                writeToUntypeFile();
            '5' :
                writeTableWithValues();
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