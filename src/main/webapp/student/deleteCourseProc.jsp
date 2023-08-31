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
            out.println("삭제가 완료되었습니다. 3초후 이동합니다.");
        } else {
            out.println("삭제 중 오류가 발생했습니다.");
        }

        deletePstmt.close();
        stmt.close();
        dbMgr.freeConnection(conn);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("오류가 발생했습니다.");
    }
%>

<script>
    setTimeout(function() {
        location.href = "studentIndex.jsp"; 
    }, 3000); // 3초 후에 이동
</script>
