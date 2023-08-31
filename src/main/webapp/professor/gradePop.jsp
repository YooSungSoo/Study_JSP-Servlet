<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<html>
<head>
</head>
<body>
    <div align="center">
        <h1>학점부여</h1>
        <form action="gradePopProc.jsp" method="post">
            <table border="1" width="1000" cellpadding="10" style="margin-left: auto; margin-right: auto;">
                <tr>
                    <td>학생명</td>
                    <td>학과</td>
                    <td>학번</td>
                    <td>학점</td>
                </tr>
                <%
                String courseSeq = request.getParameter("courseSeq");

                try {
                    DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
                    Connection conn = dbMgr.getConnection();

                    String query = "SELECT s.student_name, m.major_name, s.student_id FROM course_registration cr JOIN student s ON cr.student_seq = s.student_seq JOIN major m ON s.major_seq = m.major_seq WHERE cr.course_seq = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, courseSeq);
                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String studentName = rs.getString("student_name");
                        String majorName = rs.getString("major_name");
                        String studentId = rs.getString("student_id");
                        %>
                        <tr>
                            <td><%= studentName %></td>
                            <td><%= majorName %></td>
                            <td><%= studentId %></td>
                            <td>
                                <select name="grades_<%= studentId %>">
                                    <option value="0" selected>선택</option>
                                    <option value="4.5">A+</option>
                                    <option value="4">A</option>
                                    <option value="3.5">B+</option>
                                    <option value="3">B</option>
                                    <option value="2.5">C+</option>
                                    <option value="2">C</option>
                                    <option value="1.5">D+</option>
                                    <option value="1">D</option>
                                    <option value="0">F</option>
                                </select>
                            </td>
                        </tr>
                        <%
                    }

                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </table>
            <input type="hidden" name="courseSeq" value="<%= courseSeq %>">
            <input type="submit" value="저장">
        </form>
    </div>
</body>
</html>
