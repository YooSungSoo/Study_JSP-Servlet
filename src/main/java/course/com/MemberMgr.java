package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberMgr {
    private DBConnectionMgr pool;

    public MemberMgr() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean loginMember(String user_id, String user_pw, String chk_info) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        boolean flag = false;
        try {
            con = pool.getConnection();

            if (chk_info.equals("Student")) {
                sql = "SELECT student_id FROM student WHERE student_id = ? AND student_pw = ?";
            } else if (chk_info.equals("Professor")) {
                sql = "SELECT professor_id FROM professor WHERE professor_id = ? AND professor_pw = ?";
            } else if (chk_info.equals("Staff")) {
                sql = "SELECT staff_id FROM staff WHERE staff_id = ? AND staff_pw = ?";
            }

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user_id);
            pstmt.setString(2, user_pw);
            rs = pstmt.executeQuery();
            flag = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return flag;
    }
}
