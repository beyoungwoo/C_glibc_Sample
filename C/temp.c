#include <stdarg.h>

int sum(int nargs, ...)
{
    va_list argptr;
    int i, total = 0;

    va_start(argptr, nargs);
    for (i = 0; i < nargs, i++) {
        total += va_arg(arg_ptr, int);
    }
    va_end(argptr);
    return total;
}

int main()
{
    int s1, s2;

    s1 = sum(5, 1,2 , 3, 4, 5);
    printf("%d\n", s1);
    s2 = sum(5, 1,2 , 3, 4, 5);
    printf("%d\n", s2);

    return 0;
}
