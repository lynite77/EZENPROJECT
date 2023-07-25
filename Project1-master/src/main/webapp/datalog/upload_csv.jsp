<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>CSV 파일 업로드</title>
</head>
<body>
    <h1>CSV 파일 업로드</h1>
    <form action="/PUploadServlet" method="post" enctype="multipart/form-data">
        <input type="file" name="file" accept=".csv" required />
        <input type="submit" value="업로드" />
    </form>
</body>
</html>
