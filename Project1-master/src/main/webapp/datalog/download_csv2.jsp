<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.util.List" %>
<%@ page import="Spring.monitoringDAO" %>
<%@ page import="bean.Gproduct" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 상품 데이터 다운로드 -->
<%
// 데이터베이스 연결 및 데이터 조회
try {
    monitoringDAO productDAO = new monitoringDAO();
    List<Gproduct> products = productDAO.getAllGProducts();
    
    // CSV 파일 생성
    response.setContentType("text/csv");
    response.setHeader("Content-Disposition", "attachment; filename=\"GProduct_log.csv\"");
    PrintWriter writer = response.getWriter();
    writer.println("상품코드,상품명,색상,사이즈,길이,가격,상품정보");
    
    // 상품 데이터 출력
    for (Gproduct product : products) {
        String productCode = product.getProductCode();
        String productName = product.getProductName();
        String productColor = product.getProductColor();
        String productSize = product.getProductSize();
        String productLength = product.getProductLength();
        String productPrice = product.getProductPrice();
        String productInfo = product.getProductInfo();
        
        writer.println(productCode + "," + productName + "," + productColor + "," + productSize + "," + productLength + "," + productPrice + "," + productInfo);
    }
    writer.close();
} catch (Exception e) {
    out.println("오류 발생: " + e.getMessage());
    e.printStackTrace();
}
%>
