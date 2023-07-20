package Spring;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import bean.QualityBean;

import database.DBConnectionMgr;

public class QualityDAO {
	
	private DBConnectionMgr pool;
	
	public QualityDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 리스트 가져오기 (안씀)
	/*public Vector<QualityBean> getRegisterList() { 
		   final String strQuery = "select * FROM qualitytable";
		   Connection conn = null;
		   Statement stmt = null;
	       ResultSet rs = null;
	       Vector<QualityBean> vlist = new Vector<QualityBean>();
	       try {
	          conn = pool.getConnection(); //DBMS 접속 객체를 얻음
	          stmt = conn.createStatement(); // 쿼리(SQL)를 실행 할 수 있는 객체를 얻음
	          rs = stmt.executeQuery(strQuery);		// 쿼리(SQL)를 샐행, 결과를 리턴
	          
			  while (rs.next()) {					// 결과셋에 데이터가 있으면 true
	             QualityBean bean = new QualityBean();
			 	 bean.setQUALITY_CODE (rs.getString("Quality_code"));
				 bean.setPRODUCT_NAME (rs.getString("product_name"));
	 			 bean.setORDER_DATE (rs.getString("order_date"));
	 			 bean.setMEMBER_NAME (rs.getString("member_name"));
	 			 vlist.addElement(bean);
	          }
	       } catch (Exception ex) {
	          System.out.println("Exception" + ex);
	       } finally {
	          if(rs!=null)   try{rs.close();}  catch(SQLException e){}
			  if(stmt!=null) try{stmt.close();}catch(SQLException e){}
		      if(conn!=null) try{conn.close();}catch(SQLException e){}
	       }
	       return vlist;
	    }*/
	
	// 셀렉박스 값 이름 가져오기
	public Vector<QualityBean> getMemberList() { 
		   final String strQuery = "select member_name from member_info order by member_name";
		   Connection conn = null;
		   Statement stmt = null;
	       ResultSet rs = null;
	       Vector<QualityBean> mlist = new Vector<QualityBean>();
	       try {
	          conn = pool.getConnection(); //DBMS 접속 객체를 얻음
	          stmt = conn.createStatement(); // 쿼리(SQL)를 실행 할 수 있는 객체를 얻음
	          rs = stmt.executeQuery(strQuery);		// 쿼리(SQL)를 샐행, 결과를 리턴
	          
			  while (rs.next()) {					// 결과셋에 데이터가 있으면 true
	             QualityBean bean = new QualityBean();
			 	 bean.setMEMBER_NAME (rs.getString("member_name"));
	 			 mlist.addElement(bean);
	          }
	       } catch (Exception ex) {
	          System.out.println("Exception" + ex);
	       } finally {
	          if(rs!=null)   try{rs.close();}  catch(SQLException e){}
			  if(stmt!=null) try{stmt.close();}catch(SQLException e){}
		      if(conn!=null) try{conn.close();}catch(SQLException e){}
	       }
	       return mlist;
	    }
		
		//셀렉박스 값 에러명 가져오기
		public Vector<QualityBean> getErrorList() { 
		   final String strQuery = "select * from error_info order by error_code";
		   Connection conn = null;
		   Statement stmt = null;
	       ResultSet rs = null;
	       Vector<QualityBean> elist = new Vector<QualityBean>();
	       try {
	          conn = pool.getConnection(); //DBMS 접속 객체를 얻음
	          stmt = conn.createStatement(); // 쿼리(SQL)를 실행 할 수 있는 객체를 얻음
	          rs = stmt.executeQuery(strQuery);		// 쿼리(SQL)를 샐행, 결과를 리턴
	          
			  while (rs.next()) {					// 결과셋에 데이터가 있으면 true
	             QualityBean bean = new QualityBean();
	             bean.setERROR_CODE(rs.getString("error_code"));
	             bean.setERROR_NAME(rs.getString("error_name"));
			 	 bean.setERROR_CONTENT(rs.getString("error_info"));
	 			 elist.addElement(bean);
	          }
	       } catch (Exception ex) {
	          System.out.println("Exception" + ex);
	       } finally {
	          if(rs!=null)   try{rs.close();}  catch(SQLException e){}
			  if(stmt!=null) try{stmt.close();}catch(SQLException e){}
		      if(conn!=null) try{conn.close();}catch(SQLException e){}
	       }
	       return elist;
	    }
	
