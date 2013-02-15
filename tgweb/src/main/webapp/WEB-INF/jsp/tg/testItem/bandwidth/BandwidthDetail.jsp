<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
var data, flag = false;
$(function() {
	function syncTooltip(renderTo, p) {
		var syncWith = ["srm_CPU", "srm_process", "srm_memory", "srm_network", "srm_diskUsage", "srm_diskIO"];
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
	
	$.Topic("dataGrid/xhrComplete/" + "tgBandwidthDetail.do").subscribe(function xhrSub(_data) {
		data = _data;
		
		fnCharting();
		
		$.Topic("dataGrid/xhrComplete/" + "tgBandwidthDetail.do").unsubscribe(xhrSub);
	});
	
	function fnCharting() {
		
		if (data.rows.length <= 1) {
			return null;
		}
		
		if (data.rows.length > 0) {
			if (data.rows[0].hasOwnProperty("START_TIME"))			$("#${_wid}_startTime").text(data.rows[0].START_TIME);
			if (data.rows[0].hasOwnProperty("END_TIME"))			$("#${_wid}_endTime").text(data.rows[0].END_TIME);
			if (data.rows[0].hasOwnProperty("EXECUTION_TIME"))		$("#${_wid}_executionTime").text(data.rows[0].EXECUTION_TIME);
			if (data.rows[0].hasOwnProperty("INSERT_DATE"))			$("#${_wid}_insertDate").text(data.rows[0].INSERT_DATE);
		}

		var download = {data: []};
		
		$.extend(download, data.rows[0]);
		for (var i = 0; i < data.rows.length; i++) {
			//console.debug(data.rows[i]);
			download.data.push([data.rows[i].SEQ_TIME, data.rows[i].DOWNLOAD]);
			
		}
		masterChart.series[0] = download;
		masterChart.series[0].type = "area";
		
		masterChart.xAxis.plotBands[0].to = download.data.length > 50 ? download.data.length - 50 : 0;
		
		var $container = $("#${_wid}_result_chart").css('position', 'relative');
		var $detailContainer = $("<div id='${_wid}_detailContainer'>").appendTo($container);
		var $masterContainer = $("<div id='${_wid}_masterContainer'>").css({position: "absolute", top: 270, height: 110, width: $detailContainer.css("width")}).appendTo($container);
		
		chart = new Highcharts.Chart(masterChart);
		createDetail(masterChart);
		
		
		$("#${_wid}_result_chart").data("chart", chart);
	}
	
	var masterChart, detailChart;

	masterChart = {
		maskFlagValue : 0,
		chart : {
			renderTo : "${_wid}_masterContainer",
			reflow : false,
			borderWidth : 0,
			backgroundColor : null,
			marginLeft : 50,
//			marginRight : 20,
//			width : 1100,
			zoomType : "x",
			events : {
				selection : function(event) {
					var extremesObject = event.xAxis[0], min = extremesObject.min, max = extremesObject.max, detailData = [], xAxis = this.xAxis[0];
					var xMax = this.series[0].data[this.series[0].data.length - 1].x;
					
					$.each(this.series, function(i, series) {
						$.each(series.data, function(j, point) {
							if (point.x > min && point.x < max) {
								detailData.push({
									x : point.x,
									y : point.y
								});
							}
						});
						detailChart.series[i].setData(detailData);
						detailData.length = 0;
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
				text : '<span style="color:#FF0000">Select an area by dragging across the lower chart</span>',
				margin: 20
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
				enableMouseTracking : false,
				point: {
	                events: {
	                    mouseOver: function(){
	                        syncTooltip(this.series.chart.renderTo, this.x);
	                    }
	                }
	            }
			}
		},
		series : [{
			type : "area",
			name : "Traffic",
			data : []
		}],
		exporting : {
			enabled : false
		}
	};

	function createDetail(masterChart) {
		var detailData = [], detailStart = masterChart.xAxis.plotBands[0].to;

		$.each(masterChart.series, function(i, series) {
			detailData[i] = [];
			$.each(series.data, function(j, point) {
				if (point[0] >= detailStart) {
					detailData[i].push({
						x : point[0],
						y : point[1]
					});
				}
			});
		});

		detailChart = new Highcharts.Chart({
			chart : {
				marginBottom : 150,
				renderTo : "${_wid}_detailContainer",
				reflow : false,
				marginLeft : 50,
//				marginRight : 20,
//				width : 1100,
				style : {
					position : "absolute"
				}
			},
			credits : {
				enabled : false
			},
			title : {
				text : "${params.MODEL} (${params.FW_VERSION}ver) - Bandwidth"
			},
			subtitle : {
				text : 'Max Traffic:<span style="color:#C77405">' + masterChart.series[0].MAX_DOWNLOAD + '</span>, Min Traffic:<span style="color:#C77405">' + masterChart.series[0].MIN_DOWNLOAD + '</span>, Avg Traffic:<span style="color:#C77405">' + masterChart.series[0].AVG_DOWNLOAD + '</span>, Dev Traffic:<span style="color:#C77405">' + masterChart.series[0].STDEV_DOWNLOAD + '</span>'
			},
			xAxis : {
				type : "linear",
				allowDecimals: false
			},
			yAxis : {
				title : null,
				allowDecimals: false,
				maxZoom : 0.1
			},
			tooltip : {
				formatter : function() {
					return "<b>" + this.point.series.name + "</b><br/>" + "Seq : " + this.x + "<br/>" + "bps : " + this.y + " (kbps)";
				}
			},
			legend : {
				enabled : true,
				align: 'right',
		        verticalAlign: 'top',
		        x: -15,
		        y: 50,
		        floating: true
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
				name : "Traffic",
				pointStart: detailStart,
				data : detailData[0]
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
});
</script>
<form id="${_wid}_searchForm">
	<input type="hidden" name="TC_IDX" value="${params.TC_IDX}" />
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" name="FW_VERSION" value="${params.FW_VERSION}" />
	<input type="hidden" name="TEST_PROJECT_ID" value="${params.TEST_PROJECT_ID}" />
	<input type="hidden" name="TEST_SUITE_ID" value="${params.TEST_SUITE_ID}" />
	<input type="hidden" name="TEST_CASE_ID" value="${params.TEST_CASE_ID}" />
	<input type="hidden" name="TEST_CASE_NAME" value="${params.TEST_CASE_NAME}" />
	<input type="hidden" name="SUITE_DESCRIPTION" value="${params.SUITE_DESCRIPTION}" />
	<input type="hidden" name="NODE_MAC" value="${params.NODE_MAC}" />
	<input type="hidden" name="NODE_IP" value="${params.NODE_IP}" />
	<input type="hidden" name="CYCLE" value="${params.CYCLE}" />
	<input type="hidden" name="NG" value="${params.RESULT}" />
	<input type="hidden" name="EXTRA1" value="${params.EXTRA1}" />
	<input type="hidden" name="EXTRA2" value="${params.EXTRA2}" />
	<input type="hidden" name="EXTRA3" value="${params.EXTRA3}" />
	<input type="hidden" name="EXTRA4" value="${params.EXTRA4}" />
	<input type="hidden" name="EXTRA5" value="${params.EXTRA5}" />
	<input type="hidden" name="EXTRA6" value="${params.EXTRA6}" />
	<input type="hidden" name="EXTRA7" value="${params.EXTRA7}" />
	<input type="hidden" name="EXTRA8" value="${params.EXTRA8}" />
	<input type="hidden" name="EXTRA9" value="${params.EXTRA9}" />
	<input type="hidden" name="EXTRA10" value="${params.EXTRA10}" />
	<input type="hidden" name="EXTRA11" value="${params.EXTRA11}" />
	<input type="hidden" name="EXTRA12" value="${params.EXTRA12}" />
	<input type="hidden" name="EXTRA13" value="${params.EXTRA13}" />
	<input type="hidden" name="EXTRA14" value="${params.EXTRA14}" />
	<input type="hidden" name="EXTRA15" value="${params.EXTRA15}" />
	<input type="hidden" name="_wid" value="${params._wid}" />
	<div class="accordion">
		<div class="accordionPart">
			<h3><a href="#">Results</a></h3>
			<div>
				<table class="lTable w100">
					<tr>
						<th class="w10">Category</th>
						<td class="w15">${params.CATEGORY}</td>
						<th class="w10">Model</th>
						<td class="w15">${params.MODEL}</td>
						<th class="w10">Firmware</th>
						<td class="w15">${params.FW_VERSION}</td>
						<th class="w10"></th>
						<td class="w15"></td>
					</tr>
					<tr>
						<th>Test Project</th>
						<td>${params.TEST_PROJECT_ID}</td>
						<th>Test Suite</th>
						<td>${params.TEST_SUITE_ID}</td>
						<th>Test Case</th>
						<td>${params.TEST_CASE_NAME}</td>
						<th>Description</th>
						<td>${params.SUITE_DESCRIPTION}</td>
					</tr>
		<c:if test="${params.CATEGORY == 'NCAM'}">
					<tr>
						<th>Profile Number</th>
						<td>${params.EXTRA1}</td>
						<th>Profile Name</th>
						<td>${params.EXTRA2}</td>
						<th>Encoding</th>
						<td>${params.EXTRA3}</td>
						<th>Resolution</th>
						<td>${params.EXTRA4}</td>
					</tr>
					<tr>
						<th>Framerate</th>
						<td>${params.EXTRA5}</td>
						<th>Bitrate</th>
						<td>${params.EXTRA6}</td>
						<th>Compression</th>
						<td>${params.EXTRA7}</td>
			<c:if test="${params.EXTRA3 == 'H.264'}">
						<th>Bit Control</th>
						<td>${params.EXTRA8}</td>
					</tr>
					<tr>
						<th>Encoding Priority</th>
						<td>${params.EXTRA9}</td>
						<th>GOP Size</th>
						<td>${params.EXTRA10}</td>
						<th>Entropy Coding</th>
						<td>${params.EXTRA11}</td>
						<th>Profile</th>
						<td>${params.EXTRA12}</td>
					</tr>
			</c:if>
			<c:if test="${params.EXTRA3 == 'MPEG4'}">
						<th>Bit Control</th>
						<td>${params.EXTRA8}</td>
					</tr>
					<tr>
						<th>Encoding Priority</th>
						<td>${params.EXTRA9}</td>
						<th>GOP Size</th>
						<td>${params.EXTRA10}</td>
						<th></th>
						<td></td>
						<th></th>
						<td></td>
					</tr>
			</c:if>
			<c:if test="${params.EXTRA3 != 'H.264' && params.EXTRA3 != 'MPEG4'}">
						<th></th>
						<td></td>
					</tr>
			</c:if>
		</c:if>
		<c:if test="${params.CATEGORY == 'NVR'}">
					<tr>
						<th>Channel Number</th>
						<td>${params.EXTRA1}</td>
						<th>Codec</th>
						<td>${params.EXTRA3}</td>
						<th>Resolution</th>
						<td>${params.EXTRA4}</td>
						<th>Framerate</th>
						<td>${params.EXTRA5}</td>
					</tr>
		</c:if>
		<c:if test="${params.CATEGORY == 'DVR'}">
					<tr>
						<th>Channel Number</th>
						<td>${params.EXTRA1}</td>
						<th>Quality</th>
						<td>${params.EXTRA2}</td>
						<th>Resolution</th>
						<td>${params.EXTRA4}</td>
						<th></th>
						<td></td>
					</tr>
		</c:if>
					<tr>
						<th>Mac Address</th>
						<td>${params.NODE_MAC}</td>
						<th>IP</th>
						<td>${params.NODE_IP}</td>
						<th>Total Cycle</th>
						<td>${params.TOTAL_CYCLE}</td>
						<th>Cycle</th>
						<td>${params.CYCLE}</td>
					</tr>
					<tr>
						<th>Start Time</th>
						<td id="${_wid}_startTime"></td>
						<th>End Time</th>
						<td id="${_wid}_endTime"></td>
						<th>Execution Time</th>
						<td id="${_wid}_executionTime"></td>
						<th>Insert Date</th>
						<td id="${_wid}_insertDate"></td>
					</tr>
					<tr>
						<th>Log Serial</th>
						<td>
							<c:if test="${fn:indexOf(params.LOG_FILE, 'serial') > -1}">
								<button type="button" class="file" data="{formId:'${_wid}_searchForm', LOG_NAME:'serial'}"><span class="ui-icon ui-icon-document"></span></button>
							</c:if>
						</td>
						<th>Log Tool</th>
						<td>
							<c:if test="${fn:indexOf(params.LOG_FILE, 'tool') > -1}">
								<button type="button" class="file" data="{formId:'${_wid}_searchForm', LOG_NAME:'tool'}"><span class="ui-icon ui-icon-document"></span></button>
							</c:if>
						</td>
						<th>NG</th>
						<td <c:if test="${params.RESULT == 'NG'}">style="color:#FF0000;"</c:if>>${params.RESULT}</td>
						<th></th>
						<td></td>
					</tr>
		<c:if test="${params.RESULT == 'NG'}">
					<tr>
						<th>Cause</th>
						<td colspan="7" style="text-align:left; color:#FF0000;">
							${params.CAUSE}
						</td>
					</tr>
		</c:if>
				</table>
			</div>
		</div>
		<div class="accordionPart closed">
			<h3><a href="#">Grid</a></h3>
			<div>
				<div class="searchDiv">
					<ul>
				    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
				    </ul>
				</div>
				<div style="float:left;">
					<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', pginput:false, singleRowNum:true, recordtext:'', loadonce:true, rownumbers:false, formId:'${_wid}_searchForm', url:'tgBandwidthDetail.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.BANDWIDTH.title"/> Detail', pager:'#${_wid}_pager'}">
						<tr>
							<th field="SEQ_TIME" width="40px">Time</th>
							<th field="DOWNLOAD" width="100px">Traffic (kbps)</th>
						</tr>
					</table>
					<div id="${_wid}_pager"></div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div class="accordionPart">
			<h3><a href="#">Chart</a></h3>
			<div>
				<div id="${_wid}_result_chart" style="height:400px;"></div>
			</div>
		</div>
		<c:import url="/tgSrm.do?method=container" />
	</div>
</form>
