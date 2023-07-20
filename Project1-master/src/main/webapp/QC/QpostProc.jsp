<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.*"%>
<%@ page import="java.util.*"%>
<%@ page import="Spring.*"%>
<%@ page import="bean.*"%>
<jsp:useBean id="qDao" class="Spring.QualityDAO"/>
<% 
	request.setCharacterEncoding("UTF-8");
	String qcode = request.getParameter("qcode");
	String worker = request.getParameter("worker");
	QualityBean bean = qDao.getBoard(qcode);
	String mname = bean.getMEMBER_NAME();
	String mdate = bean.getQUALITY_DATE();
	String content = bean.getCHECK_INFO();
	String url = null;
	if (mdate == null) {
		url ="Qpost.jsp?qcode="+qcode+"&worker="+worker;
	}
	else {
		url ="Qread.jsp?qcode="+qcode+"&worker="+worker;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quality Test</title>
<Script>
	location.href="<%=url%>";
</Script>
</head>
<body>
</body>
</html>