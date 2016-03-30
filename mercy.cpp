#include <iostream>
#include <cstdio>

int main()
{
    int i, value;
    scanf("%d", &value);
    if (value <= 1 || value > 10) 
        return -1;

    for (i = 0; i < value; i++) 
        printf("Hello Algospot!\n");

    return 0;
}
