<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgWebDetail.do").subscribe(fnXhrComplete);
	
	function fnXhrComplete(data) {
		fnInit(data);
		fnCompareData();

		$.Topic("dataGrid/xhrComplete/" + "tgWebDetail.do").unsubscribe(fnInit);
	}
	
	function fnInit(data) {
		if (data.rows.length > 0) {
			if (data.rows[0].hasOwnProperty("START_TIME"))			$("#${_wid}_startTime").text(data.rows[0].START_TIME);
			if (data.rows[0].hasOwnProperty("END_TIME"))			$("#${_wid}_endTime").text(data.rows[0].END_TIME);
			if (data.rows[0].hasOwnProperty("EXECUTION_TIME"))		$("#${_wid}_executionTime").text(data.rows[0].EXECUTION_TIME);
			if (data.rows[0].hasOwnProperty("INSERT_DATE"))			$("#${_wid}_insertDate").text(data.rows[0].INSERT_DATE);
		}
	}
	
	function fnCompareData() {
		$("#${_wid}_grid").find("tr[role='row'][id]").each(function() {
			var expectedResult = $(this).find("td")[7];
			var actualResult = $(this).find("td")[8];
			
			if ($(expectedResult).text() !== $(actualResult).text()) {
				$(actualResult).css("color", "red");
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
	<input type="hidden" name="EXTRA1" value="${params.EXTRA1}" />
	<input type="hidden" name="EXTRA2" value="${params.EXTRA2}" />
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
						<th>Browser Type</th>
						<td>${params.EXTRA1}</td>
						<th>Browser Version</th>
						<td>${params.EXTRA2}</td>
						<th></th>
						<td></td>
						<th></th>
						<td></td>
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
			<h3><a href="#">Grid</a></h3>
			<div>
				<div class="searchDiv">
					<ul>
				    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
				    </ul>
				</div>
				<div>
					<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgWebDetail.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.WEB.title"/> Detail', pager:'#${_wid}_pager'}">
						<tr>
							<th field="STEP" width="40px">Step</th>
							<th field="CONTROL_NAME" width="120px">Control Name</th>
							<th field="ID" width="80px">ID</th>
							<th field="TYPE" width="80px">Type</th>
							<th field="METHOD" width="80px">Method</th>
							<th field="INPUT_VALUE" width="120px">Input Value</th>
							<th field="EXPECTED_RESULT" width="120px">Expected</th>
							<th field="ACTUAL_RESULT" width="120px">Actual</th>
							<th field="RESULT" syntax="{'flag':'NG','syntaxColor':'red'}" width="60px">Result</th>
						</tr>
					</table>
					<div id="${_wid}_pager"></div>
				</div>
			</div>
		</div>
		<c:import url="/tgSrm.do?method=container" />
	</div>
</form>
