#include <stdio.h>
// Вариант 12
// задания 2б, 5, 6 7е, 8а, 9

unsigned int countFirstNumber() {
    // в оправдание этого говнокода могу сказать, что циклы было использовать нельзя =(
    unsigned int counter = 0;
    signed int input;
    scanf("%d", &input);
    unsigned char c = (char) input;

    unsigned char mask = 0x80;
    int umnozh = 7;
    counter = counter + ((c & mask) >> umnozh);
    umnozh -= 1;
    mask = mask >> 1;// сдвигаем единичку вправо

    counter = counter + ((c & mask) >> umnozh);
    umnozh -= 1;
    mask = mask >> 1;// сдвигаем единичку вправо

    counter = counter + ((c & mask) >> umnozh);
    umnozh -= 1;
    mask = mask >> 1;// сдвигаем единичку вправо

    counter = counter + ((c & mask) >> umnozh);
    umnozh -= 1;
    mask = mask >> 1;// сдвигаем единичку вправо

    counter = counter + ((c & mask) >> umnozh);
    umnozh -= 1;
    mask = mask >> 1;// сдвигаем единичку вправо

    counter = counter + ((c & mask) >> umnozh);
    umnozh -= 1;
    mask = mask >> 1;// сдвигаем единичку вправо
    counter = counter + ((c & mask) >> umnozh);

    umnozh -= 1;
    mask = mask >> 1;// сдвигаем единичку вправо
    counter = counter + ((c & mask) >> umnozh);
    return counter;
}

unsigned short makeStrangeEvents() {
    unsigned short input;
    scanf("%hx", &input);
    printf("\nВведите число в 16 сс (двухбайтовое)\n");
    printf("input is %hx \n", input);

    unsigned short mask = 0xf000;
    input = input | mask;

    mask = 0xfff0;
    input = input & mask;

    return input;
}

unsigned short makeStrangeEvents2() {
    unsigned short input;
    printf("Введите двухбайтовое число в 16 сс");
    scanf("%hx", &input);
    printf("\ninput is %hx \n", input);
    unsigned short mask = 0x000f;
    input = input ^ mask;
    return input;
}

unsigned short makeStrangeEvents3() {
    unsigned short input;
    printf("Введите двухбайтовое число в 16 сс\n");
    scanf("%hx", &input);
    printf("\n input is %hx \n", input);

    // выделяем первую и вторую тетрады
    unsigned short mask1 = 0xf000;
    unsigned short mask2 = 0x0f00;
    unsigned short final1 = input & mask1;
    unsigned short final2 = input & mask2;
    final2 = final2 << 4;// сдвигаем влево чтобы они были на позиции 1 тетрады

    // это нужно записать в первую тетраду
    unsigned short res = final1 + final2; // если число получилось больше, первый символ обрезается (в тз не задано)
    // и чтобы кроме первой тетрады везде были нолики, что не нолики - обрезаем
    res = res & mask1;

    // маска для обнуления первой тетрады
    unsigned short mask3 = 0x0fff;
    // обнуляем первую тетраду во входном значении
    input = mask3 & input;

    // и праибавляем в начало первую тетраду
    input = input | res;

    printf("final result is input is %hx \n", input);
    return input;
}

long makeNumberFrom4() {
    long result = 0;
    long input1, input2, input3, input4;
    printf("Введите 4 числа в 16 сс (числа однобайтовые)\n");
    scanf("%lx", &input1);
    scanf("%lx", &input2);
    scanf("%lx", &input3);
    scanf("%lx", &input4);

    input1 = input1 << 24;
    input2 = input2 << 8;
    input3 = input3 << 16;

    result = result | input1;
    result = result | input2;
    result = result | input3;
    result = result | input4;

    return result;
}

unsigned short cycleSdvid() {
    unsigned short input;
    printf("Введите двухбайтовое число в 16 сс\n");
    scanf("%hx", &input);
    printf("input is %hx \n", input);

    unsigned short mask1 = 0x8000;// первый символ достаём
    unsigned short mask2 = 0x4000;// второй символ достаём
    unsigned short mask3 = 0x2000;// третий символ достаём
    unsigned short mask4 = 0x1000;// четвертый символ достаём
    unsigned short mask5 = 0x0800;// пятый символ достаём

    unsigned short s1, s2, s3, s4, s5;// если число получиться неравное 0, то там 1 =)
    s1 = mask1 & input;
    s2 = mask2 & input;
    s3 = mask3 & input;
    s4 = mask4 & input;
    s5 = mask5 & input;

    input = input << 5;
    // добавляем символы в конце
    input = input | (s1 >> 11);
    input = input | (s2 >> 11);
    input = input | (s3 >> 11);
    input = input | (s4 >> 11);
    input = input | (s5 >> 11);
    return input;
}

int main() {
    printf("Write task number 2б, 5, 6 7е, 8а, 9 (only number, without letter)\n");
    int input;
    scanf("%d", &input);// это для ввода информации (d это signed int)
    switch (input) {
        case 2:
            //2. Из четырех однобайтовых переменных собрать значение для 4-байтовой
            //переменной целого типа. Сборку выполнить так:
            //чтобы значение первой переменной попало в старший (4-й) байт, значение второй переменной - в 2-й байт,
            //третьей - во третий и четвертой переменной - в
            //младший (1-й) байт переменной целого типа (4 байта).
            printf("task 2б\n");
            printf("input:\n");
            long res = makeNumberFrom4();
            printf("result is %lx\n", res);
            break;
        case 5:
            //*5*. В двухбайтовом числе *(unsigned short, например) все нули в старшей тетраде поменять на единицы, а в
            //младшей тетраде поменять все единицы на нули.
            printf("task 5\n");
            printf("input:\n");
            unsigned short res4 = makeStrangeEvents();
            printf("result is %hx\n", res4);
            break;
        case 6:
            //6. В младшей тетраде двухбайтового числа побитно поменять все нули на единицы, а единицы - на нули.
            printf("task 6\n");
            printf("input:\n");
            unsigned short res2 = makeStrangeEvents2();
            printf("result is %hx\n", res2);
            break;
        case 7:
            //7. Обычно при циклическом сдвиге «выдвигаемые» (за границу числа) разряды
            //«задвигаются» в сдвигаемое значение со стороны, противоположной направлению
            //сдвига: реализовать циклический сдвиг двухбайтового числа влево на 5 разрядов.
            printf("task 7е\n");
            printf("input:\n");
            unsigned short resu = cycleSdvid();
            printf("result is %hx\n", resu);
            break;
        case 8:
            //8. В двухбайтовом числе в 1-ю тетраду записать код, равный сумме значений 1-й и 2-й тетрад
            printf("task 8а\n");
            printf("input:\n");
            unsigned short res8 = makeStrangeEvents3();
            printf("result is %hx\n", res8);
            break;
        case 9:
            //9. Подсчитать число единиц в однобайтовом числе.
            printf("task 9\n");
            unsigned int counter = countFirstNumber();
            printf("количество единиц = %d\n", counter);
            break;
        default:
            printf("Нет такого задания. Увы =()\n");
    }
    getchar();
    return 0;
}