#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>

#define BUFSIZE 100
#define NAMESIZE 20
void *send_message(void *arg);
void *recv_message(void *arg);
void error_handling(char * message);
char message[BUFSIZE];
struct sockaddr_in serv_addr;

int main(int argc, char **argv)
{
    int sock;
    pthread_t snd_thread, rcv_thread;
    void *thread_result;

    sock = tcp_socket_set();

    pthread_create(&snd_thread, NULL, send_message, (void*)sock);
    pthread_create(&rcv_thread, NULL, recv_message, (void*)sock);
    pthread_join(snd_thread, &thread_result);
    pthread_join(rcv_thread, &thread_result);
    close(sock);
    return 0;
}

void *send_message(void *arg){     
    int sock = (int)arg;
    //char name[NAMESIZE]="[Default]";
    char name[NAMESIZE];
    char name_message[NAMESIZE+BUFSIZE];
    char get_name[NAMESIZE];

    printf("Your ID : ");
    fgets(get_name, NAMESIZE, stdin);
    (strlen(get_name) -1)[get_name]='\0';
    strncpy(name, get_name, NAMESIZE);

    while(1){
        fgets(message, BUFSIZE, stdin);
        if(!strcmp(message, "q\n")){     /* 'q' quit */
            close(sock);
            exit(0);
        }
        sprintf(name_message, "%s %s", name, message);
        write(sock, name_message, strlen(name_message));
        read(sock, name_message, NAMESIZE+BUFSIZE-1);
        if(str_len == -1) return ;
        name_message[str_len] = 0;
        fputs(name_message, stdout);
    }
}

int tcp_socket_set(void)
{
    int sock;
    struct hostent *host;

    host = gethostbyname("127.0.0.1");

    if ((sock = socket(PF_INET, SOCK_STREAM, 0)) == -1) {
        perror("Socket");
        exit(1);
    }

    serv_addr.sin_family = PF_INET;
    serv_addr.sin_port = htons(5000);
    serv_addr.sin_addr = *((struct in_addr *)host->h_addr);
    memset(&(serv_addr.sin_zero), 0x00, 8);
    if (connect(sock, (struct sockaddr *)&serv_addr,
                sizeof(struct sockaddr)) == -1) {
        perror("Connect");
        exit(1);
    }

    return sock;
}
