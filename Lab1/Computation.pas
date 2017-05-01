program Computation;
var
    a, z1, z2, x : real;
begin
    Write('Write a ');
    ReadLn(a);

    z1 := sin(4 * a) * cos(2 * a) / ((1 + cos(4 * a)) * (1 + cos(2 * a)));
    x := 3 / 2 * pi - a;
    z2 := cos(x) / sin (x);

    WriteLn('Results');

    WriteLn(z1 : 10 : 5);
    Write(z2 : 10 : 5);
end.