<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="qDao" class="Spring.QualityDAO"/>
<%
	request.setCharacterEncoding("UTF-8");
	String[] qcode = request.getParameterValues("qcode");
	String[] member = request.getParameterValues("member");
	for (int i=0;i<qcode.length;i++){
		//if (member[i].equals("선택") || member[i].equals("")) {
		//	continue;
		//}
		if (qDao.checkmember(qcode[i],member[i])){
			continue;
		}else{
			 qDao.updatemember(qcode[i],member[i]);
		}
		System.out.println(qcode[i] +", "+ member[i]);
	}
	String url = "list.jsp";
	String msg = "저장했습니다.";
%>
<script>
	alert("<%=msg%>");	
	location.href="<%=url%>";
</script>