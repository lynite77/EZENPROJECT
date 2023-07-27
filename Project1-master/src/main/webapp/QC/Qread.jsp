<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*"%>
<%@ page import="java.util.*"%>
<%@ page import="Spring.*"%>
<%@ page import="bean.*"%>
<jsp:useBean id="qDao" class="Spring.QualityDAO"/>
<jsp:useBean id="Mgr" class="member.MemberMgr"/>
<% 
		String id = (String)session.getAttribute("idKey");
		int memberCode = Mgr.findCode(id);
		request.setCharacterEncoding("UTF-8");		
		String qcode = request.getParameter("qcode");
		String worker = request.getParameter("worker");
		String w_name = qDao.findmember(Integer.valueOf(worker));
		QualityBean bean = qDao.getBoard(qcode);
		int mcode = bean.getMEMBER_CODE();
		String pname = bean.getPRODUCT_NAME();
		String pcode = Integer.toString(bean.getPRODUCT_CODE());
		String pinfo = bean.getPRODUCT_INFO();
		String mname = bean.getMEMBER_NAME();
		String mdate = bean.getQUALITY_DATE();
		String odate = bean.getORDER_DATE();
		String content = bean.getCHECK_INFO();
		String error = bean.getERROR_CODE();
		String ename = bean.getERROR_NAME();
		String pwd = qDao.findPwd(Integer.valueOf(worker));
%>
<script type="text/javascript">
function save() {
	document.postFrm.content.disabled=false;
	document.postFrm.submit();
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
<form name="postFrm" method="post" action="Qpost.jsp">
<table class="head" align="center";>
	<tr>
		<td colspan="6" style="font-size:18pt;" bgcolor="gray" height="25" align="center">시험 기록서</td>
	</tr>
	<tr>
		<td align=center>
		<table class="body" align="center">
			<tr>
				<td colspan="2">품질 코드</td>
				<td colspan="4"><%=qcode%></td>
			</tr>
			<tr>
				<td colspan="2">품 목 명</td>
				<td colspan="4"><%=pname%></td>
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
				<%if (error == null){%><td colspan="2">품질 결과 : 적합</td>
									   <td colspan="4">이상이 없습니다</td>
				<%}else{%><td colspan="2">품질 결과 : 부적합</td>
									   <td colspan="4">부적합명 : <%=ename%></td>
				<%}%>		
			</tr>
			<tr>
				<td colspan="2">비고</td>
				<td colspan="4"><textarea name="content" rows="10" cols="50" disabled><%if(content==null){%><%}else{%><%=content%><%}%></textarea></td>
			</tr>
		</table>
		<table class="foot1" align="center";>
			<tr>
				<td>작업자</td>
				<td><%=mname%></td>
				<td>작업일</td>
				<td><span><%=mdate.substring(0,10)%></span></td>
				<td>저장시간</td>
				<td><span><%=mdate.substring(11)%></span></td>
				
			</tr>
		</table>
		<table class="foot2" align="center">
			<tr>
<% if (memberCode == mcode){ %>
				<td align="right">
					 <input style="font-size:14pt;" type="submit" value="수  정" onClick="javascript:save()">
				</td>
				<%} else {%>
				<td align="right"></td>
				<%} %>	
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