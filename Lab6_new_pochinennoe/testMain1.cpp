// подключаем главный заголовочный файл
// теперь доступна генерация тестов и text fexture
#include <gtest/gtest.h>
#include "main.h"

#define n 5
#define m 3

// можно использовать main из библиотеки тестов, для этогоо
// добавить в target_link_libraries gtest_main через пробел
TEST(first_task, Lab6_new_pochinennoe) {
    int staticArray[n][m] = {{1, 1, 1},
                             {0, 9, 2},
                             {0, 8, 8},
                             {0, 1, 1},
                             {0, 4, 2}};
    EXPECT_STREQ("Седловая точка в строчке 0 на элементе 1\n"
                         "С индексами 0 0",
                 (char *) findSedlPoint(staticArray));
}


// todo запуск всех тестов сразу
//int main(int argc, char **argv) {
//    ::testing::InitGoogleTest(&argc, argv);
//    return RUN_ALL_TESTS();
//}