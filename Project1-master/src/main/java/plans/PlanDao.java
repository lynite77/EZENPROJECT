package plans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import plans.PlanVO;

public class PlanDao {
    DataSource dataSource = null;
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    public PlanDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    public PlanDao() {
        try {
            // 데이터베이스 연결 설정은 Context를 이용하여 DataSource를 직접 생성합니다.
            Context context = new InitialContext();
            this.dataSource = (DataSource) context.lookup("java:comp/env/jdbc/your_datasource_name");
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("MonitoringDAO() : dataSource=" + (dataSource != null));
    }

    // 메소드: 선택한 값들을 데이터베이스에 저장하는 기능
    public void saveSelectedValues(PlanVO vo) {
        System.out.printf("[WorkDao] saveSelectedValues: color(%s), size(%s), len(%s), num(%s)\n", vo.getColor(), vo.getSize(), vo.getLen(), vo.getNum());

        try {
            conn = this.dataSource.getConnection(); // DBMS 접속 객체를 얻음
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO plan (color, psize, len, num) VALUES (?, ?, ?, ?)");

            pstmt.setString(1, vo.getColor());
            pstmt.setString(2, vo.getSize());
            pstmt.setString(3, vo.getLen());
            pstmt.setString(4, vo.getNum());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("[saveSelectedValues] connection exception: " + e.getMessage());
            }
        }
    }

    public List<PlanVO> getPlanlist() {
        List<PlanVO> planlists = new ArrayList<>();

        try {
            conn = this.dataSource.getConnection(); // DBMS 접속 객체를 얻음
            stmt = conn.createStatement(); // 쿼리(SQL)를 실행 할 수 있는 객체를 얻음
            rs = stmt.executeQuery("SELECT * FROM plan"); // 쿼리(SQL)를 실행, 결과를 리턴

            while (rs.next()) { // 결과셋에 데이터가 있으면 true
                String color = rs.getString("COLOR");
                String size = rs.getString("PSIZE");
                String len = rs.getString("LEN");
                String num = rs.getString("NUM");

                PlanVO planlist = new PlanVO(color, size, len, num);
                planlists.add(planlist);
            }
            // 연결 및 리소스 정리
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("[getPlanlist] connection, statement exception: " + e.getMessage());
            }
        }

        return planlists;
    }
}
