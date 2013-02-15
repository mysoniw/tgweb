<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgPtzDetail.do").subscribe(fnXhrComplete);
	
	function fnXhrComplete(data) {
		fnCompareData();
		fnGroupHeaders(data);
		fnCharting(data);
		
		$.Topic("dataGrid/xhrComplete/" + "tgPtzDetail.do").unsubscribe(fnXhrComplete);
	}
	
	function fnCompareData() {
		$("#${_wid}_grid").find("tr[role='row'][id]").each(function() {
			var presetP = $(this).find("td")[2];
			var presetT = $(this).find("td")[3];
			var presetZ = $(this).find("td")[4];
			var resultP = $(this).find("td")[5];
			var resultT = $(this).find("td")[6];
			var resultZ = $(this).find("td")[7];
			
			if ($(presetP).text() !== $(resultP).text()) {
				$(resultP).css("color", "red");
			}
			if ($(presetT).text() !== $(resultT).text()) {
				$(resultT).css("color", "red");
			}
			if ($(presetZ).text() !== $(resultZ).text()) {
				$(resultZ).css("color", "red");
			}
		});
	}
	
	function fnGroupHeaders(data) {
		$("#${_wid}_grid").jqGrid('destroyGroupHeader');
		$("#${_wid}_grid").jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : "PRESET_P",
				numberOfColumns : 3,
				titleText : "Preset"
			}, {
				startColumnName : "RESULT_P",
				numberOfColumns : 3,
				titleText : "Result"
			}]
		});
		
		if (data.rows.length > 0) {
			if (data.rows[0].hasOwnProperty("START_TIME"))			$("#${_wid}_startTime").text(data.rows[0].START_TIME);
			if (data.rows[0].hasOwnProperty("END_TIME"))			$("#${_wid}_endTime").text(data.rows[0].END_TIME);
			if (data.rows[0].hasOwnProperty("EXECUTION_TIME"))		$("#${_wid}_executionTime").text(data.rows[0].EXECUTION_TIME);
			if (data.rows[0].hasOwnProperty("INSERT_DATE"))			$("#${_wid}_insertDate").text(data.rows[0].INSERT_DATE);
		}
	}
	
	function fnCharting(data) {
		
		// TODO
		var panMin = -1,
		panMax = -1,
		tiltMin = -1,
		tiltMax = -1,
		zoomMin = -1,
		zoomMax = -1,
	    panHalf,
	    tiltHalf;
		
		function parseNumber(str) {
			if (!str) return -1;
			
			if (!isNaN(parseFloat(str)) && isFinite(str)) {
				return parseFloat(str);
			} else {
				return -1;
			}
		}
		
		if (data.rows.length > 0) {
			if (data.rows[0].hasOwnProperty("P_RANGE_MAX"))	panMax = parseNumber(data.rows[0].P_RANGE_MAX);
			if (data.rows[0].hasOwnProperty("T_RANGE_MAX"))	tiltMax = parseNumber(data.rows[0].T_RANGE_MAX);
			if (data.rows[0].hasOwnProperty("Z_RANGE_MAX"))	zoomMax = parseNumber(data.rows[0].Z_RANGE_MAX);
			if (data.rows[0].hasOwnProperty("P_RANGE_MIN"))	panMin = parseNumber(data.rows[0].P_RANGE_MIN);
			if (data.rows[0].hasOwnProperty("T_RANGE_MIN"))	tiltMin = parseNumber(data.rows[0].T_RANGE_MIN);
			if (data.rows[0].hasOwnProperty("Z_RANGE_MIN"))	zoomMin = parseNumber(data.rows[0].Z_RANGE_MIN);
			if (data.rows[0].hasOwnProperty("P_TOLERANCE"))	$("#${_wid}_panTolerance").text(data.rows[0].P_TOLERANCE);
			if (data.rows[0].hasOwnProperty("T_TOLERANCE"))	$("#${_wid}_tiltTolerance").text(data.rows[0].T_TOLERANCE);
			if (data.rows[0].hasOwnProperty("Z_TOLERANCE"))	$("#${_wid}_zoomTolerance").text(data.rows[0].Z_TOLERANCE);
		}
		
		panHalf = parseInt(panMax / 2, 10);
	    tiltHalf = parseInt(tiltMax / 2, 10);
		
		var pass = 0, fail = 0;
		
		for (var i = 0; i < data.rows.length; i++) {
			if (data.rows[i].RESULT == "OK") {
				pass++;
			} else {
				fail++;
			}
		}
		$("#${_wid}_sequenceTotal").text(pass + fail);
		$("#${_wid}_keyPass").text(pass);
		$("#${_wid}_keyFail").text(fail);
		
		var chartOptions = {
				
			chart: {
				renderTo: "${_wid}_chart",
				polar: true,
				type: "spline"
			},
			title: {
				text: "${params.MODEL} (${params.FW_VERSION}ver) - PTZ"
			},
			subtitle : {
				text : 'Pan range: <span style="color:#C77405">' + panMin + " - " + panMax + '</span>, Tilt range: <span style="color:#C77405">' + tiltMin + " - " + tiltMax + '</span>, Zoom range: <span style="color:#C77405">' + zoomMin + " - " + zoomMax + '</span>'
			},
			pane: {
				size: "80%"
			},
			xAxis: {
				tickmarkPlacement: "on",
				lineWidth: 0,
				labels: {
					enabled: true
				},
				showLastLabel: true,
				endOnTick: false,
				minorTickInterval: 1000,
				max: panMax,
				min: panMin
			},
			yAxis: {
				gridLineInterpolation: "circle",
				lineWidth: 0,
				labels: {
					enabled : false
				},
				endOnTick: false,
				minorTickInterval: 1000,
				max: tiltHalf,
				min: tiltMin
			},
			tooltip: {
				backgroundColor: {
	                linearGradient: [0, 0, 0, 60],
	                stops: [
	                    [0, "#FFFFFF"],
	                    [1, "#E0E0E0"]
	                ]
	            },
				borderWidth: 1,
				formatter: function() {
					return '<b style="color:' + this.point.series.color + '};">' + this.point.series.name + '</b><br/>' + '<span style="color:#C77405">P</span> : ' + this.point.config[2] + '<br/>' + '<span style="color:#C77405">T</span> : ' + this.point.config[3] + '<br/>' + '<span style="color:#C77405">Z</span> : ' + this.point.config[4];
				},
				crosshairs: [{
	                width: 1,
	                color: "#FF8800"
	            }, {
	                width: 1,
	                color: "#FF8800"
	            }]
			},
			legend: {
				align: "right",
				verticalAlign: "top",
				y: 100,
				layout: "vertical",
				floating: true
			},
			series: [{
				color: "#FF0000",
				name: "Preset",
				pointPlacement: "on",
				connectEnds: false,
				marker: {
					symbol: "triangle",
					radius: 3,
		            states: {
						hover: {
							enabled: true,
							radius: 5,
							fillColor: "#00FF00",
			                lineColor: null
						}
					}
				}
			}, {
				color: "#0000FF",
				name: "Result",
				pointPlacement: "on",
				connectEnds: false,
				marker: {
					symbol: "triangle-down",
					radius: 3,
		            states: {
						hover: {
							enabled: true,
							radius: 5,
							fillColor: "#00FF00",
			                lineColor: null
						}
					}
				}
			}],
			credits: {
				enabled: false
			},
			plotOptions: {
				series: {
					lineWidth: 0.3,
					marker: {
						symbol: "triangle",
						radius: 3,
			            states: {
							hover: {
								enabled: true,
								radius: 5,
								fillColor: "#00FF00",
				                lineColor: null
							}
						}
					},
					shadow: false,
					states: {hover : {lineWidth: 0.7}}
				}
			},
			exporting: {
				enabled: true,
				enableImages: false,
				filename: "${params.MODEL}_${params.FW_VERSION}_PTZ_Chart",
				url: "cmnExportChart.do?method=chart",
				width: 800
			}
		};
		
		var preset = {data: []}, result = {data: []};
		for (var i = 0; i< data.rows.length; i++) {
//			preset.data.push([data.rows[i].PRESET_P, data.rows[i].PRESET_T, data.rows[i].PRESET_Z]);
//			result.data.push([data.rows[i].RESULT_P, data.rows[i].RESULT_T, data.rows[i].RESULT_Z]);
			
			
			preset.data.push(fixXY(data.rows[i].PRESET_P, data.rows[i].PRESET_T).concat([data.rows[i].PRESET_P, data.rows[i].PRESET_T, data.rows[i].PRESET_Z]));
			result.data.push(fixXY(data.rows[i].RESULT_P, data.rows[i].RESULT_T).concat([data.rows[i].RESULT_P, data.rows[i].RESULT_T, data.rows[i].RESULT_Z]));
		}
		
		$.extend(chartOptions.series[0], preset);
		$.extend(chartOptions.series[1], result);
		
		var chart = new Highcharts.Chart(chartOptions);
		
		(function() {
			var _rowid;
			$("#${_wid}_grid").jqGrid("setGridParam", {
			    onSelectRow: function(rowid, status) {
					var seriesIdx = 0;
					
					if (_rowid === rowid) {
						seriesIdx = 1;
						_rowid = null;
					} else {
					    _rowid = rowid;
					}
	
					chart.series[seriesIdx].data[rowid - 1].select();
					
					chart.hoverSeries = chart.series[seriesIdx];
				    chart.tooltip.refresh(chart.hoverSeries.data[rowid - 1]);
			    }
			});
		}());
		
		function fixXY(x, y) {
		    var p = x,
		    t = y,
		    fixP = p,
		    fixT;
		    
		    if (t > tiltHalf) {
		        if (p >= panHalf) {
		            fixP = p - panHalf;
		        } else {
		            fixP = p + panHalf;
		        }
		    }
		    fixT = Math.abs(t - tiltHalf);
		    return [fixP, fixT];
		}
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
	<input type="hidden" name="EXTRA1" value="${params.EXTRA1}" />
	<input type="hidden" name="EXTRA2" value="${params.EXTRA2}" />
	<input type="hidden" name="EXTRA3" value="${params.EXTRA3}" />
	<input type="hidden" name="EXTRA4" value="${params.EXTRA4}" />
	<input type="hidden" name="EXTRA5" value="${params.EXTRA5}" />
	<input type="hidden" name="EXTRA6" value="${params.EXTRA6}" />
	<input type="hidden" name="EXTRA7" value="${params.EXTRA7}" />
	<input type="hidden" name="EXTRA8" value="${params.EXTRA8}" />
	<input type="hidden" name="EXTRA9" value="${params.EXTRA9}" />
	<input type="hidden" name="TOTAL_CYCLE" value="${params.TOTAL_CYCLE}" />
	<input type="hidden" name="PASS" value="${params.PASS}" />
	<input type="hidden" name="FAIL" value="${params.FAIL}" />
	<input type="hidden" name="PASS_RATE" value="${params.PASS_RATE}" />
	<input type="hidden" name="RESULT" value="${params.RESULT}" />
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
					<tr>
						<th>PASS</th>
						<td>${params.PASS}</td>
						<th>FAIL</th>
						<td>${params.FAIL}</td>
						<th>PASS RATE</th>
						<td>${params.PASS_RATE}</td>
						<th></th>
						<td></td>
					</tr>
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
						<th>Result</th>
						<td <c:if test="${params.RESULT != 'PASS'}">style="color:#FF0000;"</c:if>>${params.RESULT}</td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th>Pan tolerance</th>
						<td id="${_wid}_panTolerance"></td>
						<th>Tilt tolerance</th>
						<td id="${_wid}_tiltTolerance"></td>
						<th>Zoom tolerance</th>
						<td id="${_wid}_zoomTolerance"></td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th>Sequence Total</th>
						<td id="${_wid}_sequenceTotal"></td>
						<th>Key PASS</th>
						<td id="${_wid}_keyPass"></td>
						<th>Key FAIL</th>
						<td id="${_wid}_keyFail" style="color:#FF0000;"></td>
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
		<div class="accordionPart closed">
			<h3><a href="#">Grid</a></h3>
			<div>
				<div class="searchDiv">
					<ul>
				    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
				    </ul>
				</div>
				<div style="float:left;">
					<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', singleRowNum:true, loadonce:true, rownumbers:false, formId:'${_wid}_searchForm', url:'tgPtzDetail.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.PTZ.title"/> Detail', pager:'#${_wid}_pager'}">
						<tr>
							<th field="SEQ" width="80px">Sequence</th>
							<th field="COMMAND" width="70px">Command</th>
							<th field="PRESET_P" width="60px">P</th>
							<th field="PRESET_T" width="50px">T</th>
							<th field="PRESET_Z" width="50px">Z</th>
							<th field="RESULT_P" width="50px">P</th>
							<th field="RESULT_T" width="50px">T</th>
							<th field="RESULT_Z" width="50px">Z</th>
							<th field="RESULT" syntax="{'flag':'NG','syntaxColor':'red'}" width="60px">Result</th>
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
				<div id="${_wid}_chart" style="width:500px; float:left; height:500px; margin-left:5em;"></div>
			</div>
		</div>
		<c:import url="/tgSrm.do?method=container" />
	</div>
</form>
