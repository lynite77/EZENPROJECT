<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="Spring.*"%>
<%@ page import="bean.*"%>
<jsp:useBean id="qDao" class="Spring.QualityDAO"/>
<%	
	request.setCharacterEncoding("UTF-8");
	String worker = (String)session.getAttribute("idKey");	
	
	
	int totalRecord=0;		// 전체레코드수
	int numPerPage=15;		// 페이지당 레코드 수 
	int pagePerBlock=10;	// 블럭당 페이지수 
	
	int totalPage=1;		// 전체 페이지 수
	int totalBlock=1;		// 전체 블럭수 
	
	int nowPage=1;			// 현재페이지
	int nowBlock=1;			// 현재블럭
	
	int start=1;			// DB의 select 시작번호
	int end=15;				// 시작번호로 부터 가져올 select 갯수
	
	int listSize=0;			//현재 읽어온 게시물의 수
	
	String before = LocalDate.now().toString();
	String after =  LocalDate.now().toString();
	
	
	
	if (request.getParameter("before") != null) {
		before = request.getParameter("before");
	}
	
	if (request.getParameter("after") != null) {
		after = request.getParameter("after");
	}
	
	String keyWord = "";
	String keyField = "";
	Vector<QualityBean> qlist = null;
	Vector<QualityBean> vlist = null;
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	
	System.out.println("keyField:" + keyField);
	System.out.println("keyWord:" + keyWord);
	System.out.println("before:" + before);
	System.out.println("after:" + after);
	
	
	if (request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	if (request.getParameter("numPerPage") != null) {
		numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	}
	
	System.out.println("nowPage:" + nowPage);
	System.out.println("numPerPage:" + numPerPage);
	
	start = (nowPage * numPerPage) - numPerPage + 1;
	end = start + numPerPage - 1;
	 
	totalRecord = qDao.getTotalCount(keyField, keyWord, before, after);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);	// 전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock); 		// 현재블럭 계산
	  
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  // 전체블럭계산
%>
<html>
<head>
<title>Quality Control</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}
	
	function pageing(page,num) {
		document.readFrm.numPerPage.value = num;
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value,num) {
		document.readFrm.numPerPage.value = num;
		 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		 document.readFrm.submit();
	} 
	
	function read(qcode) {
		var userInput = prompt("품질코드를 입력하세요"+"");
		if(userInput == qcode){
			location = "QpostProc.jsp?qcode="+qcode+"&worker="+<%=worker%>;
		}
		else if(userInput == null){
			alert("품질코드를 입력해주세요.");	
		}
		else {
			alert("품질코드가 일치하지 않습니다.");	
		}		
	}
	
	function check() {
		if ((document.searchFrm.keyField.value == "quality_CODE"||document.searchFrm.keyField.value == "Product_NAME")&&document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
   		}
		
		console.log("keyField:", document.searchFrm.keyField.value);
		console.log("keyWord:", document.searchFrm.keyWord.value);
		console.log("before:", document.searchFrm.before.value);
		console.log("after:", document.searchFrm.after.value);
		
		// document.searchFrm.submit();
	 }
	
	function save() {
		document.saveFrm.submit();
	}
	
	
	function page(){
		var PageSelect = document.getElementById("PageSize");
		var PageSize = PageSelect.options[PageSelect.selectedIndex].value;
		/* var url="list.jsp?keyField="+document.searchFrm.keyField.value+"&keyWord="+document.searchFrm.keyWord.value+"&nowPage=1&numPerPage="+listSize */
		var para = document.location.href.split("?");
		const urlParameter = new URLSearchParams(para[1]);
		urlParameter.set("numPerPage", PageSize);
		location.href = "list.jsp?"+urlParameter;
		}
