<script type="text/javascript">
var transform = {data: []};

$.extend(transform, data.rows[0]);
for (var i = 0; i < data.rows.length; i++) {
	transform.data.push([data.rows[i].SEQ, parseInt(data.rows[i].F_COUNT)]);
}

masterChart.series[0] = transform;
masterChart.series[0].type = "area";

masterChart.xAxis.plotBands[0].to = transform.data.length > 50 ? transform.data.length - 50 : 0;

var $container = $("#${_wid}_charting").css('position', 'relative');
var $detailContainer = $("<div id='${_wid}_detailContainer'>").css({"margin-left": "300px"}).appendTo($container);
var $masterContainer = $("<div id='${_wid}_masterContainer'>").css({position : "absolute", top : 270, height : 110, "margin-left": "300px", width : $detailContainer.css("width")}).appendTo($container);

chart = new Highcharts.Chart(masterChart);
createDetail(masterChart);




	var masterChart, detailChart;
	var standardFrame = parseInt("${params.EXTRA5}");
	var tolerance = parseInt("${params.EXTRA13}");
	var underFlow = standardFrame - tolerance;
	var overFlow = standardFrame + tolerance;
	masterChart = {
		maskFlagValue : 0,
		chart : {
			renderTo : "${_wid}_masterContainer",
			reflow : false,
			borderWidth : 0,
			backgroundColor : null,
			marginLeft : 50,
			marginRight : 20,
//			width : 1100,
			zoomType : "x",
			events : {
				selection : function(event) {
					var extremesObject = event.xAxis[0], min = extremesObject.min, max = extremesObject.max, detailData = [], xAxis = this.xAxis[0];
					var xMax = this.series[0].data[this.series[0].data.length - 1].x;
					$.each(this.series[0].data, function(i, point) {
						if (point.x > min && point.x < max) {
							if (point.y <= underFlow) {
								detailData.push({
									x : point.x,
									y : point.y,
									color: "#ED561B",
						            marker: {
						                fillColor: "#ED561B",
						                radius : 3,
						                states : {
											hover : {
												enabled : true,
												radius : 2,
												fillColor: "#ED561B",
								                lineColor: null
											}
						                }
									}
								});
							} else {
								detailData.push({
									x : point.x,
									y : point.y
								});
							}
						}
					});

					xAxis.removePlotBand("${_wid}_mask-before");
					xAxis.addPlotBand({
						id : "${_wid}_mask-before",
						from : 0,
						to : min,
						color : Highcharts.theme.maskColor || "rgba(0, 0, 0, 0.2)"
					});

					xAxis.removePlotBand("${_wid}_mask-after");
					xAxis.addPlotBand({
						id : "${_wid}_mask-after",
						from : max,
						to : xMax,
						color : Highcharts.theme.maskColor || "rgba(0, 0, 0, 0.2)"
					});

					detailChart.series[0].setData(detailData);

					return false;
				}
			}
		},
		title : {
			text : null
		},
		xAxis : {
			showLastTickLabel : true,
			maxZoom : 10,
			plotBands : [ {
				id : "${_wid}_mask-before",
				from : 0,
				to : 0,
				color : Highcharts.theme.maskColor || "rgba(0, 0, 0, 0.2)"
			} ],
			title : {
				text : '<span style="color:#FF0000">Select an area by dragging across the lower chart</span>'
			}
		},
		yAxis : {
			gridLineWidth : 0,
			labels : {enabled : false},
			title : {text : null},
			min : 0.6,
			showFirstLabel : false
		},
		tooltip : {
			formatter : function() {return false;}
		},
		legend : {
			enabled : false
		},
		credits : {
			enabled : false
		},
		plotOptions : {
			series : {
				fillColor : {
					linearGradient : [ 0, 0, 0, 70 ],
					stops : [[0, highchartsOptions.colors[0]], [1, "rgba(0,0,0,0)"]]
				},
				lineWidth : 1,
				marker : {enabled : false},
				shadow : false,
				states : {hover : {lineWidth : 1}},
				enableMouseTracking : false
			}
		},
		series : [{
			type : "area",
			name : "Frame Rate",
			data : []
		}],
		exporting : {
			enabled : false
		}
	};

	function createDetail(masterChart) {
		var detailData = [], detailStart = masterChart.xAxis.plotBands[0].to;

		$.each(masterChart.series[0].data, function(i, point) {
			if (point[0] >= detailStart) {
				if (point[1] <= underFlow) {
					detailData.push({
						x : point[0],
						y : point[1],
						color: "#ED561B",
			            marker: {
			                fillColor: "#ED561B",
			                radius : 3,
			                //lineColor: "#FF0000"
			                states : {
								hover : {
									enabled : true,
									radius : 2,
									fillColor: "#ED561B",
					                lineColor: null
								}
			                }
						}
					});
				} else {
					detailData.push({
						x : point[0],
						y : point[1]
					});
				}
			}
		});
		
		detailChart = new Highcharts.Chart({
			chart : {
				marginBottom : 150,
				renderTo : "${_wid}_detailContainer",
				reflow : false,
				marginLeft : 50,
				marginRight : 20,
//				width : 1100,
				style : {
					position : "absolute"
				}
			},
			credits : {
				enabled : false
			},
			title : {
				text : "${params.MODEL} (${params.FW_VERSION}ver) - Frame Rate"
			},
			subtitle : {
				text : 'Tolerance:<span style="color:#C77405">' + masterChart.series[0].TOLERANCE + '</span>, Duration:<span style="color:#C77405">' + masterChart.series[0].TOTALCOUNT + 's</span>, Max Frame:<span style="color:#C77405">' + masterChart.series[0].MAX_FRAME + '</span>, Min Frame:<span style="color:#C77405">' + masterChart.series[0].MIN_FRAME + '</span>, Avg Frame:<span style="color:#C77405">' + masterChart.series[0].AVG_FRAME + '</span>'
			},
			xAxis : {
				type : "linear",
				allowDecimals: false
			},
			yAxis : {
				title : null,
				allowDecimals: false,
				maxZoom : 0.1,
				plotBands: [{
		            color: "#FFD5D5",
		            from: -100,
		            to: underFlow
		        },
		        {
		            color: "#FFD5D5",
		            from: overFlow,
		            to: 9999
		        }, 
		        {
	                color: "#C2FFC9",
	                from: standardFrame - 0.2,
	                to: standardFrame + 0.2
		        }],
				max: overFlow + 1
			},
			tooltip : {
				formatter : function() {
					var point = this.points[0];
					return "<b>" + point.series.name + "</b><br/>" + "Sec : " + this.x + "<br/>" + "Frame : " + point.y;
				},
				shared : true
			},
			legend : {
				enabled : false
			},
			plotOptions : {
				series : {
					marker : {
						radius : 3,
						enabled : true,
						states : {
							hover : {
								enabled : true,
								radius : 2,
								fillColor: null,
				                lineColor: null
							}
						}
					}
				}
			},
			series : [{
				name : "Frame Rate",
				pointStart: detailStart,
				data : detailData
			}],
			exporting: {
				enabled: true,
				enableImages: false,
				filename: "chart",
				url: "cmnExportChart.do?method=chart",
				width: 800
			}

		});
	}
</script>