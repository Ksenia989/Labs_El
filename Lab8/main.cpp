#include <iostream>

// Структуры

//Вариант 12
//Описать структуру с именем WORKER,содержащую следующие поля:
//–фамилия и инициалы работника;
//–название занимаемой должности;
//–год поступления на работу.
// Написать программу, выполняющую следующие действия:
//–ввод  с  клавиатуры  данных  в  массив,  состоящий  из  десяти
//структур типа WORKER;
//–вывод таблицы на экран;
//–записи упорядочить по алфавиту;
//–вывод отсортированной таблицы на экран;
//–вывод на дисплей фамилий работников, чей стаж работы в
//организации превышает значение, введенное с клавиатуры;
//–если  таких  работников  нет,  вывести  на
//дисплей соответствующее сообщение.


int main() {
    struct Worker {
        char* fioInitcialy;
        char* dolzhnostDescription;
        int employmentYear;
    };


    return 0;
}