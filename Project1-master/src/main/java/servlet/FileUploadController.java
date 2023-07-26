package servlet;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import database.OracleConnector;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@Controller
public class FileUploadController {
    @PostMapping("/upload")
    public String handleFileUpload(@RequestParam("file") MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                // Get database connection using OracleConnector class
                Connection conn = OracleConnector.getConnection();
                if (conn == null) {
                    return "uploadError"; // Database connection failed
                }

                String insertQuery = "INSERT INTO error_log (상품코드, 상품명, 에러코드, 에러명, 에러수량) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
                    BufferedReader br = new BufferedReader(new InputStreamReader(file.getInputStream(), Charset.forName("euc-kr")));
                    String line;
                    br.readLine(); // Skip header line
                    while ((line = br.readLine()) != null) {
                        String[] data = line.split(",");
                        pstmt.setString(1, data[0].trim());
                        pstmt.setString(2, data[1].trim());
                        pstmt.setString(3, data[2].trim());
                        pstmt.setString(4, data[3].trim());
                        pstmt.setInt(5, Integer.parseInt(data[4].trim()));
                        pstmt.executeUpdate();
                    }
                }

                OracleConnector.closeConnection(); // Close database connection
                return "uploadSuccess"; // Upload success 페이지로 이동
            } catch (Exception e) {
                e.printStackTrace();
                return "uploadError"; // Upload error 페이지로 이동
            }
        } else {
            return "uploadError"; // 파일이 비어있는 경우 Upload error 페이지로 이동
        }
    }
}
