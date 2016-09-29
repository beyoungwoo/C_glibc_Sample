#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define MAX_ES 6
char es[8][MAX_ES] = {"%20","%21","%24","%28","%29", "%2a"};
char sc[MAX_ES] =  {' ','!','$','(',')', '*'};

size_t test_strlcpy(char *dst, const char *src, size_t dstsize)
{
  size_t i, size, srclen;

  srclen = strlen(src);
  size = srclen + 1;
  if (size > dstsize)
    size = dstsize;

  for (i = 0; i < (size - 1); i++)
    dst[i] = src[i];
  dst[size - 1] = '\0';

  return srclen;
}

int _Decode(char *in, char *out, size_t out_size)
{
    int i;
    char input[128];
    char buff[128];
    char *str;

    test_strlcpy(input, in, sizeof(input));

    for (i = 0; i < MAX_ES; i++) {
        str = NULL;
        memset(buff, 0x00, sizeof(buff));
        str = strstr(input, es[i]);
        if (str == NULL) {
            continue;
        }

        strncpy(buff, input, str-input); 
        snprintf(out, out_size, "%s%c%s", buff, sc[i], str+3);
        //printf("[%s]out:%s\n", es[i], out);
        return 0;
    }

    test_strlcpy(out, input, out_size);
    return -1;
}

int _Decode2(char *in, char *out, size_t out_size)
{
    int i;
    char buf[128] = {0,};
    size_t len = strlen(buf);
    char ret[128] = {0,};
    int cnt = 0;
    int flag = 0;

    test_strlcpy(buf, in, sizeof(buf));
    len = strlen(buf);

    for (i = 0; i < len; i++) {
        if (buf[i] == '%' && buf[i+1] == '2' && buf[i+2] == '5') {
            flag = 1;
            ret[cnt] = '%';
            cnt += 1;
            i += 2;
            continue;
        }

        ret[cnt] = buf[i];
        cnt += 1;
    }

    if (flag == 1) {
        test_strlcpy(out, ret, out_size);
    }
    else {
        test_strlcpy(out, in, out_size);
    }

    return 0;
}

void Decode(char *in)
{
    int ret;
    char result[128];
    char out[128];
    test_strlcpy(result, in, sizeof(result));
    while (1) {
        ret = _Decode(result, out, sizeof(out));
        if (ret < 0) {
            break;
        }
        test_strlcpy(result, out, sizeof(result));
        memset(out, 0x00, sizeof(out));
    }

    _Decode2(result, out, sizeof(out));

    printf("%s\n", out);
    return;
}

int main()
{
    int i, n;
    char u[81];
    char in[100][81];
    if (scanf("%d", &n) != 1) {
        return -1;
    }

    if (n < 1 || n > 100) 
        return -1;
    for (i = 0; i < n; i++) {
        if (scanf("%s", u) != 1) {
            return -1;
        }
        test_strlcpy(in[i], u, sizeof(in[i]));
    }
    for (i = 0; i < n; i++) 
        Decode(in[i]);
    return 0;
}
