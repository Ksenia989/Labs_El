program 
  StringJob;

var 
  newString : string;
  initialString : string;
  subString : string;
  subStringPosition : integer;
  subStringLength : integer;

const
  beginning : integer = 1; // константа начала строки
  
 begin
  initialString := 'abcioweabc';
  subString := 'abc';
  newString := '';
  subStringLength := subString.length;
  // subStringLength - 1 используется для расползнования количества символов, 
  // которые нужно перевести в новую строку
  
  subStringPosition := pos(subString, initialString);
  newString := concat(copy(initialString, beginning, subStringPosition - 1), '_', subString, '_');
  delete(initialString, beginning, subStringPosition + subStringLength - 1);  
  
  subStringPosition := pos(subString, initialString);
  newString := concat(newString, copy(initialString, beginning, subStringPosition - 1), '_', subString, '_');
  delete(initialString, beginning, subStringPosition + subStringLength - 1); 
  
  writeLn(newString);
 end.