#include <stdio.h>
#include <cstdlib>
#include <string.h>

#define n 300

struct stringPredlWithNumberOfWords {
    char *string = {0};
    int words;
};

void counWordsNumber(stringPredlWithNumberOfWords *pWords);

int izvlechPredlozhenie(char *stringArray, stringPredlWithNumberOfWords *predlArray, int numberOfElements);

int maxWords;


int main(int argc, char **argv) {
    stringPredlWithNumberOfWords *predlArray;

    char *stringArray = (char *) malloc(300);

    FILE *file;

    // считываем параметр из аргументов командной строки
    maxWords = atoi(argv[2]);
    printf("%i\n", maxWords);

    const char *path = "/home/tkseniya/Programming/Labs_El/newTaskClasswork/fileForReading";

    file = fopen(path, "r");

    if (file == NULL) {
        printf("Файл не найден!");
    } else {
        int counter = 0;
        // выделяем под все строки 300, т.к. не знаем, какой они будут длины
        while (fgets(&(stringArray[counter * 300]), n, file) != NULL) {
            counter++;
            stringArray = (char *) realloc(stringArray, (counter + 1) * 300);
        };
        // закрываем файлик
        fclose(file);

        predlArray = (stringPredlWithNumberOfWords *) malloc(sizeof(stringPredlWithNumberOfWords) * counter);
        int length = izvlechPredlozhenie(stringArray, predlArray, counter);

        int input;
        printf("Введите количество слов в предложении\n");
        scanf("%i", &input);
        for (int i = 0; i < length; ++i) {
            if (predlArray[i].words == input) {
                printf("Предложение %i: \n", i);
                printf("%s \n\n", predlArray[i].string);
            }
        }
    }
    return 0;
}

int izvlechPredlozhenie(char *stringArray, stringPredlWithNumberOfWords *predlArray, int numberOfElements) {
    char *newString = (char *) malloc(1);
    int i = 0;
    int symbolCounter = 0;
    int currentStrLenCounter = 0;
    int predlCounter = 0;
    char symbol = *(stringArray + i * 300 + currentStrLenCounter);

    while (i < numberOfElements - 1 && strlen(stringArray + i * 300) != 0) {
        while (symbol != '.' && symbol != '!' && symbol != '?') {
            // если не закончились символы в строке
            if (currentStrLenCounter < strlen(stringArray + i * 300) - 1) {
                // добавляем символы к новой строке
                newString[symbolCounter++] = symbol; // todo пропускать пробел, если он после точки
                newString = (char *) realloc(newString, symbolCounter + 1);
                symbol = (stringArray + i * 300)[currentStrLenCounter + 1];
                currentStrLenCounter++;
            } else {
                // если в этой строке больше нет символов, переходим на следующую
                i++;
                currentStrLenCounter = 0;
            }
        }
        //todo !!!!!!! схема алгоритма

        newString = (char *) realloc(newString, symbolCounter + 1);
        newString[symbolCounter++] = symbol;
        newString = (char *) realloc(newString, symbolCounter + 1);
        newString[symbolCounter] = '\0';

        // добавляем 1 для символа конца строки
        predlArray[predlCounter].string = (char *) malloc(symbolCounter + 1);
        symbolCounter = 0;
        currentStrLenCounter++;
        symbol = (stringArray + i * 300)[currentStrLenCounter];

        strcpy(predlArray[predlCounter].string, newString);
        free(newString);
        // считаем количество слов
        counWordsNumber(predlArray + predlCounter);// todo

        predlCounter++; // нашли предложение
    }
    return predlCounter;
}

void counWordsNumber(stringPredlWithNumberOfWords *pWords) {
    int pr = 0;

    for (int i = 0; i < strlen(pWords->string) - 1; i++)
        if ((pWords->string[i] == ' ') && (pWords->string[i + 1] != ' '))
            pr = pr + 1;
    if (pWords->string[0] != ' ')
        pr = pr + 1;

    pWords->words = pr;
}

