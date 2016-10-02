package task;

import java.io.*;

public class MemoryGetCurrentValue {
	
	private MemorySnapShot memory = new MemorySnapShot();
    private final static String MeminfoPath="/proc/meminfo";

    public int CurrentStatus() {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(MeminfoPath)));
            String line;
            int hitCount = 0;
            while ((line=br.readLine().trim()) != null) {
                if (line.startsWith("MemTotal:")) {
                    hitCount ++;
                    String[] infoArray = line.split("\\s+");
                    memory.setMemTotal(Long.valueOf(infoArray[1]));
                } else if (line.startsWith("MemFree:")) {
                    hitCount ++;
                    String[] infoArray = line.split("\\s+");
                    memory.setMemFree(Long.valueOf(infoArray[1]));
                } else if (line.startsWith("Buffers:")) {
                    hitCount ++;
                    String[] infoArray = line.split("\\s+");
                    memory.setBuffers(Long.valueOf(infoArray[1]));
                } else if (line.startsWith("Cached:")) {
                    hitCount ++;
                    String[] infoArray = line.split("\\s+");
                    memory.setCached(Long.valueOf(infoArray[1]));
                }

                if (hitCount >= 4) {
					memory.setUsage();
					break;
				}
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

	public long getMemTotal() {
		return memory.getMemTotal();
	}

	public long getMemFree() {
		return memory.getMemFree();
	}

	public long getUsage() {
		return memory.getUsage();
	}

}
