#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>

void PrintSayHello(char *namebuf)
{
    char hello[64]={0,};
    if (namebuf[strlen(namebuf)-1] == '\n') {
        namebuf[strlen(namebuf)-1] = '\0';
    }
    snprintf(hello, sizeof(hello), "Hello, %s!", namebuf);
    printf("%s\n", hello);
    return;
}

int main()
{
    int i, value;
    char buf[1024] = {0,};
    char name[64][51];
    scanf("%d", &value);
    if (value <= 1 || value > 50) {
        return -1;
    }
    for (i = 0; i < value; i++) {
        scanf("%s", buf);
        strcpy(name[i], buf);
    }
    for (i = 0; i < value; i++) {
        PrintSayHello(name[i]);
    }
    return 0;
}
