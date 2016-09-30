#define _GNU_SOURCE
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <sched.h>
#include <errno.h>

#include <unistd.h>

int getNumberOfCpus( void )
{
    long nprocs       = -1;
    long nprocs_max   = -1;

    # ifdef _SC_NPROCESSORS_ONLN
    nprocs = sysconf( _SC_NPROCESSORS_ONLN );
    if ( nprocs < 1 )
    {
        //std::cout << "Could not determine number of CPUs on line. Error is  " << strerror( errno ) << std::endl;
        return 0;
    }

    nprocs_max = sysconf( _SC_NPROCESSORS_CONF );

    if ( nprocs_max < 1 )
    {
        //std::cout << "Could not determine number of CPUs in host. Error is  " << strerror( errno ) << std::endl;
        return 0;
    }

    //std::cout << nprocs < " of " << nprocs_max << " online" << std::endl;
    return nprocs; 

#else
    //std::cout << "Could not determine number of CPUs" << std::endl;
    return 0;
#endif
}

void *pthread_Message( void *ptr )
{
    sleep(10);
    int i;
    long li;
    char *message;
    message = (char *) ptr;
    printf("%s \n", message);
    cpu_set_t      l_cpuSet;
    int            l_maxCpus;
    int            j;
    unsigned long  l_cpuBitMask;

    CPU_ZERO( &l_cpuSet );
    printf("get affinity %d\n",pthread_getaffinity_np(pthread_self()  , sizeof( cpu_set_t ), &l_cpuSet ));
    // printf("cpuset %d\n",l_cpuSet);
    printf (" thread id %u\n", pthread_self());      

    if ( pthread_getaffinity_np(pthread_self()  , sizeof( cpu_set_t ), &l_cpuSet ) == 0 )
        for (i = 0; i < 4; i++)
            if (CPU_ISSET(i, &l_cpuSet))
                printf("XXXCPU: CPU %d\n", i);
    for (li=0; li< 10000000000; ++li){
        printf("%ld\n", li);
    }

    for (li=0; li< 10000000000; ++li){
        printf("%ld\n", li);
    }
    for (li=0; li< 10000000000; ++li){
        printf("%ld\n", li);
    }
    for (li=0; li< 10000000000; ++li){
        printf("%ld\n", li);
    }
    for (li=0; li< 10000000000; ++li){
        printf("%ld\n", li);
    }
}

int main()
{
    pthread_t thread1, thread2, thread3, thread4;
    pthread_t threadArray[4];
    cpu_set_t cpu1, cpu2, cpu3, cpu4;
    const char *thread1Msg = "Thread 1";
    const char *thread2Msg = "Thread 2";
    const char *thread3Msg = "Thread 3";
    const char *thread4Msg = "Thread 4";
    int thread1Create, thread2Create, thread3Create, thread4Create, i, temp;

    thread1Create = pthread_create(&thread1, NULL, &pthread_Message, (void*)thread1Msg);
    sleep(1);
    thread2Create = pthread_create(&thread2, NULL, &pthread_Message, (void*)thread2Msg);
    sleep(1);
    thread3Create = pthread_create(&thread3, NULL, &pthread_Message, (void*)thread3Msg);
    sleep(1);
    thread4Create = pthread_create(&thread4, NULL, &pthread_Message, (void*)thread4Msg);


    CPU_ZERO(&cpu1);
    CPU_SET(0, &cpu1);
    temp = pthread_setaffinity_np(thread1, sizeof(cpu_set_t), &cpu1);
    printf("setaffinity=%d\n", temp);
    printf("Set returned by pthread_getaffinity_np() contained:\n");
    for (i = 0; i < CPU_SETSIZE; i++)
        if (CPU_ISSET(i, &cpu1))
            printf("CPU1: CPU %d\n", i);

#if 0
    temp = pthread_setaffinity_np(thread2, sizeof(cpu_set_t), &cpu1);
    printf("Set returned by pthread_getaffinity_np() contained:\n");
    temp = pthread_setaffinity_np(thread3, sizeof(cpu_set_t), &cpu1);
    printf("Set returned by pthread_getaffinity_np() contained:\n");
    temp = pthread_setaffinity_np(thread4, sizeof(cpu_set_t), &cpu1);
    printf("Set returned by pthread_getaffinity_np() contained:\n");
#endif
    CPU_ZERO(&cpu2);
    CPU_SET(1, &cpu2);
    temp = pthread_setaffinity_np(thread2, sizeof(cpu_set_t), &cpu2);
    for (i = 0; i < CPU_SETSIZE; i++)
        if (CPU_ISSET(i, &cpu2))
            printf("CPU2: CPU %d\n", i);

    CPU_ZERO(&cpu3);
    CPU_SET(2, &cpu3);
    temp = pthread_setaffinity_np(thread3, sizeof(cpu_set_t), &cpu3);
    for (i = 0; i < CPU_SETSIZE; i++)
        if (CPU_ISSET(i, &cpu3))
            printf("CPU3: CPU %d\n", i);

    CPU_ZERO(&cpu4);
    CPU_SET(3, &cpu4);
    temp = pthread_setaffinity_np(thread4, sizeof(cpu_set_t), &cpu4);
    for (i = 0; i < CPU_SETSIZE; i++)
        if (CPU_ISSET(i, &cpu4))
            printf("CPU4: CPU %d\n", i);

    // pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpu1);



    // pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpu1);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    pthread_join(thread3, NULL);
    pthread_join(thread4, NULL);

    return 0;
}
