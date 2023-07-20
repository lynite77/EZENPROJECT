package bean;

public class ProductPdata {
	private String pname;
	private int ptot;
	    
	    public ProductPdata(String pname, int ptot) {
	        this.pname = pname;
	        this.ptot = ptot;
	    }
	    
	    public String getPname() {
	    	return pname;
	    }
	    
	    public void setPname(String pname) {
	    	this.pname = pname;
	    }
	    
	    public int getPtot() {
	    	return ptot;
	    }
	    
	    public void setPtot(int ptot) {
	    	this.ptot = ptot;
	    }
}
