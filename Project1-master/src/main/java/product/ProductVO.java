package product;

import java.time.LocalDateTime;

public class ProductVO {
	private String productCode;
	private String productName;
	private String productManager;
	private LocalDateTime register_Date;
	
	public ProductVO() {}
	
	public ProductVO(String productCode, String productName, String productManager) {
		this.productCode = productCode;
		this.productName = productName;
		this.productManager = productManager;
	}
	
	public ProductVO(String productCode, String productName, String productManager, LocalDateTime register_Date) {
		this.productCode = productCode;
		this.productName = productName;
		this.productManager = productManager;
		this.register_Date = register_Date;
	}
	
	
	public LocalDateTime getRegister_Date() {
		return register_Date;
	}

	public void setRegister_Date(LocalDateTime register_Date) {
		this.register_Date = register_Date;
	}

	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductManager() {
		return productManager;
	}
	public void setProductManager(String productManager) {
		this.productManager = productManager;
	}

	@Override
	public String toString() {
		return "ProductVO [productCode=" + productCode + ", productName=" + productName + ", productManager="
				+ productManager + ", register_Date=" + register_Date + "]";
	}
	
	
}
