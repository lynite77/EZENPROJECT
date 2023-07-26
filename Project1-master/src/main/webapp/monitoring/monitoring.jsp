<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="Spring.monitoringDAO" %>
<%@ page import="bean.*" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
        
<%
        monitoringDAO errorLogDAO = new monitoringDAO();
       	List<ErrorLog> errorLogs = errorLogDAO.getAllErrorLogs();
        List<ProductPdata> productPdataList = errorLogDAO.getProductPdata();
        List<ProductEpdata> productEpdataList = errorLogDAO.getProductEpdata();
       	List<Gproduct> products = errorLogDAO.getAllGProducts();
       	
       	int petot = errorLogDAO.getProductPetot();
       	int etot = errorLogDAO.getProductEtot();
       	
       	System.out.printf("[monitoring] petot(%d), etot(%d)\n", petot, etot);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
    <link href="../CSS/styles.css" rel="stylesheet" />
</head>
<body class="maincontent">
    <main>
        <div class="container-fluid px-4">
            <h1 class="mt-4">종합화면</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Monitoring page</li>
            </ol>
            <div class="row">
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-primary text-white mb-4">
                        <div class="card-body">
                            <h3>생산실적</h3>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link">
							    <h4><%= petot %></h4>
                            </a>
                            <div class="small text-white">
                                <i class="fas fa-angle-right"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-danger text-white mb-4">
                        <div class="card-body">
                            <h3>부적합현황</h3>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link">
							    <h4><%= etot %></h4>
                            </a>
                            <div class="small text-white">
                                <i class="fas fa-angle-right"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-success text-white mb-4">
                        <div class="card-body">
                            <h3>검수품목명</h3>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link">
                                <!-- 여기는 작업지시 대표명 가져오는걸로 -->
                                <h4>여름옷</h4>
                            </a>
                            <div class="small text-white">
                                <i class="fas fa-angle-right"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <!-- 유튜브 영상 자동재생으로 걸어놓음 -->
                    <!--  <iframe width="560" height="315" src="https://www.youtube.com/embed/e1t5w1vl16Y?autoplay=1&mute=1&controls=0&loop=1&playlist=e1t5w1vl16Y" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe> -->
                    <img src="../images/WuQO.gif" alt="WuQO.gif">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-chart-pie me-1"></i>
                            생산률
                        </div>
                        <div class="card-body">
                            <canvas id="myPieChart" width="100%" height="50"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-xl-6">
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-chart-bar me-1"></i>
                            생산 진척사항
                        </div>
                        <div class="card-body">
                            <canvas id="myBarChart" width="100%" height="50"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-xl-6">
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-chart-area me-1"></i>
                            제품별 생산현황
                        </div>
                        <div class="card-body">
                            <canvas id="myAreaChart1" width="100%" height="40"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-xl-6">
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-chart-area2 me-1"></i>
                            제품별 불량현황
                        </div>
                        <div class="card-body">
                            <canvas id="myAreaChart2" width="100%" height="40"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card mb-4">
			    <div class="card-header">
			        <i class="fas fa-table me-1"></i>
			        <label for="status-select">현황 선택:</label>
			        <select id="status-select" onchange="changeStatus()">
			            <option value="error">시간대별 불량현황</option>
			            <option value="good">시간대별 양품현황</option>
			        </select>
			    </div>
    			<div class="card-body" id="error-table">
    			<table id="datatablesSimple">
            		<thead>
                		<tr>
		                    <th>제품코드</th>
		                    <th>제품명</th>
		                    <th>에러코드</th>
		                    <th>에러명</th>
		                    <th>에러수량</th>
		                    <th>에러발생시기</th>
		                </tr>
		            </thead>
		            <tfoot>
		                <tr>
		                    <th>제품코드</th>
		                    <th>제품명</th>
		                    <th>에러코드</th>
		                    <th>에러명</th>
		                    <th>에러수량</th>
		                    <th>에러발생시기</th>
		                </tr>
		            </tfoot>
		            <tbody>
		                <% 
		                for (ErrorLog errorLog : errorLogs) {
		                %>
		                <tr>
		                    <td><%= errorLog.getProductCode() %></td>
		                    <td><%= errorLog.getProductName() %></td>
		                    <td><%= errorLog.getErrorCode() %></td>
		                    <td><%= errorLog.getErrorName() %></td>
		                    <td><%= errorLog.getErrorQuantity() %></td>
		                    <td><%= errorLog.getErrorDate() %></td>
		                </tr>
		                <% 
		                }
		                %>
		            </tbody>
		        </table>
		    </div>

		    <div class="card-body" id="good-table" style="display: none;">
		        <table id="datatablesSimple">
		            <thead>
		                <tr>
		                    <th>제품코드</th>
		                    <th>제품명</th>
		                    <th>제품색상</th>
		                    <th>제품사이즈</th>
		                    <th>제품길이</th>
		                    <th>제품가격</th>
		                    <th>제품정보</th>
		                </tr>
		            </thead>
		            <tfoot>
		                <tr>
		                    <th>제품코드</th>
		                    <th>제품명</th>
		                    <th>제품색상</th>
		                    <th>제품사이즈</th>
		                    <th>제품길이</th>
		                    <th>제품가격</th>
		                    <th>제품정보</th>
		                </tr>
		            </tfoot>
		            <tbody>
		                <% for (Gproduct gproduct : products) { %>
		                <tr>
		                    <td><%= gproduct.getProductCode() %></td>
		                    <td><%= gproduct.getProductName() %></td>
		                    <td><%= gproduct.getProductColor()%></td>
		                    <td><%= gproduct.getProductSize()%></td>
		                    <td><%= gproduct.getProductLength()%></td>
		                    <td><%= gproduct.getProductPrice()%></td>
		                    <% String productInfo = gproduct.getProductInfo();
		                    String badgeStyle = "badge-success";
		                    if ("라운드넥".equals(productInfo)) {
		                        badgeStyle = "badge-danger";
		                    }
		                    %>
		                    <td><span class="badge <%= badgeStyle %> w-75 py-2"><%= productInfo %></span></td>
		                </tr>
		                <% 
		                }
		                %>
		            </tbody>
		        </table>
		    </div>
		</div>
    </div>
    </main>
    <script src="../chart/area1.js"></script>
    <script src="../chart/area2.js"></script>
    <script src="../chart/bar.js"></script>
    <script src="../chart/pie.js"></script>
    <script src="../js/datatables.js"></script>
    <script>    	
		// 10초마다 새로고침
		setInterval(function() {
		   	location.reload();
		}, 60000);

		var petot = <%=petot%>;
		var etot = <%=etot%>;
		var tot = petot + <%=etot%>;
		
		// pie 차트
		chartpercent(petot, etot);
		// bar 차트
		chartProductPetotEtot(tot, petot);
    	
    	// area1 차트
    	var productPdata = [
            <%
            	for (ProductPdata pdata : productPdataList) { 
            %>
                {
                    pname: '<%= pdata.getPname() %>',
                    ptot: <%= pdata.getPtot() %>
                },
            <% } %>
        ];
    	chartProductPdata(productPdata);
        
        // area2 차트        
		var productEpdata = [
            <%
            	for (ProductEpdata epdata : productEpdataList) { 
            %>
                {
                    pname: '<%= epdata.getPname() %>',
                    eptot: <%= epdata.getEptot() %>
                },
            <% } %>
        ];
        chartErrorLogs(productEpdata);
        

        // Call the function initially to show the "시간대별 불량현황" table by default
        function changeStatus() {
            const selectedOption = document.getElementById("status-select").value;
            const errorTable = document.getElementById("error-table");
            const goodTable = document.getElementById("good-table");

            if (selectedOption === "error") {
                errorTable.style.display = "block";
                goodTable.style.display = "none";
            } else if (selectedOption === "good") {
                errorTable.style.display = "none";
                goodTable.style.display = "block";
            }
        }

        changeStatus()
    </script>
</body>
</html>