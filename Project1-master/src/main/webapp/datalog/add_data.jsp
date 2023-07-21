<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Data</title>
</head>
<body>
    <h2>Add Data</h2>
    <form id="addDataForm">
	    <label for="databaseType">데이터베이스 선택:</label>
	    <select id="databaseType" name="databaseType">
	        <option value="DB_A">ErrorLog 테이블</option>
	        <option value="DB_B">Product 테이블</option>
	    </select><br>
        <label for="productCode">제품코드:</label>
        <input type="text" id="productCode" name="productCode" required><br>
        
        <label for="productName">제품명:</label>
        <input type="text" id="productName" name="productName" required><br>
        
        <label for="errorCode">에러코드:</label>
        <input type="text" id="errorCode" name="errorCode" required><br>
        
        <label for="errorName">에러명:</label>
        <input type="text" id="errorName" name="errorName" required><br>
        
        <label for="errorQuantity">에러수량:</label>
        <input type="number" id="errorQuantity" name="errorQuantity" required><br>
        
        <label for="errorDate">에러발생시기:</label>
        <input type="text" id="errorDate" name="errorDate" required><br>
        
        <input type="submit" value="데이터 추가">
    </form>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
	 	// 현재 시간을 가져와서 에러발생시기 필드에 설정
	    var currentTime = new Date();
	    var formattedTime = currentTime.toISOString(); // ISO 형식으로 변환
	    
	    // 에러발생시기 필드에 값 설정
	    $("#errorDate").val(formattedTime);
    
        $("#addDataForm").submit(function(event) {
            event.preventDefault();
            
            var formData = {
                productCode: $("#productCode").val(),
                productName: $("#productName").val(),
                errorCode: $("#errorCode").val(),
                errorName: $("#errorName").val(),
                errorQuantity: $("#errorQuantity").val(),
                errorDate: $("#errorDate").val(),
                databaseType: $("#databaseType").val()
            };
            
            $.ajax({
                type: "POST",
                url: "AddDataServlet",
                data: formData,
                success: function(response) {
                    // 성공적으로 데이터를 추가한 경우 팝업 창 닫기 및 페이지 리로드
                    window.close();
                    opener.location.reload();
                },
                error: function(xhr, status, error) {
                    // 데이터 추가 실패 시 에러 메시지 출력
                    alert("데이터 추가 실패: " + error);
                }
            });
        });
    </script>
</body>
</html>
