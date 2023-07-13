<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 데이터베이스 연결 및 데이터 조회
try {
    // 드라이버 로딩
    Class.forName("oracle.jdbc.driver.OracleDriver");
    
    // 데이터베이스 연결 설정
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/your_datasource_name");
    Connection connection = dataSource.getConnection();
    
    // 데이터 조회
    Statement statement = connection.createStatement();
    ResultSet resultSet = statement.executeQuery("SELECT * FROM ERROR_LOG");
    
    // CSV 파일 생성
    response.setContentType("text/csv");
    response.setHeader("Content-Disposition", "attachment; filename=\"error_log.csv\"");
    PrintWriter writer = response.getWriter();
    writer.println("Product Code,Product Name,Error Code,Error Name,Error Quantity,Error Date");
    while (resultSet.next()) {
        String productCode = resultSet.getString("P_CODE");
        String productName = resultSet.getString("P_NAME");
        String errorCode = resultSet.getString("E_CODE");
        String errorName = resultSet.getString("E_NAME");
        int errorQuantity = resultSet.getInt("ERROR_COUNT");
        String errorDate = resultSet.getString("ERROR_DATE");
        writer.println(productCode + "," + productName + "," + errorCode + "," + errorName + "," + errorQuantity + "," + errorDate);
    }
    writer.close();
    
    // 리소스 정리
    resultSet.close();
    statement.close();
    connection.close();
} catch (Exception e) {
    out.println("오류 발생: " + e.getMessage());
    e.printStackTrace();
}
%>