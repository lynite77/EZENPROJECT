package bean;

public class ProductEpdata {
	private String pname;
	private int eptot;
	    
	    public ProductEpdata(String pname, int eptot) {
	        this.pname = pname;
	        this.eptot = eptot;
	    }
	    
	    public String getPname() {
	    	return pname;
	    }
	    
	    public void setPname(String pname) {
	    	this.pname = pname;
	    }
	    
	    public int getEptot() {
	    	return eptot;
	    }
	    
	    public void setEptot(int eptot) {
	    	this.eptot = eptot;
	    }
}
