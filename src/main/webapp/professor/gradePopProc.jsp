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
        <h1>�����ο� ���</h1>
        <%
        // ���� �����͸� ���޹���
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

            // ���� �����͸� course_registration ���̺� ������Ʈ
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

            out.println("���� �ο��� �Ϸ�Ǿ����ϴ�.");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("���� �ο� �� ������ �߻��߽��ϴ�.");
        }
        %>
        <br>
        <a href="javascript:window.close();">â �ݱ�</a>
    </div>
</body>
</html>
