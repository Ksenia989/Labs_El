program 
  additionalTask;
 
var
  initialString : string;
  newString : string;
  summa : string;
  subStringPosition : integer;
  resultat : integer;
  summand1 : integer;
  summand2 : integer;
  errorCode : integer;
  smallStringLength : integer;

begin
  initialString := '55 + 122 = ?; 6 + 188 = ?;';
  newString := '';
  
  smallStringLength := copy(initialString, 1, pos(';', initialString)).length; // поолучаем длину до ;
  
  val(copy(initialString, 1, pos('+', initialString) - 2), summand1, errorCode);
  val(copy(initialString, pos('+', initialString) + 2, pos('=', initialString) - 1 - (pos('+', initialString) + 2)),
                                                                                            summand2, errorCode);
  str(summand1 + summand2, summa);
  // вставляем получившиеся выражение в нашу новую результурующую строку
  newString := concat(newString, copy(initialString, 1, smallStringLength - 2), summa);
  // удаляем знак вопроса
  delete(initialString, 1, smallStringLength - 1); // удаляем длину маленькой строки без ;
  // копируем символы для читаемости
  newString := concat(newString, copy(initialString, 1, 2));
  // и удаляем их
  delete(initialString,1 ,2);
  
  smallStringLength := copy(initialString, 1, pos(';', initialString)).length; // поолучаем длину до ;
  
  val(copy(initialString, 1, pos('+', initialString) - 2), summand1, errorCode);
  val(copy(initialString, pos('+', initialString) + 2, pos('=', initialString) - 1 - (pos('+', initialString) + 2)),
                                                                                            summand2, errorCode);
  str(summand1 + summand2, summa); // bufferString - буферная строка для копирования результата
  // вставляем получившиеся выражение в нашу новую результурующую строку
  newString := concat(newString, copy(initialString, 1, smallStringLength - 2), summa);
  // удаляем знак вопроса
  delete(initialString, 1, smallStringLength - 1); // удаляем длину маленькой строки без ;
  // копируем символы для читаемости
  newString := concat(newString, copy(initialString, 1, 2));
  // и удаляем их
  delete(initialString,1 ,2);
  
  writeLn(newString);
end.