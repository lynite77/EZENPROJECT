<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- ... -->
</head>
<body>
    <h2>Add Data</h2>
    <form id="addDataForm">
        <label for="databaseType">데이터베이스 선택:</label>
        <select id="databaseType" name="databaseType" onchange="toggleFields()">
            <option value="GProduct">GProduct 테이블</option>
            <option value="ErrorLog">ErrorLog 테이블</option>
        </select><br>
        <label for="productCode">제품코드:</label>
        <input type="text" id="productCode" name="productCode"><br>
        
        <label for="productName">제품명:</label>
        <input type="text" id="productName" name="productName"><br>
        
        <!-- GProduct 테이블 필드들 -->
        <div id="gProductFields">
            <label for="productColor">제품색상:</label>
            <input type="text" id="productColor" name="productColor"><br>
            
            <label for="productSize">제품크기:</label>
            <input type="text" id="productSize" name="productSize"><br>
            
            <label for="productLength">제품길이:</label>
            <input type="text" id="productLength" name="productLength"><br>
            
            <label for="productPrice">제품가격:</label>
            <input type="text" id="productPrice" name="productPrice"><br>
            
            <label for="productInfo">제품정보:</label>
            <input type="text" id="productInfo" name="productInfo"><br>
        </div>
        
        <!-- ErrorLog 테이블 필드들 -->
        <div id="errorLogFields" style="display: none;">
            <label for="errorCode">에러코드:</label>
            <input type="text" id="errorCode" name="errorCode"><br>
            
            <label for="errorName">에러명:</label>
            <input type="text" id="errorName" name="errorName"><br>
            
            <label for="errorQuantity">에러수량:</label>
            <input type="number" id="errorQuantity" name="errorQuantity"><br>
            
            <label for="errorDate">에러발생시기:</label>
            <input type="text" id="errorDate" name="errorDate"><br>
        </div>
        
        <input type="submit" value="데이터 추가">
    </form>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        // 현재 시간을 가져와서 에러발생시기 필드에 설정
        var currentTime = new Date();
        var formattedTime = currentTime.toISOString(); // ISO 형식으로 변환

        // 에러발생시기 필드에 값 설정
        $("#errorDate").val(formattedTime);

        // 필드 숨기기/보이기 함수
        function toggleFields() {
            var selectedValue = $("#databaseType").val();
            if (selectedValue === "GProduct") {
                $("#gProductFields").show();
                $("#errorLogFields").hide();
            } else if (selectedValue === "ErrorLog") {
                $("#gProductFields").hide();
                $("#errorLogFields").show();
            }
        }

        // 페이지 로드 시에도 필드 숨기기/보이기 함수 호출
        toggleFields();

        $("#addDataForm").submit(function(event) {
            event.preventDefault();

            var formData = {
                productCode: $("#productCode").val(),
                productName: $("#productName").val(),
                databaseType: $("#databaseType").val()
            };

            if ($("#databaseType").val() === "GProduct") {
                formData.productColor = $("#productColor").val();
                formData.productSize = $("#productSize").val();
                formData.productLength = $("#productLength").val();
                formData.productPrice = $("#productPrice").val();
                formData.productInfo = $("#productInfo").val();
            } else if ($("#databaseType").val() === "ErrorLog") {
                formData.errorCode = $("#errorCode").val();
                formData.errorName = $("#errorName").val();
                formData.errorQuantity = $("#errorQuantity").val();
                formData.errorDate = $("#errorDate").val();
            }

            $.ajax({
                type: "POST",
                url: $("#addDataForm").attr("action"),
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
