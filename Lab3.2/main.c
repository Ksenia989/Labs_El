#include <stdio.h>
#include <math.h>
// вариант 13 - дополнительное задание

void additional_tz() {
    double var1 = 0, var2 = 0;
    double a = 2, b = 3;
//    var1 = (sin(a) + cos(2 * b - a)) / (cos(a) - sin(2 * b - a));
//    var2 = (1 + sin(2 * b)) / cos(2 * b);
//    printf("%lf, %lf", var2, var1);
}

int main1() {
    additional_tz();

    double r1, r2;
    printf("Введите R1, R2\n");
    scanf("%lf", &r1);
    scanf("%lf", &r2);
    printf("Считаны значения \n %lf, \n %lf \n", r1, r2);
    if (r1 < 0 || r2 < 0) {
        printf("Радиус не может быть отрицательным");
        return 1;
    }
    if (r1 > r2) {
        printf("ERROR, TRY AGAIN r1 не может быть меньше r2");
        return 1;
    }

    double x, y;
    printf("Введите координаты x, y точки: \n");
    scanf("%lf", &x);
    scanf("%lf", &y);

    printf("Координаты равны \n x = %lf, \n y = %lf", x, y);

    if (((x >= 0 && y >= 0) || (x <= 0 && y <= 0)) &&
        (x * x + y * y >= r1 * r1 && // не внутри первого круга
         x * x + y * y <= r2 * r2) // но внутри второго
            ) {
        printf("\n входит");
    } else {
        printf("\n не входит");
    }
    return 0;
}
