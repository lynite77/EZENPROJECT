<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = "rorod";
	session.setAttribute("idKey", id);
	String url = "list.jsp?keyField=member_name&keyWord="+id;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<style>
	body{
	padding: 0px;
	margin: 0px;
	}
</style>
<script>
location.href="<%=url%>";
</script>
</head>
<body>
<body bgcolor="#FFFFCC">
	<table>
		<tr>
			<td></td>
		</tr>
	</table>
</body>
</html>