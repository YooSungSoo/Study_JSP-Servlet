<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>로그인</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
    function loginCheck() {
        if (document.loginFrm.id.value === "") {
            alert("아이디를 입력해 주세요.");
            document.loginFrm.id.focus();
            return;
        }
        if (document.loginFrm.pw.value === "") {
            alert("비밀번호를 입력해 주세요."); 
            
            
            document.loginFrm.pw.focus();
            return;
        }
        if (document.loginFrm.chk_info.value === "") {
            alert("신분을 체크해 주세요.");
            document.loginFrm.chk_info.focus();
            return;
        }
        document.loginFrm.submit();
    }
</script>
</head>
<body>
<div align="center"><br/><br/>
    <form name="loginFrm" method="post" action="loginProc.jsp">
        <table>
            <tr>
                <td align="center" colspan="2"><h4>LS UNIV. Course Registration</h4></td>
            </tr>
            <tr>
                <td>ID</td>
                <td><input name="id"></td>
            </tr> 
            <tr>
                <td>PW</td>
                <td><input type="password" name="pw"></td>
            </tr>
            <tr>
                <td colspan="2"> 
                    <input type="radio" name="chk_info" value="Student">학생
                    <input type="radio" name="chk_info" value="Professor">교수
                    <input type="radio" name="chk_info" value="Staff">직원
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div align="right">
                        <input type="button" value="로그인" onclick="loginCheck()">&nbsp;
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>