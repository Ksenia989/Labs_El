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
  
  smallStringLength := copy(initialString, 1, pos(';', initialString)).length; // ��������� ����� �� ;
  
  val(copy(initialString, 1, pos('+', initialString) - 2), summand1, errorCode);
  val(copy(initialString, pos('+', initialString) + 2, pos('=', initialString) - 1 - (pos('+', initialString) + 2)),
                                                                                            summand2, errorCode);
  str(summand1 + summand2, summa);
  // ��������� ������������ ��������� � ���� ����� �������������� ������
  newString := concat(newString, copy(initialString, 1, smallStringLength - 2), summa);
  // ������� ���� �������
  delete(initialString, 1, smallStringLength - 1); // ������� ����� ��������� ������ ��� ;
  // �������� ������� ��� ����������
  newString := concat(newString, copy(initialString, 1, 2));
  // � ������� ��
  delete(initialString,1 ,2);
  
  smallStringLength := copy(initialString, 1, pos(';', initialString)).length; // ��������� ����� �� ;
  
  val(copy(initialString, 1, pos('+', initialString) - 2), summand1, errorCode);
  val(copy(initialString, pos('+', initialString) + 2, pos('=', initialString) - 1 - (pos('+', initialString) + 2)),
                                                                                            summand2, errorCode);
  str(summand1 + summand2, summa); // bufferString - �������� ������ ��� ����������� ����������
  // ��������� ������������ ��������� � ���� ����� �������������� ������
  newString := concat(newString, copy(initialString, 1, smallStringLength - 2), summa);
  // ������� ���� �������
  delete(initialString, 1, smallStringLength - 1); // ������� ����� ��������� ������ ��� ;
  // �������� ������� ��� ����������
  newString := concat(newString, copy(initialString, 1, 2));
  // � ������� ��
  delete(initialString,1 ,2);
  
  writeLn(newString);
end.