<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(function() {
	function syncTooltip(renderTo, p) {
		var syncWith = ["result", "srm_process", "srm_memory", "srm_network", "srm_diskUsage", "srm_diskIO"];
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
	
	var cpu_chart;
	
	cpu_chart = {
		chart: {
			renderTo: "${_wid}_srm_CPU_chart",
		    zoomType: "x",
		    spacingRight: 20
		},
		title: {
		    text: "CPU Usage"
		},
		subtitle: {
		    text: document.ontouchstart === undefined ? "Click and drag in the plot area to zoom in" : "Drag your finger over the plot to zoom in"
		},
		credits : {
			enabled : false
		},
		xAxis: {
		    title: {
		        text: null
		    }
		},
		yAxis: {
			min: 0,
			max: 100,
		    title: {
		        text: "CPU Usage (%)"
		    },
		    startOnTick: false,
		    showFirstLabel: false
		},
		tooltip: {
            crosshairs: {
                width: 2,
                color: "gray",
                dashStyle: "shortdot"
            },
            formatter: function() {
            	console.log(this);
            	
            	return '<span style="color:' + this.series.color + ';">' + this.series.name + '</span>:  ' + '<b>' + this.point.y + '</b>' + ' %';
            }
		},
		legend: {
		    enabled: false
		},
		plotOptions: {
		    area: {
		        fillColor: {
		            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
		            stops: [
		                [0, "#FF0000"],
		                [1, "rgba(2,0,0,0)"]
		            ]
		        },
		        lineWidth: 1,
		        marker: {
		            enabled: false,
		            states: {
		                hover: {
		                    enabled: true,
		                    radius: 5
		                }
		            }
		        },
		        shadow: false,
		        states: {
		            hover: {
		                lineWidth: 1
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
		series: [{
			type: "area"
		}]
	};
	
	$.ajax({
		url: "${params.asyncUri}",
		data: {TC_IDX:"${params.TC_IDX}"},
		type: "post",
		dataType: "json",
		async: false,
		success : function(_response) {
			$.extend(cpu_chart.series[0], {
				name: "CPU Usage", 
				data: getArrayValues(_response, [{key:"SEQ", series:"x"}, {key:"USAGE", series:"y"}], true)
			});
			var cc = new Highcharts.Chart(cpu_chart);
			$("#${_wid}_srm_CPU_chart").data("chart", cc);
		}
	});
});
</script>
<div id="${_wid}_srm_CPU_chart"></div>
