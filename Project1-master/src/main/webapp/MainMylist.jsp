<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.time.*"%>
<%@ page import="Spring.*"%>
<%@ page import="bean.*"%>
<jsp:useBean id="qMgr" class="Spring.QualityDAO"/>
<%	
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	
	int totalRecord=0;		// 전체레코드수
	int numPerPage=100;		// 페이지당 레코드 수 
	int pagePerBlock=10;	// 블럭당 페이지수 
	
	int totalPage=1;		// 전체 페이지 수
	int totalBlock=1;		// 전체 블럭수 
	
	int nowPage=1;			// 현재페이지
	int nowBlock=0;			// 현재블럭
	
	int start=0;			// DB의 select 시작번호
	int end=10;				// 시작번호로 부터 가져올 select 갯수
	
	int listSize=0;			//현재 읽어온 게시물의 수

	String before = LocalDate.now().toString();
	String after =  LocalDate.now().toString();
	String keyField = "TEMPORARY";
	String keyWord = qMgr.findmember(Integer.valueOf(id));

	Vector<QualityBean> vlist = null;
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	
	System.out.println("keyField:" + keyField);
	System.out.println("keyWord:" + keyWord);
	
	if (request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}

	start = (nowPage * numPerPage) - numPerPage + 1;
	end = start + numPerPage - 1;
	 
	totalRecord = qMgr.getTotalCount(keyField, keyWord, before, after);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);	// 전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock); 		// 현재블럭 계산
	  
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  // 전체블럭계산
%>
<html>
<head>
<title>My Task</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}
	
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value) {
		 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		 document.readFrm.submit();
	} 
	
	function read(num) {
		document.readFrm.num.value=Q_CODE;
		document.readFrm.action="read.jsp";
		document.readFrm.submit();
	}
	
	function check() {
		if (document.searchFrm.keyField.value != "member_name"&&document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
   		}
		
		console.log("keyField:", document.searchFrm.keyField.value);
		console.log("keyWord:", document.searchFrm.keyWord.value);
		
		// document.searchFrm.submit();
	 }
	function save() {
		document.saverm.submit();
		 
	}
</script>
<style>
	body{
	padding: 0px;
	margin: 0px;
	}
	.mem input:focus {
  		outline: none;
	}
	.mem input:hover {
		cursor:pointer;
	}
	.mem input {
		border:none;
	}
	a {text-decoration: none;
		color:black;}
	.mt table{ border: 1px solid #444444;
	}
	.mt td {border: 1px solid #D0D0D0;}
</style>
</head>
<body>
<div align="center">
	<br/>
	<h1 style="margin-right:800px;">My Task</h1>
	<br/>
	<table class="mt" align="center" width="1000" cellpadding="3">
		<tr>
			<td align="center" colspan="2">
			<%
				  vlist = qMgr.getBoardList(keyField, keyWord, start, end, before, after);
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
				  if (vlist.isEmpty()) {
					out.println("등록된 작업이 없습니다.");
				  } else {
			%>
				<form name=saveFrm id="employee" method="post" action="saveProc.jsp">		
				  <table width="100%" cellpadding="2" cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						 <td><strong>번호</strong></td>
						 <td><strong>품질코드</strong></td>
					     <td><strong>제품명</strong></td>
					     <td><strong>지시일</strong></td>
					     <td><strong>작업자</strong></td>
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
					%>
					
					<tr>
						<td align="center">
							<%=totalRecord-((nowPage-1)*numPerPage)-i%>
						</td>
						<td align="center" >
							<span align="center"><%=Q_CODE%></span>
						</td>
						<td align="center"><%=P_NAME%></td>
						<td align="center"><%=O_DATE%></td>
						<td align="center"><%=keyWord%></td>
<% 
								if(bean.getQUALITY_DATE()==null){%>
									<td></td>
<%}								else{%>
									<td align="center"><%=bean.getQUALITY_DATE()%></td>
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
    			  		<a href="javascript:block('<%=nowBlock-1%>')">[prev]</a><%}%>&nbsp; 
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
     			     	<a href="javascript:pageing('<%=pageStart %>')"> 
     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
     					[<%=pageStart%>]
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
    					<%}//for%>&nbsp;
    					<%if (totalBlock > nowBlock ) {%>
    					<a href="javascript:block('<%=nowBlock+1%>')">[next]</a>
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
	</form>
	<form name="readFrm" method="get"> 
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="keyField" value="<%=keyField%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
	</form>
</div>
</body>
</html>