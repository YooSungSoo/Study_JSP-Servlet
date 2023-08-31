<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.MemberMgr" %>

<%
    String user_id = request.getParameter("id");
    String user_pw = request.getParameter("pw");
    String chk_info = request.getParameter("chk_info");

    MemberMgr memberMgr = new MemberMgr();
    boolean loginSuccess = memberMgr.loginMember(user_id, user_pw, chk_info);

    if (loginSuccess) {
        session.setAttribute("loggedIn", true);
        session.setAttribute("user_id", user_id);

        if (chk_info.equals("Student")) {
            response.sendRedirect("student/studentIndex.jsp");
        } else if (chk_info.equals("Professor")) {
            response.sendRedirect("professor/professorIndex.jsp");
        } else if (chk_info.equals("Staff")) {
            response.sendRedirect("staff/staffIndex.jsp");
        }
    } else {
        out.println("<script>alert('아이디 또는 비밀번호가 올바르지 않습니다.'); history.go(-1);</script>");
    }
%>
