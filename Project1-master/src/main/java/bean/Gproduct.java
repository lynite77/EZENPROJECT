package bean;

public class Gproduct {
    private String productCode;
    private String productName;
    private String productColor;
    private String productSize;
    private String productLength;
    private String productPrice;
    private String productInfo;

    public Gproduct(String productCode, String productName, String productColor, String productSize, String productLength, String productPrice, String productInfo) {
        this.productCode = productCode;
        this.productName = productName;
        this.productColor = productColor;
        this.productSize = productSize;
        this.productLength = productLength;
        this.productPrice = productPrice;
        this.productInfo = productInfo;
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

    public String getProductColor() {
        return productColor;
    }

    public void setProductColor(String productColor) {
        this.productColor = productColor;
    }

    public String getProductSize() {
        return productSize;
    }

    public void setProductSize(String productSize) {
        this.productSize = productSize;
    }

    public String getProductLength() {
        return productLength;
    }

    public void setProductLength(String productLength) {
        this.productLength = productLength;
    }

    public String getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductInfo() {
        return productInfo;
    }

    public void setProductInfo(String productInfo) {
        this.productInfo = productInfo;
    }
}
