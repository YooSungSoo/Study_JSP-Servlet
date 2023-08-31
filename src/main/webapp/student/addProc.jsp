<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<%@ page import="com.DeleteCourseServlet" %>
<%@ page import="java.io.*" %>

<%
    String courseSeq = request.getParameter("courseSeq");
    String studentID = (String) session.getAttribute("user_id");

    try {
        DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
        Connection conn = dbMgr.getConnection();
        Statement stmt = conn.createStatement();

        String query = "INSERT INTO course_registration (course_seq, major_seq, professor_seq, student_seq) SELECT c.course_seq, c.major_seq, c.professor_seq, s.student_seq FROM course c, student s WHERE c.course_seq = ? AND s.student_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, courseSeq);
        pstmt.setString(2, studentID);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("신청이 완료되었습니다. 3초 후에 이동합니다.");
        } else {
            out.println("신청 중 오류가 발생했습니다.");
        }

        pstmt.close();
        stmt.close();
        dbMgr.freeConnection(conn);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("이미 신청한 과목입니다. 3초 후에 이동합니다.");
    }
%>

<script>
    setTimeout(function() {
        location.href = "studentIndex.jsp"; 
    }, 3000); // 3초 후에 이동
</script>
