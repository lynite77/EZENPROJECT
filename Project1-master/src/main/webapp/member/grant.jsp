<%@ page import="java.util.List"%>
<%@ page import="member.MemberMgr"%>
<%@ page import="member.MemberBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<style>
form label {
	display: block;
	font-size: 16px;
	margin-bottom: 5px;
}

form input[id="username"], form select {
	width: 76%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

form input[id="permission"], form select {
	width: 80%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

form input[type="submit"]:hover {
	background-color: #cc9900;
}

table {
	width: 80%;
	border-collapse: collapse;
	margin: 20px auto;
	border: 1px solid #ccc;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #996600;
	color: #ffffff;
}
</style>
</head>
<body align="center">
	<%
	// 현재 로그인한 사용자의 권한 가져오기
	String role = (String) session.getAttribute("role");

	// 권한에 따른 페이지 접근 제어
	if (role == null) {
		// 로그인하지 않은 경우, 로그인 페이지로 이동
		response.sendRedirect("login.jsp");
	} else if (role.equals("admin")) {
		// admin 권한의 경우에만 접속 가능
	%>
	<h1>권한 부여</h1>
	<form method="post" action="grant-permission.jsp" class="align-center">

		<label for="username">계정 아이디:</label> <input type="text" id="username"
			name="username" required><br> <label for="permission">새로운
			권한:</label> <select id="permission" name="permission" required>
			<option value="user">일반 사용자</option>
			<option value="guest">게스트</option>
		</select><br> <input type="submit" value="권한 부여"> <input
			type="button" value="뒤로가기" onclick="history.back();">
	</form>

	<h2>회원 목록</h2>
	<table>
		<tr>
			<th>ID</th>
			<th>이름</th>
			<th>Email</th>
			<th>권한</th>
		</tr>
		<%
		// 모든 회원 조회
		List<MemberBean> memberList = new MemberMgr().getAllMembers();
		if (memberList.isEmpty()) {
		%>
		<tr>
			<td colspan="4">회원 목록이 없습니다.</td>
		</tr>
		<%
		} else {
		for (MemberBean member : memberList) {
		%>
		<tr>
			<td><%=member.getId()%></td>
			<td><%=member.getName()%></td>
			<td><%=member.getEmail()%></td>
			<td><%=member.getRole()%></td>
		</tr>
		<%
		}
		}
		%>
	</table>
	<%
	} else {
	// admin 권한이 아닌 경우 접속불가 페이지로 이동
	response.sendRedirect("access-denied.jsp");
	}
	%>
</body>
</html>