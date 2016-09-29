#include <iostream>
#include <cstring>

#define MAXCNT 10001
#define MAXBUF 10001

using namespace std;

char T[MAXCNT][4];
int cnt;

void DIVIS(char *buf, size_t len)
{
    int sum = 0, temp;
    if (buf[len-1] == '\n') {
        buf[len-1] = '\0';
        len -= 1;
    }

    if (len == 0)
        return;

    for (size_t i = 0; i < len; i++) {
        temp = buf[i];
        if (temp < 65 && temp > 47)  /* 0~9 */
            temp -= 48;
        else if (temp < 97 && temp > 64)  /* A~Z */
            temp -= 55;
        else if (temp < 123 && temp > 96) /* a~z */
            temp -= 61;
        else {
            return;
        }
        sum += temp;
    }

    if (sum % 61 == 0) 
        snprintf(T[cnt], sizeof(T[cnt]), "yes");
    else 
        snprintf(T[cnt], sizeof(T[cnt]), "no");
    cnt += 1;
    return;
}

int main()
{
    int i;
    char buf[MAXBUF];

    cnt = 0;
    for (i = 0; i < MAXCNT; i++) 
        memset(T[i], 0x00, 4);

    //FILE *fp = fopen("dump", "r");
    while (1) {
        memset(buf, 0x00, sizeof(buf));
        //if (fgets(buf, sizeof(buf), fp) == NULL) {
        if (fgets(buf, sizeof(buf), stdin) == NULL) {
            exit(1);
        }
        if (strlen(buf) == 4)
            if (strncmp(buf, "end", 3) == 0) 
                break;

        DIVIS(buf, strlen(buf));
        fflush(stdout);
    }

    for (i = 0; i < cnt; i++) 
        printf("%s\n", T[i]);
    return 0;
}
