<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(function() {
	function syncTooltip(renderTo, p) {
		var syncWith = ["result", "srm_CPU", "srm_process", "srm_network", "srm_diskUsage", "srm_diskIO"];
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
	
	var memory_chart;
	
	memory_chart = {
		chart: {
		    renderTo: "${_wid}_srm_memory_chart",
		    zoomType: "xy",
		    type: "area"
		},
		title: {
		    text: "Memory Usage",
		    x: -20 //center
		},
		subtitle: {
		    text: document.ontouchstart === undefined ? "Click and drag in the plot area to zoom in" : "Drag your finger over the plot to zoom in"
		},
		credits : {
			enabled : false
		},
		yAxis: {
			//min: 0,
		    title: {
		        text: "Memory Usage (kB)"
		    }
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
					s.push('<span style="color:' + point.series.color + ';">' + point.series.name + '</span>:  ' + '<b>' + point.y + '</b>' + ' kB');
				});
				return s.join("<br/>");
			}
		},
		plotOptions: {
            area: {
                marker: {
                    enabled: false,
                    symbol: "circle",
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            },
			series: {
	            point: {
	                events: {
	                    mouseOver: function(){
	                        syncTooltip(this.series.chart.renderTo, this.x);
	                    }
	                }
	            }
			}
        },
		legend: {
	        backgroundColor: "#FFFFFF"
		},
		series: [{
			color: "#A600FF"
		}]
	};
	
	$.ajax({
		url: "${params.asyncUri}",
		data: {TC_IDX:"${params.TC_IDX}"},
		type: "post",
		dataType: "json",
		async: false,
		success : function(_response) {
			
			
			var xxx = getArrayValues(_response, [{key:"SEQ", series:"x"}, {key:"USAGE", series:"y"}], true);
			
			var arr = [];
			$.each(xxx, function() {
				arr.push("{x:" + this.x + ", y:" + this.y + "}");
			});
			
			//console.log(arr.join(",").toString());
			
			
			$.extend(memory_chart.series[0], {
				name: "Memory Usage", 
				data: getArrayValues(_response, [{key:"SEQ", series:"x"}, {key:"USAGE", series:"y"}], true)
			});
			
			memory_chart.series[1] = {
				name: "Memory Total", 
				data: getArrayValues(_response, [{key:"SEQ", series:"x"}, {key:"MEMORY_TOTAL", series:"y"}], true), 
				type:"line",
				marker: {
                	enabled: false,
                	radius: 1
                },
                color: "#FF0000"
			};
			
			var cc = new Highcharts.Chart(memory_chart);
			$("#${_wid}_srm_memory_chart").data("chart", cc);
			
			
			
			//console.log(cc.series);
		}
	});
});
</script>
<div id="${_wid}_srm_memory_chart"></div>
