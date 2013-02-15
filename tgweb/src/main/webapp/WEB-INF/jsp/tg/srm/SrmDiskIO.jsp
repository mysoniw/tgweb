<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(function() {
	function syncTooltip(renderTo, p) {
		var syncWith = ["result", "srm_CPU", "srm_process", "srm_memory", "srm_network", "srm_diskUsage"];
		var data = [];
		
		$.each(syncWith, function() {
			var $container = $("#${_wid}_" + this + "_chart").data();
			if ($container !== null) {
				data = $container.chart.series[0].data;
				
				for (var i = 0, size = data.length; i < size; i++) {
					if (data[i].x === p) {
						var _data;
						if ($container.chart.series.length > 1) {
							_data = [];
							for (var j = 0, _size = $container.chart.series.length; j < _size; j++) {
								if ($container.chart.series[j].visible) {
									_data.push($container.chart.series[j].data[i]);
								}
							}
						} else {
							_data = data[i];
						}
						$container.chart.tooltip.refresh(_data);
					}
				}
			}
		});
	}
	
	var diskIO_chart;
	
	diskIO_chart = {
	    chart: {
	        renderTo: "${_wid}_srm_diskIO_chart",
	        zoomType: "xy",
	        type: "line"
	    },
	    title: {
	        text: "Disk IO"
	    },
		subtitle: {
		    text: document.ontouchstart === undefined ? "Click and drag in the plot area to zoom in" : "Drag your finger over the plot to zoom in"
		},
		credits : {
			enabled : false
		},
	    yAxis: {
	        min: 0,
	        title: {
	            text: "Disk IO (kB/s)"
	        }
	    },
	    legend: {
	        backgroundColor: "#FFFFFF"
	    },
		tooltip: {
			shared: true,
            crosshairs: {
                width: 2,
                color: "gray",
                dashStyle: "shortdot"
            },
			formatter: function() {
				var s = [this.x];
				
				$.each(this.points, function(i, point) {
					s.push('<span style="color:' + point.series.color + ';">' + point.series.name + '</span>:  ' + '<b>' + point.y + '</b>' + ' kB/s');
				});
				return s.join("<br/>");
			}
		},
	    credits: {
	        enabled: false
	    },
	    plotOptions: {
	        series: {
	            point: {
	                events: {
	                    mouseOver: function() {
	                        syncTooltip(this.series.chart.renderTo, this.x);
	                    }
	                }
	            }
	        }
	    },
		series: []
	};
	
	var getArrayValues = function(objArr, groupBy, whatKeyArr, isNum, postFix) {
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
		
		var res = [];
		for (var key in data) {
			res.push({name:key + (postFix ? " " + postFix : ""), data:data[key]});
		}
		
		return res;
	};
	
	
	$.ajax({
		url: "${params.asyncUri}",
		data: {TC_IDX:"${params.TC_IDX}"},
		type: "post",
		dataType: "json",
		async: false,
		success : function(_response) {
			var readArr = getArrayValues(_response, "DISK_NAME", [{key:"SEQ", series:"x"}, {key:"DISK_READ", series:"y"}], true, "read");
			var writeArr = getArrayValues(_response, "DISK_NAME", [{key:"SEQ", series:"x"}, {key:"DISK_WRITE", series:"y"}], true, "write");
			
			diskIO_chart.series = readArr.concat(writeArr);
			var cc = new Highcharts.Chart(diskIO_chart);
			$("#${_wid}_srm_diskIO_chart").data("chart", cc);
		}
	});
});
</script>
<div id="${_wid}_srm_diskIO_chart"></div>
