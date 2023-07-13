<%@ page contentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello Form</title>
</head>
<body>
	<h1>로그인 정보 등록</h1>
	<form method="POST" action="login.post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email"></td>
			</tr>						
			<tr>
				<td><input type="submit" value="전송"></td>
				<td><input type="reset" value="리셋"></td>
			</tr>						
		</table>
	</form>

</body>
</html>