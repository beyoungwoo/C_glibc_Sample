#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT 200
#define MAXBUF 32

long long in[MAXCNT];

void Check(int n)
{
    long long t, i, org, abun = 0;
    if (in[n] % 2 == 1 || in[n] < 70) {
        printf("not weird\n");
        return;
    }
    org = in[n];
    t = in[n] / 2;
    for (i = t; i > 0; i--) {

        if (in[n] % i == 0) {
            abun += i;
            if (org < i)
                continue;

            org -= i;
            //printf("%lld %lld\n", org, i);
            if (org == 0) {
                printf("not weird\n");
                return;
            }
        }
    }

    if (abun < in[n])
        printf("not weird\n");
    else 
        printf("weird\n");
    return;
}

int main()
{
    int i, n;
    if (scanf("%d", &n) != 1) exit(1);
    if (n < 1 || n > MAXCNT) return -1;

    for (i = 0; i < n; i++) {
        if (scanf("%llu", &in[i]) != 1) exit(1);
        if (in[i] < 1 || in[i] > 500000) exit(1);
    }

    for (i = 0; i < n; i++) Check(i);
    return 0;
}
