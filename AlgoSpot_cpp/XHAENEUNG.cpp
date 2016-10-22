#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT 10000
#define MAXBUF 32

struct T {
    int outnum;
    char in[MAXBUF];
    char out[MAXBUF];
};
struct T t[MAXCNT];

char number[11][MAXBUF] = 
{"zero","one","two","three","four","five","six","seven","eight","nine","ten"};
char ord_num[11][MAXBUF] = 
{"eorz","eno","otw","eehrt","foru","efiv","isx","eensv","eghit","einn","ent"};

size_t Tstrlcpy(char *dst, const char *src, size_t dstsize)
{
    size_t i, size, srclen;
    srclen = std::strlen(src);
    size = srclen + 1;
    if (size > dstsize)
        size = dstsize;

    for (i = 0; i < (size - 1); i++)
        dst[i] = src[i];
    dst[size - 1] = '\0';
    return srclen;
}

void Check(int n)
{
    if (strcmp(t[n].in, ord_num[t[n].outnum]) == 0) 
        printf("Yes\n");
    else 
        printf("No\n");
    return;
}

int main()
{
    int i, j, k, n, out;
    int n1, n2;
    char temp, a1[MAXBUF], a2[MAXBUF], a3[MAXBUF], a4[MAXBUF];

    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) {
        /* two + three = ivef */
        if (scanf("%s %s %s %*s %s", a1, a2, a3, a4) != 4)
            exit(1);

        for (j = 0; j < 12; j++) {
            if (strcmp(number[j], a1) == 0) 
                break;
        }
        n1 = j;

        for (j = 0; j < 12; j++) {
            if (strcmp(number[j], a3) == 0) 
                break;
        }
        n2 = j;

        out = 100;
        if (strcmp(a2, "+") == 0) 
            out = n1+n2;
        else if (strcmp(a2, "*") == 0)
            out = n1*n2;
        else if (strcmp(a2, "/") == 0)
            out = n1/n2;
        else if (strcmp(a2, "-") == 0)
            out = n1-n2;

        t[i].outnum = out;
        if (out == 100) 
            Tstrlcpy(t[i].out, "err", MAXBUF);
        else 
            Tstrlcpy(t[i].out, number[out], MAXBUF);

        for(j=0;j<strlen(a4);j++) {
            for(k=0;k<strlen(a4);k++) {
                if (a4[j] < a4[k]) {
                    temp = a4[j];
                    a4[j] = a4[k];
                    a4[k] = temp;
                }
            }
        }
        Tstrlcpy(t[i].in, a4, MAXBUF);
    }

    for (i = 0; i < n; i++) {
        Check(i);
    }

    return 0;
}
