<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
</head>
<body>
    <div align="center">
        <h1>학점부여 결과</h1>
        <%
        // 학점 데이터를 전달받음
        String courseSeq = request.getParameter("courseSeq");
        Enumeration<String> paramNames = request.getParameterNames();
        Map<String, String> gradesMap = new HashMap<>();

        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            if (paramName.startsWith("grades_")) {
                String studentId = paramName.substring("grades_".length());
                String grade = request.getParameter(paramName);
                gradesMap.put(studentId, grade);
            }
        }

        try {
            DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
            Connection conn = dbMgr.getConnection();

            // 학점 데이터를 course_registration 테이블에 업데이트
            String updateQuery = "UPDATE course_registration SET course_grade = ? WHERE student_seq = ? AND course_seq = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateQuery);

            for (Map.Entry<String, String> entry : gradesMap.entrySet()) {
                String studentId = entry.getKey();
                String grade = entry.getValue();
                updateStmt.setString(1, grade);
                updateStmt.setString(2, studentId);
                updateStmt.setString(3, courseSeq);
                updateStmt.executeUpdate();
            }

            updateStmt.close();
            dbMgr.freeConnection(conn);

            out.println("학점 부여가 완료되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("학점 부여 중 오류가 발생했습니다.");
        }
        %>
        <br>
        <a href="javascript:window.close();">창 닫기</a>
    </div>
</body>
</html>
