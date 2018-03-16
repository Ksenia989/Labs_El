#include <stdio.h>
#include <stdlib.h>

void calculate_5_values() {
    double input;
    double sum = 0;
    double srAr = 0;

    printf("10 task selected\n");
    for (int i = 1; i < 5; ++i) {
        printf("Введите %i число\n", i);
        scanf("%lf", &input);
        sum = sum + input;
        srAr = sum / i;
        printf("Введено чисел%i , сумма %lf ,средее арифметическое %lf", i, sum, srAr);
    }
}

int random_number_game() {
    int counter = 0;
    int out_number = 1 + rand() % 11;
    int input;
    while (counter != 5) {
        scanf("%i", &input);
        if (out_number == input) {
            printf("Вы выиграли!\n");
            return 0;
        } else {
            printf("Нет\n");
            counter++;
        }
    }
    printf("Вы проиграли =(");
}

// tasks 10, 19, 22
int main() {
#ifdef WIN32
    system("chcp 65001");
#endif
    int input = 10;
    printf("Введите номер задания \n");
    scanf("%i", &input);
    switch (input) {
        case 10:
            calculate_5_values();
            break;
        case 19:
            random_number_game();
            break;
        case 22:
            break;
        default:
            break;
    }
    return 0;
}
