Program 
  ArrayList;

Type
    list = ^TList;
    TList = record
    number : integer;
    next : list;
    end;
    
Var
    (*
       Ёлемент четного списка
    *)
    evenPositiveNumber : list;
    
    (*
        Ёлемент нечетного списка
    *)
    oddNegativeNumber : list;
    
    (*
        ƒл€ выборки действий
    *)
    q : char;

(*
    ‘ункци€, считывающа€ номера в числовых значени€х
*)
function readNumber() : integer;
	var resulter : integer;
    begin
        try
		    write('¬ведите номер, пожалуйста : ');
			readln(resulter);
	    except on System.Exception do
	        begin
		        writeln('Ёто неверный номер, введите другой!');
		        readNumber();
		    end;
        end;
            
        readNumber := resulter;
    end;

procedure add(var listForAdd : List; value : integer);
var
  temp:List;
begin
    writeln('ƒобавление элемента');
    // если список пуст, то создаЄм его первый элемент
  if (listForAdd = nil) then
  begin
    new(listForAdd);
    temp := listForAdd;
  end
  else
  begin
    temp := listForAdd;
    
    // перенос указател€ на последний элемент
    while (temp^.next <> nil) do
      begin
        temp:=temp^.next;
      end;
    new(temp^.next);
    // сделующий элемент
    temp := temp^.next;
  end;
  
  // сейчас указатель на следующий элемент пуст - его нет
  temp^.next := nil; 
  temp^.number := value;
  writeln('Ёлемент добавлен');
end;
    
(*
    ‘ункци€, считывающа€ значение в список, и распредел€юща€ на четные и нечетные 
    положительные и отрицательные
*)
procedure readValues() ;
    var number : integer;
    begin
        number := readNumber;;
        if ((number > 0) and (number mod 2 = 0)) then
            add(evenPositiveNumber, number);
        if ((number < 0) and (number mod 2 <> 0)) then
            add(oddNegativeNumber, number); 
    end;

procedure printValues(currentList : List);
var 
    i : integer;
begin
    i := 0;
    if (currentList = nil) then
    begin
        writeln('—писок пуст');
    end;
    while (currentList <> nil) do
    begin
        writeln('[', i, '] = ',currentList^.number);
        currentList := currentList^.next;
        inc(i);
    end;
end;

function countElements(currentList : List) : integer;
    var 
        i : integer;
    begin
        while (currentList <> nil) do
        begin
            currentList := currentList^.next;
            inc(i);
        end;   
    end;

function printNumberOfValues(list1 : List; list2 : List) : integer;
    begin
        printNumberOfvalues := countElements(list1) + countElements(list2); 
    end;
    
begin
    // инициализаци€ указателей на списки нул€ми - в начале они пустые
    evenPositiveNumber := nil;
    oddNegativeNumber := nil;

    while (true) do
    begin
        writeln('1 - добавление значени€');
        writeln('2 - печатание списка значени€');
        writeln('3 - печатание количества значений в двух списках');
    
        read(q);
        case q of
            // считывание значений в список
            '1' : readValues(); 
            '2' : 
                begin
                    writeln('„етные положительные');
                    printValues(evenPositiveNumber);
                    writeln();
                    writeln('Ќечентые отрицательные');
                    printValues(oddNegativeNumber);
                end;
            '3' : printNumberOfValues(evenPositiveNumber, oddNegativeNumber);
        end;
    end;
end.