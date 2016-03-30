#include "FUNC.h"

void strstr_test1();

int main()
{
    strstr_test1();
    return 0;
}

void strstr_test1()
{
    char *buf =  "SXX MSG :: \
                  { \
                     SXX/2.0 254 SESSION \
                     Require: COMPLETED 90000rel \
                     ... \
                     COMPLETED \
                  }";

    char *ret;
    char check[256] = {0,};

    strlcpy(check, buf, sizeof(check));
    ret = strstr(check, "COMPLETED");
    printf("[1]%s\n", ret);
    ret = strrstr(check, "COMPLETED");
    printf("[2]%s\n", ret);




    return;
}
