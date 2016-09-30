// 
// LINUX network interface check
//

#include <stdio.h>
#include <errno.h>
#include <dirent.h>
#include <unistd.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <net/if.h>

int get_ip_address(char* ip, int iplen, const char* ifname)
{
	int s;
	struct ifreq ifr;
	struct sockaddr_in* sin;

	s = socket(AF_INET, SOCK_DGRAM, 0);
	if(s<0) return -1;
	strncpy(ifr.ifr_name, ifname, IFNAMSIZ);

	if(ioctl(s, SIOCGIFADDR, &ifr) < 0)
	{
		close(s);
		return -1;
	}

	sin = (struct sockaddr_in*)&ifr.ifr_addr;
	strncpy(ip,
			inet_ntoa(sin->sin_addr),
			iplen);

	close(s);
	return 0;
}

int main()
{
	DIR *ni_dir = NULL;
	struct dirent *dir_entry = NULL;
	int sd;
	struct ifreq ifr;
	char* mac;

	if ((ni_dir = opendir("/sys/class/net")) == NULL) {
		printf("opendir(/sys/class/net) failed errno=%d\n",
				errno);
		return -1;
	}

	if ((sd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
		closedir(ni_dir);
		return -1;
	}

	while ((dir_entry = readdir(ni_dir)) != NULL) {
		if (dir_entry->d_name[0] == '\0' || dir_entry->d_name[0] == '.') {
			continue;
		}
		strcpy(ifr.ifr_name, dir_entry->d_name);
		if (ioctl(sd, SIOCGIFFLAGS, &ifr) < 0) {
			printf("%s:: ioctl() fail, ni(%s)\n", __func__, dir_entry->d_name);
			continue;
		}

		if (strcmp(ifr.ifr_name, "lo") != 0) {
			if (ioctl(sd, SIOCGIFHWADDR, &ifr) < 0) {
				printf("%s:: ioctl() fail, ni(%s)\n", __func__, dir_entry->d_name);
				continue;
			}
		}

		if (!(ifr.ifr_flags & IFF_UP)) {
			printf("%s:: ni(%s) NOT UP STATUS\n", __func__, dir_entry->d_name);
			continue;
		}

		mac = ifr.ifr_hwaddr.sa_data;
		printf("[%s] %02x:%02x:%02x:%02x:%02x:%02x ",
				ifr.ifr_name,
				mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);

		char ip[64];
		get_ip_address(ip, sizeof(ip), dir_entry->d_name);
		printf("[%s]\n", ip);
	}
	close(sd);
	closedir(ni_dir);

	return 0;
}

