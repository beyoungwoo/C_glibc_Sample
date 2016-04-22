//
// LINUX disk check
//

#include <stdio.h>
#include <errno.h>
#include <dirent.h>
#include <string.h>
#include <sys/statvfs.h>
#include <mntent.h>

#define MNTTAB_PATH "/etc/mtab"


int main()
{
	struct statvfs  vfsbuf;
	double disk_size = 0;

	struct mntent *mp = NULL;
	FILE *fp = NULL;

	fp = fopen(MNTTAB_PATH, "r");
	if (fp == NULL) {
		printf("fopen error = %d\n", errno);
		return -1;
	}

	while ((mp = getmntent(fp)) != NULL) {
		if (strcmp(mp->mnt_type, "ufs") == 0 ||
				strcmp(mp->mnt_type, "ext2") == 0 ||
				strcmp(mp->mnt_type, "ext3") == 0 ||
				strcmp(mp->mnt_type, "ext4") == 0 ||
				strcmp(mp->mnt_type, "xfs") == 0 ||
				strcmp(mp->mnt_type, "vxfs") == 0) {

			if (statvfs(mp->mnt_dir, &vfsbuf) != 0) {
				continue;
			}

			disk_size = (double)((vfsbuf.f_blocks - vfsbuf.f_bfree + vfsbuf.f_bavail) * (vfsbuf.f_frsize/1024)) / (1024 * 1024);
			printf("Device:[%6s] Type:[%4s] Size:[%7.2f GB] Directory:[%16s]\n",
					mp->mnt_dir, 
					mp->mnt_type,
					disk_size,
					mp->mnt_fsname);
		}
	}

	fclose(fp);

	return 0;
}
