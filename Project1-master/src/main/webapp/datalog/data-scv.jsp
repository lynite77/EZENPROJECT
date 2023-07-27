<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String tPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
	<title>데이터관리</title>
	<link href="../CSS/scv-styles.css" rel="stylesheet" />
</head>
<body>
	<h1>데이터 관리</h1>
	<div class="button-container">
		<div>
			<a href="<%=tPath%>/datalog/download_csv.jsp" class="button close-button">에러데이터 다운</a>
		</div>
		<div>
			<a href="<%=tPath%>/datalog/download_csv2.jsp" class="button close-button">양품데이터 다운</a>
		</div>
		<div>
			<a href="<%=tPath%>/datalog/add_data.jsp" class="button">데이터 낱개추가</a>
		</div>
		<div>
			<a href="<%=tPath%>/datalog/add_data2.jsp" class="button close-button">데이터 일괄추가</a>
		</div>
	</div>
</body>
</html>
