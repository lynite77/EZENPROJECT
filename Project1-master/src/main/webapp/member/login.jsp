<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="member.MemberMgr"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	String role = null;
	if (id != null) {
		// 로그인한 경우
		MemberMgr memberMgr = new MemberMgr();
		role = memberMgr.getRole(id);
	}
%>
<html>
<head>
<title>로그인</title>
<link href="../CSS/login-styles.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.id.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.id.focus();
			return;
		}
		if (document.loginFrm.pwd.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.pwd.focus();
			return;
		}
		document.loginFrm.submit();
	}
</script>
<%
		if (id != null) {
			if (role != null && role.equals("admin")) {
				response.sendRedirect("admin.jsp");
			} else if (role != null && role.equals("user")){
				response.sendRedirect("user.jsp");
			} else {
				response.sendRedirect("guest.jsp");
			}
		} else {
%>
</head>
<body bgcolor="">
	<div class="wrapper" align="center">
	<div class="container">
    <h1>Welcome</h1>
		<form class="form" name="loginFrm" method="post" action="loginProc.jsp">
		<input type="text"  name="id" placeholder="Username">
		<input type="password" placeholder="Password" name="pwd">
			<br>
			<div>
				<button id="login-button" type="submit" onclick="loginCheck()">로그인</button>
			</div>
			<div>
				<button id="login-button" type="submit" onClick="javascript:location.href='member.jsp'">회원가입</button>
			</div>
		</form>
		</div>
		<ul class="bg-bubbles">
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
		</ul>
	</div>
			<%
		}
		%>
	<script>
	$("#login-button").click(function(event){
		event.preventDefault();
	
		$('form').fadeOut(500);
		$('.wrapper').addClass('form-success');
	});
	</script>
</body>
</html>
