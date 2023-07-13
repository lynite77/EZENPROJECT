//생산계획을 불러와 지시등록 완료후, 지시번호/공정정보는 기초데이터 기준으로  자동으로 생성되며, 수정이 가능
//공정을 진행할 레일은 따로 수정가능


package work;

import java.sql.*;
import java.util.*;

public class WorkOrderRegistration3 {
	private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String user = "SMFUSER";
    private static final String password = "SMFUSER";
    
    // 지시 등록
    private static void createOrder(Connection conn, String productCode, int quantity, String rail) throws SQLException {
        // 자동으로 생성할 지시번호 가져오기
        int orderNumber = generateOrderNumber(conn);
        
        // 공정 정보 가져오기
        String process = getProcessForProduct(conn, productCode);
        
        // 지시 등록
        String insertQuery = "INSERT INTO orders (order_number, product_code, quantity, process, rail) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setInt(1, orderNumber);
            pstmt.setString(2, productCode);
            pstmt.setInt(3, quantity);
            pstmt.setString(4, process);
            pstmt.setString(5, rail);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("지시 등록 성공");
            } else {
                System.out.println("지시 등록 실패");
            }
        }
    }

    // 자동으로 생성할 지시번호 가져오기
    private static int generateOrderNumber(Connection conn) throws SQLException {
        String selectQuery = "SELECT MAX(order_number) FROM orders";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(selectQuery)) {
            if (rs.next()) {
                return rs.getInt(1) + 1;
            } else {
                return 1;
            }
        }
    }

    // 상품 코드를 기준으로 공정 정보 가져오기
    private static String getProcessForProduct(Connection conn, String productCode) throws SQLException {
        String selectQuery = "SELECT process FROM products WHERE code = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(selectQuery)) {
            pstmt.setString(1, productCode);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("process");
                } else {
                    return null;
                }
            }
        }
    }

    public static void main(String[] args) {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, password);

            // 생산 계획 불러오기
            List<Map<String, Object>> productionPlans = loadProductionPlansFromCSV("production_plans.csv");

            // 생산 계획에 따라 지시 등록
            for (Map<String, Object> plan : productionPlans) {
                String productCode = (String) plan.get("ProductCode");
                int quantity = (int) plan.get("Quantity");
                String rail = (String) plan.get("Rail");
                
                createOrder(conn, productCode, quantity, rail);
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
    
    // CSV 파일에서 생산 계획 불러오기
    private static List<Map<String, Object>> loadProductionPlansFromCSV(String filename) {
        // CSV 파일 파싱 및 데이터 추출 로직 구현
        // 생산 계획 데이터를 Map 형태로 반환
        return new ArrayList<>();
    }
}
