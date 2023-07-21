<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="Spring.*"%>
<%@ page import="bean.*"%>
<jsp:useBean id="qDao" class="Spring.QualityDAO"/>
<%
	request.setCharacterEncoding("UTF-8");
	String qcode = request.getParameter("qcode");
 	String worker = request.getParameter("worker");
	String content = request.getParameter("content");
	String error = request.getParameter("error");
	qDao.registBoard(content, qcode, Integer.parseInt(worker), error);
	String msg = "저장했습니다.";
%>

<html>
<head>
<script language="javascript">
	alert("<%=msg%>");
</script>
</head>
<body onload="document.readFrm.submit()">

	<form name="readFrm" method="post" action="Qread.jsp">
			<input type="hidden" name="qcode" value="<%=qcode%>"> 
			<input type="hidden" name="worker" value="<%=worker%>">  
	</form>
</body>
</html>