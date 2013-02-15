<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgRs485Detail.do").subscribe(fnCharting);
	
	function fnCharting(data) {
		
		if (data.rows.length > 0) {
			if (data.rows[0].hasOwnProperty("START_TIME"))			$("#${_wid}_startTime").text(data.rows[0].START_TIME);
			if (data.rows[0].hasOwnProperty("END_TIME"))			$("#${_wid}_endTime").text(data.rows[0].END_TIME);
			if (data.rows[0].hasOwnProperty("EXECUTION_TIME"))		$("#${_wid}_executionTime").text(data.rows[0].EXECUTION_TIME);
			if (data.rows[0].hasOwnProperty("INSERT_DATE"))			$("#${_wid}_insertDate").text(data.rows[0].INSERT_DATE);
		}
		
		var pass = 0, fail = 0;
		
		for (var i = 0; i < data.rows.length; i++) {
			if (data.rows[i].KEY_RESULT == "OK") {
				pass++;
			} else {
				fail++;
			}
		}
		$("#${_wid}_sequenceTotal").text(pass + fail);
		$("#${_wid}_keyPass").text(pass);
		$("#${_wid}_keyFail").text(fail);
		
		var chartOptions = {
				chart : {
					renderTo : "${_wid}_charting",
					plotBackgroundColor : null,
					plotBorderWidth : null,
					plotShadow : false
				},
				title : {
					text : "${params.MODEL} ${params.TEST_PROJECT_ID} PASS Rate"
				},
				subtitle : {
					text : 'Sequence total:<span style="color:#C77405">' + (pass + fail) + '</span>'
							+ ', Pass:<span style="color:#C77405">' + pass + '</span>'
							+ ', Fail:<span style="color:#C77405">' + fail + '</span>'
				},
				credits: {
			        enabled: false
			    },
				tooltip : {
					formatter : function() {
						return "<b>" + this.point.name + "</b>: " + this.y + "/" + this.total + " (" + this.percentage + "%)";
					}
				},
				plotOptions : {
					pie : {
						allowPointSelect : true,
						cursor : "pointer",
						dataLabels : {
							enabled : false
						},
						showInLegend : true
					}
				},
				series : [{
					type : "pie",
					name : "Result",
					data : [
						{
							name: "PASS",    
							y: pass,
							color : {
								radialGradient: {cx: 0.5, cy: 0.3, r: 0.7},
								stops: [[0, "#058DC7"],
										[1, Highcharts.Color("#058DC7").brighten(-0.3).get("rgb")]]
							}
						}
						, {
							name: "FAIL",    
							y: fail,
							color : {
								radialGradient: {cx: 0.5, cy: 0.3, r: 0.7},
								stops: [[0, "#ED561B"],
										[1, Highcharts.Color("#ED561B").brighten(-0.3).get("rgb")]]
							}
					}]
				}],
				exporting: {
					enabled: true,
					enableImages: false,
					filename: "${params.MODEL}_${params.FW_VERSION}_Chart",
					url: "cmnExportChart.do?method=chart",
					width: 800
				}
			};
		
		new Highcharts.Chart(chartOptions);
		
		$.Topic("dataGrid/xhrComplete/" + "tgRs485Detail.do").unsubscribe(fnCharting);
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
						<th>Protocol</th>
						<td>${params.EXTRA1}</td>
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
		<div class="accordionPart">
			<h3><a href="#">Grid &amp; Chart</a></h3>
			<div>
				<div class="searchDiv">
					<ul>
				    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
				    </ul>
				</div>
				<div style="float:left;">
					<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', singleRowNum:true, recordtext:'', loadonce:true, rownumbers:false, formId:'${_wid}_searchForm', url:'tgRs485Detail.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.RS_485.title"/> Detail', pager:'#${_wid}_pager'}">
						<tr>
							<th field="SEQ" width="80px">Sequence</th>
							<th field="KEY_EVENT" width="120px">Key Event</th>
							<th field="KEY_RESULT" syntax="{'flag':'NG','syntaxColor':'red'}" width="80px">Result</th>
						</tr>
					</table>
					<div id="${_wid}_pager"></div>
				</div>
				<div id="${_wid}_charting" style="width:400px; float:left; height:400px; margin-left:5em;"></div>
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
</form>
