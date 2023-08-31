<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<%
    request.setCharacterEncoding("EUC-KR");
%>
<html>
<head>
<title>과목 삭제 결과</title>
<script>

    function redirectToStaffIndex() {
        setTimeout(function() {
            location.href = 'staffIndex.jsp';
        }, 3000); 
    }

    window.onload = redirectToStaffIndex;
</script>
</head>
<body>
    <div align="center">
        <h2>과목 삭제 결과</h2>
        <%
            String courseSeq = request.getParameter("courseSeq");
            
            try {
                DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
                Connection conn = dbMgr.getConnection();
                Statement stmt = conn.createStatement();

                String query = "DELETE FROM course WHERE course_seq='" + courseSeq + "'";
                int rowsAffected = stmt.executeUpdate(query);

                stmt.close();
                dbMgr.freeConnection(conn);

                if (rowsAffected > 0) {
                    out.println("과목이 성공적으로 삭제되었습니다. 3초 후 이동합니다");
                } else {
                    out.println("과목 삭제 중 오류가 발생했습니다.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("과목 삭제 중 오류가 발생했습니다.");
            }
        %>
    </div>
</body>
</html>
