#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT  2000

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

void Lecture(char *buff, size_t n)
{
    int i, j;
    int cnt = 0;
    char div[MAXCNT/2][4];
    char temp[4];
    char res[1001] = {0,};

    for (i = 0; i < (MAXCNT/2); i++) 
        std::memset(div[i], 0x00, sizeof(div[i]));

    for (i = 0; i < n; i+=2) {
        div[cnt][0] = buff[i];
        div[cnt][1] = buff[i+1];
        cnt+=1;
    }

    for (i = 0; i < (n/2); i++) {
        for (j = i+1; j < (n/2); j++) {
            if (strcmp(div[i], div[j]) > 0) {
                memcpy(temp, div[i], sizeof(div[i]));
                memcpy(div[i], div[j], sizeof(div[i]));
                memcpy(div[j], temp, sizeof(div[j]));
            }
        }
    }

    for (i = 0; i < (n/2); i++) {
        Tstrlcat(res, div[i], sizeof(res));
    }
    printf("%s\n", res);

    return;
}

int main()
{
    int i, n;
    char a[1001];
    char buff[MAXCNT][1001];
    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) {
        if (scanf("%1000s", a) != 1) {
            exit(1);
        }
        if (std::strlen(a) % 2 != 0) {
            continue;
        }
        
        Tstrlcpy(buff[i], a, sizeof(buff[i]));
    }

    for (i = 0; i < n; i++) {
        Lecture(buff[i], std::strlen(buff[i]));
    }

    return 0;
}
