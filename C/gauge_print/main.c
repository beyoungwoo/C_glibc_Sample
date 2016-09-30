#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <poll.h>
#include <errno.h>
#include <sys/time.h>

static void gauge_print(int i, int cnt)
{
    int gauge;
    gauge = (double)(i / cnt);

    if (gauge <= 1) {
        printf("*****                                               ");
    }
    else if (gauge == 2) {
        printf("**********                                          ");
    }
    else if (gauge == 3) {
        printf("******************                                  ");
    }
    else if (gauge == 4) {
        printf("***********************                             ");
    }
    else if (gauge == 5) {
        printf("**************************                          ");
    }
    else if (gauge == 6) {
        printf("*******************************                     ");
    }
    else if (gauge == 7) {
        printf("***********************************                 ");
    }
    else if (gauge == 8) {
        printf("*****************************************           ");
    }
    else {
        printf("**********************************************      ");
    }
    fflush(NULL);
    printf("%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c",
            0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
            0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
            0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
            0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
            0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
            0x08, 0x08);

}

int main(int argc, char **argv)
{
    int i;
    int cnt;
    char buf[1024];
    struct timeval start_time;
    struct timeval end_time;
    struct timeval diff_time;
    time_t diff_tm;

    gettimeofday(&start_time, NULL);
    printf("\n+------------------------------------+\n");
    printf("| GAUGE PRINT EXAMPLE                |\n");
    printf("+------------------------------------+\n\n");
    printf("\n\n|0----------25-----------50----------75---------100|\n");

    cnt = 100;
    for (i = cnt; i < 1000; i++) {
        gauge_print(i, cnt);
        poll(0, 0, 1);
    }
    printf("****************************************************\n");

    gettimeofday(&end_time, NULL);
    diff_tm = end_time.tv_sec - start_time.tv_sec;
    diff_time.tv_usec = end_time.tv_usec - start_time.tv_usec;
    if (diff_time.tv_usec < 0) {
        diff_time.tv_usec += 1000000;
    }
    diff_time.tv_usec = diff_time.tv_usec/1000;

    strftime(buf, sizeof(buf), "%M:%S.", localtime(&diff_tm));
    printf("Elapsed time : %s%03d\n\n", buf, diff_time.tv_usec);

    return 0;
}
