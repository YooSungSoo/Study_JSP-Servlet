<%@ page contentType="text/html; charset=EUC-KR" %>
<%
	  request.setCharacterEncoding("EUC-KR");
	  String id = (String)session.getAttribute("idKey");
%>
<html>
<head>
<title>과목등록</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loginCheck() {
		if (document.regFrm.major.value == "") {
			alert("Major_seq을 입력해 주세요");
			document.regFrm.major.focus();
			return;
		}
		if (document.regFrm.professor.value == "") {
			alert("Professor_seq을 입력해 주세요");
			document.regFrm.professor.focus();
			return;
		}
		if (document.regFrm.subject.value == "") {
			alert("subject_seq을 입력해 주세요");
			document.regFrm.subject.focus();
			return;
		}
		if (document.regFrm.credit.value == "") {
			alert("Course_credit을 입력해 주세요");
			document.regFrm.credit.focus();
			return;
		}
		if (document.regFrm.capacity.value == "") {
			alert("Course_capacity을 입력해 주세요");
			document.regFrm.capacity.focus();
			return;
		}
		if (document.regFrm.year.value == "") {
			alert("year을 입력해 주세요");
			document.regFrm.year.focus();
			return;
		}
		if (document.regFrm.semester.value == "") {
			alert("semester 입력해 주세요");
			document.regFrm.semester.focus();
			return;
		}
		document.regFrm.submit();
	}
</script>
</head>
<body onLoad="regFrm.id.focus()">

	<div align="center">
		<br /><br />
		<form name="regFrm" method="post" action="registProc.jsp">
			<table cellpadding="5">
				<tr>
					<td>
						<table border="1" cellspacing="0" cellpadding="2" width="600">
							<tr>
								<td colspan="2"><b>과목등록</b></td>
							</tr>
							<tr>
								<td>Major_Seq</td>
								<td><input name="major" size="15">
								</td>
							</tr>
							<tr>
								<td>Professor_Seq</td>
								<td><input name="professor" size="15"></td>
							</tr>
							<tr>
								<td>Subject_Seq</td>
								<td><input name="subject" size="15">
								</td>
							</tr>
							<tr>
								<td>Course_Credit</td>
								<td><input name="credit" size="15">
								</td>
							</tr>
							<tr>
								<td>Course_Capacity</td>
								<td><input name="capacity" size="15">
								</td>
							</tr>
														<tr>
								<td>Year</td>
								<td><input name="year" size="15">
								</td>
							</tr>
														<tr>
								<td>Semester</td>
								<td><input name="semester" size="15">
								</td>
							</tr>
						</table>
						<table>
							<tr>
								<td colspan="2" align="center">
								  <input type="button" value="과목등록" onclick="loginCheck()">&nbsp;
								  </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>