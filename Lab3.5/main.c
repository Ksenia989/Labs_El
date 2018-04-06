#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <stdint.h>

uint32_t n;

void initializeArray(int *array, uint32_t);

const uint32_t c = 10;
// Вариант 12
// В одномерном массиве, состоящем из n целых элементов, вычислить:
// 1) номер максимального элемента масcива;
// 2) произведение элементов массива, расположенных между первым и вторым нулевыми элементами.
// Преобразовать  массив  таким  образом,  чтобы  в  первой  его  половине
// располагались  элементы,  стоявшие  в  нечетных  позициях,  а  во  второй
// половине — элементы, стоявшие в четных позициях.

int getMaxArrayNumber(int *arPointer) {
    int maxIndex = 0;
    for (int i = 0; i < n; ++i) {
        if (arPointer[i] > maxIndex) {
            maxIndex = i;
        }
    }
    printf("Максимальное число c индексом %i\n ", maxIndex);
    return maxIndex;
}

int *chetNechet(int *pInt) {
    int newArrPointer = 0;
    int *array = calloc(c, sizeof(int));
    for (int i = 1; i < c; i += 2, newArrPointer++) {
        array[newArrPointer] = pInt[i];
    }
    for (int i = 0; i < c; i += 2, newArrPointer++) {
        array[newArrPointer] = pInt[i];
    }
    return array;
}

int getMultiplyBetweenZeros(const int *pInt) {
    int composition = 1;
    int firstIndex = -1, secondIndex = -1;
    int ind = 0;
    while (ind < c) {
        if (pInt[ind] == 0) {
            if (firstIndex < 0) {
                firstIndex = ind;
            } else {
                secondIndex = ind;
                break;
            }
        }
        ind++;
    }

    if (firstIndex != -1 && secondIndex != -1) {
        if (secondIndex - firstIndex == 1) {
            printf("Произведение между двумя нулями это 0");
            return 0;
        }
        for (int i = firstIndex + 1; i < secondIndex; ++i) {
            composition *= pInt[i];
        }
        printf("Произведение между двумя нулями это %i\n", composition);
        return composition;
    } else {
        printf("Нужное количество нулей не найдено");
        return -1;
    }
}


void printArray(int *array, int c) {
    for (int i = 0; i < c; ++i) {
        printf("%i ", array[i]);
    }
    printf("\n");
}

int main() {
#ifdef WIN32
    system("chcp 65001");
#endif
    srand(time(NULL));
    printf("Введите число элементов массива\n");
    scanf("%u", &n);
    int *arr = calloc(n, sizeof(int));
    if (arr == 0) {
        return -1;
    }
    // initialization
    int array[10] = {0, 1, 2, 6, 0, 2, 4, 3, 7, 0};
    printArray(array, 10);
    initializeArray(arr, n);

    getMaxArrayNumber(arr);
    getMultiplyBetweenZeros(array);

    //arr = {1, 0, 3, 2,};
    int *arrrrr = chetNechet(array);
    printArray(arrrrr, c);

    free(arrrrr);
    free(arr);

    return 0;
}

void initializeArray(int *array, uint32_t c) {
    for (int i = 0; i < c; ++i) {
        array[i] = rand() % 7;
    }
    printArray(array, c);
}

