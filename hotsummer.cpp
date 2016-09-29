#include <iostream>
#include <climits>
#include <cstring>

#define MAXCNT 1000

int main()
{
    int i, n;
    int watt[MAXCNT][9];
    int max[MAXCNT];
    int total_watt;

    if (scanf("%d", &n) != 1) 
        exit(1);

    if (n < 1 || n > MAXCNT) 
        return -1;

    for (i = 0; i < n; i++) {
        if (scanf("%d", &max[i]) != 1) 
            exit(1);

        if (scanf("%d %d %d %d %d %d %d %d %d", 
                    &watt[i][0], &watt[i][1], &watt[i][2], 
                    &watt[i][3], &watt[i][4], &watt[i][5], 
                    &watt[i][6], &watt[i][7], &watt[i][8]) != 9) {
            printf("scanf failed\n");
            exit(1);
        } 
   }

    for (i = 0; i < n; i++) {
        total_watt = watt[i][0]+watt[i][1]+watt[i][2]+watt[i][3]+watt[i][4]+watt[i][5]+watt[i][6]+watt[i][7]+watt[i][8];

        if (total_watt > max[i])
            printf("NO\n");
        else 
            printf("YES\n");
    }
 
    return 0;
}
