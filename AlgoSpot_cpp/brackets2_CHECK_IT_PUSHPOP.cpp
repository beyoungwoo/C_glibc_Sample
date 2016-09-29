#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT 100
#define MAXBUF 10001

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

void Blackets2(char *a, size_t n)
{
    int l1;
    char stack[10001] = {0,};
    int top = 0;

    top = 0; // init
    for(l1=0;a[l1];l1++)
    {
        // open, push
        if(a[l1] == '(' || a[l1] == '{' || a[l1] == '[')
        {
            stack[top++] = a[l1];
        }
        // close, pop
        // no top -> error
        else if(a[l1] == ')')
        {
            if(top == 0) break;
            if(stack[--top] != '(') break;
        }
        else if(a[l1] == '}')
        {
            if(top == 0) break;
            if(stack[--top] != '{') break;
        }
        else if(a[l1] == ']')
        {
            if(top == 0) break;
            if(stack[--top] != '[') break;
        }
    }
    if(a[l1] || top != 0) // stack is not empty
        printf("NO\n");
    else printf("YES\n");

    return;
}

int main()
{
    int i, n, ret;
    char a[MAXBUF];
    char buff[MAXCNT][MAXBUF];

    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) {
        if (scanf("%10000s", a) != 1) {
            exit(1);
        }
        Tstrlcpy(buff[i], a, sizeof(buff[i]));
    }

    for (i = 0; i < n; i++) {
        Blackets2(buff[i], std::strlen(buff[i]));
    }

    return 0;
}
