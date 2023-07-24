package plans;

public class PlanVO {
    String color;
    String size;
    String len;
    String num;

    public PlanVO() {}
    
	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getLen() {
		return len;
	}

	public void setLen(String len) {
		this.len = len;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public PlanVO(String color, String size, String len, String num) {
		this.color = color;
		this.size = size;
		this.len = len;
		this.num = num;
	}
    
    

}
