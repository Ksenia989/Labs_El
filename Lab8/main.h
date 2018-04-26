//
// Created by tkseniya on 13/04/18.
//

#ifndef LAB8_MAIN_H
#define LAB8_MAIN_H

#define maxNameSymbols 35

struct Worker {
    //–фамилия и инициалы работника;
    char fioInitcialy[maxNameSymbols];
    //–название занимаемой должности;
    char dolzhnostDescription[60];
    //–год поступления на работу.
    int employmentYear;
};

Worker *makeBubbleSort(Worker *worker);

void printArray(Worker pWorker[10]);

int select(Worker *pWorker);

#endif //LAB8_MAIN_H
