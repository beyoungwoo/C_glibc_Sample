#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT 10
#define MAXBUF 101

size_t Tstrlcat(char *dst, const char *src, size_t dstsize)
{
    size_t i, size, dstlen, srclen;

    dstlen = std::strlen(dst);
    srclen = std::strlen(src);
    size = dstlen + srclen + 1;
    if (size > dstsize)
        size = dstsize;

    for (i = dstlen; i < (size - 1); i++)
        dst[i] = src[i - dstlen];
    if (size > dstlen)
        dst[size - 1] = '\0';

    return dstlen + srclen;
}

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

void Encrypt(char *buff, size_t n)
{
    int i;
    int cnt_l = 0;
    int cnt_r = 0;
    char res_l[51] = {0,}; /* 0, 2, 4 ... */
    char res_r[51] = {0,}; /* 1, 3, 5 ... */
    char res[MAXBUF] = {0,}; 

    for (i = 0; i < n; i++) {
        if (i%2 == 0) {
            res_l[cnt_l] = buff[i];
            cnt_l += 1;
        } 
        else {
            res_r[cnt_r] = buff[i];
            cnt_r += 1;
        }
    } 

    Tstrlcpy(res, res_l, sizeof(res)); 
    Tstrlcat(res, res_r, sizeof(res));
    printf("%s\n", res);

    return;
}

int main()
{
    int i, n;
    char a[101];
    char buff[MAXCNT][MAXBUF];
    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) {
        if (scanf("%100s", a) != 1) {
            exit(1);
        }
        Tstrlcpy(buff[i], a, sizeof(buff[i]));
    }

    for (i = 0; i < n; i++) {
        Encrypt(buff[i], std::strlen(buff[i]));
    }

    return 0;
}
