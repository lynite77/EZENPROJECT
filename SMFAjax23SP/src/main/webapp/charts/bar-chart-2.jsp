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
    		var _num=$("#t_num").val();
    		var _max=$("#t_max").val();
    		
    		if(_num == '' || _max == '') {
   	 			alert("항목수나 최대값을 입력하세요");
   	 			return;
    		}

    		$.ajax({
       			type:"post",
       			async:false,  
       			url:"http://localhost:8584/SMFAjax23SP/chart2",
       			data: { num:_num, max: _max },
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
  		//--------------------------------------------------------
  		var autoChart = null;
  		function fn_start() {
  			autoChart = setInterval(fn_chart, 3000);
  		}
  		
  		function fn_stop() {
  			if(autoChart != null) {
  				clearInterval(autoChart);
  				autoChart = null;
  			}
  			
  		}
  		//--------------------------------------------------------
	</script>
	  	
</head>
	
<body style="height: 90%; margin: 10px">
	<div>
		<label>항목수: <input type="text" id="t_num" value="7"/></label><br>
		<label>최대값: <input type="text" id="t_max" value="200"/></label><br>
	   	<button type="button" id="fnchart" onClick="fn_chart()">바차트</button>
	   	<button type="button" id="fnchart" onClick="fn_start()">자동시작</button>
	   	<button type="button" id="fnchart" onClick="fn_stop()">자동종료</button>
	   	<div id="message"></div>
   	</div>

	<div id="container" style="height: 80%"></div>

</body>
</html>