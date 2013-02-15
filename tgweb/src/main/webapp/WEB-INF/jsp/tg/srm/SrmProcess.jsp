<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(function() {
	function syncTooltip(renderTo, p) {
		var syncWith = ["result", "srm_CPU", "srm_memory", "srm_network", "srm_diskUsage", "srm_diskIO"];
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
	
	var process_chart;
	
	process_chart = {
		chart: {
		    renderTo: "${_wid}_srm_process_chart",
		    zoomType: "xy",
		    type: "area"
		},
		title: {
		    text: "Process Usage",
		    x: -20 //center
		},
		subtitle: {
		    text: document.ontouchstart === undefined ? "Click and drag in the plot area to zoom in" : "Drag your finger over the plot to zoom in"
		},
		credits : {
			enabled : false
		},
		legend: {
	        backgroundColor: "#FFFFFF"
		},
		yAxis: {
			min: 0,
			max: 100,
		    title: {
		        text: "Process Usage (%)"
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
					s.push('<span style="color:' + point.series.color + ';">' + point.series.name + '</span>:  ' + '<b>' + point.y + '</b>' + ' %');
				});
				return s.join("<br/>");
			}
		},
		plotOptions: {
			series: {
				stacking: "normal",
	            point: {
	                events: {
	                    mouseOver: function(){
	                        syncTooltip(this.series.chart.renderTo, this.x);
	                    }
	                }
	            }
			}
		}
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
		
		
		var res = [];
		for (var key in data) {
			res.push({name:key, data:data[key]});
		}
		
		return res;
	};
	
	(function() {
		var cc;
		$.ajax({
			url: "${params.asyncUri}",
			data: {TC_IDX:"${params.TC_IDX}"},
			type: "post",
			dataType: "json",
			async: false,
			success : function(_response) {
				process_chart.series = getArrayValues(_response, "PID", [{key:"SEQ", series:"x"}, {key:"CPU_USAGE", series:"y"}], true);
				cc = new Highcharts.Chart(process_chart);
				$("#${_wid}_srm_process_chart").data("chart", cc);
			}
		});
		
		var arr = [];
	
		$("#${_wid}_slider").slider({
			value: 0,
			min: 0,
			max: 100,
			step: 5,
			slide: function(event, ui) {
				$("#${_wid}_amount").text(ui.value);
			},
			change: function(event, ui) {
				var criterion = ui.value;
				for (var i = cc.series.length - 1; i >= 0; i--) {
					var res = $.grep(cc.series[i].processedYData, function(n) {
						return n > criterion;
					});
						
					if (res.length === 0) {
						if (cc.series[i].visible)	fnHide(cc.series[i], false);
					} else {
						if (!cc.series[i].visible)	fnHide(cc.series[i], true);
					}
				}
				cc.redraw();
			}
		});

		var slider_value = $("#${_wid}_slider").slider("value");
	    $("#${_wid}_amount").text(slider_value);
		$("#${_wid}_slider").slider("value", slider_value);
	})();
	
	
	
	function fnHide(s, vis) {
		var series = s,
			chart = series.chart,
			legendItem = series.legendItem,
			seriesGroup = series.group,
			seriesTracker = series.tracker,
			dataLabelsGroup = series.dataLabelsGroup,
			markerGroup = series.markerGroup,
			showOrHide,
			i,
			points = series.points,
			point,
			ignoreHiddenSeries = chart.options.chart.ignoreHiddenSeries,
			oldVisibility = series.visible;
		
		// if called without an argument, toggle visibility
		series.visible = vis = vis === undefined ? !oldVisibility : vis;
		showOrHide = vis ? 'show' : 'hide';

		// show or hide series
		if (seriesGroup) { // pies don't have one
			seriesGroup[showOrHide]();
		}
		if (markerGroup) {
			markerGroup[showOrHide]();
		}
		
		// show or hide trackers
		if (seriesTracker) {
			seriesTracker[showOrHide]();
		} else if (points) {
			i = points.length;
			while (i--) {
				point = points[i];
				if (point.tracker) {
					point.tracker[showOrHide]();
				}
			}
		}
		
		if (dataLabelsGroup) {
			dataLabelsGroup[showOrHide]();
		}
		if (legendItem) {
			chart.legend.colorizeItem(series, vis);
		}

		// rescale or adapt to resized chart
		series.isDirty = true;
		// in a stack, all other series are affected
		if (series.options.stacking) {
			$.each(chart.series, function (i, otherSeries) {
				if (otherSeries.options.stacking && otherSeries.visible) {
					otherSeries.isDirty = true;
				}
			});
		}
		
		if (ignoreHiddenSeries) {
			chart.isDirtyBox = true;
		}
		//chart.redraw();
	}
});
</script>
<div id="${_wid}_srm_process_chart"></div>
<p style="margin-top:10px; margin-bottom:10px;">
    <label for="${_wid}_amount" style="font-weight:bold;">Exclude: </label>
    <span id="${_wid}_amount" style="border: 0; color: #f6931f; font-weight: bold;"></span>
</p>
<div id="${_wid}_slider"></div>
