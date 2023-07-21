package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.Vector;

import member.MemberBean;
import member.DBConnectionMgr;

public class MemberMgr {
    // MemberMgr.java	

    private DBConnectionMgr pool;

    public MemberMgr() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ID 중복확인
    public boolean checkId(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        boolean flag = false;
        try {
            con = pool.getConnection();
            sql = "SELECT id FROM memuser WHERE id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            flag = rs.next(); // 결과를 바로 반환하여 중복된 ID인 경우 true를 반환
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return flag;
    }

    // CODE 중복확인
    public boolean checkCode(String code) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        boolean flag = false;
        try {
            con = pool.getConnection();
            sql = "SELECT code FROM memuser WHERE code = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, code);
            rs = pstmt.executeQuery();
            flag = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return flag;
    }

    // 회원가입
    public boolean insertMember(MemberBean bean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;
        try {
            con = pool.getConnection();
            if (checkId(bean.getId())) {
                return false;
            }
            if (checkCode(bean.getCode())) {
                return false;
            }

            // 중복되지 않은 ID인 경우, 회원 가입 처리
            sql = "insert into memuser (ID,PWD,NAME,RRN,TEL,EMAIL,CODE) values (?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, bean.getId());
            pstmt.setString(2, bean.getPwd());
            pstmt.setString(3, bean.getName());
            pstmt.setString(4, bean.getRrn1() + "-" + bean.getRrn2());
            pstmt.setString(5, bean.getTel1() + "-" + bean.getTel2() + "-" + bean.getTel3());
            pstmt.setString(6, bean.getEmail());
            pstmt.setString(7, bean.getCode());
            if (pstmt.executeUpdate() == 1)
                flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return flag;
    }

    // 로그인
    public String loginMember(String id, String pwd) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        String role = null;

        try {
            con = pool.getConnection();
            sql = "SELECT role FROM memuser WHERE id = ? AND pwd = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return role;
    }

    // 회원정보가져오기
    public MemberBean getMember(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberBean bean = null;
        try {
            con = pool.getConnection();
            String sql = "select * from memuser where id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                bean = new MemberBean();
                bean.setId(rs.getString("id"));
                bean.setPwd(rs.getString("pwd"));
                bean.setName(rs.getString("name"));
                bean.setRrn1(rs.getString("rrn"));
                bean.setTel3(rs.getString("tel"));
                bean.setEmail(rs.getString("email"));
                bean.setCode(rs.getString("code"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con);
        }
        return bean;
    }

    // 회원정보수정
    public boolean updateMember(MemberBean bean) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try {
            con = pool.getConnection();
            String sql = "update memuser set pwd=?, tel=?, email=?, code=? where id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, bean.getPwd());
            pstmt.setString(2, bean.getTel1() + "-" + bean.getTel2() + "-" + bean.getTel3());
            pstmt.setString(3, bean.getEmail());
            pstmt.setString(4, bean.getCode());
            pstmt.setString(5, bean.getId());
            int count = pstmt.executeUpdate();
            if (count > 0)
                flag = true;
        } catch (Exception e) {
            throw new Exception("회원 정보 수정 중 오류가 발생했습니다.", e);
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return flag;
    }

    // 권한 조회
    public String getRole(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String role = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT role FROM memuser WHERE id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return role;
    }

    // 접근 권한 확인
    public boolean checkAccessPermission(String id, String requiredRole) {
        String role = getRole(id);
        return role != null && role.equals(requiredRole);
    }
    
    // 권한 부여
    public boolean grantPermission(String targetId, String permission) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean success = false;

        try {
            con = pool.getConnection();
            String role = getRole(targetId);
            if (role != null && role.equals("admin")) {
                // admin 권한을 가진 계정만 권한을 부여할 수 있도록 함
                sql = "UPDATE memuser SET role = ? WHERE id = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, permission);
                pstmt.setString(2, targetId);
                int count = pstmt.executeUpdate();
                success = count > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }

        return success;
    }
    
 // 권한 변경
    public boolean changePermission(String targetUsername, String newPermission) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            con = pool.getConnection();
            
            // 현재 사용자의 권한 가져오기
            String role = getRole(targetUsername);
            
            // 권한 변경 로직
            if (role != null) {
                // 현재 사용자의 권한과 변경할 권한이 다를 경우에만 권한 변경
                if (!role.equals(newPermission)) {
                    String sql = "UPDATE memuser SET role = ? WHERE id = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, newPermission);
                    pstmt.setString(2, targetUsername);
                    int rowsUpdated = pstmt.executeUpdate();
                    
                    if (rowsUpdated > 0) {
                        success = true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }
    
 // 회원 목록 조회
    public Vector<MemberBean> getAllMembers() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector<MemberBean> memberList = new Vector<MemberBean>();

        try {
            con = pool.getConnection();
            String sql = "SELECT id, name, email, role FROM memuser";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                MemberBean bean = new MemberBean();
                bean.setId(rs.getString("id"));
                bean.setName(rs.getString("name"));
                bean.setEmail(rs.getString("email"));
                bean.setRole(rs.getString("role"));
                memberList.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return memberList;
    }
    
    // 회원탈퇴
    public boolean deleteMember(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            con = pool.getConnection();
            String sql = "DELETE FROM memuser WHERE id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }

        return success;
    }
}