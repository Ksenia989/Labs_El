program 
    asciizz_stirngs;
//������� - �� ������������ ������������������ �������� ���������
//������ ��������, ������������� ����� �������� ��������.

   
{$�+} // ����������� ���������
const
    n = 7;

type
    arrChar = array[0..n] of Char;

var
    inputString : PChar;
    startBracket, endBracket : PChar;
    res : PChar;
    c : arrChar;
    
begin
    readln(c);
//c := '����(jk;a)��!';
inputString := c;
    startBracket := StrScan(inputString, '(');
    endBracket := StrScan(inputString, ')');
    if ((endBracket <> nil) and (startBracket <> nil)) 
    then
    begin
      StrLCopy(res, inputString, StrLen(inputString) - StrLen(startBracket)); 
//       StrMove(res, inputString)
//       StrLCat
    end;

end.