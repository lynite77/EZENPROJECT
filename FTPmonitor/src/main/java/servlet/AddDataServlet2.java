package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 폼 데이터 추출
        String productCode = request.getParameter("productCode");
        String productName = request.getParameter("productName");
        String errorCode = request.getParameter("errorCode");
        String errorName = request.getParameter("errorName");
        int errorQuantity = Integer.parseInt(request.getParameter("errorQuantity"));
        
        // 현재 날짜 및 시간 가져오기
        Date errorDate = new Date();
        
        // 데이터베이스 연결 및 데이터 추가
        try {
            // 데이터베이스 연결
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "HELLOUSER", "HELLOUSER");
            
            // 데이터 추가 SQL 문 작성
            String sql = "INSERT INTO ERROR_LOG (P_CODE, P_NAME, E_CODE, E_NAME, ERROR_COUNT, ERROR_DATE) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, productCode);
            statement.setString(2, productName);
            statement.setString(3, errorCode);
            statement.setString(4, errorName);
            statement.setInt(5, errorQuantity);
            statement.setTimestamp(6, new java.sql.Timestamp(errorDate.getTime()));
            statement.executeUpdate();
            
            // 리소스 정리
            statement.close();
            connection.close();
            
            // 데이터 추가 성공 응답
            response.getWriter().println("데이터 추가 성공");
        } catch (Exception e) {
            // 데이터 추가 실패 응답
            response.getWriter().println("데이터 추가 실패: " + e.getMessage());
        }
    }
}
