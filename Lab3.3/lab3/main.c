//вариант 12
// задания 10, 19, 22
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

void guess_game();

void sr_arifm();

void evklid();

void guess_game() {
    int i = 0;
    printf("Игра \"Угадай число\".\n"
                   "        Компьютер \"задумал\" число от 1 до 10.\n"
                   "        Угадайте его за 5 попыток.\n");
    int number = rand() % 10 + 1;
    int in;
    int founded = 0;
    while (i++ <= 5 & founded == 0) {
        printf("Введите число и нажмите <Enter>\n");
        scanf("%i", &in);
        if (number == in) {
            printf("Вы выиграли! Поздравляю!\n");
        } else {
            founded = 1;
            printf("Нет.");
        }
    }
    if (founded) {
        printf("Вы проиграли");
    }
}

void sr_arifm() {
    char inp = 0;
    printf("Обработка последовательности дробных чисел\n"
                   "После ввода каждого числа нажимайте <Enter>\n");
    while (inp != '\n') {
        double sum = 0;
        for (int i = 1; i <= 5; ++i) {
            double input;
            int symb_readed = scanf("%lf", &input);
            if (symb_readed) {
                printf("%i", symb_readed);
            }
            sum = sum + input;
            printf("Введено чисел: %i Сумма: %.2lf Сред. арифметическое: %.2lf \n", i, sum, sum / i);
        }
        printf("Для завершения нажмите <Enter>\n");
        getchar();
        inp = getchar();

    }
    printf("Программа завершена");
}

int main() {
#ifdef WIN32
    system("chcp 65001");
#endif
    int inp;
    printf("Здравствуйте! Введите номер задания - 10, 19 или 22\n");
    scanf("%i", &inp);
    switch (inp) {
        // Оператор for. Написать программу, которая вводит с клавиатуры последовательность из
        //пяти дробных чисел и после ввода каждого числа выводит среднее арифметическое
        //введенной части последовательности.
        case 10:
            sr_arifm();
            break;
            // Оператор do while. Написать программу, которая «задумывает» число в диапазоне от 1
            // до  10  и  предлагает  пользователю  угадать  число  за  5  попыток.
        case 19:
            guess_game();
            break;
            // Оператор while.
            // Написать программу, которая вычисляет наибольший общий делитель
            //двух целых чисел по алгоритму Евклида
        case 22:
            evklid();
            break;
        default:
            printf("Нет такого номера! Ошибочка!!!1!");
    }
}

void evklid() {
    printf("Введите два числа для нахождения НОД\n");
    int first_num;
    int second_num;
    scanf("%i%*c%i", &first_num, &second_num);
    while (first_num != 0 & second_num != 0) {
        if (first_num > second_num) {
            first_num %= second_num;
        } else {
            second_num %= first_num;
        }
    }
    printf("НОД равен %i", first_num + second_num);
}

