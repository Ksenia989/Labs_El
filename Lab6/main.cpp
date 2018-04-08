#include <stdlib.h>
#include <stdio.h>
#include <time.h>

// вариант 12
//Матрица A
//имеет седловую точку ijA, если ij
//A является минимальным элементом в
//i - й строке и максимальным в j
//-м столбце.
//Дана целочисленная прямоугольная матрица. Определить:
//1) количество  отрицательных  элементов  в  тех  строках,  которые
//содержат хотя бы один нулевой элемент;
//2) номера строк и столбцов всех седловых точек матрицы.
const int n = 5;
const int m = 3;

int isZeroInString(int pInt[n]);

int countElementsLowerZero(int pInt[n]);

int findSedlPoint(int pInt[n][m]);

void findMaxSeldEl(int i, int i1[5][3], int rawIndex);

int main() {
    // для обеспечения рандома
    srand(time(NULL));
    int staticArray[n][m] = {0};
//    staticArray = {}; todo constanta
    printf("Массив: \n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; ++j) {
            // заполняем числами от 0 до 9
            // todo заполнить от -4 до 5, чтобы были элементы < 0
            staticArray[i][j] = rand() % 4;
            printf("%i  ", staticArray[i][j]);
        }
        printf("\n");
    }


    // 1 task
    // пробегаемся по сторока
    for (int i = 0; i < n; ++i) {
        if (isZeroInString(staticArray[i])) {
            printf("в строке %i %i элементов меньше нуля\n"
                           "\n", i, countElementsLowerZero(staticArray[i]));
        }
    }

    // 2 task
    staticArray[4][0] = 4;
    staticArray[4][1] = 3;
    staticArray[4][2] = 3;
    findSedlPoint(staticArray);

    return 0;
}

int findSedlPoint(int pInt[n][m]) {
    // массив для хранения точек для вычисления седловой
    int addArray[n][m] = {0};

    // ищем минимальный элемент
    for (int i = 0; i < n; i++) {
        // объявляем, что нулевой элемент в каждой строке - минимальный
        int min = pInt[i][0];
        for (int j = 0; j < m; ++j) {
            if (pInt[i][j] < min) {
                min = pInt[i][j];
            }
        }
        // в новом массиве заменяем все минимальные значения на двоичную 1
        for (int j = 0; j < m; ++j) {
            if (pInt[i][j] == min) {
                addArray[i][j] = 1;
            }
        }
    }

    // ищем максимальный элемент
    for (int i = 0; i < m; i++) {
        // объявляем, что нулевой элемент в каждом столбце - максимальный
        int max = pInt[0][i];
        for (int j = 0; j < n; ++j) {
            if (pInt[j][i] > max) {
                max = pInt[j][i];
            }
        }
        // если элемент является максимальным, складываем
        for (int j = 0; j < n; ++j) {
            if (pInt[j][i] == max) {
                addArray[j][i] |=  2;
            }
        }
    }

    // выводим седловые элементы, если значение в столбце массива == 3
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (addArray[i][j] == 3) {
                printf("Седловая точка в строчке %i на элементе %i\n", i, pInt[i][j]);//todo
                printf("С индексами %i %i\n", i, j);//todo
            }
        }
    }

    return 0;
}


int countElementsLowerZero(int pInt[3]) {
    int elements = 0;
    for (int i = 0; i < m; ++i) {
        if (pInt[i] < 0) {
            elements++;
        }
    }
    return elements;
}

int isZeroInString(int pInt[3]) {
    int founded = 0;
    int i = 0;
    while (!founded && i < m) {
        if (pInt[i] == 0) {
            founded = 1;
        }
        i++;
    }
    return founded;
}
