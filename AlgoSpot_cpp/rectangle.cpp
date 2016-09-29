#include <iostream>

void RecT(int *a, int *b, int n)
{
    int i;
    int res_a, res_b;
    for (i = 0; i < n*3; i +=3 ) {
        if (a[i] == a[i+1]) 
            res_a = a[i+2];
        else if (a[i] == a[i+2]) 
            res_a = a[i+1];
        else 
            res_a = a[i];

        if (b[i] == b[i+1]) 
            res_b = b[i+2];
        else if (b[i] == b[i+2]) 
            res_b = b[i+1];
        else 
            res_b = b[i];

        printf("%d %d\n", res_a, res_b);
    }
    return;
}

int main()
{
    int i, n;
    int a[10000], b[10000];
    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > 3000) 
        return -1;

    for (i = 0; i < n*3; i++) {
        if (scanf("%d %d", &a[i], &b[i]) != 2) {
            exit(1);
        }
    }
    RecT(a, b, n);
    return 0;
}
