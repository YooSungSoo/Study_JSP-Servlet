<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<%@ page import="com.DeleteCourseServlet" %>
<%@ page import="java.io.*" %>

<%
    String courseSeq = request.getParameter("courseSeq");

    try {
        DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
        Connection conn = dbMgr.getConnection();
        Statement stmt = conn.createStatement();

        String deleteQuery = "DELETE FROM course_registration WHERE course_seq = ?";
        PreparedStatement deletePstmt = conn.prepareStatement(deleteQuery);
        deletePstmt.setString(1, courseSeq);
        int deleteRowsAffected = deletePstmt.executeUpdate();

        if (deleteRowsAffected > 0) {
            out.println("������ �Ϸ�Ǿ����ϴ�. 3���� �̵��մϴ�.");
        } else {
            out.println("���� �� ������ �߻��߽��ϴ�.");
        }

        deletePstmt.close();
        stmt.close();
        dbMgr.freeConnection(conn);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("������ �߻��߽��ϴ�.");
    }
%>

<script>
    setTimeout(function() {
        location.href = "studentIndex.jsp"; 
    }, 3000); // 3�� �Ŀ� �̵�
</script>
