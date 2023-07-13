package main;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ErrorLogDAO2 {
	
	
	public ErrorLogDAO2() {
        try {
            // 드라이버 로딩
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // 데이터베이스 연결 설정
            Context context = new InitialContext();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
    public List<ErrorLog> getAllErrorLogs() {
        List<ErrorLog> errorLogs = new ArrayList<>();
        
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
            ResultSet resultSet2 = statement.executeQuery("SELECT SUM(PTOT) as PETOT FROM (SELECT DISTINCT P_NAME, COUNT(*) OVER(PARTITION BY P_NAME) as PTOT FROM PRODUCT WHERE P_NAME IN ('여름 반팔A','여름 반팔B', '여름 반팔C'))");
            
            // 결과 처리
            while (resultSet.next() && resultSet2.next()) {
                String productCode = resultSet.getString("P_CODE");
                String productName = resultSet.getString("P_NAME");
                String errorCode = resultSet.getString("E_CODE");
                String errorName = resultSet.getString("E_NAME");
                int errorQuantity = resultSet.getInt("ERROR_COUNT");
                String errorDate = resultSet.getString("ERROR_DATE");
                int petot = resultSet2.getInt("PETOT");
                
                ErrorLog errorLog = new ErrorLog(productCode, productName, errorCode, errorName, errorQuantity, errorDate, petot);
                errorLogs.add(errorLog);
            }
            
            // 연결 및 리소스 정리
            resultSet.close();
            resultSet2.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return errorLogs;
    }
}
