#include <iostream>
#include <stack>

using namespace std;

int main()
{
    std::string input;
    cin >> input;

    int mismatch_cnt = 0;
    stack<char> Istack, Tstack;

    if (input.length() < 2 || input.length() > 50)
        return -1;

    for (int i = 0; i < input.length(); ++i) {
        if (i > 0) {
            if (input[i-1] != input[i]) 
                mismatch_cnt++;

            if (mismatch_cnt > 1) {
                if (input[i-2] == input[i]) {
                    cout << "False" << endl;
                    return 0;
                }
            }
            if (mismatch_cnt > 2) {
                cout << "False" << endl;
                return 0;
            }
        }

        if (input[i] == 'I') {
            if (Istack.empty()) 
                Istack.push(input[i]); 
            else {
                Istack.pop();
                mismatch_cnt--;
            }
        }
        else { // 'T'
            if (Tstack.empty()) 
                Tstack.push(input[i]); 
            else {
                Tstack.pop();
                mismatch_cnt--;
            }
        }
    }
        
    if (! Istack.empty() || ! Tstack.empty() ) 
        cout << "False" << endl;
    else 
        cout << "True" << endl;

    return 0;
}
