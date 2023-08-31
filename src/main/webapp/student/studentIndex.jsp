<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnectionMgr" %>
<%@ page import="com.DeleteCourseServlet" %>
<html>
<head>
<script>

function filterCourses(majorSeq) {
    var table = document.getElementById("courseTable");
    
    for (var i = 1; i < table.rows.length; i++) {
        var row = table.rows[i];
        var majorCell = row.cells[2];
        var professorCell = row.cells[1];

        if (majorSeq === "all" || majorCell.innerText.trim() === majorSeq) {
            row.style.display = "table-row";
        } else {
            row.style.display = "none";
        }
    }
}
</script>
</head>
<body>
	<div align="center">
		<h1>수강신청</h1>
		 <table width="1000">
		 	<td align="right">로그인한 학생 : <%
                try {
                    
                    String studentID = (String) session.getAttribute("user_id");
 
                   
                    DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
                    Connection conn = dbMgr.getConnection();
                    Statement stmt = conn.createStatement();

                   
                    String query = "SELECT student_name FROM student WHERE student_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, studentID);
                    ResultSet rs = pstmt.executeQuery();

                    
                    String studentName = "";
                    if (rs.next()) {
                    	studentName = rs.getString("student_name");
                    }

                    rs.close();
                    pstmt.close();
                    stmt.close();
                    dbMgr.freeConnection(conn);
 
                    out.print(studentName);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %></td>
                </table>
<div align="center">
    <h3>신청내역</h3>
    <table style="text-align:center" border="1" width="1000" cellpadding="10" style="margin-left: auto; margin-right: auto;">
        <tr>
            <td>과목명</td>
            <td>교수명</td>
            <td>개설학과</td>
            <td>학점</td>
            <td>정원</td>
            <td>과목코드</td>
            <td>삭제</td>
        </tr>
        <%
        try {
            DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
            Connection conn = dbMgr.getConnection();
            String studentID = (String) session.getAttribute("user_id");
            PreparedStatement pstmt = conn.prepareStatement("SELECT s.subject_name, p.professor_name, m.major_name, c.course_credit, c.course_capacity, c.course_seq FROM course_registration cr INNER JOIN course c ON cr.course_seq = c.course_seq INNER JOIN subject s ON c.subject_seq = s.subject_seq INNER JOIN professor p ON c.professor_seq = p.professor_seq INNER JOIN major m ON c.major_seq = m.major_seq WHERE cr.student_seq = (SELECT student_seq FROM student WHERE student_id = ?)");
            pstmt.setString(1, studentID);
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
    <form method="post" action="deleteCourseProc.jsp">
        <input type="submit" name="del_course" value="삭제">
        <input type="hidden" name="courseSeq" value="<%= courseSeq %>">
    </form>
</td>

        </tr>
        <%
            }
            rs.close();
            pstmt.close();
            dbMgr.freeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </table>
</div>
		    <div align="center">
        <h3>과목조회</h3>
        <div>
        <table width="1000" cellpadding="10" style="margin-left: auto; margin-right: auto;">
            <td colspan="7">개설학과 선택 : 
                <select id="majorSelect" onchange="filterCourses(this.value)">
                    <option value="all">전체</option>
                    <option value="기계공학">기계공학</option>
                    <option value="소프트웨어학">소프트웨어학</option>
                    <option value="경영학">경영학</option>
                    <option value="전자공학">전자공학</option>
                    <option value="사회학">사회학</option>
                    <option value="의학">의학</option>
                    <option value="간호학">간호학</option>
                    <option value="수의학">수의학</option>
                </select>
                </td>
        </table>
<table id="courseTable" style="text-align:center" border="1" width="1000" cellpadding="10" style="margin-left: auto; margin-right: auto;">
    <tr>
        <td width="200">과목명</td>
        <td width="150">교수명</td>
        <td width="150">개설학과</td>
        <td width="150">학점</td>
        <td width="150">정원</td>
        <td width="150">과목코드</td>
        <td width="50">신청</td>
    </tr>
        </tr>
        <%
        int itemsPerPage = 50; 
        int currentPage = 1;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
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
    <form method="post" action="addProc.jsp">
        <input type="submit" name="add_course" value="신청">
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
        <br><br>
     </div>
</body>
</html>