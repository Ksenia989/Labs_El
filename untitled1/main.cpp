#include <stdio.h>

int a, b, c;

void f1(int &b) {
    int a;
    a = 21;
    b = 22;
    c = a + b;
}

void f2(int a, int *b) {
    int c;
    a = 51;
    *b = 52;
    c = a + *b;
}

void f3() {
    int c;
    a = 31;
    b = 32;
    c = a + b;
}

void f4(int &b) {
    a = 41;
    b = 42;
    c = a + b;
}

int main() {
    a = 4;
    b = 5;
    c = 6;
    f1(a);
    f2(a, &c);
    f3();
    f4(a);
    return 0;
}