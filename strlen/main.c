#include "FUNC.h"

void strlen_test1();

int main()
{
    strlen_test1();
    return 0;
}

void strlen_test1()
{
    char *buf =  "SXX MSG :: \
                  { \
                     SXX/2.0 254 SESSION \
                     Require: 90000rel \
                     ... \
                  }";

    size_t len;
    len = strlen(buf);
    printf("%s(%zu)\n", buf, len);

#if 0
    FILE *fp = NULL;
    char *path = "./dump";
    fp = fopen(path, "a+");
    if (fp == NULL) {
        perror("fopen failed");
        return;
    }

    size_t ret;
    ret = fwrite(buf, sizeof(char), len, fp);
    if (ret != len) {
        perror("fwrite failed");
    }
#endif
    return;
}
