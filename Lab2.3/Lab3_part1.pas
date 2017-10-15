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
       ������� ������� ������
    *)
    evenPositiveNumber : list;
    
    (*
        ������� ��������� ������
    *)
    oddNegativeNumber : list;
    
    (*
        ��� ������� ��������
    *)
    q : char;

(*
    �������, ����������� ������ � �������� ���������
*)
function readNumber() : integer;
	var resulter : integer;
    begin
        try
		    write('������� �����, ���������� : ');
			readln(resulter);
	    except on System.Exception do
	        begin
		        writeln('��� �������� �����, ������� ������!');
		        readNumber();
		    end;
        end;
            
        readNumber := resulter;
    end;

procedure add(var listForAdd : List; value : integer);
var
  temp:List;
begin
    writeln('���������� ��������');
    // ���� ������ ����, �� ������ ��� ������ �������
  if (listForAdd = nil) then
  begin
    new(listForAdd);
    temp := listForAdd;
  end
  else
  begin
    temp := listForAdd;
    
    // ������� ��������� �� ��������� �������
    while (temp^.next <> nil) do
      begin
        temp:=temp^.next;
      end;
    new(temp^.next);
    // ��������� �������
    temp := temp^.next;
  end;
  
  // ������ ��������� �� ��������� ������� ���� - ��� ���
  temp^.next := nil; 
  temp^.number := value;
  writeln('������� ��������');
end;
    
(*
    �������, ����������� �������� � ������, � �������������� �� ������ � �������� 
    ������������� � �������������
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
        writeln('������ ����');
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
    // ������������� ���������� �� ������ ������ - � ������ ��� ������
    evenPositiveNumber := nil;
    oddNegativeNumber := nil;

    while (true) do
    begin
        writeln('1 - ���������� ��������');
        writeln('2 - ��������� ������ ��������');
        writeln('3 - ��������� ���������� �������� � ���� �������');
    
        read(q);
        case q of
            // ���������� �������� � ������
            '1' : readValues(); 
            '2' : 
                begin
                    writeln('������ �������������');
                    printValues(evenPositiveNumber);
                    writeln();
                    writeln('�������� �������������');
                    printValues(oddNegativeNumber);
                end;
            '3' : printNumberOfValues(evenPositiveNumber, oddNegativeNumber);
        end;
    end;
end.