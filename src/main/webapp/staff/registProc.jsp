<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<%
    request.setCharacterEncoding("EUC-KR");
%>
<html>
<head>
<title>과목 등록 결과</title>
<script>
    function redirectToRegist() {
        setTimeout(function() {
            location.href = 'staffIndex.jsp';
        }, 3000);
    }

    window.onload = redirectToRegist;
</script>
</head>
<body>
    <div align="center">
        <h2>과목 등록 결과</h2>
        <%
            String majorSeq = request.getParameter("major");
            String professorSeq = request.getParameter("professor");
            String subjectSeq = request.getParameter("subject");
            String courseCredit = request.getParameter("credit");
            String courseCapacity = request.getParameter("capacity");
            String year = request.getParameter("year");
            String semester = request.getParameter("semester");
            
            try {
                DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
                Connection conn = dbMgr.getConnection();
                Statement stmt = conn.createStatement();

                String query = "INSERT INTO course (major_seq, professor_seq, subject_seq, course_credit, course_capacity, year, semester) " +
                               "VALUES ('" + majorSeq + "', '" + professorSeq + "', '" + subjectSeq + "', '" + courseCredit + "', '" + courseCapacity + "', '" + year + "', '" + semester + "')";
                int rowsAffected = stmt.executeUpdate(query);

                stmt.close();
                dbMgr.freeConnection(conn);

                if (rowsAffected > 0) {
                    out.println("과목이 성공적으로 등록되었습니다. 3초 후 이동합니다");
                } else {
                    out.println("과목 등록 중 오류가 발생했습니다.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("과목 등록 중 오류가 발생했습니다.");
            }
        %>
    </div>
</body>
</html>