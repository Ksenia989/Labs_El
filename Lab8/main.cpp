#include <iostream>
#include "main.h"
#include <string.h>

// todo библиотека
// todo usage # pragma once

#define n 10

Worker *readWorker(int i) {
    Worker *worker = (Worker *) calloc(1, sizeof(Worker));
    printf("Введите фамилию и инициалы работника %i\n", i);
    scanf("%s", &((*worker).fioInitcialy));
    printf("Введите название должности работника\n");
    scanf("%s", &(*worker).dolzhnostDescription);
    printf("Введите год поступления на работу работника\n");
    scanf("%i", &(*worker).employmentYear);
    return worker;
}

Worker *readWorkerFromConst(Worker *pWorker) {
    char *workerNames[n] = {
            (char *) "Иванов И. К.", (char *) "1Торгаева К. О.", (char *) "Сердюк С. В.",
            (char *) "Шахиджанян К. А.", (char *) "Шарипов К. О.", (char *) "Михайлова Т. И.",
            (char *) "Дырочкина М. С.", (char *) "Цымбалист У. И.", (char *) "Нечаев С. В.",
            (char *) "Шалынова У. А."
    };

    char *dolzhnostDescription[n] = {
            (char *) "Старший инженер", (char *) "Младший аналитик", (char *) "Разработчик",
            (char *) "Повар", (char *) "Переводчик", (char *) "Бухгалтер",
            (char *) "Инженер по девопсу", (char *) "Программист микроконтроллеров", (char *) "Уборщик",
            (char *) "Лентяй"
    };

    int yearArray[n] = {
            1923, 2014, 2016, 2019, 2011, 1998, 1992, 1993, 2017, 2016
    };

    for (int i = 0; i < n; ++i) {
        strcpy(pWorker[i].fioInitcialy, workerNames[i]);
        strcpy(pWorker[i].dolzhnostDescription, dolzhnostDescription[i]);
        pWorker[i].employmentYear = yearArray[i];
    }

    return pWorker;
}

int main() {
    struct Worker *workerArray = (Worker *) malloc(n * sizeof(Worker));

    int yesNo = 0;
    printf("Вы хотите ввести массив с клавиатуры (1) или взять из константы (2)?\n");
    scanf("%i", &yesNo);
    switch (yesNo) {
        case 1:
            for (int i = 0; i < n; i++)
                workerArray[i] = *readWorker(i);
            break;
        case 2:
            workerArray = readWorkerFromConst(workerArray);
            break;
        default:
            printf("Нет такого варианта\n");
            break;
    }

    printf("Вывод таблицы с вариантами на экран\n");
    printArray(workerArray);


    printf("Вывод упорядоченной таблицы по алфавиту");
    printf("\n\n\nОТСОРТИРОВННЫЙ МАССИВ\n");
    workerArray = makeBubbleSort(workerArray);
    printArray(workerArray);

    printf("\n\n\nВыборка по стажу\n");
    printf("Введите, больше какого срока должен проработать работник\n");
    select(workerArray);

    return 0;
}

int select(Worker *pWorker) {
    int compareInt;
    scanf("%i", &compareInt);
    time_t t;
    time(&t);
    bool founded = false;

    for (int i = 0; i < n; ++i) {
        if (2018 - pWorker[i].employmentYear > compareInt) {
            founded = true;
            printf("\nРаботник с именем ");
            printf("%s\n", pWorker[i].fioInitcialy);
            printf("Стаж с %i\n", pWorker[i].employmentYear);
        }
    }
    if (!founded) {
        printf("Подобных работников не найдено");
    }
    return 0;
}

void printArray(Worker *worker) {
    for (int i = 0; i < n; ++i) {
        printf("Фамилия и инициалы работника - %s\n", worker[i].fioInitcialy);
        printf("Название должности работника - %s\n", worker[i].dolzhnostDescription);
        printf("Год поступления на работу работника - %i\n\n", worker[i].employmentYear);
    }
}

Worker *makeBubbleSort(Worker *worker) {
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