</script>
<style>
	.mem:hover {
		cursor:pointer;
	}
	a {text-decoration: none;
		color:black;}
	.mt table{ border: 1px solid #444444;
	}
	.mt td {border: 1px solid #D0D0D0;}
	.main div{
	overflow:hidden;
    height:auto;
    }
</style>
</head>
<body>
<div class="main" align="center">
	<br/>
	<h1 align="center">품질 관리</h1>
	<br/>
	<table width="1000" cellpadding="4" cellspacing="0">
 		<tr>
 			<form name="searchFrm"  method="get" action="list.jsp">
  			<td align="left" valign="bottom">
   				<select name="keyField" size="1" >
   					<option>선택</option>
    				<option value="quality_CODE">품질코드</option>
    				<option value="Product_NAME">제품명</option>
    				<option value="temporary">작업자</option>
   				</select>
   				<input size="16" name="keyWord">
   				<input type="date" name="before" value="<%=before%>"><input type="date" name="after" id="after" value="<%=after%>">
   				<input type="submit"  value="검색" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
  			<td align="right">
  				페이지 당 레코드 수(현재:<%=numPerPage%>)
  				<select id="PageSize" onchange="page()">
  					<option value="">선택</option>
  					<option value="15">15</option>
  					<option value="50">50</option>
  					<option value="100">100</option>
  					<option value="200">200</option>
  				</select>
  				<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
  				작업자 변경
  			</form>
  				<input type="submit" form="employee" value="저장">
  			</td>
 		</tr>
	</table>
	
	<table class="mt" align="center" width="1000" cellpadding="3">
		<tr>
			<td align="center" colspan="2">
			<%
				  vlist = qDao.getBoardList(keyField, keyWord, start, end, before, after);
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
				  if (vlist.isEmpty()) {
					out.println("등록된 작업이 없습니다.");
				  } else {
			%>
				<form name=saveFrm id="employee" method="post" action="NameSaveProc.jsp">		
				  <table width="100%" cellpadding="2" cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						 <td><strong>번호</strong></td>
						 <td><strong>품질코드</strong></td>
					     <td><strong>제품명</strong></td>
					     <td><strong>지시일</strong></td>
					     <td><strong>작업자</strong></td>
					     <td><strong>예정작업자</strong></td>
					     <td><strong>작업일</strong></td>	
					</tr>
					<%
						  for (int i = 0;i<numPerPage; i++) {
							if (i == listSize) break;
							QualityBean bean = vlist.get(i);
							String Q_CODE = bean.getQUALITY_CODE();
							String P_NAME = bean.getPRODUCT_NAME();
							String O_DATE = bean.getORDER_DATE();
							String M_NAME = bean.getMEMBER_NAME();
							String P_WORKER = bean.getTEMPORARY_WORKER();
							String Q_DATE = bean.getQUALITY_DATE();
					%>
					
					<tr>
						<td align="center">
							<%=totalRecord-((nowPage-1)*numPerPage)-i%>
						</td>
						<td align="center" class="mem" onclick="javascript:read('<%=Q_CODE%>')" name=""><span align="center"><%=Q_CODE%></span></td>
						<input type="hidden" name="qcode" value="<%=Q_CODE%>">
						<td align="center"><%=P_NAME%></td>
						<td align="center"><%=O_DATE%></td>
<% if (M_NAME==null) {%>
						<td align="center"></td>
<%} else { %>			<td align="center"><%=M_NAME%></td>
<%}%>
						<td align="center">
							
							<select name="member">
<%  
								if (P_WORKER == null){%>
									<option value="" selected>선택</option>

<%} 							else{%>
									<option value="<%=P_WORKER%>" selected><%=P_WORKER%></option>
									<option value="">선택</option>
<%}
								Vector<QualityBean> mlist = qDao.getMemberList();
								for(int j=0; j<mlist.size(); j++){
									QualityBean mBean = mlist.get(j);
									if (mBean.getMEMBER_NAME()== null) continue;
%>
									<option value="<%=mBean.getMEMBER_NAME()%>"><%=mBean.getMEMBER_NAME()%></option>
<%}%>						</select>
							
						</td>
<% 
								if(Q_DATE==null){%>
									<td></td>
<%}								else{%>
									<td align="center"><%=Q_DATE%></td>
<%}%>
					</tr>
					
					<%}//for%>
				</table>
				</form> <%
 			}//if
 		%>
			</td>
		</tr>
		<table width="1000">
		<br>
		<hr width="1000"/>
		<br>
			<tr>
				<td align="left">
			<!-- 페이징 및 블럭 처리 Start--> 
			<%
   				  int pageStart = (nowBlock - 1) * pagePerBlock + 1 ; // 하단 페이지 시작번호
   				  int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage + 1; 
   				  // 하단 페이지 끝번호
   				  if(totalPage != 0) {
    			  	if (nowBlock > 1) {%>
    			  		<a href="javascript:block('<%=nowBlock-1%>','<%=numPerPage%>')">[prev]</a><%}%>&nbsp; 
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
     			     	<a href="javascript:pageing('<%=pageStart %>','<%=numPerPage%>')"> 
     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
     					[<%=pageStart%>]
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
    					<%}//for%>&nbsp;
    					<%if (totalBlock > nowBlock ) {%>
    					<a href="javascript:block('<%=nowBlock+1%>','<%=numPerPage%>')">[next]</a>
    				<%}%>&nbsp; 
    			  <%}%> 
 				<!-- 페이징 및 블럭 처리 End-->
				</td>
				<td align="right">총 <%=totalRecord%> 개(<font color="red">
				<%=nowPage%>/<%=totalPage%> Pages</font>)</td>
			</tr>
		</table>
	</table>
	
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
		<input type="hidden" name="numPerPage" value="15">
	</form>
	<form name="readFrm" method="get"> 
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="keyField" value="<%=keyField%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>">		
	</form>
</div>
</body>
</html>