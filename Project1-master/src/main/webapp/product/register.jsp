<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품등록 페이지</title>
	<link href="../CSS/pstyles.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <h1 class="grid1">제품등록 페이지</h1>
        <form id="paddDataForm">
            <label for="productCode">제품코드:</label>
            <input type="text" id="productCode" name="productCode" required>
            <label for="productName">제품명:</label>
            <input type="text" id="productName" name="productName" required>
            <label for="productName">제품색상:</label>
            <input type="text" id="productColor" name="productColor" required>
            <label for="productName">제품사이즈:</label>
            <input type="text" id="productSize" name="productSize" required>
            <label for="productName">제품길이:</label>
            <input type="text" id="productLength" name="productLength" required>
            <label for="productName">제품가격:</label>
            <input type="text" id="productPrice" name="productPrice" required>
            <label for="productName">제품정보:</label>
            <input type="text" id="productInfo" name="productInfo" required>
            <br>
            <button type="submit">등록</button>
        </form>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $("#paddDataForm").submit(function(event) {
            event.preventDefault();
            
            var formData = {
                productCode: $("#productCode").val(),
                productName: $("#productName").val(),
                productColor: $("#productColor").val(),
	            productSize: $("#productSize").val(),
	            productLength: $("#productLength").val(),
	            productPrice: $("#productPrice").val(),
	            productInfo: $("#productInfo").val()
            };
            
            $.ajax({
                type: "POST",
                url: "/PAddDataServlet",
                data: formData,
                success: function(response) {
                    // 성공적으로 데이터를 추가한 경우 팝업 창 닫기 및 페이지 리로드
                    alert("데이터 추가 성공");
                    window.location.href = "registerconfirm.htm";
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