		// 게시판 리스트
		public Vector<QualityBean> getBoardList(String keyField, String keyWord, int start, int end, String before, String after) {
			System.out.printf("[getBoardList] keyField(%s), keyWord(%s), start(%d), end(%d)\n", keyField, keyWord, start, end, before, after);
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<QualityBean> vlist = new Vector<QualityBean>();
			
			try {
				con = pool.getConnection();
				if (keyField.equals("temporary") && (keyWord.equals("null")||keyWord.equals("")||keyWord.equals("선택"))) {
					sql = "SELECT rownum, a.* FROM (SELECT rownum rnum, b.* FROM ";
					sql += "(select * FROM qualitytable where member_name is null order by quality_code desc) b) a WHERE rnum BETWEEN ? AND ? and TO_CHAR(ORDER_DATE,'YYYY-MM-DD') between ? and ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
					pstmt.setString(3, before);
					pstmt.setString(4, after);
				}			
				else if (keyWord.equals("null") || keyWord.equals("")) {
					sql = "SELECT rownum, a.* FROM (SELECT rownum rnum, b.* FROM ";
					sql += "(select * FROM qualitytable order by quality_code desc) b) a WHERE rnum BETWEEN ? AND ? and TO_CHAR(ORDER_DATE,'YYYY-MM-DD') between ? and ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
					pstmt.setString(3, before);
					pstmt.setString(4, after);
				} 				
				else {
					sql = "SELECT rownum, a.* FROM (SELECT rownum rnum, b.* FROM (select * FROM qualitytable ";
					sql += "WHERE " + keyField + " like ? ";
					sql += "order by quality_code desc) b) a WHERE rnum BETWEEN ? AND ? and TO_CHAR(ORDER_DATE,'YYYY-MM-DD') between ? and ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
					pstmt.setString(4, before);
					pstmt.setString(5, after);
				}
				rs = pstmt.executeQuery();
				while (rs.next()) {					// 결과셋에 데이터가 있으면 true
		             QualityBean bean = new QualityBean();
				 	 bean.setQUALITY_CODE (rs.getString("quality_code"));
					 bean.setPRODUCT_NAME (rs.getString("product_name"));
		 			 bean.setORDER_DATE (rs.getString("order_date"));
		 			 bean.setMEMBER_CODE(rs.getInt("member_code"));
		 			 bean.setMEMBER_NAME (rs.getString("member_name"));
		 			 bean.setTEMPORARY_WORKER(rs.getString("temporary"));
		 			 bean.setQUALITY_DATE(rs.getString("CHECK_DATE"));
		 			 vlist.addElement(bean);
		          }
			} 
			catch (Exception e) {
				e.printStackTrace();
			} 
			finally {
				pool.freeConnection(con, pstmt, rs);
			}
			
			return vlist;
		}
		
		// 총 게시물수
		public int getTotalCount(String keyField, String keyWord, String before, String after) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if (keyField.equals("temporary") && (keyWord.equals("null")||keyWord.equals("")||keyWord.equals("선택"))) {
					sql = "select count(rownum) from qualitytable where member_name is null and TO_CHAR(ORDER_DATE,'YYYY-MM-DD') between ? and ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, before);
					pstmt.setString(2, after);
				}
				else if (keyWord.equals("null") || keyWord.equals("")) {
					sql = "select count(rownum) from qualitytable where TO_CHAR(ORDER_DATE,'YYYY-MM-DD') between ? and ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, before);
					pstmt.setString(2, after);
				} 				
				else {
					sql = "select count(rownum) from qualitytable where " + keyField + " like ? and TO_CHAR(ORDER_DATE,'YYYY-MM-DD') between ? and ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
					pstmt.setString(2, before);
					pstmt.setString(3, after);
				}
				rs = pstmt.executeQuery();
				if (rs.next()) {
					totalCount = rs.getInt(1);
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			} 
			finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
		// 임시작업자 이름 찾기
		public String findmember(int tnum) {
			Connection con = null;
			PreparedStatement pstmt1 = null;	
			ResultSet rs1 = null;
			String sql1 = null;
			String tname = null;
				try {
					con = pool.getConnection();
					sql1 = "select member_name from member_info where member_code = ?";
					pstmt1 = con.prepareStatement(sql1);
					pstmt1.setInt(1, tnum);
					rs1 = pstmt1.executeQuery();
					if (rs1.next()) {
						tname = rs1.getString("member_name");
					}
				} 
				catch (Exception e) {
					e.printStackTrace();
				} 
				finally {
					if(rs1!=null)   try{rs1.close();}  catch(SQLException e){}
					if(pstmt1!=null) try{pstmt1.close();}catch(SQLException e){}
			
					
				    if(con!=null) try{con.close();}catch(SQLException e){}
				}
				return tname;
		}
		// 작업자 확인
		public boolean checkmember(String quality_code, String employee) {
			Connection con = null;
			PreparedStatement pstmt1 = null;
			PreparedStatement pstmt2 = null;
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			String sql1 = null;
			String sql2 = null;
				try {
					con = pool.getConnection();
					sql1 = "select member_code from member_info where member_name = ?";
					pstmt1 = con.prepareStatement(sql1);
					pstmt1.setString(1, employee);
					rs1 = pstmt1.executeQuery();
					int ref1 = 0;
					if (rs1.next()) {
						ref1 = rs1.getInt("member_code");
					}
					sql2 = "select member_code from temporary_worker where quality_code = ?";				
					pstmt2 = con.prepareStatement(sql2);
					pstmt2.setString(1, quality_code);
					rs2 = pstmt2.executeQuery();
					int ref2 = 0;
					if (rs2.next()) {
						ref2 = rs2.getInt("member_code");
					}
					if (ref1 == ref2){
						return true;
					}else {return false;}
				} 
				catch (Exception e) {
					e.printStackTrace();
				} 
				finally {
					if(rs1!=null)   try{rs1.close();}  catch(SQLException e){}
					if(pstmt1!=null) try{pstmt1.close();}catch(SQLException e){}
					if(rs2!=null)   try{rs2.close();}  catch(SQLException e){}
					if(pstmt2!=null) try{pstmt2.close();}catch(SQLException e){}
				    if(con!=null) try{con.close();}catch(SQLException e){}
				}
				return true;
		}
		
		
		// 작업자 지정
		public void updatemember(String quality_code, String employee) {
			Connection con = null;
			PreparedStatement pstmt1 = null;
			PreparedStatement pstmt2 = null;
			ResultSet rs = null;
			String sql1 = null;
			String sql2 = null;
				try {
					con = pool.getConnection();
					sql1 = "select member_code from member_info where member_name = ?";
					pstmt1 = con.prepareStatement(sql1);
					pstmt1.setString(1, employee);
					rs = pstmt1.executeQuery();
					int ref = 0;
					if (rs.next()) {
						ref = rs.getInt("member_code");
					}
					sql2 = "update temporary_worker set member_name = ?, member_code = "+ ref +" where quality_code = ?";				
					pstmt2 = con.prepareStatement(sql2);
					pstmt2.setString(1, employee);
					pstmt2.setString(2, quality_code);
					pstmt2.executeUpdate();	
				} 
				catch (Exception e) {
					e.printStackTrace();
				} 
				finally {
					if(rs!=null)   try{rs.close();}  catch(SQLException e){}
					if(pstmt1!=null) try{pstmt1.close();}catch(SQLException e){}
					if(pstmt2!=null) try{pstmt2.close();}catch(SQLException e){}
				    if(con!=null) try{con.close();}catch(SQLException e){}   
				}
		}
		
