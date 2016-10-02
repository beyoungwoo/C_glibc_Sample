package task;

public class FdSnapShot {
	
	    private long FdTotal;
	    private long FdUsed;
	    private long FdUsage;

	    public long getFdTotal() {
	        return FdTotal;
	    }

	    public void setFdTotal(long FdTotal) {
	        this.FdTotal = FdTotal;
	    }

	    public long getFdUsed() {
	        return FdUsed;
	    }

	    public void setFdUsed(long FdUsed) {
	        this.FdUsed = FdUsed;
	    }

	    public long getUsage() {
			return FdUsage;
		}

	    public void setUsage() {
	        this.FdUsage = (this.FdUsed / this.FdTotal * 100);
	    }

}
