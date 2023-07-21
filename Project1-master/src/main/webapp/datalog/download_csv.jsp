<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.util.List" %>
<%@ page import="Spring.monitoringDAO" %>
<%@ page import="bean.ErrorLog" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 에러데이터 다운로드 -->
<%
// 데이터베이스 연결 및 데이터 조회
try {

    monitoringDAO errorLogDAO = new monitoringDAO();
    List<ErrorLog> errorLogs = errorLogDAO.getAllErrorLogs();
    
 	// CSV 파일 생성
    response.setContentType("text/csv");
    response.setHeader("Content-Disposition", "attachment; filename=\"error_log.csv\"");
    PrintWriter writer = response.getWriter();
    writer.println("상품코드,상품명,에러코드,에러명,에러수량,에러발생날짜");
    
    // 오류 로그 데이터 출력
    for (ErrorLog errorLog : errorLogs) {
        String productCode = errorLog.getProductCode();
        String productName = errorLog.getProductName();
        String errorCode = errorLog.getErrorCode();
        String errorName = errorLog.getErrorName();
        int errorQuantity = errorLog.getErrorQuantity();
        String errorDate = errorLog.getErrorDate();
        
        writer.println(productCode + "," + productName + "," + errorCode + "," + errorName + "," + errorQuantity + "," + errorDate);
    }
    writer.close();
} catch (Exception e) {
    out.println("오류 발생: " + e.getMessage());
    e.printStackTrace();
}
%>