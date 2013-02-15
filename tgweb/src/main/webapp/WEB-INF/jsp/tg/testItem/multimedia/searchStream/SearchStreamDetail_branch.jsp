<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<link rel="stylesheet" type="text/css" href="/javascript/jquery/plugin/adGallery/jquery.ad-gallery.css" />
<script type="text/javascript" src="/javascript/jquery/plugin/adGallery/jquery.ad-gallery.min.js"></script>
<script type="text/javascript">
var data, flag = false;
$(function() {

	//var tabs = window.smileGlobal.tabInfo.tabs;
	
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
								_data.push($container.chart.series[j].data[i]);
							}
						} else {
							_data = data[i];
						}
						$container.chart.tooltip.refresh(_data);
					}
				}
			}
		});
		
		/*
		var data;
		if (tabs["#tab_${_wid}"]) {
			for(var i = 0, size = tabs["#tab_${_wid}"].length; i < size; i++) {
				if (renderTo.id != tabs["#tab_${_wid}"][i].chart.renderTo.id) {
					data = tabs["#tab_${_wid}"][i].chart.series[0].data;
					
					if (p < data.length) {
						tabs["#tab_${_wid}"][i].chart.tooltip.refresh(data[p]);
					}
//					for(var j = 0; j < data.length; j++) {
//						if (data[j].x === p)
//							tabs["#tab_${_wid}"][i].chart.tooltip.refresh(tabs["#tab_${_wid}"][i].chart.series[0].data[j]);
//					}
				}
			}
		}
		
		*/

	}
	
	
	
	
	$.Topic("dataGrid/xhrComplete/" + "tgSearchStreamDetail.do").subscribe(function xhrSub(_data) {
		data = _data;
		
		fnInit();
		
		$.Topic("dataGrid/xhrComplete/" + "tgSearchStreamDetail.do").unsubscribe(xhrSub);
	});
	/*
	if ("#tab_${_wid}" !== window.smileGlobal.tabHash) {
		$.Topic("#tab_${_wid}").subscribe(function tabsSub(ui) {
			if (flag) {
				fnInit();
			}
			console.log("1", flag);
			flag = true;
	
			$.Topic("#tab_${_wid}").unsubscribe(tabsSub);
		});
	} else {
		if (flag) {
			fnInit();
		}
		console.log("2", flag);
		flag = true;
	}
	
	$.Topic("dataGrid/xhrComplete/" + "tgSearchStreamDetail.do").subscribe(function xhrSub(_data) {
		data = _data;
		
		if (flag) {
			fnInit();
		}
		console.log("3", flag);
		flag = true;
		
		$.Topic("dataGrid/xhrComplete/" + "tgSearchStreamDetail.do").unsubscribe(xhrSub);
	});
	*/
	
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
	
	function fnInit() {
		fnCharting();
		
		$("#${_wid}_gallery").adGallery({
			loader_image: "/javascript/jquery/plugin/adGallery/loader.gif",
			width: 600,
			height: 400,
			callbacks: {
				afterImageVisible: function() {
					$("#${_wid}_screenShots").accordion("activate", false);
				}
			}
		});
	}
	
	var f_count, f_deviation, pc_deviation, seq;
	function fnCharting() {
		//$("#${_wid}_chart").css("width", $(document).width() - 492 + "px");
		
		if (data.rows.length <= 1) {
			return null;
		}
		
		if (data.rows.length > 0) {
			if (data.rows[0].hasOwnProperty("START_TIME"))			$("#${_wid}_startTime").text(data.rows[0].START_TIME);
			if (data.rows[0].hasOwnProperty("END_TIME"))			$("#${_wid}_endTime").text(data.rows[0].END_TIME);
			if (data.rows[0].hasOwnProperty("EXECUTION_TIME"))		$("#${_wid}_executionTime").text(data.rows[0].EXECUTION_TIME);
			if (data.rows[0].hasOwnProperty("INSERT_DATE"))			$("#${_wid}_insertDate").text(data.rows[0].INSERT_DATE);
		}
		
		f_count = getValues(data.rows, "F_COUNT", true);
		f_deviation = getValues(data.rows, "F_DEVIATION", true);
		pc_deviation = getValues(data.rows, "PC_DEVIATION", true);

		seq = getValues(data.rows, "SEQ", true);
		
		chart.series[0].data = f_deviation;
		chart.series[1].data = pc_deviation;
		chart.series[2].data = f_count;
		
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
			text: "${params.MODEL} (${params.FW_VERSION}ver) - Search Stream"
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
				text: "Frame & PC Deviation",
				style: {
					color: "#AA4643"
				}
			},
			labels: {
				formatter: function() {
					return this.value + " ms";
				},
				style: {
					color: "#AA4643"
				}
			},
			allowDecimals: false
		}, 
		{ // Secondary yAxis
			labels: {
				formatter: function() {
					return this.value + " FPS";
				},
				style: {
					color: "#4572A7"
				}
			},
			title: {
				text: "Frame Count",
				style: {
					color: "#4572A7"
				}
			},
			opposite: true,
			allowDecimals: false
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
					var unit = {
						"Frame Count": "FPS",
						"Frame Deviation": "ms",
						"PC Deviation": "ms"
					}[point.series.name];
					s.push('<span style="color:' + point.series.color + '">' + point.series.name + '</span>:  ' + '<b>' + point.y + '</b>' + " " + unit);
				});
				return s.join("<br/>");
			}
		},
