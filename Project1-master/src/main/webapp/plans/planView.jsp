<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="plans.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container">
    <h1>작업지시목록</h1>
    <table class="table table-bordered">
      <thead>
        <tr>
          <th>지시번호</th>
          <th>품명</th>
          <!-- <th>작업자</th> -->
          <th>수량</th>
          <th>지시사항</th>
          <th>지시일</th>
        </tr>
      </thead>
      <tbody>
      	<c:forEach var="plan" items="${olist}" varStatus="idx">
        <tr>
          <td>${plan.orderCode}</td>
          <td>${plan.productName}</td>
          <%-- <td>${plan.memberName}</td> --%>
          <td>${plan.orderCount}</td>
          <td>${plan.orderInfo}</td>
          <td>${plan.orderDate}</td>
        </tr>
        </c:forEach>
      </tbody>
    </table>
    <div class="btn-group">
      <a href="planOrder.do" class="btn btn-primary">작업지시등록</a>
    </div>
  </div>
</body>
</html>