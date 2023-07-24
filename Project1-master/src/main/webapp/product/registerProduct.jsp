<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>제품등록 페이지</title>
    <style type="text/css">

        .grid1 { 
            grid-column-start: 1; grid-column-end: 2; 
            background: rgb(21, 49, 14); 
        }
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f7f7f7;
        }
        h1 {
            text-align: center;
            font-size: 30px;
            color: #333;
            margin-bottom: 20px;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 4px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }
        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            border: none;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function registerProduct() {
            // 입력된 데이터 가져오기
            var productCode = document.getElementById("productCode").value;
            var productName = document.getElementById("productName").value;
            var productManager = document.getElementById("productManager").value;
            
            /*
            var materialCodes = [];
            var materialCodeInputs = document.getElementsByClassName("materialCode");
            for (var i = 0; i < materialCodeInputs.length; i++) {
                materialCodes.push(materialCodeInputs[i].value);
            }
            */

            var form = document.getElementById("formProduct");
            form.submit();
            alert("제품 등록이 완료되었습니다.");
        }
    </script>
</head>
<body>
    <div class="container">
        <h1 class="grid1">제품등록 페이지</h1>
        
        <form id="formProduct" action="register" method="post">
            <label for="productCode">제품코드:</label>
            <input type="text" id="productCode" name="productCode" required>
            <label for="productName">제품명:</label>
            <input type="text" id="productName" name="productName" required>
            <label for="productManager">관리자:</label>
            <input type="text" id="productManager" name="productManager" required>
            <br>
            <button type="button" onClick="registerProduct()">
        </form>
    </div>
</body>
</html>
