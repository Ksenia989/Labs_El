#include <iostream>
#include "main.h"
#include <string.h>

// todo библиотека
// todo usage # pragma once

#define n 10

void printSpaces(size_t strlen, int i);

int main() {
    struct Worker workerArray[n] = {
            {"Торгаева К. О.",   "Дегустатор",  2014},
            {"Иванов И. К.",     "Разработчик", 1960},
            {"Дырочкина М. С.",  "Разработчик", 1992},
            {"Сердюк С. В.",     "Разработчик", 2016},
            {"Шахиджанян К. А.", "Разработчик", 2019},
            {"Шарипов К. О.",    "Переводчик",  2011},
            {"Михайлова Т. И.",  "Бухгалтер",   1998},
            {"Цымбалист У. И.",  "Разработчик", 1993},
            {"Нечаев С. В.",     "Уборщик",     2017},
            {"Шалынова У. А.",   "Лентяй",      2016}
    };

    printf("Вывод таблицы с вариантами на экран\n");
    printArray(workerArray);


    printf("Вывод упорядоченной таблицы по алфавиту");
    printf("\n\n\nОТСОРТИРОВННЫЙ МАССИВ\n");
    *workerArray = *makeBubbleSort(workerArray);
    printArray(workerArray);

    printf("\n\n\nВывод должности\n");
    printf("Введите должность, для которой нужно найти максимальный срок\n");
    select(workerArray);

    return 0;
}

int select(Worker *pWorker) {
    char compareDolzhnost[50];
    scanf("%s", &compareDolzhnost);
    int minStag = 2018;
    bool founded = false;
    int ind = 0;

    for (int i = 0; i < n; ++i) {
        if ((strcmp((pWorker + i)->dolzhnostDescription, compareDolzhnost) == 0) && ((pWorker + i)->employmentYear < minStag)) {
            minStag = pWorker->employmentYear;
            founded = true;
            ind = i;
        }
    }
    if (!founded) {
        printf("Подобных работников не найдено");
    } else {

        printf("\nРаботник с именем ");
        printf("%s\n", pWorker[ind].fioInitcialy);
        printf("Стаж с %i\n", pWorker[ind].employmentYear);
        printf("По профессии %s\n", pWorker[ind].dolzhnostDescription);
    }
    return 0;
}

void printArray(Worker *worker) {
    printf("╔════════════════════════╤═════════════════════════════════╤════════════════════════════╗\n");
    printf("║  Фамилия и инициалы    │  Название должности             │  Год поступления на работу ║\n");
    printf("╟────────────────────────┼─────────────────────────────────┼────────────────────────────╢\n");
    for (int i = 0; i < n; ++i) {
        printf("║%s", worker[i].fioInitcialy);
        printSpaces(strlen(worker[i].fioInitcialy), 22);
        printf("│%s", worker[i].dolzhnostDescription);
        printSpaces(strlen(worker[i].dolzhnostDescription), 33);
        printf("│%i", worker[i].employmentYear);
        printf("                        ");
        printf("║\n");
        if (i != n - 1) {
            printf("╟────────────────────────┼─────────────────────────────────┼────────────────────────────╢\n");
        }
    }
    printf("╚════════════════════════╧═════════════════════════════════╧════════════════════════════╝\n\n\n");
}

void printSpaces(size_t strlen, int size) {
    int length = (int) (size - strlen / 2);
    for (int i = 0; i < length; ++i) {
        printf(" ");
    }
}

Worker *makeBubbleSort(Worker worker[n]) {
    int i = 0, j = 0;

    /* Сортировка методом пузырька */
    for (i = 1; i < n; i++) {
        for (j = 0; j < n - i; j++) {
            if (strcmp(worker[j].fioInitcialy, worker[j + 1].fioInitcialy) > 0) {
                Worker *bufferWorker = (Worker *) malloc(sizeof(Worker));
                *bufferWorker = worker[j];
                worker[j] = worker[j + 1];
                worker[j + 1] = *bufferWorker;
            }
        }
    }
    return worker;
}

