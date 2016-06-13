#include <stdio.h>

int main ()
{
    enum asdf {
        A1,
        A2,
        A3,
        A4,
        A5,
        __END__
    };

    char conf[10];

    sprintf(conf, "test_enum");

    printf("%c\n", conf[A1]);
    printf("%c\n", conf[A2]);
    printf("%c\n", conf[A3]);
    printf("%c\n", conf[A4]);
    printf("%c\n", conf[A5]);
    printf("%d\n", A5);
    printf("%d\n", A1);
    printf("%d\n", __END__);

    return 0;
}
