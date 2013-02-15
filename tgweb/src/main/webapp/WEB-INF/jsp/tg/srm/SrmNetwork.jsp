<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(function() {
	function syncTooltip(renderTo, p) {
		var syncWith = ["result", "srm_CPU", "srm_process", "srm_memory", "srm_diskUsage", "srm_diskIO"];
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

	
	
	var network_chart;
	
	network_chart = {
		chart: {
		    renderTo: "${_wid}_srm_network_chart",
		    zoomType: "xy",
		    type: "line"
		},
		title: {
		    text: "Network Traffic",
		    x: -20 //center
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
		        text: "Network Traffic (kbps)"
		    },
		    plotLines: [{
		        value: 0,
		        width: 1,
		        color: "#808080"
		    }]
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
					s.push('<span style="color:' + point.series.color + ';">' + point.series.name + '</span>:  ' + '<b>' + point.y + '</b>' + ' kbps');
				});
				return s.join("<br/>");
			}
		},
		plotOptions: {
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
		series: []
	};
	
	var getArrayValues = function(objArr, whatKeyArr, isNum) {
		var values = [];
		
		var retObj = {};
		// _response iteration
		$.each(objArr, function(i) {
			
			// _response key iteration
			for (var key in this) {
				var _this = this;
				
				// whatKey iteration
				$.each(whatKeyArr, function() {
					
					if (!retObj[this.name]) {
						retObj[this.name] = [];
					}
					
					var r = retObj[this.name];
					// whatKey data iteration
					$.each(this.data, function() {
						if (key === this.key) {
							var _obj = {};
							_obj[this.series] = (isNum ? parseFloat(_this[key]) : _this[key]);
							
							if (r[i]) {
								$.extend(r[i], _obj);
							} else {
								r.push(_obj);
							}
						}
					});
				});
			}
		});
		
		var retArr = [];
		for (var key in retObj) {
			var _obj = {name: key};
			$.extend(_obj, {data: retObj[key]});
			
			retArr.push(_obj);
		}
		
		return retArr;
	};
	
	
	$.ajax({
		url: "${params.asyncUri}",
		data: {TC_IDX:"${params.TC_IDX}"},
		type: "post",
		dataType: "json",
		async: false,
		success : function(_response) {
			network_chart.series = getArrayValues(_response,  
									[{
										name:"IN",
										data:[{
											key:"SEQ", 
											series:"x"
										}, {
											key:"IN_TRAFFIC",
											series:"y"
										}]
										
									}, {
										name:"OUT",
										data:[{
											key:"SEQ", 
											series:"x"
										}, {
											key:"OUT_TRAFFIC",
											series:"y"
										}]
									}], true);
			var cc = new Highcharts.Chart(network_chart);
			$("#${_wid}_srm_network_chart").data("chart", cc);
		}
	});
});
</script>
<div id="${_wid}_srm_network_chart"></div>
