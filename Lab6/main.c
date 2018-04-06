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

int findSedlPoint(int pInt[n][m], int i);

int main() {
    // для обеспечения рандома
    srand(time(NULL));
    int staticArray[n][m];
//    staticArray = {}; todo constanta
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; ++j) {
            // заполняем числами от 0 до 9
            // todo заполнить от -4 до 5, чтобы были элементы < 0
            staticArray[i][j] = rand() % 10;
        }
    }

    // 1 task
    // пробегаемся по сторока
    for (int i = 0; i < n; ++i) {
        if (isZeroInString(staticArray[i])) {
            printf("в строке %i %i элементов меньше нуля"
                           "\n", i, countElementsLowerZero(staticArray[i]));
        }
    }

    // 2 task
    for (int i = 0; i < n; ++i) {
        findSedlPoint(staticArray, i);
    }

    return 0;
}

int findSedlPoint(int pInt[n][m], int i) {
    int minElement = pInt[i][0];
    int minElementIndex = 0;
    // находим минимальный элемент в переданной строке i
    for (int k = 0; k < m; ++k) {
        if (minElement > pInt[i][k]) {
            minElement = pInt[i][k];
            minElementIndex = k;
        }
    }

    int maxElementIndex = 0;
    // для начальных условий берём максимальный элементом первый в этой строке
    int maxElement = pInt[0][minElementIndex];
    // находим минимальный элемент в столбце (до n)
    for (int k = 0; k < n; ++k) {
        if (maxElement < pInt[k][minElementIndex]) {
            maxElement = pInt[k][minElementIndex];
            maxElementIndex = k;
        }
    }

    // если максимальный элемент совпадает со строкой, переданной как текущая, то это - седловой элемент
    if (maxElementIndex == i) {
        // todo вывод неправильно работает =(((
        printf("Седловая точка в строчке %i на элементе %i\n", i, pInt[minElementIndex][maxElementIndex]);
        printf("С индексами %i %i\n", minElementIndex, maxElementIndex);
        return pInt[minElementIndex][maxElementIndex];
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