// 제품 조회

package register;

import java.sql.*;
import java.util.Scanner;

public class ProductRegistrationConfirm {
    private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String user = "SMFUSER";
    private static final String password = "SMFUSER";

    public static void main(String[] args) {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, password);

            Scanner scanner = new Scanner(System.in);
            System.out.print("제품 코드를 입력하세요: ");
            int productCode = scanner.nextInt();

            // 제품 정보 조회
            Product product = getProduct(conn, productCode);
            if (product != null) {
                System.out.println("제품 정보:");
                System.out.println("제품 코드: " + product.getCode());
                System.out.println("제품명: " + product.getName());
                System.out.println("관리자: " + product.getManager());
            } else {
                System.out.println("제품을 찾을 수 없습니다.");
            }          
            
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println("오류: " + e.getMessage());
                }
            }
        }
    }

    private static Product getProduct(Connection conn, int productCode) throws SQLException {
        String selectQuery = "SELECT code, pname, manager FROM product WHERE code = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(selectQuery)) {
            pstmt.setInt(1, productCode);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int code = rs.getInt("code");
                String name = rs.getString("pname");
                String manager = rs.getString("manager");
                return new Product(code, name, manager);
            }
        }
        return null;
    }

}

class Product {
    private int code;
    private String name;
    private String manager;

    public Product(int code, String name, String manager) {
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
