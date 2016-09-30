/*
 * need to root permition !!
 */

#include <stdio.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <linux/sockios.h>
#include <linux/if.h>
#include <linux/ethtool.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>

#define IFI_HADDR     8           /* allow for 64-bit EUI-64 in future */

struct ifi_info {
    char            ifi_name[IFNAMSIZ];   /* interface name, null terminated */
    u_char          ifi_haddr[IFI_HADDR]; /* hardware address */
    u_short         ifi_hlen;             /* #bytes in hw address: 0, 6, 8 */
    short           ifi_flags;            /* IFF_xx constants from <net/if.h> */
    short           ifi_myflags;          /* our own IFI_xxx flags */
    struct sockaddr *ifi_addr;            /* primary address */
    struct sockaddr *ifi_dstaddr;         /* destination address */
    struct sockaddr *ifi_brdaddr;         /* broadcast address */
    struct sockaddr *ifi_netmask;         /* netmask address */
    struct sockaddr *ifi_hwaddr;          /* mac address */
    struct ifi_info *ifi_next;            /* next of these structures */
};

static struct ifi_info *get_ifi_info(int family, int doaliases)
{
    int                 n;
    int                 sockfd, len, lastlen = 0, flags, myflags;
    char                lastname[IFNAMSIZ], *cptr;
    struct ifconf       ifc;
    struct ifreq        *ifr, ifrcopy;
    struct ifi_info     *ifi, *ifihead, **ifipnext;
    struct sockaddr_in  *sinptr;

    sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
    if (sockfd < 0) {
        printf("%s:: socket fail, ret = %d\n", __func__, sockfd);
        return NULL;
    }

    memset(&ifc, 0x00, sizeof(ifc));
    ifc.ifc_buf = 0x00;
    ifc.ifc_len = 100 * sizeof(struct ifreq);

    ifc.ifc_buf = malloc(ifc.ifc_len);
    if (ifc.ifc_buf == NULL) {
        printf("malloc failed, rv=%d(%s)\n", errno, strerror(errno));
        return NULL;
    }

    if (ioctl(sockfd, SIOCGIFCONF, &ifc) < 0) {
        if (errno != EINVAL || lastlen != 0) {
            printf("ioctl failed, rv=%d(%s)\n", errno, strerror(errno));
        }
    }

    ifihead = NULL;
    ifipnext = &ifihead;
    lastname[0] = 0;

    ifr = ifc.ifc_req;

    for (n = 0; n < ifc.ifc_len; n+= sizeof(struct ifreq)) {
//        printf("hw(ni) alarm info, ni_name=%s\n", ifr->ifr_name);

        switch (ifr->ifr_addr.sa_family) {
#ifdef IPV6 
            case AF_INET6:
                len = sizeof(struct sockaddr_in6);
                break;
#endif
            case AF_INET:
            default:
                len = sizeof(struct sockaddr);
                break;
        }

        if (ifr->ifr_addr.sa_family != family) {
            continue;               /* ignore if not desired address family */
        }

        myflags = 0;

        if ((cptr = (char*)strchr(ifr->ifr_name, ':')) !=  NULL) {
            if (doaliases == 0) {
                *cptr = 0;          /* replace colon will null */
            }
        }

        if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) {
            if (doaliases == 0) {
                continue;           /* already processed this interface */
            }
            myflags = 1;
        }
        memcpy(lastname, ifr->ifr_name, IFNAMSIZ);

        ifrcopy = *ifr;
        ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
        flags = ifrcopy.ifr_flags;

        ifi = (struct ifi_info *)calloc(1, sizeof(struct ifi_info));
        if (ifi == NULL) {
            printf("calloc failed, rv=%d(%s)\n", errno, strerror(errno));
            free(ifc.ifc_buf);
            close(sockfd);
            return NULL;
        }

        *ifipnext = ifi;            /* prev points to this new one */
        ifipnext = &ifi->ifi_next;  /* pointer to next one goes here */
        ifi->ifi_flags = flags;     /* IFF_xxx values */
        ifi->ifi_myflags = myflags; /* IFI_xxx values */
        memcpy(ifi->ifi_name, ifr->ifr_name, IFNAMSIZ);
        ifi->ifi_name[IFNAMSIZ-1] = '\0';

        switch (ifr->ifr_addr.sa_family) {
            case AF_INET:
                sinptr = (struct sockaddr_in *) &ifr->ifr_addr;
                if (ifi->ifi_addr == NULL) {
                    ifi->ifi_addr = (struct sockaddr *)calloc(1,
                            sizeof(struct sockaddr_in));
                    if (ifi->ifi_addr == NULL) {
                        printf("calloc failed, rv=%d(%s)\n",
                                errno, strerror(errno));
                        free(ifc.ifc_buf);
                        close(sockfd);
                        return NULL;
                    }
                    memcpy(ifi->ifi_addr, sinptr, sizeof(struct sockaddr_in));

#ifdef  SIOCGIFBRDADDR
                    if (flags & IFF_BROADCAST) {
                        ioctl(sockfd, SIOCGIFBRDADDR, &ifrcopy);
                        sinptr = (struct sockaddr_in *)&ifrcopy.ifr_broadaddr;
                        ifi->ifi_brdaddr = (struct sockaddr *)calloc(1,
                                sizeof(struct sockaddr_in));
                        memcpy(ifi->ifi_brdaddr, sinptr,
                                sizeof(struct sockaddr_in));
                    }
#endif
#ifdef  SIOCGIFDSTADDR
                    if (flags & IFF_POINTOPOINT) {
                        ioctl(sockfd, SIOCGIFDSTADDR, &ifrcopy);
                        sinptr = (struct sockaddr_in *)&ifrcopy.ifr_dstaddr;
                        ifi->ifi_dstaddr = (struct sockaddr *)calloc(1,
                                sizeof(struct sockaddr_in));
                        memcpy(ifi->ifi_dstaddr, sinptr,
                                sizeof(struct sockaddr_in));
                    }
#endif
                }
                break;
            default:
                break;
        }
        ifr ++;
    }
    free(ifc.ifc_buf);

    if (sockfd > 0) {
        close(sockfd);
    }

    return ifihead;     /* pointer to first structure in linked list */
}

int main(int argc, char *argv[])
{
    int sock;
    struct ifreq ifr;
    struct ifi_info *ifi, *ifihead;
    struct ethtool_cmd edata;
    int rc;

    sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
    if (sock < 0) {
        perror("socket");
        exit(1);
    }

    for (ifihead = ifi = get_ifi_info(AF_INET, 1);
         ifi != NULL; 
         ifi = ifi->ifi_next) {

        if (strstr(ifi->ifi_name, "lo") != NULL) {
            continue;
        }

        strncpy(ifr.ifr_name, ifi->ifi_name, sizeof(ifr.ifr_name));
        printf("%s:", ifr.ifr_name);
        ifr.ifr_data = &edata;

        edata.cmd = ETHTOOL_GSET;

        rc = ioctl(sock, SIOCETHTOOL, &ifr);
        if (rc < 0) {
            //perror("ioctl");
            continue;
        }
        switch (edata.speed) {
            case SPEED_10: printf("10Mbps\n"); break;
            case SPEED_100: printf("100Mbps\n"); break;
            case SPEED_1000: printf("1Gbps\n"); break;
            case SPEED_2500: printf("2.5Gbps\n"); break;
            case SPEED_10000: printf("10Gbps\n"); break;
            default: printf("%dbps\n", edata.speed);
        }

    }

    return 0;
}
