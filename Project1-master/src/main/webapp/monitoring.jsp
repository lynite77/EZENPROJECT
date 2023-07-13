<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monitoring</title>
    <link href="./styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
	    function openPopup() {
	        window.open("add_data.jsp", "_blank", "width=500,height=400");
	    }
	    
	    $(document).ready(function() {
	        // 페이지 로드 후 10초마다 새로고침
	        setInterval(function() {
	            location.reload();
	        }, 10000);
	        
	        $("#addDataButton").click(function() {
	            openPopup();
	        });
	    });
    </script>
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
                                <% 
	                            try {
	                                // 드라이버 로딩
	                                Class.forName("oracle.jdbc.driver.OracleDriver");
	                                
	                                // 데이터베이스 연결 설정
	                                Context context = new InitialContext();
	                                DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/your_datasource_name");
	                                Connection connection = dataSource.getConnection();
	                                
	                             	// 데이터 조회
	                                Statement statement = connection.createStatement();
	                                ResultSet resultSet = statement.executeQuery("SELECT SUM(PTOT) as PETOT FROM (SELECT DISTINCT P_NAME, COUNT(*) OVER(PARTITION BY P_NAME) as PTOT FROM PRODUCT WHERE P_NAME IN ('여름 반팔A','여름 반팔B', '여름 반팔C'))");
	                                				 	                                				 
	                                // 결과 처리
	                                while (resultSet.next()) {
	                                	int PETOT = resultSet.getInt("PETOT");
		                    	%>
									<h4><%= PETOT %></h4>
            	                <% 
                                }
                                
                                // 연결 및 리소스 정리
                                resultSet.close();
                                statement.close();
                                connection.close();
                            } catch (Exception e) {
                                out.println("오류 발생: " + e.getMessage());
                                e.printStackTrace();
                            }
                            %>
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
                            	<% 
	                            try {
	                                // 드라이버 로딩
	                                Class.forName("oracle.jdbc.driver.OracleDriver");
	                                
	                                // 데이터베이스 연결 설정
	                                Context context = new InitialContext();
	                                DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/your_datasource_name");
	                                Connection connection = dataSource.getConnection();
	                                
	                             	// 데이터 조회
	                                Statement statement = connection.createStatement();
	                                ResultSet resultSet = statement.executeQuery("SELECT SUM(ERROR_COUNT) as ETOT FROM ERROR_LOG");
									
	                                // 결과 처리
	                                while (resultSet.next()) {
	                                	int ETOT = resultSet.getInt("ETOT");
		                    	%>
									<h4><%= ETOT %></h4>
            	                <% 
                                }
                                
                                // 연결 및 리소스 정리
                                resultSet.close();
                                statement.close();
                                connection.close();
                            } catch (Exception e) {
                                out.println("오류 발생: " + e.getMessage());
                                e.printStackTrace();
                            }
                            %>
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
                    <iframe width="560" height="315" src="https://www.youtube.com/embed/e1t5w1vl16Y?autoplay=1&mute=1&controls=0&loop=1&playlist=e1t5w1vl16Y" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
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
                        <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                    </div>
                </div>
                <div class="col-xl-6">
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-chart-bar me-1"></i>
                            생산 진척사항
                        </div>
                        <div class="card-body">
                            <canvas id="myBarChart" width="100%" height="40"></canvas>
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
                    시간대별 불량현황
                </div>
                <div class="card-body">
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
                            try {
                                // 드라이버 로딩
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                
                                // 데이터베이스 연결 설정
                                Context context = new InitialContext();
                                DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/your_datasource_name");
                                Connection connection = dataSource.getConnection();
                                
                             	// 데이터 조회
                                Statement statement = connection.createStatement();
                                ResultSet resultSet = statement.executeQuery("SELECT * FROM ERROR_LOG");
								
                                // 결과 처리
                                while (resultSet.next()) {
		                            String productCode = resultSet.getString("P_CODE");
		                            String productName = resultSet.getString("P_NAME");
		                            String errorCode = resultSet.getString("E_CODE");
		                            String errorName = resultSet.getString("E_NAME");
		                            int errorQuantity = resultSet.getInt("ERROR_COUNT");
		                            String errorDate = resultSet.getString("ERROR_DATE");
		                    %>
                                    <tr>
                                        <td><%= productCode %></td>
                                        <td><%= productName %></td>
                                        <td><%= errorCode %></td>
                                        <td><%= errorName %></td>
                                        <td><%= errorQuantity %></td>
                                        <td><%= errorDate %></td>
                                    </tr>
            	                <% 
                                }
                                
                                // 연결 및 리소스 정리
                                resultSet.close();
                                statement.close();
                                connection.close();
                            } catch (Exception e) {
                                out.println("오류 발생: " + e.getMessage());
                                e.printStackTrace();
                            }
                            %>
                        </tbody>
                    </table>
                </div>
        <!-- "Add Data" 버튼 -->
        <button onclick="openPopup()">Add Data</button>
        <a href="download_csv.jsp" class="btn btn-primary">Download CSV</a>
            </div>
        </div>
    </main>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="chart/area1.js"></script>
    <script src="chart/area2.js"></script>
    <script src="chart/bar.js"></script>
    <script src="chart/pie.js"></script>
    <script src="chart/datatable.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="js/datatables.js"></script>
</body>
</html>