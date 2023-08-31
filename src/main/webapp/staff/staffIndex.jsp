<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<%@ page import="com.DeleteCourseServlet" %>
<%@ page import="com.MemberMgr" %>
<html>
<head>
<script>
function filterCourses(selectedMajor) {
    var table = document.getElementById("courseTable");
    
    for (var i = 1; i < table.rows.length; i++) {
        var row = table.rows[i];
        var majorCell = row.cells[2]; 

        if (selectedMajor === "all" || majorCell.innerText.trim() === selectedMajor) {
            row.style.display = "table-row";
        } else {
            row.style.display = "none";
        }
    }
}

function showAllCourses() {
    var table = document.getElementById("courseTable");
    for (var i = 1; i < table.rows.length; i++) {
        table.rows[i].style.display = "table-row";
    }
}
</script>
</head>
<body>
    <div align="center">
        <h1>������ �� ����</h1>
        <table width="1000" cellpadding="10" style="margin-left: auto; margin-right: auto;">
            <td colspan="7">�����а� ���� : 
                <select id="majorSelect" onchange="filterCourses(this.value)">
                    <option value="all">��ü</option>
                    <option value="������">������</option>
                    <option value="����Ʈ������">����Ʈ������</option>
                    <option value="�濵��">�濵��</option>
                    <option value="���ڰ���">���ڰ���</option>
                    <option value="��ȸ��">��ȸ��</option>
                    <option value="����">����</option>
                    <option value="��ȣ��">��ȣ��</option>
                    <option value="������">������</option>
                </select>
                </td>
              <td align="right"><p>�α����� ���� : 
                <%
                try {
                    
                    String staffId = (String) session.getAttribute("user_id");
 
                   
                    DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
                    Connection conn = dbMgr.getConnection();
                    Statement stmt = conn.createStatement();

                   
                    String query = "SELECT staff_name FROM staff WHERE staff_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, staffId);
                    ResultSet rs = pstmt.executeQuery();

                    
                    String staffName = "";
                    if (rs.next()) {
                        staffName = rs.getString("staff_name");
                    }

                    rs.close();
                    pstmt.close();
                    stmt.close();
                    dbMgr.freeConnection(conn);

                    // staff_name ���
                    out.print(staffName);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %></p></td>  
        </table>
<table id="courseTable" style="text-align:center" border="1" width="1000" cellpadding="10" style="margin-left: auto; margin-right: auto;">
    <tr>
        <td width="200">�����</td>
        <td width="150">������</td>
        <td width="150">�����а�</td>
        <td width="150">����</td>
        <td width="150">����</td>
        <td width="150">�����ڵ�</td>
        <td width="50">����</td>
    </tr>
        </tr>
        <%
        int itemsPerPage = 10; 
        int currentPage = 1;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                // ���� ó��
            }
        }

        try {
            DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
            Connection conn = dbMgr.getConnection();
            Statement stmt = conn.createStatement();

            int startItem = (currentPage - 1) * itemsPerPage;
            String query = "SELECT c.course_seq, c.course_credit, c.course_capacity, c.major_seq, c.professor_seq, s.subject_name, p.professor_name, m.major_name FROM course c JOIN subject s ON c.subject_seq = s.subject_seq JOIN professor p ON c.professor_seq = p.professor_seq JOIN major m ON c.major_seq = m.major_seq LIMIT ?, ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, startItem);
            pstmt.setInt(2, itemsPerPage);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String subjectName = rs.getString("subject_name");
                String professorName = rs.getString("professor_name");
                String majorName = rs.getString("major_name");
                String courseCredit = rs.getString("course_credit");
                String courseCapacity = rs.getString("course_capacity");
                String courseSeq = rs.getString("course_seq");
        %>
        <tr>
            <td><%= subjectName %></td>
            <td><%= professorName %></td>
            <td><%= majorName %></td>
            <td><%= courseCredit %></td>
            <td><%= courseCapacity %></td>
            <td><%= courseSeq %></td>
            <td>
                <form method="post" action="deleteProc.jsp">
                    <input type="submit" name="del_course" value="����">
                    <input type="hidden" name="courseSeq" value="<%= courseSeq %>">
                </form>
            </td>
        </tr>
        <%
            }
            rs.close();
            pstmt.close();
            stmt.close();
            dbMgr.freeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </table>

    <table style="text-align:center" width="1000" cellpadding="10" style="margin-left: auto; margin-right: auto;">
        <tr>
            <td align="center">
                <%
                int totalItemCount = 50;
                int totalPages = (int) Math.ceil(totalItemCount / (double) itemsPerPage);
                for (int i = 1; i <= totalPages; i++) {
                    if (i == currentPage) {
                        out.print(i + " ");
                    } else {
                        out.print("<a href='?page=" + i + "'>" + i + "</a> ");
                    }
                }
                %>
            </td><td align="right" width="10">
                <input type="button" name="add_course" value="�߰�" onClick="location.href='regist.jsp'">
            </td>
        </tr>
    </table>
    <br>
</div>
</body>
</html>