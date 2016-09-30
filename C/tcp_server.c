#include <sys/types.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <signal.h>
#include <pthread.h>

#define BUFSIZE 100

void *clnt_connection(void *arg);
void send_message(char *message, int len);
void error_handling(char * message);
int tcp_socket_set(void);

struct sockaddr_in serv_addr;
struct sockaddr_in clnt_addr;
int clnt_number = 0;
int clnt_socks[10];
int serv_sock;
int state;
pthread_mutex_t mutx;

int main(int argc, char **argv)
{
    int clnt_sock;
    int clnt_addr_size;
    pthread_t thread;

    serv_sock = tcp_socket_set();

    while(1)
    {
        clnt_addr_size = sizeof(clnt_addr);
        clnt_sock = accept(serv_sock, (struct sockaddr*) &clnt_addr, 
                &clnt_addr_size);

        pthread_mutex_lock(&mutx);
        clnt_socks[clnt_number++] = clnt_sock;
        pthread_mutex_unlock(&mutx);

        pthread_create(&thread, NULL, clnt_connection, (void*)clnt_sock);
        printf("New!!,  Client IP_addr : %s\n", inet_ntoa(clnt_addr.sin_addr));
        printf("clnt_socks[clnt_number++] = %d\n", clnt_sock);
    }
    
    return 0;
}

void *clnt_connection(void *arg)
{
    int clnt_sock = (int)arg;
    int str_len = 0;
    char message[BUFSIZE];
    int i;
    while((str_len = read(clnt_sock, message, sizeof(message))) != 0)
    {
        printf("read from Client==>%s \n", message);
        send_message(message, str_len);
    }

    pthread_mutex_lock(&mutx);
    for(i=0; i<clnt_number; i++){        //
        if(clnt_sock == clnt_socks[i]){
            for(; i<clnt_number-1; i++)
                clnt_socks[i] = clnt_socks[i+1];
            break;
        }
    }
    clnt_number--;
    pthread_mutex_unlock(&mutx);
    close(clnt_sock);
    return 0;
}

void send_message(char * message, int len){
    int i;
    pthread_mutex_lock(&mutx);
    for(i=0; i<clnt_number; i++)
    {
        write(clnt_socks[i], message, len);
    }
    pthread_mutex_unlock(&mutx);
}


int tcp_socket_set(void)
{
    int serv_sock;
    int ret;

    if ((serv_sock = socket(PF_INET, SOCK_STREAM, 0)) == -1) {
        perror("Socket");
        exit(1);
    }

    serv_addr.sin_family = PF_INET;
    serv_addr.sin_port = htons(5000);
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    memset(&(serv_addr.sin_zero), 0x00, 8);

    state = bind(serv_sock, (struct sockaddr *)&serv_addr,
            sizeof(struct sockaddr));

    if (listen(serv_sock, 5) == -1) {
        perror("Listen");
        exit(1);
    }
    return serv_sock;
}

