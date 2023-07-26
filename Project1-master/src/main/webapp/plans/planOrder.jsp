﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap JS (Optional) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    #selected-member {
      margin-top: 10px;
    }

    #input-info {
      margin-top: 10px;
    }

    #selected-count {
      margin-top: 10px;
    }

    #selected-product {
      margin-top: 10px;
    }

    
  </style>

  <script>
   /*  function displaySelectedMember(member) {
      document.getElementById('selected-member').innerText = member;
      document.getElementById('selected-member').style.border = "1px solid black";
    } */

    function displayInputInfo(info) {
      document.getElementById('input-info').innerText = info;
      document.getElementById('input-info').style.border = "1px solid black";
    }
    
    function displaySelectedCount(count) {
      document.getElementById('selected-count').innerText = count;
      document.getElementById('selected-count').style.border = "1px solid black";
    }

    function displaySelectedProduct(product) {
      document.getElementById('selected-product').innerText = product;
      document.getElementById('selected-product').style.border = "1px solid black";
    }

    function displaySelectedValues() {
    	var selectedProduct = document.getElementById('selected-product').innerText;
    	/* var selectedMember = document.getElementById('selected-member').innerText; */
      	var selectedCount = document.getElementById('selected-count').innerText;
      	var inputInfo = document.getElementById('input-info').innerText;
      if (/* !selectedMember || */ !selectedCount  || !selectedProduct || !inputInfo) {
    	  alert("각 항목에 대한 옵션을 모두 입력해 주시기 바랍니다.");
        return;
      }

      var table = document.getElementById('selected-values-table').getElementsByTagName('tbody')[0];
      var newRow = table.insertRow(table.rows.count);
      var cell1 = newRow.insertCell(0);
      var cell2 = newRow.insertCell(1);
      var cell3 = newRow.insertCell(2);
      /* var cell4 = newRow.insertCell(3); */

      cell1.innerHTML = selectedProduct;
      /* cell2.innerHTML = selectedMember; */
      cell2.innerHTML = selectedCount;
      cell3.innerHTML = inputInfo;

    
      // 수정 버튼 생성
      /*
      var modifyButton = document.createElement('button');
      modifyButton.innerText = '수정';
      modifyButton.onclick = function() {
        alert('선택한 값 수정: ' + selectedColor + ', ' + selectedSize + ', ' + selectedcount);
      };
      newRow.appendChild(modifyButton);
      */

      // 삭제 버튼 생성
      var deleteButton = document.createElement('button');
      deleteButton.innerText = '삭제';
      deleteButton.onclick = function() {
        table.deleteRow(newRow.rowIndex-1);
      };
      newRow.appendChild(deleteButton);

      createPlan(/*selectedMember,*/ inputInfo, selectedCount, selectedProduct);
     /*  document.getElementById('selected-member').innerText = null;
      document.getElementById('selected-member').style.border = "none"; */
      document.getElementById('input-info').innerText = null;
      document.getElementById('input-info').style.border = "none";
      document.getElementById('selected-count').innerText = null;
      document.getElementById('selected-count').style.border = "none";
      document.getElementById('selected-product').innerText = null;
      document.getElementById('selected-product').style.border = "none";
    } 

    function createPlan(/*memberName,*/ orderInfo, orderCount, productName) {
     
      var form = document.getElementById("planOrderForm");
      /*var inpmember = document.createElement("input");
      inpmember.setAttribute("type", "hidden");
      inpmember.setAttribute("value", memberName);
      inpmember.setAttribute("name", "memberName");
      form.appendChild(inpmember);*/

      var inpinfo = document.createElement("input");
      inpinfo.setAttribute("type", "hidden");
      inpinfo.setAttribute("value", orderInfo);
      inpinfo.setAttribute("name", "orderInfo");
      form.appendChild(inpinfo);

      var inpcount = document.createElement("input");
      inpcount.setAttribute("type", "hidden");
      inpcount.setAttribute("value", orderCount);
      inpcount.setAttribute("name", "orderCount");
      form.appendChild(inpcount);

      var inpproduct = document.createElement("input");
      inpproduct.setAttribute("type", "hidden");
      inpproduct.setAttribute("value", productName);
      inpproduct.setAttribute("name", "productName");
      form.appendChild(inpproduct);

    }

    function submitSelectedValues() {
      var form = document.getElementById("planOrderForm");
      form.submit();
    }

    /*
    // 경고창
    function displayerror() {
      var selectedColor = document.getElementById('selected-member').innerText;
      var selectedSize = document.getElementById('input-info').innerText;
      var selectedcount = document.getElementById('selected-count').innerText;
      var selectedproduct = document.getElementById('selected-product').innerText;

      if (!selectedColor || !selectedSize || !selectedcount  || !selectedproduct) {
        alert("각 항목에 대한 옵션을 모두 선택 바랍니다.");
        return;
      }

      var table = document.getElementById('selected-values-table').getElementsByTagName('tbody')[0];
      var newRow = table.insertRow(table.rows.count);
      var cell1 = newRow.insertCell(0);
      var cell2 = newRow.insertCell(1);
      var cell3 = newRow.insertCell(2);
      var cell4 = newRow.insertCell(3);

      cell1.innerHTML = selectedColor;
      cell2.innerHTML = selectedSize;
      cell3.innerHTML = selectedcount;
      cell4.innerHTML = selectedproduct;
    }
*/
  </script>
