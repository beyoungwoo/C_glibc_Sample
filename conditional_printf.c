#include <stdio.h>

int main()
{
    int a = 10;
    int b = 20;
    int c = 30;
    int max;

    //max = (b > a ) ? b : a;
    max = (c > b) ? c : ((b > a ) ? b : a);
    printf("%d\n", max);
    return 0;
}
