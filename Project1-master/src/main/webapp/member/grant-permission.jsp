<%@ page import="member.MemberMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>권한 부여 확인</title>
<script>
	
</script>
</head>
<body>
	<%
	String targetUsername = request.getParameter("username");
	String newPermission = request.getParameter("permission");

	MemberMgr memberMgr = new MemberMgr();
	boolean success = memberMgr.changePermission(targetUsername, newPermission);
	if (success) {
	%>
	<script>
		// 권한 부여 성공 시 팝업창을 띄우고 관리자 페이지로 돌아갑니다.
		window.onload = function() {
			confirmGrant();
		};
	</script>
	<%
	} else {
	// 권한 부여 실패 시 팝업창을 띄우고 관리자 페이지로 돌아갑니다.
	%>
	<script>
		alert("권한 부여 실패");
		window.location.href = "admin.jsp"; // 관리자 페이지로 돌아갑니다.
	</script>
	<%
	}
	%>
</body>
</html>
