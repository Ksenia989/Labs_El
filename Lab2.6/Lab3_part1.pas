{$X+}
uses Strings;

type
        arrChar = array[0..65535] of char;
var
        inputString : PChar;
        arrayChar : arrChar;
        i : integer;
        stBrSymbol : PChar;
        endBrSymbol : PChar;
        res,res2 : PChar;
        beforeBracket, afterBracket : PChar;
        l : string;
        canEnd:boolean;
Begin
        writeln();
        writeln('Write your string: ');
        readln(arrayChar);
        inputString := arrayChar;
        writeln;
        new(res);
        new(res2);
        l := '';

        i := 0;
        while  (strLen(inputString) <> 0 and not can close) do // end symbol #0
        begin
            stBrSymbol := strScan(inputString, '(');
            if (stBrSymbol <> nil) then
               endBrSymbol := strScan(stBrSymbol, ')');

            if ((stBrSymbol <> nil) and (endBrSymbol <> nil))
            then
                begin
                strLCopy(res2, inputString, strLen(inputString) - strLen(stBrSymbol) + 1);
                res := strLCat(res, res2, strLen(res2));
                l := l + strPas(res2);
                res := strPCopy(res2, l);
                canEnd := true;
                end
                else
                canClose = true;
          if(not canClose)
          begin
          inputString := endBrSymbol;
          stBrSymbol := nil;
          endBrSymbol := nil;
          end;
        end;
        l := l + strPas(inputString);
        writeln('Your new string is ', l);
        readln();
End.
