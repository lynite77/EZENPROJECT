<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bean.Gproduct" %>
<%@ page import="Spring.monitoringDAO" %>
<%@ page import="java.util.List" %>
<%
    	monitoringDAO GproductDAO = new monitoringDAO();
       	List<Gproduct> products = GproductDAO.getAllGProducts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>제품 등록 확인</title>
	<link href="../CSS/styles.css" rel="stylesheet" />
	<link href="../CSS/bootstyles.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container400">
        <div class="grid1"><h2 class="c1">제품 등록 확인</h2></div>
        <div class="form-group">
            <label for="productCode">제품 코드:</label>
            <input type="text" id="productCode">
        </div>
        <div class="form-group">
            <button onclick="getProduct()">조회</button>
        </div>
    </div>
	<div class="card-body">
		<table id="datatablesSimple">
			<thead>
                  <tr>
                      <th>제품코드</th>
                      <th>제품명</th>
                      <th>제품색상</th>
                      <th>제품사이즈</th>
                      <th>제품길이</th>
                      <th>제품가격</th>
                      <th>제품정보</th>
                  </tr>
              </thead>
              <tfoot>
                  <tr>
                      <th>제품코드</th>
                      <th>제품명</th>
                      <th>제품색상</th>
                      <th>제품사이즈</th>
                      <th>제품길이</th>
                      <th>제품가격</th>
                      <th>제품정보</th>
                  </tr>
              </tfoot>
              <tbody>
              	<% for (Gproduct gproduct : products) { %>
					<tr>
					    <td><%= gproduct.getProductCode() %></td>
					    <td><%= gproduct.getProductName() %></td>
					    <td><%= gproduct.getProductColor()%></td>
						<td><%= gproduct.getProductSize()%></td>
						<td><%= gproduct.getProductLength()%></td>
						<td><span class="badge badge-success w-75 py-2"><%= gproduct.getProductPrice()%></span></td>
						<%
							// getProductInfo() 값에 따라 badge 스타일을 지정합니다.
							String productInfo = gproduct.getProductInfo();
							String badgeStyle = "badge-success";
							if ("라운드넥".equals(productInfo)) {
								badgeStyle = "badge-danger";
							}
						%>
						<td><span class="badge <%= badgeStyle %> w-75 py-2"><%= productInfo %></span></td>
					</tr>
					<% 
					}
					%>
              </tbody>
          </table>
      </div>
    <script src="../js/datatables.js"></script>
</body>
</html>
