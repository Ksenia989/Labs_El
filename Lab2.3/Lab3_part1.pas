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
       Элемент четного списка
    *)
    evenPositiveNumber : list;
    
    (*
        Элемент нечетного списка
    *)
    oddNegativeNumber : list;
    
    // Элемент нечетного списка
    justOddList : list;
    
    // элемент чётного списка
    justEvenList : list;
    
    (*
        Для выборки действий
    *)
    q : char;
    
    (*
      Лист для разделения
    *)
    mainList : list;

(*
    Функция, считывающая номера в числовых значениях
*)
function readNumber() : integer;
	var resulter : integer;
    begin
        try
		    write('Введите номер, пожалуйста : ');
			readln(resulter);
	    except on System.Exception do
	        begin
		        writeln('Это неверный номер, введите другой!');
		        readNumber();
		    end;
        end;
            
        readNumber := resulter;
    end;

procedure add(var listForAdd : List; value : integer);
var
  temp:List;
begin
    // если список пуст, то создаём его первый элемент
  if (listForAdd = nil) then
  begin
    new(listForAdd);
    temp := listForAdd;
  end
  else
  begin
    temp := listForAdd;
    
    // перенос указателя на последний элемент
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
  // элемент добавлен
end;

procedure divideForTwoLists(mainList : list; 
                var evenPositiveNumber : list; var oddNegativeNumber : list);            
begin
    while (mainList <> nil) do 
    begin
        if ((mainList^.number > 0) and (mainList^.number mod 2 = 0)) then
            add(evenPositiveNumber, mainList^.number);
        if ((mainList^.number < 0) and (mainList^.number mod 2 <> 0)) then
            add(oddNegativeNumber, mainList^.number);
        if (mainList^.number mod 2 <> 0) then
            add(justOddList, mainList^.number);
        if (mainList^.number mod 2 = 0) then
            add(justEvenList, mainList^.number);    
          
        mainList := mainList^.next;
    end;
end;
    
(*
    Функция, считывающая значение в список, и распределяющая на четные и нечетные 
    положительные и отрицательные
*)
procedure readValues() ;
    var number : integer;
    begin
        number := readNumber;
        add(mainList, number); 
    end;

procedure printValues(currentList : List);
var 
    i : integer;
begin
    i := 0;
    if (currentList = nil) then
    begin
        writeln('Список пуст');
    end;
    while (currentList <> nil) do
    begin
        writeln('[', i, '] = ', currentList^.number);
        currentList := currentList^.next;
        inc(i);
    end;
end;

function countElements(currentList : List) : integer;
    var 
        i : integer;
    begin
        i := 0; // default Value
        while (currentList <> nil) do
        begin
            currentList := currentList^.next;
            inc(i);
        end;
        countElements := i;
        writeln('количетво = ', i)
    end;

function printNumberOfValues(list1 : List; list2 : List) : integer;
    begin
        printNumberOfvalues := countElements(list1) + countElements(list2); 
    end;

procedure addInBeginning(var curLIst : list; varForAdd : integer);
var
    newElement : list;
begin
    new(newElement);
    newElement^.number := varForAdd;
    newElement^.next := curList;
    
    curList := newElement;
end;

procedure detailInfoForList(var curList : list);
var
    max, min, middle, sum : integer; 
    elementsNumber : integer;
    l : list;
begin
    sum := 0;
    l := curList;
    elementsNumber := 0;
    max := -maxInt;
    min := maxInt;
    while (l <> nil) do 
    begin
        if (l^.number > max) then max := l^.number;
        if (l^.number < min) then min := l^.number; 
        sum += l^.number;
        inc(elementsNumber);
        l := l^.next;
    end;
    middle := trunc(sum / elementsNumber);
    writeln('средний элемент = ', middle);
    writeln('максимальный элемент = ', max);
    writeln('минимальный элемент = ', min);
    add(curList, min);
    add(curList, max);
    addInBeginning(curLIst, middle);
end;
    
begin
    // инициализация указателей на списки нулями - в начале они пустые
    evenPositiveNumber := nil;
    oddNegativeNumber := nil;

    while (true) do
    begin
        writeln('1 - добавление значения');
        writeln('2 - печатание списка значения');
        writeln('3 - разделить общий список');
        writeln('4 - печатание количества значений в двух списках');
        writeln('5 - детальная инфа о чёрных и нечётных значениях в списке');
        writeln();
        readln(q);
        case q of
            // считывание значений в список
            '1' : 
                begin
                    readValues();
                end;
            '2' : 
                begin
                    writeln('Четные положительные');
                    printValues(evenPositiveNumber);
                    writeln();
                    writeln('Нечетные отрицательные');
                    printValues(oddNegativeNumber);
                    writeln();
                end;
            '3' : 
                begin
                    printValues(mainList);
                    divideForTwoLists(mainList, evenPositiveNumber, oddNegativeNumber);
                end;
            '4' : 
                begin
                    writeln(printNumberOfValues(evenPositiveNumber, oddNegativeNumber));
                end;
            '5' :
                begin
                    writeln('Четные');
                    printValues(justEvenList);
                    writeln();
                    writeln('Нечетные');
                    printValues(justOddList);
                    writeln();
                    writeln('Детальная инфа для нечётного списка');
                    writeln();
                    detailInfoForList(justOddList);
                    writeln('Детальная инфа для чётного списка');
                    writeln();
                    detailInfoForList(justEvenList);
                    writeln();
                    writeln('После добавления');
                    writeln('Четные');
                    printValues(justEvenList);
                    writeln();
                    writeln('Нечетные');
                    printValues(justOddList);
                    writeln();
                end;
        end;
    end;
end.