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
            
            // 자재 등록
            Material(conn, "M001", "Material A", "Supplier A");
            
            // 생산 달력 등록
            Calendar(conn, "Line A", "Shift 1");
            
            // 공정/라인/설비 등록
            Line(conn, "Process A", "Line A", "Equipment A");
            
            // 창고 등록
            Warehouses(conn, "Warehouse A", "Location A");
            
            // 거래처 등록
            Customer(conn, "Customer A", "Address A", "Contact A");
            
            // 공통 코드 등록
            CommonCode(conn, "Code A", "Description A");
            
            // 비가동 코드 등록
            Downtime(conn, "Downtime A", "Reason A");
            
            
            // BOM 생성
            int productCode = 1231;
            List<String> materialCodes = new ArrayList<>();
            materialCodes.add("M001");
            materialCodes.add("M002");
            createBOM(conn, productCode, materialCodes);
			
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

    private static void createBOM(Connection conn, int productCode, List<String> materialCodes) throws SQLException {
        String insertQuery = "INSERT INTO bom (product_code, material_code) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            for (String materialCode : materialCodes) {
                pstmt.setInt(1, productCode);
                pstmt.setString(2, materialCode);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("BOM 등록 성공");
                } else {
                    System.out.println("BOM 등록 실패");
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

    private static void Material(Connection conn, String code, String name, String supplier) throws SQLException {  // 자재코드, 자재명, 자재공급업체
        String insertQuery = "INSERT INTO materials (code, name, supplier) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setString(1, code);
            pstmt.setString(2, name);
            pstmt.setString(3, supplier);
            int rowsAffected = pstmt.executeUpdate();   // 등록 성공여부
            if (rowsAffected > 0) {
                System.out.println("자재 등록 성공");
            } else {
                System.out.println("자재 등록 실패");
            }
        }
    }

    private static void Calendar(Connection conn, String line, String shift) throws SQLException {
        String insertQuery = "INSERT INTO production_calendar (regdate, line, shift) VALUES (sysdate, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setString(1, line);
            pstmt.setString(2, shift);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("생산 달력 등록 성공");
            } else {
                System.out.println("생산 달력 등록 실패");
            }
        }
    }



    private static void Line(Connection conn, String process, String line, String equipment) throws SQLException {  // 공정, 라인, 설비
        String insertQuery = "INSERT INTO process_line_equipment (process, line, equipment) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setString(1, process);
            pstmt.setString(2, line);
            pstmt.setString(3, equipment);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("공정/라인/설비 등록 성공");
            } else {
                System.out.println("공정/라인/설비 등록 실패");
            }
        }
    }

    private static void Warehouses(Connection conn, String warehouse, String location) throws SQLException {  // 창고, 창고위치
        String insertQuery = "INSERT INTO warehouses (warehouse, location) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setString(1, warehouse);
            pstmt.setString(2, location);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("창고 등록 성공");
            } else {
                System.out.println("창고 등록 실패");
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

    private static void CommonCode(Connection conn, String code, String description) throws SQLException {   // 공통코드, 코드에 대한 설명
        String insertQuery = "INSERT INTO common_codes (code, description) VALUES (?, ?)"; 
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setString(1, code);
            pstmt.setString(2, description);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("공통 코드 등록 성공");
            } else {
                System.out.println("공통 코드 등록 실패");
            }
        }
    }

    private static void Downtime(Connection conn, String code, String reason) throws SQLException {   // 비가동코드, 비가동코드 이유
        String insertQuery = "INSERT INTO downtime_codes (code, reason) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setString(1, code);
                pstmt.setString(2, reason);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("비가동 코드 등록 성공");
                } else {
                    System.out.println("비가동 코드 등록 실패");
                }
            }
        } /*catch (SQLException e)*/ {
            System.out.println();
        }
    }

    

        		
        		

