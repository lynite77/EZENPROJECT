<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	int[] chartVals = new int[7];
	for(int cnt=0; cnt < 7; cnt++) {
		chartVals[cnt] = (int)(Math.random() * 200);
	}
%>

<!DOCTYPE html>
<html lang="en" style="height: 100%">
<head>
	<meta charset="utf-8">
	<script type="text/javascript" src="js/jquery-1.12.4.js"></script>
  	<script type="text/javascript" src="js/echarts.min.js"></script>

  	<script type="text/javascript">
        $(function () { // javascript
  			var vals = [<%
	  			for(int i=0; i < chartVals.length; i++) { // java
	  				out.print(chartVals[i]);
	  				if(i < (chartVals.length - 1)) {
	  					out.print(",");
	  				}
	  			}
	  		%>];
        	barChart(vals);
        });
    </script>

   	<script type="text/javascript">
  		//--------------------------------------------------------
 		function chartRandom() {
  			var vals = [];
  			for(var cnt=0; cnt < 7; cnt++) {
  				vals[cnt] = Math.floor(Math.random() * 200);
  			}
			barChart(vals);
 		}		

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

	</script>
	  	
</head>
	
<body style="height: 90%; margin: 10px">
	<div>
	   	<button type="button" id="fnchart" onClick="chartRandom()">랜덤 바-차트</button>
	   	<div id="message"></div>
   	</div>

	<div id="container" style="height: 80%"></div>

</body>
</html>