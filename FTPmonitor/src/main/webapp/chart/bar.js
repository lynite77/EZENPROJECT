// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

/*
var petot = ErrorLogDAO.getProductPetot();
var etot = ErrorLogDAO.getProductEtot();
var tot = etot + petot;
*/

// Bar Chart 생성
function chartProductPetotEtot(tot, petot) {
	var ctx = document.getElementById("myBarChart");
	var myLineChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
	    labels: ["투입수량", "생산실적"],
	    datasets: [{
	      label: "Revenue",
	      backgroundColor: "rgba(2,117,216,1)",
	      borderColor: "rgba(2,117,216,1)",
	      data: [tot, petot],
	    }],
	  },
	  options: {
	    scales: {
	      xAxes: [{
	        time: {
	          unit: 'week'
	        },
	        gridLines: {
	          display: false
	        },
	        ticks: {
	          maxTicksLimit: 6
	        }
	      }],
	      yAxes: [{
	        ticks: {
	          min: 0,
	          max: 10000,
	          maxTicksLimit: 5
	        },
	        gridLines: {
	          display: true
	        }
	      }],
	    },
	    legend: {
	      display: false
	    }
	  }
	});
}