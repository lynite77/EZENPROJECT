package bean;

public class ErrorLog {
    private String productCode;
    private String productName;
    private String errorCode;
    private String errorName;
    private int errorQuantity;
    private String errorDate;
    private int petot;
    private int etot;

    public ErrorLog(String productCode, String productName, String errorCode, String errorName, int errorQuantity, String errorDate, int petot, int etot) {
        this.productCode = productCode;
        this.productName = productName;
        this.errorCode = errorCode;
        this.errorName = errorName;
        this.errorQuantity = errorQuantity;
        this.errorDate = errorDate;
        this.petot = petot;
        this.etot = etot;
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

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getErrorName() {
        return errorName;
    }

    public void setErrorName(String errorName) {
        this.errorName = errorName;
    }

    public int getErrorQuantity() {
        return errorQuantity;
    }

    public void setErrorQuantity(int errorQuantity) {
        this.errorQuantity = errorQuantity;
    }

    public int getPetot() {
        return petot;
    }

    public void setPetot(int petot) {
        this.petot = petot;
    }

    public int getEtot() {
        return etot;
    }

    public void setEtot(int etot) {
        this.etot = etot;
    }

    public String getErrorDate() {
        return errorDate;
    }

    public void setErrorDate(String errorDate) {
        this.errorDate = errorDate;
    }
}
