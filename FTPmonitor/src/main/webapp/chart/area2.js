// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Area Chart Example
function chartErrorLogs(pname, eptot) {
    var labels = [];
    var datas = [];
    for (var i = 0; i < productEpdata.length; i++) {
        labels.push(productEpdata[i].pname); // 제품명 값을 labels 배열에 추가
        datas.push(productEpdata[i].eptot); // 에러 수량 값을 datas 배열에 추가
    }
	var ctx = document.getElementById("myAreaChart2");
	var myLineChart = new Chart(ctx, {
	  type: 'line',
	  data: {
	    labels: labels,
	    datasets: [{
	      label: "Sessions",
	      lineTension: 0.3,
	      backgroundColor: "rgba(2,117,216,0.2)",
	      borderColor: "rgba(2,117,216,1)",
	      pointRadius: 5,
	      pointBackgroundColor: "rgba(2,117,216,1)",
	      pointBorderColor: "rgba(255,255,255,0.8)",
	      pointHoverRadius: 5,
	      pointHoverBackgroundColor: "rgba(2,117,216,1)",
	      pointHitRadius: 50,
	      pointBorderWidth: 2,
	      data: datas,
	    }],
	  },
	  options: {
	    scales: {
	      xAxes: [{
	        time: {
	          unit: 'date'
	        },
	        gridLines: {
	          display: false
	        },
	        ticks: {
	          maxTicksLimit: 7
	        }
	      }],
	      yAxes: [{
	        ticks: {
	          min: 0,
	          max: Math.max(...datas), // 데이터 중 최대값을 y축 최대값으로 설정
	          maxTicksLimit: 3
	        },
	        gridLines: {
	          color: "rgba(0, 0, 0, .125)",
	        }
	      }],
	    },
	    legend: {
	      display: false
	    }
	  }
	});
}