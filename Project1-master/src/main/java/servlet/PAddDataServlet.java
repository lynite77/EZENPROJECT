package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PAddDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 폼 데이터 추출
        String productCode = request.getParameter("productCode");
        String productName = request.getParameter("productName");
        String productColor = request.getParameter("productColor");
        String productSize = request.getParameter("productSize");
        String productLength = request.getParameter("productLength");
        String productPrice = request.getParameter("productPrice");
        String productInfo = request.getParameter("productInfo");

        
        // 데이터베이스 연결 및 데이터 추가
        try {
            // 데이터베이스 연결
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "HELLOUSER", "HELLOUSER");
            
            // 데이터 추가 SQL 문 작성
            String sql = "INSERT INTO PRODUCT (P_CODE, P_NAME, P_COLOR, P_SIZE, P_LENGTH, P_PRICE, P_INFO) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, productCode);
            statement.setString(2, productName);
            statement.setString(3, productColor);
            statement.setString(4, productSize);
            statement.setString(5, productLength);
            statement.setString(6, productPrice);
            statement.setString(7, productInfo);
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
