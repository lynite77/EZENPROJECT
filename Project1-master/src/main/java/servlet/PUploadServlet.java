package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import database.OracleConnector; // OracleConnector 클래스 import

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/PUploadServlet")
public class PUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        // 데이터베이스 연결 정보
        String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbUsername = "HELLOUSER";
        String dbPassword = "HELLOUSER";

        try {
            // CSV 파일 업로드 처리
            Part filePart = request.getPart("file");
            InputStream fileContent = filePart.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(fileContent));
            String line;

            // Oracle 데이터베이스 연결
            Connection connection = OracleConnector.getConnection();
            
            // CSV 파일 데이터 처리
            String query = "INSERT INTO error_log (product_code, product_name, error_code, error_name, error_quantity, error_date) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 6) {
                    statement.setString(1, data[0]);
                    statement.setString(2, data[1]);
                    statement.setString(3, data[2]);
                    statement.setString(4, data[3]);
                    statement.setInt(5, Integer.parseInt(data[4]));
                    statement.setDate(6, java.sql.Date.valueOf(data[5]));
                    statement.executeUpdate();
                }
            }

            statement.close();
            OracleConnector.closeConnection(); // 데이터베이스 연결 종료

            response.getWriter().println("데이터 업로드가 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("데이터 업로드 중 오류가 발생했습니다.");
        }
    }
}
