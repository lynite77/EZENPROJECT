<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String tPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>menu</title>
	<link href="../CSS/menu-styles.css" rel="stylesheet" />
</head>
<body>
	<table>
		<tr>         
			<td onClick="location.href='<%=tPath%>/member/memberProc2.jsp'" style="cursor:pointer;">
				<img src="images/account.png" border="0" width="300px" height="300px">
			</td>
			<td onClick="location.href='<%=tPath%>/plans/planOrder.jsp'" style="cursor:pointer;">
				<img src="images/masterdata.png" border="0" width="300px" height="300px">
			</td>
		</tr>
		<tr>
			<td target="content" onClick="location.href='<%=tPath%>/QC/list.jsp'" style="cursor:pointer;">
				<img src="images/operations management.png" border="0" width="300px" height="300px">
			</td>
			<td onClick="openNewWindow()" style="cursor:pointer;">
				<img src="images/downdata.png" border="0" width="300px" height="300px">
			</td>
		</tr>
	</table>
	<script>
        function openNewWindow() {
            var newWindow = window.open("<%=tPath%>/datalog/data-scv.jsp", "_blank", "width=500,height=700");
        }
    </script>
</body>
</html>
