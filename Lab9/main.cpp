#include <stdio.h>
#include <malloc.h>
#include <cstring>
//12.
// текстовые файлы
//Заменить встречающиеся в программе  на  Си  ключевые слова "="
//на ":=" , "==" на "=" , "{" на "begin", "}" на "end", "/*" на "{", а "*/" на "}",
//сформировав при этом выходной файл (с тем же именем, что и у входного,
//но с расширением "pas"),  содержащий преобразованную программу.
//Ключ:
//-предельное число заменяемых символов

#define n 150

int maxCount;
int currentCount;

char *replaceWord(char pString[40]) {
    if (currentCount < maxCount) {
        if (strcmp(pString, "=") == 0) {
            currentCount++;
            return (char *) (":=");
        } else if (strcmp(pString, "=") == 0) {
            currentCount++;
            return (char *) (":=");
        } else if (strcmp(pString, "==") == 0) {
            currentCount++;
            return (char *) ("=");
        } else if (strcmp(pString, "{") == 0) {
            currentCount++;
            return (char *) ("begin");
        } else if (strcmp(pString, "}") == 0) {
            currentCount++;
            return (char *) ("end");
        }
        if (strcmp(pString, "/*") == 0) {
            currentCount++;
            return (char *) ("(*");
        }
        if (strcmp(pString, "*/") == 0) {
            currentCount++;
            return (char *) ("*)");
        }
    }
    return pString;
}

char *replaceWordsInString(char *arr) {
    int i = 0;
    char *newString = (char *) (malloc(n));

    char *word = (char *) malloc(1);
    int wordLetterIndex = 0;
    do {
        if (arr[i] == ' ' || arr[i] == '\n') {
            wordLetterIndex = 0;
            // записываем в строку полученное слово
            newString = strcat(newString, replaceWord(word));

            word = (char *) malloc(1);
            // и записываем следующий символ
            newString[strlen(newString)] = arr[i];
        } else {
            word[wordLetterIndex++] = arr[i];
            // + 5 если заменится символы на большее их количество
            word = (char *) (realloc(word, wordLetterIndex * sizeof(char) + 5));
        }
    } while (arr[i++] != '\n');
    return newString;
}

int main() {
    FILE *file;
    FILE *writeFile;

    int input;
    printf("Введите ключ - количество заменяемых слов\n");
    scanf("%i", &input);
    maxCount = input;
    currentCount = 0;

    const char *path = "/home/tkseniya/Programming/Labs_El/Lab9/inputfile.txt";
    const char *pathToNewFile = "/home/tkseniya/Programming/Labs_El/Lab9/output.pas";

    file = fopen(path, "r");
    writeFile = fopen(pathToNewFile, "w");

    char arr[n] = {0};

    if (file == NULL) {
        printf("Файл не найден!");
    } else {
        while (fgets(arr, n, file) != NULL) {
            char *newString = replaceWordsInString(arr);
            // записать в файлик
            fputs(newString, writeFile);
        }
        // закрываем файлик
        fclose(file);
    }
    return 0;
}
