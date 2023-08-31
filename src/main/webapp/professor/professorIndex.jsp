<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<html>
<head>
    <script>
        function openGradePopup(courseSeq) {
            var url = "gradePop.jsp?courseSeq=" + courseSeq;
            window.open(url, "GradePopup", "width=600,height=400,resizable=yes");
        }
    </script>
</head>
<body>
    <div align="center">
        <h1>담당과목 조회 및 학점부여</h1>
        <table width="1000">
            <tr>
                <td align="left">담당교수</td>
                <td align="right">
                    <%
                    try {
                        String professorId = (String) session.getAttribute("user_id");

                        DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
                        Connection conn = dbMgr.getConnection();
                        String query = "SELECT professor_name FROM professor WHERE professor_id = ?";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, professorId);
                        ResultSet rs = pstmt.executeQuery();

                        String professorName = "";
                        if (rs.next()) {
                            professorName = rs.getString("professor_name");
                        }

                        rs.close();
                        pstmt.close();
                        conn.close();

                        out.print(professorName);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    %>
                </td>
            </tr>
        </table>
        <table border="1" width="1000" cellpadding="10" style="margin-left: auto; margin-right: auto;">
            <tr>
                <td>과목명</td>
                <td>과목코드</td>
                <td>학점</td>
                <td>정원</td>
                <td>조회</td>
            </tr>
            <%
            String userId = (String) session.getAttribute("user_id");

            if (userId != null) {
                DBConnectionMgr dbMgr = new DBConnectionMgr();
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    conn = dbMgr.getConnection();
                    String query = "SELECT c.course_seq, c.course_credit, c.course_capacity, s.subject_name FROM course c JOIN subject s ON c.subject_seq = s.subject_seq WHERE c.professor_seq = (SELECT professor_seq FROM professor WHERE professor_id = ?)";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, userId);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("subject_name") %></td>
                            <td><%= rs.getString("course_seq") %></td>
                            <td><%= rs.getString("course_credit") %></td>
                            <td><%= rs.getString("course_capacity") %></td>
                            <td>
                                <input type="button" value="조회" onclick="openGradePopup('<%= rs.getString("course_seq") %>')">
                            </td>
                        </tr>
                        <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
            %>
        </table>
    </div>
</body>
</html>
