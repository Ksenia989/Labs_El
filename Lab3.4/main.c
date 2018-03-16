#include <stdio.h>
#include <math.h>
#include <stdlib.h>


double calculate_uravnie(double x);

int main() {
#ifdef WIN32
    system("chcp 65001");
#endif
    double sum = 0;
    printf("╔══════╤════════╗\n");
    printf("║   i │  S[i]  ║\n");
    printf("╟──────┼────────╢\n");
    for (int i = 1; i < 4; ++i) {
        sum += (double) 1 / (i * (i + 1) * (i + 2));
        printf("║   %i │ %.3lf ║\n", i, sum);
        if (i != 3) {
            printf("╟──────┼────────╢\n");
        }
    }
    printf("╚══════╧════════╝\n\n\n");

    printf("SECOND PART\n");

    double l_board = 0.5;
    double r_board = 1;
    double seredina;
    double znac_l, znac_r, znac_s;
    const double e = 10e-5;

    while (fabs(l_board - r_board) > e) {
        znac_l = calculate_uravnie(l_board);
        znac_r = calculate_uravnie(r_board);
        seredina = (l_board + r_board) / 2;
        znac_s = calculate_uravnie(seredina);

        printf("%lf % lf % lf\n", l_board, seredina, r_board);
        printf("Левая граница, середина, правая граница\n\n");

        if (znac_r > 0 & znac_s > 0) {
            r_board = seredina;
        } else {
            l_board = seredina;
        }
    }
    // проверка
    printf("Проверочка, проверка\n");
    printf("%lf", calculate_uravnie(seredina));// значение должно быть около 0
}

double calculate_uravnie(double x) {
    return x + cos(pow(x, 0.52) + 2);
}
