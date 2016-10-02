package task;

//import java.io.*;

public class DiskGetCurrentValue {

	private DiskSnapShot disk = new DiskSnapShot("/home");
	private long freeSize;
	private long totalSize;

	public void setDiskInfo() {
		disk.setAll();
	}

	public long getTotalDisk() {
		// MB
		totalSize = (disk.getF_bsize() * disk.getF_blocks()) >> 20;
		return totalSize;
	}
			
	public long getFreeDisk() {
		// MB
		freeSize = (disk.getF_bsize() * disk.getF_bfree()) >> 20;
		return freeSize;
	}

	public double getDiskUsage() {
		return 1 - (double)freeSize/(double)totalSize;
	}

	public String getDiskUsageStr() {
		return (totalSize - freeSize) + "/" + totalSize;
	}
}
