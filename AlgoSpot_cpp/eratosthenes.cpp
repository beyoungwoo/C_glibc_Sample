#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

#define MAX_N 1000
int minFactor[MAX_N];


vector<int> getFactor(int n);
void er(int n);

int main()
{
    int N;
    vector<int> factor;
    vector<int> result;
    cin >> N;

    if (N < 2 || N > 10000)
        return -1;

    for (int i = 1; i < N+1; ++i) {
        factor = getFactor(i);

        for (vector<int>::iterator it = factor.begin(); 
             it != factor.end(); 
             ++it)
            result.push_back(*it);
    }

    sort(result.begin(), result.end());

    int last = 0;
    int cnt = 0;
    for (vector<int>::iterator it=result.begin(); 
         it!=result.end(); 
         ++it) {
        if (last == 0 || last == *it) {
            cnt++;
        }
        else {
            if (cnt != 0) { 
                cout << last << '^' << cnt << '*';
                cnt = 1;
            }
        }
        last = *it;
    }
    cout << last << '^' << cnt << endl;

    return 0;
}

vector<int> getFactor(int n) 
{
    vector<int> ret;

    // use eratosthenes
    er(n);

    while (n > 1) {
        ret.push_back(minFactor[n]);
        n /= minFactor[n];
    }
    return ret;
}

void er(int n) 
{
    minFactor[0] = minFactor[1] = -1;

    for (int i = 2; i <= n; ++i) 
        minFactor[i] = i;

    int sqrtn = int(sqrt(n));
    for (int i = 2; i <= sqrtn; ++i) {
        if (minFactor[i] == i) {
            for (int j = i*i; j <= n; j += i) {
                if (minFactor[j] == j) {
                    minFactor[j] = i;
                }
            }
        }
    }

}


