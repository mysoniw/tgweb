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
	
	$.Topic("dataGrid/xhrComplete/" + "tgViewLatencyDetail.do").subscribe(function xhrSub(_data) {
		data = _data;
		
		fnCharting();
		
		$.Topic("dataGrid/xhrComplete/" + "tgViewLatencyDetail.do").unsubscribe(xhrSub);
	});
	
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
	
	var time, deviation, seq;
	function fnCharting() {
		//$("#${_wid}_result_chart").css("width", $(document).width() - 492 + "px");
		
		if (data.rows.length <= 1) {
			return null;
		}
		
		if (data.rows.length > 0) {
			if (data.rows[0].hasOwnProperty("START_TIME"))			$("#${_wid}_startTime").text(data.rows[0].START_TIME);
			if (data.rows[0].hasOwnProperty("END_TIME"))			$("#${_wid}_endTime").text(data.rows[0].END_TIME);
			if (data.rows[0].hasOwnProperty("EXECUTION_TIME"))		$("#${_wid}_executionTime").text(data.rows[0].EXECUTION_TIME);
			if (data.rows[0].hasOwnProperty("INSERT_DATE"))			$("#${_wid}_insertDate").text(data.rows[0].INSERT_DATE);
		}
		
		time = getValues(data.rows, "TIME", true);
		deviation = getValues(data.rows, "DEVIATION", true);

		seq = getValues(data.rows, "SEQ", true);
		
		chart.series[0].data = time;
		chart.series[1].data = deviation;
		
		chart.xAxis.categories = seq;
		
		var cc = new Highcharts.Chart(chart);
		
		$("#${_wid}_result_chart").data("chart", cc);
	}
	
	var chart;
	chart = {
		chart: {
			renderTo: "${_wid}_result_chart",
			zoomType: "xy"
		},
		title: {
			text: "${params.MODEL} (${params.FW_VERSION}ver) - View Latency"
		},
		subtitle: {
			text: "Click and drag in the plot area to zoom in"
		},
		credits : {
			enabled : false
		},
		xAxis: {
			tickmarkPlacement: "on",
			categories: []
		},
		yAxis: [{ // Primary yAxis
			gridLineWidth: 0,
			title: {
				text: "Delay Time",
				style: {
					color: "#FF00DE"
				}
			},
			labels: {
				formatter: function() {
					return this.value + " s";
				},
				style: {
					color: "#FF00DE"
				}
			}
		}, 
		{ // Secondary yAxis
			labels: {
				formatter: function() {
					return this.value + " s";
				},
				style: {
					color: "#00B3FF"
				}
			},
			title: {
				text: "Deviation",
				style: {
					color: "#00B3FF"
				}
			},
			opposite: true
		}],
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
					s.push('<span style="color:' + point.series.color + '">' + point.series.name + '</span>:  ' + '<b>' + point.y + '</b>' + " s");
				});
				return s.join("<br/>");
			}
		},
		legend: {
			enabled : true,
			align: "left",
	        verticalAlign: "top",
	        x: 70,
	        floating: true
		},
		series: [{
			name: "Delay Time",
			type: "column",
			color: "#FF00DE",
			data: []
		}, {
			name: "Deviation",
			type: "column",
			color: "#00B3FF",
			yAxis: 1,
			data: []
		}]
	};
});
</script>
<form id="${_wid}_searchForm">
	<input type="hidden" name="TC_IDX" value="${params.TC_IDX}" />
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
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
	<input type="hidden" name="TOTAL_CYCLE" value="${params.TOTAL_CYCLE}" />
	<input type="hidden" name="CAUSE" value="${params.CAUSE}" />
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
					<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', pginput:false, singleRowNum:true, recordtext:'', loadonce:true, rownumbers:false, formId:'${_wid}_searchForm', url:'tgViewLatencyDetail.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.VIEW_LATENCY.title"/> Detail', pager:'#${_wid}_pager'}">
						<tr>
							<th field="COLOR" width="60px">Color</th>
							<th field="CNT" width="70px">Repeat</th>
							<th field="TIME" width="70px">Delay(s)</th>
							<th field="DEVIATION" width="90px">Deviation(s)</th>
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
				<div id="${_wid}_result_chart" style="height:410px;"></div>
			</div>
		</div>
		<c:import url="/tgSrm.do?method=container" />
	</div>
</form>
