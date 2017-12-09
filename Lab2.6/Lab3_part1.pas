program 
    asciizz_stirngs;
//Задание - Из произвольной последовательности символов исключить
//группы символов, расположенных между круглыми скобками.

   
{$Х+} // расширенный синтаксис
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
//c := 'ПРИВ(jk;a)ЕТ!';
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