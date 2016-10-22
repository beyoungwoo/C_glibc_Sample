#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT 5000
#define MAXBUF 16

int month[13][2] = {
    {12,31},{1,31},{2,28},{3,31},{4,30},{5,31},{6,30},{7,31},{8,31},{9,30},{10,31},{11,30},{12,31}
};

char daily[7][MAXBUF] = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};

void Calrendal(int mon, int day, char *pday)
{
    int i, j, temp, disp = day;
    char buf[256] = {0,};
    int out[7], cnt = 0;

    if (mon > 12 || mon < 1)
        return;
    if (day > 31 || day < 1)
        return;

    for (i = 0; i < 7; i++) 
        if (strcmp(pday, daily[i]) == 0) 
            break;

    if (i == 7)
        return;

    j = 6 - i;
    while (i >= 0) {
        temp = disp - i;
        if (temp <= 0) {
            temp = month[mon-1][1] + temp;
            out[cnt] = temp;
        }
        else {
            out[cnt] = temp;
        }
        i -= 1;
        cnt += 1;
    }

    while (j > 0) {
        disp += 1;
        temp = disp;
        if (temp > 28) {
            if (temp <= month[mon][1]) {
                out[cnt] = disp;
            }
            else {
                temp = temp - month[mon][1];
                out[cnt] = temp;
            }
        }
        else {
            out[cnt] = disp;
        }
        j -= 1;
        cnt += 1;
    }
    printf("%d %d %d %d %d %d %d\n", 
            out[0], out[1], out[2], out[3], out[4], out[5], out[6]);
    return;
}

int main()
{
    int i, n;
    int mon[MAXCNT], day[MAXCNT];
    char buff[MAXCNT][MAXBUF];
    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) {
        if (scanf("%d %d %10s", &mon[i], &day[i], buff[i]) != 3) {
            exit(1);
        }
    }

    for (i = 0; i < n; i++) {
        Calrendal(mon[i], day[i], buff[i]);
    }

    return 0;
}