</head>
<body>
  <div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      품명
    </button>
    <ul class="dropdown-menu">
    <c:forEach var="product" items="${plist}" varStatus="idx">
      <li><a class="dropdown-item" style="cursor:pointer" onclick="displaySelectedProduct('${product.productName}')">${product.productName}</a></li>
    </c:forEach>
      <li><hr class="dropdown-divider"></li>
    </ul>
  </div>
  <!-- <div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      작업자
    </button>
    <ul class="dropdown-menu">
      <li><span value=null></span></li>	
    <c:forEach var="member" items="${mlist}" varStatus="idx">
      <li><a class="dropdown-item" style="cursor:pointer" onclick="displaySelectedMember('${member.MEMBER_NAME}')">${member.MEMBER_NAME}</a></li>
    </c:forEach>
      <li><hr class="dropdown-divider"></li>
    </ul>
  </div>  -->

  <div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      수량
    </button>
    <ul class="dropdown-menu">
      <li><input class="dropdown-item" onkeyup="displaySelectedCount(this.value)"></li>
      <li><hr class="dropdown-divider"></li>
    </ul>
  </div>

  <div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      지시사항
    </button>
    <ul class="dropdown-menu">
      <li><input class="dropdown-item" onkeyup="displayInputInfo(this.value)"></li>
      <li><hr class="dropdown-divider"></li>
    </ul>
  </div>
  
  <div align="right" class="btn-group">
    <button type="button" class="btn btn-primary" onclick="displaySelectedValues()">저장</button>
  </div>
  <div class="btn-group">
    <button type="button" class="btn btn-primary" onclick="submitSelectedValues()">전송</button>
  </div>
  
  <div class="btn-group">
  	<a href="planView" class="btn btn-primary">목록</a>
  </div>
  
  <form id="planOrderForm" action="planOrder" method="get">
  </form>
  
    <table>
      <tr>
        <td>
          <div style="min-width:80px" id="selected-product"></div>
        </td>
        <!--  <td>
          <div style="min-width:90px" id="selected-member"></div>
        </td> -->
        <td>
          <div style="min-width:80px" id="selected-count"></div>
        </td>
        <td>
          <div style="min-width:100px" id="input-info"></div>
        </td>
      </tr>
    </table>
  
  <table class="table table-bordered" id="selected-values-table">
    <thead>
      <tr>
        <th>품명</th>
        <!-- <th>작업자</th> -->
        <th>수량</th>
        <th>지시사항</th>
      </tr>
    </thead>
    <tbody>
      
    </tbody>
  </table>
</body>
</html>