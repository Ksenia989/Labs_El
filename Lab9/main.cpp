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

char * replaceWord(char pString[20]) {
    if (strcmp(pString, "=") == 0) return (char *) (":=");
    if (strcmp(pString, "==") == 0) return (char *) ("=");
    if (strcmp(pString, "{") == 0) return (char *) ("begin");
    if (strcmp(pString, "}") == 0) return (char *) ("end");
    if (strcmp(pString, "/*") == 0) return (char *) ("(*");
    if (strcmp(pString, "/*") == 0) return (char *) ("*)");
    return pString;
}

char *replaceWordsInString(char *arr) {
    int i = 0;
    char *newString = (char *) (malloc(n));

    char word[20] = {0};
    int wordLetterIndex = 0;
    do {
        if (arr[i] == ' ' || arr[i] == '\n') {
            word[20] = {0};// todo обнулять слово
            wordLetterIndex = 0;
            // записываем в строку полученное слово
            newString = strcat(newString, replaceWord(word));
            // и записываем следующий символ
            newString[strlen(newString)] = arr[i];
        } else {
            word[wordLetterIndex++] = arr[i];
        }
    } while (arr[i++] != '\n');
    // todo надо ли прибавлять \0 в конце?
    return newString;
}

int main() {
    FILE *file;
    FILE *writeFile;
    const char *path = "/home/tkseniya/Programming/Labs_El/Lab9/inputfile.txt";

    const char *pathToNewFile = "/home/tkseniya/Programming/Labs_El/Lab9/output.pas";

    file = fopen(path, "r");
    writeFile = fopen(pathToNewFile, "w");


    char arr[n] = {0};

    if (file == NULL) {
        printf("Файл не найден!");
    } else {
        while (fgets(arr, n, file) != NULL) {
            char* newString = replaceWordsInString(arr);

            // записать в файлик
            fputs(newString, writeFile);
            //fputs("\n", writeFile);// todo скорее всего будет уже со \n
        }

        // закрываем файлик
        fclose(file);
    }
    return 0;
}
