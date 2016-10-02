package task;

import java.io.*;
import java.util.Scanner;

public class FdGetCurrentValue {
	
	private FdSnapShot fd = new FdSnapShot();
    private final static String FdinfoPath="/proc/sys/fs/file-nr";

    public int CurrentStatus() {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(FdinfoPath)));

            String line;

            if ((line=br.readLine().trim()) != null) {
                System.out.println(line);
                Scanner scan = new Scanner(line);

                fd.setFdUsed(scan.nextLong());
                scan.next();
                fd.setFdTotal(scan.nextLong());
                
                scan.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {

                }
            }
        }


        return 0;
    }

	public long getFdTotal() {
		return fd.getFdTotal();
	}

	public long getFdUsed() {
		return fd.getFdUsed();
	}

	public long getUsage() {
		return fd.getUsage();
	}

}
