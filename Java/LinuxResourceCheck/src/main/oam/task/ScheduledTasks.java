package task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledTasks {

	@Scheduled(fixedRate = 5000)
	public void LinuxResourceCheck() {

		CpuGetCurrentValue cpu = new CpuGetCurrentValue();
		cpu.CurrentStatus();
		System.out.println("cpu usage: " + cpu.getUsage() + "%, " 
				+ cpu.getIdleCPUTime() + "/" + cpu.getTotalCPUTime());

		MemoryGetCurrentValue mem = new MemoryGetCurrentValue();
		mem.CurrentStatus();
		System.out.println("mem usage: " + mem.getUsage() + "%, " 
				+ mem.getMemFree() + "/" + mem.getMemTotal());

		DiskGetCurrentValue disk = new DiskGetCurrentValue();
		disk.setDiskInfo();
		System.out.println("disk usage: " + disk.getDiskUsage() + "%" );
	}

}
