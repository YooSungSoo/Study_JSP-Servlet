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
            out.println("��û�� �Ϸ�Ǿ����ϴ�. 3�� �Ŀ� �̵��մϴ�.");
        } else {
            out.println("��û �� ������ �߻��߽��ϴ�.");
        }

        pstmt.close();
        stmt.close();
        dbMgr.freeConnection(conn);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("�̹� ��û�� �����Դϴ�. 3�� �Ŀ� �̵��մϴ�.");
    }
%>

<script>
    setTimeout(function() {
        location.href = "studentIndex.jsp"; 
    }, 3000); // 3�� �Ŀ� �̵�
</script>
