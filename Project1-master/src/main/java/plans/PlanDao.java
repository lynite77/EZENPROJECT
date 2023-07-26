package plans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import bean.QualityBean;
import database.DBConnectionMgr;
import product.ProductVO;

public class PlanDao {
	private JdbcTemplate jdbcTemplate;
	
	private DBConnectionMgr pool;
	
	public PlanDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}	
	
    // 메소드: 선택한 값들을 데이터베이스에 저장하는 기능
    public void saveSelectedValues(PlanVO vo) {
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement("INSERT INTO  order_info (order_code, product_code, order_count, order_info) VALUES (ORDER_CODE_GET('now'),?, ?, ?)");			
	            pstmt.setInt(1, findPCode(vo.getProductName()));
	            pstmt.setInt(2, vo.getOrderCount());
	            pstmt.setString(3, vo.getOrderInfo());
				return pstmt;}
		});
   }
    
    public List<PlanVO> listAll() {
        return jdbcTemplate.query("select * from orderview", planRowMapper());
    }
    
	private RowMapper<PlanVO> planRowMapper() { 
    return (rs, rowNum) -> { 
    	PlanVO vo = new PlanVO(); 
        vo.setOrderCode(rs.getString("ORDER_CODE")); 
        vo.setProductCode(rs.getInt("PRODUCT_CODE"));
        vo.setOrderCount(rs.getInt("ORDER_COUNT"));
        vo.setOrderInfo(rs.getString("ORDER_INFO"));
        vo.setOrderDate(rs.getString("ORDER_DATE"));
        vo.setProductName(rs.getString("PRODUCT_NAME"));
		return vo;
        };
    }
	
	public List<ProductVO> productNamelist() {
        return jdbcTemplate.query("select * from product_info order by product_name", productRowMapper());
    }
    
	private RowMapper<ProductVO> productRowMapper() { 
    return (rs, rowNum) -> { 
    	ProductVO vo = new ProductVO(); 
        vo.setProductCode(rs.getInt("PRODUCT_CODE")); 
        vo.setProductName(rs.getString("PRODUCT_NAME"));
        vo.setProductColor(rs.getString("Product_COLOR"));
        vo.setProductSize(rs.getString("PRODUCT_SIZE"));
        vo.setProductLength(rs.getString("PRODUCT_LENGTH"));
        vo.setProductPrice(rs.getInt("PRODUCT_PRICE"));
        vo.setProductInfo(rs.getString("PRODUCT_INFO"));
		return vo;
        };
    }
	
/*	public List<QualityBean> memberNamelist() {
        return jdbcTemplate.query("select * from member_info where role !='guest' order by member_name", memberRowMapper());
    }
    
	private RowMapper<QualityBean> memberRowMapper() { 
    return (rs, rowNum) -> { 
    	QualityBean vo = new QualityBean(); 
        vo.setMEMBER_NAME(rs.getString("MEMBER_NAME"));
        vo.setMEMBER_CODE(rs.getInt("MEMBER_CODE"));
		return vo;
        };
    }*/
	
	public int findPCode(String name) {
		PlanVO pname = new PlanVO();
		jdbcTemplate.query(
				"select product_code from product_info where product_name = ?",
				new RowMapper<PlanVO>() {
					@Override
					public PlanVO mapRow(ResultSet rs, int rowNum) throws SQLException {
						pname.setProductCode(rs.getInt("product_code"));
						return pname;
					}
				}, name);
		return pname.getProductCode();
	}
	
/*	public int findMCode(String name) {
		PlanVO mname = new PlanVO();
		jdbcTemplate.query(
				"select member_code from member_info where member_name = ?",
				new RowMapper<PlanVO>() {
					@Override
					public PlanVO mapRow(ResultSet rs, int rowNum) throws SQLException {
						mname.setMemberCode(rs.getInt("member_code"));
						return mname;
					}
				}, name);
		return mname.getMemberCode();
	}*/
}