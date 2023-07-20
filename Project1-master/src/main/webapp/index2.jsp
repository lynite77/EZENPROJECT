<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.*, java.util.*"%>
<jsp:useBean id="qMgr" class="Spring.QualityDAO"/>
<%
	String grade = "guest";
	String id = "2020030001";
	session.setAttribute("idKey", id);
	String tPath = request.getContextPath();
	/* String id = (String)session.getAttribute("idKey"); 
	 String level = (String)session.getAttribute("level");
 	switch(level){
 	case "1": grade = "작업자"; break;
 	case "2": grade = "중간관리자"; break;
 	case "3": grade = "시스템관리자"; break;
 	}*/ 
	if(id == null){
%> 
<script>
   alert("로그인 되지 않았습니다.");
   location.href="Login.jsp";
</script>
<%}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빅데이터 1조</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<style>
html, body {
    height: 100%
}

footer {
    position: fixed;
    bottom: 0px;
}
iframe {
	height: 100%;
	width: 100%;
	}
.offcanvas-body a {
	color: white; text-decoration: none;}
main{
	overflow:hidden;
    height:auto;
    }
}
</style>
</head>
<body bgcolor="#FFFFCC">
	<nav class="navbar navbar-expand navbar-dark bg-dark">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="<%=tPath%>/index.jsp">의류검수 프로그램</a>
	    <button class="btn list" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling">
	    <span class="navbar-toggler-icon"></span>
	    </button>  
	    <div class="collapse navbar-collapse d-flex justify-content-end" id="navbarSupportedContent">
	      	<ul class="navbar-nav">
		        <li class="nav-item">
		        	<span style="color:white;"><%=LocalDate.now()%></span><br>
					<span style="font-size:16pt; color:white;" id="time"></span>
		        </li>
		        <li class="nav-item">
		          	<a class="nav-link" aria-current="page" href="<%=tPath%>/index.jsp"><img src="images/home.png" border="0" width="40" height="40"></a>
		        </li>
		        <li class="nav-item">
		         	<a class="nav-link" href="<%=tPath%>/menu.jsp" target="content"><img style="margin-top:3px;" src="images/setting.png" border="0" width="30" height="30"></a>
		        </li>
		        <li class="nav-item">
		        	<a class="nav-link" href="<%=tPath%>/logout.jsp"><img src="images/logout.png" border="0" width="35" height="35"></a>
		        </li>
	      	</ul>
	    </div>
	  </div>
	</nav>
	<div style="background-color:gray; color: white;">
		<span class="d-flex justify-content-end">로그인 정보 : USER(<%=qMgr.findmember(Integer.valueOf(id))%>), 등급(<%=grade%>)&nbsp;&nbsp;</span>
	</div>
	<main>
        <iframe name="content" src="<%=tPath%>/MainMylist.jsp" style="overflow-x:hidden; overflow:auto; width:100%; min-height:800px;
    	onload="this.style.height=(this.contentWindow.document.body.scrollHeight+30)+'px';"></iframe>
    </main>    
    <footer class="py-4 bg-light mt-auto" style="bottom:0px; width:100%; text-align:center;">
		<div class="text-muted"><span >Copyright &copy; <FONT COLOR="blue"><b>[K-디지털]스마트팩토리-빅데이터 플랫폼 구축 및 개발자 양성과정 1조</b></FONT> All Rights Reserved.</span> </div>
	</footer>
	<div style="position:fixed;right:10px;bottom:10px;">
        	<a href="#"><img src="images/top.png"></a>
    </div>
	<div style="width:200px; color:white;"class="offcanvas offcanvas-start bg-dark" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel">
		  <div class="offcanvas-header">
		    <h4 class="offcanvas-title" id="offcanvasScrollingLabel">MENU</h4>
		    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		  </div>
		  <hr style="border: 0; height:4px; background:#FFF; margin-top:4px; margin-bottom:0px;">
		  <hr style="border: 0; height:4px; background:#FFF; margin-bottom:0px">
		  <div class="offcanvas-body">
				 <a data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">
				    <p style="font-weight: bold; text-transform: uppercase;"> 사용자 관리</p>
				  </a>
				 <ul class="collapse show" id="collapse1">
					  <li><a href="<%=tPath%>/주소" target="content">1</a></li>
					  <li><a href="<%=tPath%>/주소" target="content">2</a></li>
					  <li><a href="<%=tPath%>/주소" target="content">3</a></li>
				 </ul>
				 <a data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
				   	<p style="font-weight: bold; text-transform: uppercase;">기준정보관리</p>
				 </a>
				 <ul class="collapse show" id="collapse2">
					  <li><a href="<%=tPath%>/주소" target="content">1</a></li>
					  <li><a href="<%=tPath%>/주소" target="content">2</a></li>
					  <li><a href="<%=tPath%>/주소" target="content">3</a></li>
				 </ul>
				 <a data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
				    <p style="font-weight: bold; text-transform: uppercase;">품질 검사</p>
				 </a>
				 <ul class="collapse show" id="collapse3">
					  <li><a href="<%=tPath%>/QC/list.jsp" target="content">품질 관리</a></li>
					  <li><a href="<%=tPath%>/monitoring.jsp" target="content">모니터링</a></li>
				 </ul>
				 <a data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
				   	<p style="font-weight: bold; text-transform: uppercase;">데이터전송</p>
				 </a>
				 <ul class="collapse show" id="collapse4">
					  <li><a href="<%=tPath%>/download_csv.jsp" target="content">에러데이터 다운</a></li>
					  <li><a href="<%=tPath%>/add_data.jsp" target="content">데이터 삽입</a></li>
					  <li><a href="<%=tPath%>/주소" target="content">3</a></li>
				 </ul>
		  </div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
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