/*		legend: {
			layout: "vertical",
			align: "left",
			x: 120,
			verticalAlign: "top",
			y: 80,
			floating: true,
			backgroundColor: "#FFFFFF"
		},
*/
		legend: {
			enabled : true,
			align: "left",
	        verticalAlign: "top",
	        x: 70,
	        floating: true
		},
		series: [{
			name: "Frame Deviation",
			type: "column",
			color: "#AA4643",
			data: []
		}, {
			name: "PC Deviation",
			type: "column",
			color: "#18CE00",
			data: []
		}, {
			name: "Frame Count",
			color: "#4572A7",
			type: "spline",
			yAxis: 1,
			data: []
		}]
	};
});
</script>
<form id="${_wid}_searchForm">
	<input type="hidden" name="TC_IDX" value="${params.TC_IDX}" />
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="_wid" value="${_wid}" />
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
						<th></th>
						<td></td>
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
						<th>Quality</th>
						<td>${params.EXTRA2}</td>
						<th>Codec</th>
						<td>${params.EXTRA3}</td>
						<th>Resolution</th>
						<td>${params.EXTRA4}</td>
					</tr>
					<tr>
						<th>Framerate</th>
						<td>${params.EXTRA5}</td>
						<th></th>
						<td></td>
						<th></th>
						<td></td>
						<th></th>
						<td></td>
					</tr>
		</c:if>
		<c:if test="${params.CATEGORY == 'DVR'}">
					<tr>
						<th>Channel Number</th>
						<td>${params.EXTRA1}</td>
						<th>Quality</th>
						<td>${params.EXTRA2}</td>
						<th>Record Mode</th>
						<td>${params.EXTRA3}</td>
						<th>Resolution</th>
						<td>${params.EXTRA4}</td>
					</tr>
					<tr>
						<th>Framerate</th>
						<td>${params.EXTRA5}</td>
						<th></th>
						<td></td>
						<th></th>
						<td></td>
						<th></th>
						<td></td>
					</tr>
		</c:if>
					<tr>
						<th>Total Cycle</th>
						<td>${params.TOTAL_CYCLE}</td>
						<th>PASS</th>
						<td>${params.PASS}</td>
						<th>FAIL</th>
						<td>${params.FAIL}</td>
						<th>PASS RATE</th>
						<td>${params.PASS_RATE}</td>
					</tr>
					<tr>
						<th>Mac Address</th>
						<td>${params.NODE_MAC}</td>
						<th>IP</th>
						<td>${params.NODE_IP}</td>
						<th>Cycle</th>
						<td>${params.CYCLE}</td>
						<th></th>
						<td></td>
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
						<th>Result</th>
						<td <c:if test="${params.RESULT != 'PASS'}">style="color:#FF0000;"</c:if>>${params.RESULT}</td>
						<th></th>
						<td></td>
					</tr>
		<c:if test="${params.RESULT != 'PASS'}">
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
		<div class="accordionPart">
			<h3><a href="#">Detail Results</a></h3>
			<div>
				<table class="lTable w100">
					<colgroup>
						<col style="width:14%;">
						<col style="width:14%;">
						<col style="width:14%;">
						<col style="width:14%;">
						<col style="width:14%;">
						<col style="width:15%;">
						<col style="width:15%;">
					</colgroup>
					<tr>
						<th>Codec</th>
						<th>Resolution</th>
						<th>Frame Count</th>
						<th>Frame Deviation</th>
						<th>PC Deviation</th>
						<th>Frame Reverse</th>
						<th>GOP Count</th>
					</tr>
					<tr>
						<td><c:if test="${params.CATEGORY != 'DVR'}">${params.EXTRA3}</c:if></td>
						<td>${params.EXTRA4}</td>
						<td>Frame: ${params.EXTRA5} (Range: ${params.F_DEV_MIN} ~ ${params.F_DEV_MAX})</td>
						<td>Base: ${params.DEV_BASE} ms (Tolerance: ${params.F_DEV_TOLERANCE_BASE} ms)</td>
						<td>Base: ${params.DEV_BASE} ms (Tolerance: ${params.PC_DEV_TOLERANCE_BASE} ms)</td>
						<td>-</td>
						<td>-</td>
					</tr>
					<tr>
						<td <c:if test="${params.CODEC == 'FAIL'}">style="color:#FF0000;"</c:if>>${params.CODEC}</td>
						<td <c:if test="${params.RESOLUTION == 'FAIL'}">style="color:#FF0000;"</c:if>>${params.RESOLUTION}</td>
						<td <c:if test="${params.FRAME_COUNT == 'FAIL'}">style="color:#FF0000;"</c:if>>${params.FRAME_COUNT} (Tolerance: ${params.EXTRA13})</td>
						<td <c:if test="${params.FRAME_DEVIATION == 'FAIL'}">style="color:#FF0000;"</c:if>>${params.FRAME_DEVIATION} (Tolerance: ${params.EXTRA14} <c:if test="${params.EXTRA15 == 'MILLISECOND'}">ms</c:if><c:if test="${params.EXTRA15 == 'PERCENT'}">%</c:if>)</td>
						<td <c:if test="${params.PC_DEVIATION == 'FAIL'}">style="color:#FF0000;"</c:if>>${params.PC_DEVIATION} (Tolerance: ${params.EXTRA16} <c:if test="${params.EXTRA17 == 'MILLISECOND'}">ms</c:if><c:if test="${params.EXTRA17 == 'PERCENT'}">%</c:if>)</td>
						<td <c:if test="${params.FRAME_REVERSE == 'FAIL'}">style="color:#FF0000;"</c:if>>${params.FRAME_REVERSE}</td>
						<td <c:if test="${params.GOP_COUNT == 'FAIL'}">style="color:#FF0000;"</c:if>>${params.GOP_COUNT}</td>
					</tr>
				</table>
			</div>
		</div>
