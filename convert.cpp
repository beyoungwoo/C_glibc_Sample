#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT 1000
#define MAXBUF 4

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

void KgToPound(char *unit, double val, int total)
{
    double ret;
    char ret_u[4] = "lb";

    ret = val * 2.2046;
    printf("%d %.4lf %s\n", total, ret, ret_u);

    return;
}

void PoundToKg(char *unit, double val, int total)
{
    double ret;
    char ret_u[4] = "kg";

    ret = val * 0.4536;
    printf("%d %.4lf %s\n", total, ret, ret_u);

    return;
}

void LiterToGallon(char *unit, double val, int total)
{
    double ret;
    char ret_u[4] = "g";

    ret = val * 0.2642;
    printf("%d %.4lf %s\n", total, ret, ret_u);

    return;
}

void GallonToLitter(char *unit, double val, int total)
{
    double ret;
    char ret_u[4] = "l";

    ret = val * 3.7854;
    printf("%d %.4lf %s\n", total, ret, ret_u);

    return;
}

void Convert(char *unit, double val, int total)
{
    if (strcmp(unit, "kg") == 0) {
        KgToPound(unit, val, total);
    }
    else if (strcmp(unit, "lb") == 0) {
        PoundToKg(unit, val, total);
    }
    else if (strcmp(unit, "l") == 0) {
        LiterToGallon(unit, val, total);
    }
    else if (strcmp(unit, "g") == 0) {
        GallonToLitter(unit, val, total);
    }

    return;
}

int main()
{
    int i, n;
    char a[MAXBUF];
    double val[MAXCNT];
    char unit[MAXCNT][MAXBUF];
    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) {
        if (scanf("%lf %4s", &val[i], a) != 2) {
            exit(1);
        }
        Tstrlcpy(unit[i], a, sizeof(unit[i]));
    }

    for (i = 0; i < n; i++) {
        Convert(unit[i], val[i], i+1);
    }

    return 0;
}
