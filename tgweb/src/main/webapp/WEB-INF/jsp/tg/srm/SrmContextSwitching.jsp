<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<script type="text/javascript" src="/javascript/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/javascript/jquery/plugin/highcharts/highcharts.js"></script>
<script type="text/javascript">
$(function() {
	var chart = {
		chart: {
			renderTo: "container",
			type: "scatter",
			zoomType: "xy",
	        events: {
	            selection: function(e) {
	            	console.log(e);
	            }
	        }
		},
		credits : {
			enabled: false
		},
		tooltip: {
			crosshairs: [true, true]
		},
        plotOptions: {
            series: {
                marker: {
                	radius: 1.5
                	, symbol: "circle"
                }
            }
        },
        yAxis: {
        	categories: [],
            gridLineWidth: 0
        }
	};
	
	var getValues = function(objArr, whatKey, isNum) {
		var values = [];
		
		$.each(objArr, function() {
			for (var key in this) {
				if (key === whatKey) {
					values.push(isNum ? parseFloat(this[key]) : this[key]);
				}
			}
		});
		
		return values;
	};
	
	var getArrayValues = function(objArr, groupBy, whatKeyArr, isNum) {
		var data = {};
		
		$.each(objArr, function() {
			var dataObj = {}, groupByValue;
			
			for (var key in this) {
				var _this = this;
				$.each(whatKeyArr, function() {
					if (key === this.key) {
						dataObj[this.series] = (isNum ? parseFloat(_this[key]) : _this[key]);
					}
				});
				
				if (key === groupBy) {
					groupByValue = _this[key];
				}
			}
			if (!data[groupByValue]) {
				data[groupByValue] = [];
			}
			data[groupByValue].push(dataObj);
		});
		
		console.log(data);
		
		var res = [];
		for (var key in data) {
			res.push({name:key, data:data[key]});
		}
		return res;
	};
	
	$.ajax({
		url: "/tgSrm.do?method=cs",
		data: {TC_IDX:"7A2CD849176311E2A70A14DAE9EA355F"},
		type: "post",
		dataType: "json",
		async: false,
		success : function(_response) {
			console.log(_response);
			
			var res = getArrayValues(_response, "PNAME", [{key:"TICK_COUNT", series:"x"}, {key:"PID_RANK", series:"y"}]);
			
			var categories = getValues(res, "name");
			console.log("categories", categories);
			chart.yAxis.categories = categories;

			chart.series = res;
			
			console.log(res);
			
			new Highcharts.Chart(chart);
		}
	});
});
</script>
<div id="container" style="width:1600px; height:900px;"></div>