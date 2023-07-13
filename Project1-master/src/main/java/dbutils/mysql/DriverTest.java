package dbutils.mysql;

import java.sql.*;

public class DriverTest{
	final static private String _driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	final static private String _url = "jdbc:sqlserver://;serverName=192.168.0.56;databaseName=nexpom_basic;encrypt=false"; //trustServerCertificate=true
	final static private String _user = "sa";
	final static private String _password = "1234";
	
	public static void main(String args[]){
		Connection con;

		try{
			Class.forName(_driver).newInstance();
			con=DriverManager.getConnection(_url, _user, _password);
			System.out.println("Success");
		}
		catch(SQLException ex){ System.out.println("SQLException" + ex);}
		catch(Exception ex){ System.out.println("Exception:" + ex);}
	}
}