#include <iostream>
#include <climits>
#include <cstring>
#include <numeric>
#include <vector>

#define MAXCNT 10000
#define MAXBUF 128

using namespace std;
int T[MAXCNT];

void FIX(char *buf, int idx, int t_num)
{
    int i, n, cnt;
    char sep[] = " ";
    char *str, *tf, *tok;

    vector<int> all_v;

    all_v.clear();
    tf = str = strdup(buf);
    while ((tok = strsep(&str, sep)) != NULL) {
        n = atoi(tok);
        all_v.push_back(n);
    }

    cnt = 0;
    for (i=0;i<all_v.size();i++){
        if (i+1 == all_v.at(i)) {
            cnt+=1;
        }
    }

    T[t_num] = cnt;
    free(tf);
    all_v.clear();
    return;
}

int main()
{
    int i, n, n2;
    char num[16] = {0,};
    char buf[MAXBUF];

    if (fgets(num, sizeof(num), stdin) == NULL) {
        exit(1);
    }
    n = atoi(num);

    if (n < 1 || n > MAXCNT)
        exit(1);

    for (i = 0; i < n; i++) {
        memset(num, 0x00, sizeof(num));
        if (fgets(num, sizeof(num), stdin) == NULL) {
            continue;
        }
        n2 = atoi(num);
        if (n2<10 || n2 > 12)
            exit(1);

        if (fgets(buf, MAXBUF, stdin) == NULL) {
            continue;
        }
        FIX(buf, n2, i);
    }

    for (i = 0; i < n; i++) {
        printf("%d\n", T[i]);
    }
    return 0;
}
