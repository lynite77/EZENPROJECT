<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.*"%>
<%@ page import="java.util.*"%>
<%@ page import="Spring.*"%>
<%@ page import="bean.*"%>
<jsp:useBean id="qDao" class="Spring.QualityDAO"/>
<% 
	request.setCharacterEncoding("UTF-8");
	// int id = Integer.valueOf(request.getParameter("id"));
	String qcode = request.getParameter("qcode");
	String worker =  request.getParameter("worker");
	String w_name = qDao.findmember(Integer.valueOf(worker));
	QualityBean bean = qDao.getBoard(qcode);
	String pname = bean.getPRODUCT_NAME();
	String pcode = Integer.toString(bean.getPRODUCT_CODE());
	String pinfo = bean.getPRODUCT_INFO();
	String mname = bean.getMEMBER_NAME();
	String mdate = bean.getQUALITY_DATE();
	String odate = bean.getORDER_DATE();
	String error = bean.getERROR_CODE();
	String ename = bean.getERROR_NAME();
	String content = bean.getCHECK_INFO();
	String pwd = qDao.findPwd(Integer.valueOf(worker));
%>
<script type="text/javascript">
function save(pwd) {
	var userInput = prompt("비밀번호를 입력하세요"+"");
	if(userInput == pwd){
		document.postFrm.error.disabled=false;
		return document.postFrm.submit();
	}
	else if(userInput == null){
		alert("비밀번호를 입력해주세요.");
	}
	else {
		alert("비밀번호가 일치하지 않습니다.");
		return save();
	}		
}
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quality Test</title>
<style>
	table{ width:1000px;
		   
		}
	tr {width:1000px;
		height: 50px;}
	.body td {border: 1px solid #D0D0D0;}
	.head table {border: 1px solid #D0D0D0;}
	.foot2 table {border: 1px solid #D0D0D0;}
	.foot1 td {border: 1px solid #D0D0D0;}
</style>
</head>
<body>
<form name="postFrm" method="post" action="QpostSaveProc.jsp">
<table class="head" align="center">
	<tr>
		<td colspan="6" style="font-size:18pt;" bgcolor="gray" height="25" align="center">시험 기록서</td>
	</tr>
	<tr>
		<td align=center>
		<table class="body" align="center">
			<tr>
				<td colspan="2">품질 코드</td>
				<td colspan="4"><span><%=qcode%></span></td>
			</tr>
			<tr>
				<td colspan="2">품 목 명</td>
				<td colspan="4"><span><%=pname%></span></td>
			</tr>
			<tr>
				<td colspan="2">지 시 일</td>
				<td colspan="4"><span><%=odate%></span></td>
			</tr>
			<tr>
				<td colspan="2">품질 분류</td>
				<td colspan="4"><span><%=pinfo%></span></td>
			</tr>
			<tr>
<% if (error == null) { %>	
				<td colspan="2">
					<div>
						<input type="radio" id="OK" name="radio" value="OK" onClick="this.form.error.disabled=true" checked>
						<label for="OK">적합</label>
						<input type="radio" id="NG" name="radio" value="NG" onClick="this.form.error.disabled=false">
						<label for="NG">부적합</label>
					</div>
				</td>
				<td colspan="4">
					<select name="error" disabled>
						<option value="" selected>선택</option>
<%
						Vector<QualityBean> elist = qDao.getErrorList();
						for(int i=0; i<elist.size(); i++){
							QualityBean eBean = elist.get(i);
%>
						<option value="<%=eBean.getERROR_CODE()%>"><%=eBean.getERROR_NAME()%></option>
<%}%>				</select>
				</td>							
<% } else {%>
				<td colspan="2">
					<div>
						<input type="radio" id="OK" name="radio" value="OK" onClick="this.form.error.disabled=true">
						<label for="OK">적합</label>
						<input type="radio" id="NG" name="radio" value="NG" onClick="this.form.error.disabled=false" checked>
						<label for="NG">부적합</label>
					</div>
				</td>
				<td colspan="4">
					<select name="error">
						<option value="<%=error%>" selected><%=ename%></option>
						<option value="">선택</option>
<%
						Vector<QualityBean> elist = qDao.getErrorList();
						for(int i=0; i<elist.size(); i++){
							QualityBean eBean = elist.get(i);
%>
						<option value="<%=eBean.getERROR_CODE()%>"><%=eBean.getERROR_NAME()%></option>
<%}%>				</select>
				</td>
<%} %>
			</tr>
			<tr>
				<td colspan="2">비고</td>
				<td colspan="4"><textarea name="content" rows="10" cols="50"><%if(content==null){%><%}else{%><%=content%><%}%></textarea></td>
			</tr>
		</table>
		<table class="foot1" align="center">
			<tr>
				<td>작업자</td>
				<td><span><%=w_name%></span></td>
<% if (mdate == null) { %>
				<td>작업일</td>
				<td><span><%=LocalDate.now()%></span></td>	
				<td>저장시간</td>
				<td><span id="time"></span></td>
<% } else { %>	<td>작업일</td>
				<td><span><%=mdate.substring(0,10)%></span></td>
				<td>저장시간</td>
				<td><span><%=mdate.substring(11)%></span></td>
<% }%>
			</tr>
		</table>
		<table class="foot2" align="center">
			<tr>
				<td align="right">
					 <input style="font-size:14pt;" type="button" value="저  장" onClick="javascript:save('<%=pwd%>')">
				</td>
				<td align="center">
					 <input style="font-size:14pt;" type="button" value="목  록" onClick="javascript:location.href='list.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="qcode" value="<%=qcode%>"> 
<input type="hidden" name="worker" value="<%=worker%>"> 
</form>
</div>
<script type="text/javascript">
		const clock = document.getElementById("time")
		function getClock(){
	 		const d = new Date();
	 		const h = String(d.getHours()).padStart(2,"0");
	  		const m = String(d.getMinutes()).padStart(2,"0");
	  		const s = String(d.getSeconds()).padStart(2,"0");
	  		clock.innerText = h+":"+m+":"+s;
		}
		getClock();
		setInterval(getClock, 1000);	
</script>
</body>
</html>