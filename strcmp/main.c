#include "FUNC.h"

void strcmp_test1();
void strcmp_test2();

int main()
{
    strcmp_test1();
    strcmp_test2();
    return 0;
}

void strcmp_test1()
{
    int ret = 0;
    char *tmp = "2HOUR";
    printf("--------- [TEST1] ---------\n");

    printf("\n[strcmp]\n");
    ret = strcmp(tmp, "1HOUR");
    printf("not matched ret=%d\n", ret);
    ret = strcmp(tmp, "2HOUR");
    printf("    matched ret=%d\n", ret);
    ret = strcmp(tmp, "3HOUR");
    printf("not matched ret=%d\n", ret);

    printf("\n[strcasecmp]\n");
    ret = strcasecmp(tmp, "2hour");
    printf("matched ret=%d\n", ret);
    ret = strcasecmp(tmp, "2HouR");
    printf("matched ret=%d\n", ret);
    ret = strcasecmp(tmp, "2hOUr");
    printf("matched ret=%d\n", ret);

    tmp = "1";
    printf("\n[strncmp]\n");
    ret = strncmp(tmp, "1HOUR", 1);
    printf("    matched ret=%d\n", ret);
    ret = strncmp(tmp, "1HOUR", 2);
    printf("not matched ret=%d\n", ret);

    printf("\n[strncasecmp]\n");
    ret = strncasecmp(tmp, "1hour", 1);
    printf("    matched ret=%d\n", ret);
    ret = strncasecmp(tmp, "1hour", 2);
    printf("not matched ret=%d\n", ret);

    return;
}

void strcmp_test2()
{
    char *ret;
    char *buf = "http://algospot.com/%2a";
    char *buf2 = "http://algospot.com/%2a/%2a/test";
    char temp[32];
    char temp2[32];

    printf("--------- [TEST2] ---------\n");
    ret = strchr(buf, '%');
    strlcpy(temp, buf, ret-buf+1);

    if (ret+3 == '\0') {
        printf("[1]it's null\n");
    }

    if (strcmp(ret+3, "\0") == 0) {
        printf("[2]it's null\n");
        strcat(temp, "*");
        printf("%s\n", temp);
    }
    else {
        printf("found [%s]\n", ret+3);
        strcat(temp, ret+3);
        printf("%s\n", temp);
    }
    return;
}
