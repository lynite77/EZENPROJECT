package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileItemIterator;

import Spring.monitoringDAO;
import bean.ErrorLog;

public class PUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 데이터베이스 연결
        try {
            // 파일 업로드 처리
            uploadFile(request);

            // 데이터베이스 연결 및 처리
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "HELLOUSER", "HELLOUSER");
            saveDataToDatabase(connection, request.getInputStream());
            connection.close();

            response.getWriter().println("CSV 파일 업로드 및 데이터베이스 저장이 완료되었습니다.");
        } catch (Exception e) {
            response.getWriter().println("오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void uploadFile(HttpServletRequest request) throws Exception {
        // Multipart 요청을 처리하여 CSV 파일 업로드
        if (ServletFileUpload.isMultipartContent(request)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            FileItemIterator iter = upload.getItemIterator(request);

            // 파일의 첫 번째 라인(목록명) 무시
            if (iter.hasNext()) {
                iter.next();
            }

            while (iter.hasNext()) {
                FileItemStream item = iter.next();
                String name = item.getFieldName();
                InputStream stream = item.openStream();

                if (!item.isFormField() && name.equals("csvFile")) {
                    // 파일을 저장하거나 처리하는 로직 추가 가능 (생략)
                }
            }
        }
    }

    
    // CSV 파일을 파싱하여 데이터베이스에 저장하는 함수
    private void saveDataToDatabase(Connection connection, InputStream inputStream) throws Exception {
    	BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, "EUC-KR"));
        String line;
        int petot = 0;
        int etot = 0;
        monitoringDAO errorLogDAO = new monitoringDAO();
        int lineNumber = 2; // 데이터가 시작되는 라인 번호
        while ((line = reader.readLine()) != null) {
            if (lineNumber == 2) {
                // 첫 번째 데이터인 경우에만 로그 출력
                System.out.println("Data processing started...");
            }
            String[] data = line.split(",");
            
            if (data.length >= 5) {
                String productCode = data[0];
                String productName = data[1];
                String errorCode = data[2];
                String errorName = data[3];
                int errorQuantity = Integer.parseInt(data[4]);
                String errorDate = data[5];

                // 데이터베이스에 저장
                ErrorLog errorLog = new ErrorLog(productCode, productName, errorCode, errorName, errorQuantity, errorDate, petot, etot);
                errorLogDAO.addErrorLog(errorLog);
            } else {
                // 데이터가 6개 열이 아닌 경우는 무시하고 다음 라인으로 넘어감
                System.out.println("Invalid data format at line " + lineNumber + ": " + line);
            }
            
            lineNumber++;
        }
        reader.close();
    }
}
