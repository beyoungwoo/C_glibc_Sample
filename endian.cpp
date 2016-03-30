#include <iostream>
#include <cstring>

#define MAXCNT 10000

void Endian(int in)
{
    unsigned long x;
    char bi[9];
    char bo[9];

    /* int to hex */
    sprintf(bi, "%08x", in);
//    printf("in [%s]\n", bi);

    /* big -> little or little -> big */
    bo[6]= bi[0];
    bo[7]= bi[1];
    bo[4]= bi[2];
    bo[5]= bi[3];
    bo[2]= bi[4];
    bo[3]= bi[5];
    bo[0]= bi[6];
    bo[1]= bi[7];

    /* hex to int */
//    printf("out[%s]\n", bo);
    x = strtoul(bo, NULL, 16);
    printf("%ld\n", x);
 
    return;
}

int main()
{
    int i, n;
    int val[MAXCNT];
    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) 
        if (scanf("%d", &val[i]) != 1) 
            exit(1);

    for (i = 0; i < n; i++) 
        Endian(val[i]);

    return 0;
}
