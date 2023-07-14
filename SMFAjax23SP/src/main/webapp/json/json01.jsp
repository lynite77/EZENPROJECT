<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>JSON 테스트</title>
	<script src="js/jquery-1.12.4.js"></script>
	<script>
	    $(function() {
	        $("#checkJson").click(function() {
		        var jsonStr  = '{"name": ["홍길동", "이순신", "임꺽정"] }';          
		        var jsonInfo = JSON.parse(jsonStr);
		        var output ="회원 이름<br>";
		        output += "=======<br>";
		        for(var i in jsonInfo.name) {
		        	output += "[" + i + "] ";
		            output += jsonInfo.name[i]+"<br>";
		        }
		        $("#output").html(output);
	      });
	    });
	</script>
  </head>
  
  <body>
    <a id="checkJson" style="cursor:pointer">출력(클릭)</a><br><br>
    <div id="output"></div>
  </body>
</html>