<c:if test="${not empty entryList}">
		<div class="accordionPart" id="${_wid}_screenShots">
			<h3><a href="#">Frame Reverse Screen Shots</a></h3>
			<div>
				<div id="${_wid}_gallery" class="ad-gallery">
					<div class="ad-image-wrapper"></div>
					<div class="ad-nav">
						<div class="ad-thumbs">
							<ul class="ad-thumb-list">
								<c:forEach items="${entryList}" var="entry">
									<li><a href="cmnCommon.do?method=image&filePath=${entry.IMAGE_PATH}"> <img src="cmnCommon.do?method=image&filePath=${entry.IMAGE_PATH}" style="width:50px;height:50px;" title="Time: ${entry.SEQ}, Group: ${entry.GROUP_IDX}, Phase: ${entry.PHASE}, Target Time: ${entry.PRESENT_TIME}" /> </a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
</c:if>
		<div class="accordionPart closed">
			<h3><a href="#">Grid</a></h3>
			<div>
				<div class="searchDiv">
					<ul>
				    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
				    </ul>
				</div>
				<div style="float:left;">
					<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', recordtext:'', loadonce:true, rownumbers:false, formId:'${_wid}_searchForm', url:'tgSearchStreamDetail.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.SEARCH_STREAM.title"/> Detail', pager:'#${_wid}_pager'}">
						<tr>
							<th field="SEQ" width="40px">Time</th>
							<th field="F_COUNT" syntax="{'matcher':'RANGE', 'flag':['${params.EXTRA5}', '${params.EXTRA13}'],'syntaxColor':'red'}" width="100px">F Count</th>
							<th field="F_DEVIATION" syntax="{'matcher':'OVER', 'flag':'${params.F_DEV_TOLERANCE_BASE}','syntaxColor':'red'}" width="100px">F Deviation</th>
							<th field="PC_DEVIATION" syntax="{'matcher':'OVER', 'flag':'${params.PC_DEV_TOLERANCE_BASE}','syntaxColor':'red'}" width="100px">PC Deviation</th>
							<th field="F_REVERSE" syntax="{'matcher':'NOT_MATCH', 'flag':'0','syntaxColor':'red'}" width="100px">F Reverse Count</th>
							<th field="GOP_COUNT" syntax="{'matcher':'NOT_MATCH', 'flag':'0','syntaxColor':'red'}" width="100px">GOP Fail Count</th>
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
		<%--<%@ include file="/WEB-INF/jsp/tg/srm/SrmContainer.jsp" %> --%>
		<c:import url="/tgSrm.do?method=container" />
	</div>
</form>
