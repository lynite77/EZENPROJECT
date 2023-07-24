<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String tPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menu</title>
</head>
<style>
	body {
		min-height: 400px;
	}
	table {	
		line-height: center;
		text-align: center;
		width: 100%;
		border-collapse: collapse;
	}
	tr, td {
		border: 1px solid #FFFFFF;
	}
	td {
		height: 400px;
	}
</style>
<body>
	<table bgcolor="#232325">
		<tr>         
			<td onClick="location.href='<%=tPath%>/member/memberProc2.jsp'" style="cursor:pointer;">
				<img src="images/account.png" border="0" width="300px" height="300px">
			</td>
			<td onClick="location.href='<%=tPath%>/주소'" style="cursor:pointer;">
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
			var newWindow = window.open("", "_blank", "width=400,height=300");
			newWindow.document.write('<!DOCTYPE html><html><head><title>Select an option</title></head><body>');
			newWindow.document.write('<h1>데이터 관리</h1>');
			newWindow.document.write('<ul>');
			newWindow.document.write('<li><a href="<%=tPath%>/datalog/download_csv.jsp">에러데이터 다운</a></li>');
			newWindow.document.write('<li><a href="<%=tPath%>/datalog/download_csv2.jsp">양품데이터 다운</a></li>');
			newWindow.document.write('<li><a href="<%=tPath%>/datalog/add_data.jsp">에러데이터 추가</a></li>');
			newWindow.document.write('<li><a href="<%=tPath%>/datalog/add_data2.jsp">양품데이터 추가</a></li>');
			newWindow.document.write('</ul>');
			newWindow.document.write('</body></html>');
			newWindow.document.close();
		}
	</script>
</body>
</html>
