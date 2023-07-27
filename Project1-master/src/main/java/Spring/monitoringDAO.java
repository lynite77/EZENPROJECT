package Spring;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import bean.ErrorLog;
import bean.Gproduct;
import bean.ProductEpdata;
import bean.ProductPdata;

public class monitoringDAO {
	
    DataSource dataSource = null;
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    
	public monitoringDAO() {
        try {
            // 드라이버 로딩
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // 데이터베이스 연결 설정
            Context context = new InitialContext();
            this.dataSource = (DataSource) context.lookup("java:comp/env/jdbc/your_datasource_name");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        System.out.println("ErrorLogDAO() : dataSource=" + (dataSource != null));
	}
	
	public List<ErrorLog> getAllErrorLogs() {
        List<ErrorLog> errorLogs = new ArrayList<>();
        
        int petot = getProductPetot();
        int etot = getProductEtot();
        
        try {
            connection = this.dataSource.getConnection();
            
            // 데이터 조회
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM ERROR_LOG");

            // 결과 처리
            while (resultSet.next()) {
                String productCode = resultSet.getString("P_CODE");
                String productName = resultSet.getString("P_NAME");
                String errorCode = resultSet.getString("E_CODE");
                String errorName = resultSet.getString("E_NAME");
                String errorDate = resultSet.getString("ERROR_DATE");
                
                ErrorLog errorLog = new ErrorLog(productCode, productName, errorCode, errorName, errorDate, petot, etot);
                errorLogs.add(errorLog);
            }
            // 연결 및 리소스 정리
            resultSet.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
        	try {
	        	if(statement != null) {
	        		statement.close();
	        	}
	        	
	        	if(connection != null) {
	        		connection.close();
	        	}
        	}
        	catch(SQLException e) {
        		System.out.println("[LOG]connection, statement exception: " + e.getMessage());
        		
        	}
        }
        
        return errorLogs;
    }
    
	public List<Gproduct> getAllGProducts() {
	    List<Gproduct> products = new ArrayList<>();
	    
	    try {
	        connection = this.dataSource.getConnection();
	        
	        // 데이터 조회
	        statement = connection.createStatement();
	        ResultSet resultSet = statement.executeQuery("SELECT * FROM PRODUCT_INFO");

	        // 결과 처리
	        while (resultSet.next()) {
	            String productCode = resultSet.getString("PRODUCT_CODE");
	            String productName = resultSet.getString("PRODUCT_NAME");
	            String productColor = resultSet.getString("PRODUCT_COLOR");
	            String productSize = resultSet.getString("PRODUCT_SIZE");
	            String productLength = resultSet.getString("PRODUCT_LENGTH");
	            String productPrice = resultSet.getString("PRODUCT_PRICE");
	            String productInfo = resultSet.getString("PRODUCT_INFO");
	            
	            Gproduct gproduct = new Gproduct(productCode, productName, productColor, productSize, productLength, productPrice, productInfo);
	            products.add(gproduct);
	        }
	        // 연결 및 리소스 정리
	        resultSet.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    finally {
	        try {
	            if(statement != null) {
	                statement.close();
	            }
	            
	            if(connection != null) {
	                connection.close();
	            }
	        }
	        catch(SQLException e) {
	            System.out.println("[GLOG]connection, statement exception: " + e.getMessage());
	        }
	    }
	    
	    return products;
	}

	public List<ProductPdata> getProductPdata() {
		List<ProductPdata> productPdatas = new ArrayList<>();
        
        try {
            connection = this.dataSource.getConnection();
            
            // 데이터 조회
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT DISTINCT PRODUCT_NAME, COUNT(*) OVER(PARTITION BY PRODUCT_NAME) as PTOT FROM PRODUCT_INFO");
            
            // 결과 처리
            while (resultSet.next()) {
            	String pname = resultSet.getString("PRODUCT_NAME");
            	int ptot = resultSet.getInt("PTOT");
                
            	ProductPdata productPdata = new ProductPdata(pname, ptot);
                productPdatas.add(productPdata);
            }
            // 연결 및 리소스 정리
            resultSet.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
        	try {
	        	if(statement != null) {
	        		statement.close();
	        	}
	        	
	        	if(connection != null) {
	        		connection.close();
	        	}
        	}
        	catch(SQLException e) {
        		System.out.println("[PLOG]connection, statement exception: " + e.getMessage());
        		
        	}
        }
        
        return productPdatas;
    }
	
	public List<ProductEpdata> getProductEpdata() {
		List<ProductEpdata> productEpdatas = new ArrayList<>();
        
        try {
            connection = this.dataSource.getConnection();
            
            // 데이터 조회
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT DISTINCT P_NAME, COUNT(*) OVER(PARTITION BY E_NAME) as EPTOT FROM ERROR_LOG");
            
            // 결과 처리
            while (resultSet.next()) {
            	String pname = resultSet.getString("P_NAME");
            	int eptot = resultSet.getInt("EPTOT");
                
            	ProductEpdata productEpdata = new ProductEpdata(pname, eptot);
            	productEpdatas.add(productEpdata);
            }
            // 연결 및 리소스 정리
            resultSet.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
        	try {
	        	if(statement != null) {
	        		statement.close();
	        	}
	        	
	        	if(connection != null) {
	        		connection.close();
	        	}
        	}
        	catch(SQLException e) {
        		System.out.println("[EPLOG]connection, statement exception: " + e.getMessage());
        		
        	}
        }
        
        return productEpdatas;
    }
	
    // 생산실적 총합 (정상제품)
	public int getProductPetot() {
        
        int petot = 0;
        
        try {
            connection = this.dataSource.getConnection();
            
            // 데이터 조회
            statement = connection.createStatement();
            resultSet = statement.executeQuery("SELECT count(*) as PETOT FROM qualitytable where error_code is null and check_date is not null");
            
            // 결과 처리
            while (resultSet.next()) {
                petot = resultSet.getInt("PETOT");
            }
            
            // 연결 및 리소스 정리
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
        	try {
        		if(resultSet != null) {
        			resultSet.close();
        		}
	        	if(statement != null) {
	        		statement.close();
	        	}
	        	
	        	if(connection != null) {
	        		connection.close();
	        	}
        	}
        	catch(SQLException e) {
        		System.out.println("[PETOT]connection, statement exception: " + e.getMessage());
        		
        	}
        }
        
        return petot;
    }    
    
    // 부적합 총합
 	public int getProductEtot() {
     
     int etot = 0;
     
     try {
         connection = this.dataSource.getConnection();
         
         // 데이터 조회
         statement = connection.createStatement();
         resultSet = statement.executeQuery("SELECT COUNT(*) as ETOT FROM ERROR_LOG");
         
         // 결과 처리
         while (resultSet.next()) {
             etot = resultSet.getInt("ETOT");
         }
         
         // 연결 및 리소스 정리
     } catch (Exception e) {
         e.printStackTrace();
     }
     finally {
     	try {
     		if(resultSet != null) {
     			resultSet.close();
     		}
         	if(statement != null) {
         		statement.close();
         	}
         	
         	if(connection != null) {
         		connection.close();
         	}
     	}
     	catch(SQLException e) {
     		System.out.println("[ETOT]connection, statement exception: " + e.getMessage());
     		
     	}
     }
     
     return etot;
 	} 
 	
}
