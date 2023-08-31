<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<%
    request.setCharacterEncoding("EUC-KR");
%>
<html>
<head>
<title>���� ���� ���</title>
<script>
    // ���� �ð� �Ŀ� staffIndex.jsp�� �����̷�Ʈ�ϴ� �Լ�
    function redirectToStaffIndex() {
        setTimeout(function() {
            location.href = 'staffIndex.jsp';
        }, 3000); // 3�� �Ŀ� �����̷�Ʈ
    }

    // ������ �ε�� �����̷�Ʈ �Լ� ȣ��
    window.onload = redirectToStaffIndex;
</script>
</head>
<body>
    <div align="center">
        <h2>���� ���� ���</h2>
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
                    out.println("������ ���������� �����Ǿ����ϴ�. 3�� �� �̵��մϴ�");
                } else {
                    out.println("���� ���� �� ������ �߻��߽��ϴ�.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("���� ���� �� ������ �߻��߽��ϴ�.");
            }
        %>
    </div>
</body>
</html>
