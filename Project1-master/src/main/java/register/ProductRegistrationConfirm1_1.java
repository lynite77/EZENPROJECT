package register;

class Productconfirm {
    private int code;
    private String name;
    private String manager;

    public Productconfirm(int code, String name, String manager) {
        this.code = code;
        this.name = name;
        this.manager = manager;
    }

    public int getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    public String getManager() {
        return manager;
    }
}
