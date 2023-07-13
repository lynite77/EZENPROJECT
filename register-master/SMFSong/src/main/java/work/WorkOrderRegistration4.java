//작업지시현황화면에서는 등록된 작업지시에 대한 상태 및 각종 정보를 조회 가능
//현재 조회한 작업지시서 총합 내용 조회

package work;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class WorkOrderRegistration4 {
	private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String DB_USER = "SMFUSER";
    private static final String DB_PASSWORD = "SMFUSER";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // 작업지시 현황 조회
            showWorkOrderStatus(conn);

            // 현재 조회한 작업지시서 총합 내용 조회
            showTotalSummary(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void showWorkOrderStatus(Connection conn) throws SQLException {
        String query = "SELECT work_order_number, status, product_name FROM work_orders";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                int workOrderNumber = rs.getInt("work_order_number");
                String status = rs.getString("status");
                String productName = rs.getString("product_name");
                // 필요한 정보들을 가져와서 출력

                System.out.println("작업지시번호: " + workOrderNumber);
                System.out.println("상태: " + status);
                System.out.println("제품명: " + productName);
                // 추가적인 정보 출력

                System.out.println("----------------------------------------");
            }
        }
    }

    private static void showTotalSummary(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) AS totalWorkOrders, SUM(quantity) AS totalQuantity FROM work_orders";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                int totalWorkOrders = rs.getInt("totalWorkOrders");
                int totalQuantity = rs.getInt("totalQuantity");

                System.out.println("총 작업지시서 개수: " + totalWorkOrders);
                System.out.println("총 생산 수량: " + totalQuantity);
            }
        }
    }
}
