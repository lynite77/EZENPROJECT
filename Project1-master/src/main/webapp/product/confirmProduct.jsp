<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>제품등록 확인 페이지</title>
	<link href="../CSS/pstyles.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <h1 class="grid1">제품등록 확인 페이지</h1>

		<table>
			<tr>
				<td>제품코드</td>
				<td>${product.productCode}</td>
			</tr>
			<tr>
				<td>제품명</td>
				<td>${product.productName}</td>
			</tr>
			<tr>
				<td>관리자</td>
				<td>${product.productManager}</td>
			</tr>
		</table>
        
        <a href="update?code=${product.productCode}">제품 수정</a>
    </div>
</body>
</html>
