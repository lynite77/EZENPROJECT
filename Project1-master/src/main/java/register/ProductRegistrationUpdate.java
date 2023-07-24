// 제품 수정

package register;

import java.sql.*;

public class ProductRegistrationUpdate {
    private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String user = "SMFUSER";
    private static final String password = "SMFUSER";

    public static void main(String[] args) {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, password);

            int productCode = 1231; // 수정할 제품 코드
            String newProductName = "New Product Name"; // 새로운 제품명

            boolean success = modifyProduct(conn, productCode, newProductName);
            if (success) {
                System.out.println("제품 정보가 수정되었습니다.");
            } else {
                System.out.println("제품 정보 수정에 실패했습니다.");
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

    private static boolean modifyProduct(Connection conn, int productCode, String newProductName) throws SQLException {
        String updateQuery = "UPDATE product SET pname = ? WHERE code = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
            pstmt.setString(1, newProductName);
            pstmt.setInt(2, productCode);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
