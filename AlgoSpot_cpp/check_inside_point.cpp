#include <iostream>
#include <cstdbool>
#include <vector>

using namespace std;

struct vec {
    double x;
    double y;
};

bool isInside(struct vec q, const vector<vec>& p);

int main()
{
    bool ret;
    int N, M;
    double x, y;
    struct vec check, v;
    vector<vec> in, out;

    if (scanf("%lf %lf", &check.x, &check.y) != 2) 
        return -1;

    cin >> N;
    for (int i = 0; i < N; ++i) {
        if (scanf("%lf %lf", &v.x, &v.y) != 2) 
            return -1;
        in.push_back(v);
    }

    ret = isInside(check, in);
    if (ret == false) {
        cout << "False" << endl;
        return -1;
    }

    cin >> M;
    for (int i = 0; i < M; ++i) {
        if (scanf("%lf %lf", &v.x, &v.y) != 2) 
            return -1;
        out.push_back(v);
    }

    ret = isInside(check, out);
    if (ret == false) 
        cout << "True" << endl;
    else 
        cout << "False" << endl;
    return 0;
}

bool isInside(struct vec q, const vector<vec>& p)
{
    int crosses = 0;

    for (int i = 0; i < p.size(); ++i) {
        int j = (i+1) % p.size();

        if ((p[i].y > q.y) != (p[j].y > q.y)) {
            double atX = (p[j].x - p[i].x) * (q.y - p[i].y) /
                         (p[j].y - p[i].y) + p[i].x;

            if (q.x < atX)
                ++crosses;
        }
    }
    return crosses % 2 > 0;
}