		// 게시물 수정
		public void updateBoard(QualityBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update process_info set error_code = ? where process_code = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getERROR_CODE());
				pstmt.setString(2, bean.getQUALITY_CODE());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		// 게시물 리턴
		public QualityBean getBoard(String num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			QualityBean bean = new QualityBean();
			try {
				con = pool.getConnection();
				sql = "select * from qualitytable where quality_code=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean.setQUALITY_CODE (rs.getString("quality_code"));
					bean.setORDER_CODE (rs.getString("order_code"));
		 			bean.setPRODUCT_CODE (rs.getInt("PRODUCT_CODE"));
		 			bean.setERROR_CODE (rs.getString("ERROR_CODE"));
		 			bean.setERROR_NAME (rs.getString("ERROR_NAME"));
		 			bean.setCHECK_INFO (rs.getString("CHECK_INFO"));
					bean.setMEMBER_CODE (rs.getInt("MEMBER_CODE"));
		 			bean.setORDER_DATE (rs.getString("order_date"));
		 			bean.setMEMBER_NAME (rs.getString("member_name"));			
		 			bean.setQUALITY_DATE (rs.getString("check_date"));
					bean.setPRODUCT_NAME (rs.getString("product_name"));
		 			bean.setMEMBER_LEVEL (rs.getString("MEMBER_LEVEL"));
		 			bean.setPASSWORD (rs.getString("PASSWORD"));
		 			bean.setREGDATE (rs.getString("REGDATE"));
		 			bean.setPRODUCT_INFO (rs.getString("PRODUCT_INFO"));
		 			bean.setORDER_COUNT (rs.getInt("ORDER_COUNT"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		// 게시물 저장
		public void registBoard(String content, String qcode, int worker, String error) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update quality_info set check_date = sysdate, check_info = ?, member_code = ?, error_code = ? where quality_code = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, content);
				pstmt.setInt(2, worker);
				pstmt.setString(3, error);
				pstmt.setString(4, qcode);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
				// 아이디로 비밀번호 불러오기
				public String findPwd(int member_code) {
					Connection con = null;
					PreparedStatement pstmt = null;	
					ResultSet rs = null;	
					String sql = null;	
					String pwd = null;
						try {
							con = pool.getConnection();
							sql = "select password from member_info where member_code = ?";
							pstmt = con.prepareStatement(sql);
							pstmt.setInt(1, member_code);
							rs = pstmt.executeQuery();
							if (rs.next()) {
								pwd = rs.getString("password");
							}
						} 
						catch (Exception e) {
							e.printStackTrace();
						} 
						finally {
							pool.freeConnection(con, pstmt, rs);
						}
						return pwd;
				}
				// 게시물 삭제
				public void deleteBoard(String qcode) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					ResultSet rs = null;
					try {
						con = pool.getConnection();
						sql = "delete from quality_info where quality_code=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, qcode);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
				}
}