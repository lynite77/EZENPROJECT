<%@ page contentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="en" style="height: 100%">
<head>
	<meta charset="utf-8">
	<script type="text/javascript" src="js/jquery-1.12.4.js"></script>
  	<script type="text/javascript" src="js/echarts.min.js"></script>
  	
  	<script type="text/javascript">
  		function barChart(vals) {
		    var dom = document.getElementById('container');
		    var myChart = echarts.init(dom, null, {
		      renderer: 'canvas',
		      useDirtyRect: false
		    });
		    
		    var app = {};
		    
		    var option;
		
		    option = { // json object
		      xAxis: {
		        type: 'category',
		        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
		      },
		      yAxis: {
		        type: 'value'
		      },
		      series: [
		        {
		          data: vals,
		          type: 'bar',
		          showBackground: true,
		          backgroundStyle: {
		            color: 'rgba(180, 180, 180, 0.2)'
		          }
		        } 
		      ]
		    }; // option
		
		    if (option && typeof option === 'object') {
		      myChart.setOption(option);
		    }
		
		    window.addEventListener('resize', myChart.resize);
  		}

  		//--------------------------------------------------------
 		function fn_chart() {
    		$.ajax({
       			type:"post",
       			async:false,  
       			url:"http://localhost:8584/SMFAjax23SP/chart",
       			success:function (data,textStatus) {
       				var jsonVals = JSON.parse(data);
       				// alert(jsonVals);
       				barChart(jsonVals);
       			},
       			error:function(data,textStatus){
          			alert("에러발생: " + data);
       			},
       			complete:function(data,textStatus){
          			// alert("수신완료");
       			}
    		});	 
 		}		
	</script>
	  	
</head>
	
<body style="height: 90%; margin: 10px">
	<div>
	   	<button type="button" id="fnchart" onClick="fn_chart()">바차트</button>
	   	<div id="message"></div>
   	</div>

	<div id="container" style="height: 80%"></div>

</body>
</html>