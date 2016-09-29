#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT 1000
#define MAXBUF 81

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

void MisSpell(char *buff, size_t n, int loc, int total_cnt)
{
    int i;
    int rcnt = 0;
    char res[MAXBUF] = {0,}; 

    for (i = 0; i < n; i++) {
        if (i == loc-1) 
            continue;
        res[rcnt] = buff[i];
        rcnt+=1;
    } 
    printf("%d %s\n", total_cnt, res);
    return;
}

int main()
{
    int i, n;
    char a[MAXBUF];
    int loc[MAXCNT];
    char buff[MAXCNT][MAXBUF];
    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) {
        if (scanf("%d %80s", &loc[i], a) != 2) {
            exit(1);
        }
        Tstrlcpy(buff[i], a, sizeof(buff[i]));
    }

    for (i = 0; i < n; i++) {
        MisSpell(buff[i], std::strlen(buff[i]), loc[i], i+1);
    }

    return 0;
}
