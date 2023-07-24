<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="plans.PlanDao" %>
<%@ page import="plans.PlanVO" %>
<%@ page import="java.util.List" %>
<%
		PlanDao planDao = new PlanDao();
       	List<PlanVO> planList = planDao.getPlanlist();

    	String tPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container">
    <h1>조회</h1>
    <table class="table table-bordered">
      <thead>
        <tr>
          <th>색상</th>
          <th>사이즈</th>
          <th></th>
          <th>기계번호</th>
        </tr>
      </thead>
      <tbody>
      	<% for (PlanVO plan : planList) { %>
        <tr>
          <td><%= plan.getColor()%></td>
          <td><%= plan.getSize()%></td>
          <td><%= plan.getLen()%></td>
          <td><%= plan.getNum()%></td>
        </tr>
        <% } %>
      </tbody>
    </table>
    <div class="btn-group">
      <a href="<%=tPath%>/index.jsp" class="btn btn-primary" target="_top">뒤로 가기</a>
    </div>
  </div>
</body>
</html>
