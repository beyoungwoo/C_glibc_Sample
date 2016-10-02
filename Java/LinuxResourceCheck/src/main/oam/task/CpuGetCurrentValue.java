package task;

import java.io.*;

public class CpuGetCurrentValue {

	private CpuSnapShot cpu = new CpuSnapShot();
	private static final String statPath = "/proc/stat";

	/**
	 * Read file /proc/stat, then get and set useful information
	 */
	public void CurrentStatus() {
		BufferedReader br = null;
		try {
			br = new BufferedReader(new InputStreamReader(new FileInputStream(statPath)));
			String line;
			while ((line=br.readLine().trim()) != null) {
				if (line.startsWith("cpu ")) {
					String[] infoArray = line.split("\\s+");
					for (int i=1; i<infoArray.length; i++) {
						cpu.setValues(i, Long.valueOf(infoArray[i]));
					}
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
					e.printStackTrace();
				}
			}
		}
	}

	public long getTotalCPUTime() {
		return cpu.getStat_user() + cpu.getStat_nice() + cpu.getStat_system()
			+ cpu.getStat_idle() + cpu.getStat_iowait() + cpu.getStat_irq()
			+ cpu.getStat_softirq() + cpu.getStat_steal() + cpu.getStat_guest();
	}

	public long getIdleCPUTime() {
		return cpu.getStat_idle();
	}

	public long getUsage() {
		return (getIdleCPUTime() / getTotalCPUTime() * 100);
	}
}
