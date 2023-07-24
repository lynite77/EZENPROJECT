// 제품 등록

package register;

import java.sql.*;
import java.util.*;

public class ProductRegistration {
    private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String user = "SMFUSER";
    private static final String password = "SMFUSER";
    
 
    public static void main(String[] args) {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, password);

            // 제품 등록
            Product(conn, 1231, "Product", "Kim");
            
            // 거래처 등록
            Customer(conn, "Customer A", "Address A", "Contact A");
            			
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
    
    
    private static void Product(Connection conn, int code, String pname, String manager) throws SQLException {
        String insertQuery = "INSERT INTO product (code, pname, manager, register_date) VALUES (?, ?, ?, sysdate)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {   // 제품정보 삽입
            pstmt.setInt(1, code);
            pstmt.setString(2, pname);
            pstmt.setString(3, manager);
            // pstmt.setString(4, register_date);
            int rowsAffected = pstmt.executeUpdate();   // 등록 성공여부
            if (rowsAffected > 0) {
                System.out.println("제품 등록 성공");
            } else {
                System.out.println("제품 등록 실패");
            }
        }
    }

    private static void Customer(Connection conn, String customer, String address, String contact) throws SQLException {   // 거래처, 거래처 주소, 거래처 위치
        String insertQuery = "INSERT INTO customers (customer, address, contact) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setString(1, customer);
            pstmt.setString(2, address);
            pstmt.setString(3, contact);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("거래처 등록 성공");
            } else {
                System.out.println("거래처 등록 실패");
            }
        }
    }

            /*catch (SQLException e)*/ {
            System.out.println();
        }
    }

    

        		
        		

