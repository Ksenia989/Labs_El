#include <stdio.h>
#include <stdint.h>
// Вариант 12
// задания 2б, 5, 6 7е, 8а, 9

uint32_t countFirstNumber(uint8_t a) {
    return a ? (a & 1) + countFirstNumber(a >> 1) : 0;
}

uint16_t makeStrangeEvents() {
    uint16_t input;
    scanf("%hx", &input);
    printf("\nВведите число в 16 сс (двухбайтовое)\n");
    printf("input is %hx \n", input);

    uint16_t mask = 0xf000;
    input |= mask;

    mask = 0xfff0;
    input &= mask;

    return input;
}

uint16_t makeStrangeEvents2() {
    uint16_t input;
    printf("Введите двухбайтовое число в 16 сс");
    scanf("%hx", &input);
    printf("\ninput is %hx \n", input);
    uint16_t mask = 0x000f;
    input ^= mask;
    return input;
}

uint16_t makeStrangeEvents3() {
    uint16_t input;
    printf("Введите двухбайтовое число в 16 сс\n");
    scanf("%hx", &input);
    printf("\n input is %hx \n", input);

    // выделяем первую и вторую тетрады
    uint16_t mask1 = 0xf000;
    uint16_t mask2 = 0x0f00;
    uint16_t final1 = input & mask1;
    uint16_t final2 = input & mask2;
    final2 <<= 4;// сдвигаем влево чтобы они были на позиции 1 тетрады

    // это нужно записать в первую тетраду
    uint16_t res = final1 + final2; // если число получилось больше, первый символ обрезается (в тз не задано)
    // и чтобы кроме первой тетрады везде были нолики, что не нолики - обрезаем
    res &= mask1;

    // маска для обнуления первой тетрады
    uint16_t mask3 = 0x0fff;
    // обнуляем первую тетраду во входном значении
    input &= mask3;

    // и праибавляем в начало первую тетраду
    input |= res;

    printf("final result is input is %hx \n", input);
    return input;
}

uint32_t makeNumberFrom4() {
    uint32_t result = 0;
    uint8_t input1, input2, input3, input4;
    printf("Введите 4 числа в 16 сс (числа однобайтовые)\n");
    scanf("%hx", &input1);
    scanf("%hx", &input2);
    scanf("%hx", &input3);
    scanf("%hx", &input4);

    result |= (input1 << 24);
    result |= (input2 << 8);
    result |= (input3 << 16);
    result |= input4;

    return result;
}

uint16_t cycleSdvid() {
    uint16_t input;
    printf("Введите двухбайтовое число в 16 сс\n");
    scanf("%hx", &input);
    printf("input is %hx \n", input);

    uint16_t mask1 = 0x8000;// первый символ достаём
    uint16_t mask2 = 0x4000;// второй символ достаём
    uint16_t mask3 = 0x2000;// третий символ достаём
    uint16_t mask4 = 0x1000;// четвертый символ достаём
    uint16_t mask5 = 0x0800;// пятый символ достаём

    uint16_t s1, s2, s3, s4, s5;// если число получиться неравное 0, то там 1 =)
    s1 = mask1 & input;
    s2 = mask2 & input;
    s3 = mask3 & input;
    s4 = mask4 & input;
    s5 = mask5 & input;

    input <<= 5;
    // добавляем символы в конце
    input |= (s1 >> 11);
    input |= (s2 >> 11);
    input |= (s3 >> 11);
    input |= (s4 >> 11);
    input |= (s5 >> 11);
    return input;
}

int main() {
    printf("Write task number 2б, 5, 6 7е, 8а, 9 (only number, without letter)\n");
    int8_t input;
    scanf("%hd", &input);// это для ввода информации (d это signed int)
    switch (input) {
        case 2:
            //2. Из четырех однобайтовых переменных собрать значение для 4-байтовой
            //переменной целого типа. Сборку выполнить так:
            //чтобы значение первой переменной попало в старший (4-й) байт, значение второй переменной - в 2-й байт,
            //третьей - во третий и четвертой переменной - в
            //младший (1-й) байт переменной целого типа (4 байта).
            printf("task 2б\n");
            printf("input:\n");
            uint32_t res = makeNumberFrom4();
            printf("result is %x\n", res);
            break;
        case 5:
            //*5*. В двухбайтовом числе *(unsigned short, например) все нули в старшей тетраде поменять на единицы, а в
            //младшей тетраде поменять все единицы на нули.
            printf("task 5\n");
            printf("input:\n");
            uint16_t res4 = makeStrangeEvents();
            printf("result is %hx\n", res4);
            break;
        case 6:
            //6. В младшей тетраде двухбайтового числа побитно поменять все нули на единицы, а единицы - на нули.
            printf("task 6\n");
            printf("input:\n");
            uint16_t res2 = makeStrangeEvents2();
            printf("result is %hx\n", res2);
            break;
        case 7:
            //7. Обычно при циклическом сдвиге «выдвигаемые» (за границу числа) разряды
            //«задвигаются» в сдвигаемое значение со стороны, противоположной направлению
            //сдвига: реализовать циклический сдвиг двухбайтового числа влево на 5 разрядов.
            printf("task 7е\n");
            printf("input:\n");
            uint16_t resu = cycleSdvid();
            printf("result is %hx\n", resu);
            break;
        case 8:
            //8. В двухбайтовом числе в 1-ю тетраду записать код, равный сумме значений 1-й и 2-й тетрад
            printf("task 8а\n");
            printf("input:\n");
            uint16_t res8 = makeStrangeEvents3();
            printf("result is %hx\n", res8);
            break;
        case 9:
            //9. Подсчитать число единиц в однобайтовом числе.
            printf("task 9\n");
            uint8_t c;
            scanf("%hd", &c);
            uint32_t counter = countFirstNumber(c);
            printf("количество единиц = %d\n", counter);
            break;
        default:
            printf("Нет такого задания. Увы =()\n");
    }
    return 0;
}