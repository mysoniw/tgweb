<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgOSDDetail.do").subscribe(fnInit);
	
	function fnInit(data) {
		if (data.rows.length > 0) {
			if (data.rows[0].hasOwnProperty("START_TIME"))			$("#${_wid}_startTime").text(data.rows[0].START_TIME);
			if (data.rows[0].hasOwnProperty("END_TIME"))			$("#${_wid}_endTime").text(data.rows[0].END_TIME);
			if (data.rows[0].hasOwnProperty("EXECUTION_TIME"))		$("#${_wid}_executionTime").text(data.rows[0].EXECUTION_TIME);
			if (data.rows[0].hasOwnProperty("INSERT_DATE"))			$("#${_wid}_insertDate").text(data.rows[0].INSERT_DATE);
		}
		
		$.Topic("dataGrid/xhrComplete/" + "tgOSDDetail.do").unsubscribe(fnInit);
	}
});
</script>
<form id="${_wid}_searchForm">
	<input type="hidden" name="TC_IDX" value="${params.TC_IDX}" />
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
			<h3><a href="#">Grid</a></h3>
			<div>
				<div class="searchDiv">
					<ul>
				    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
				    </ul>
				</div>
				<div>
					<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgOSDDetail.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.OSD.title"/> Detail', pager:'#${_wid}_pager'}">
						<tr>
							<th field="ORACLE_TEXT_ID" width="80px">Oracle ID</th>
							<th field="CAPTURE_TEXT_ID" width="80px">Target ID</th>
							<th field="ORACLE_TEXT">Oracle String</th>
							<th field="CAPTURE_TEXT">Target String</th>
							<th field="STR_RESULT" syntaxColor="NG" width="100px">String Result</th>
							<th field="WIDGET_ID" width="80px">Widget ID</th>
							<th field="WIDGET_W" width="60px">Wid. W</th>
							<th field="WIDGET_H" width="60px">Wid. H</th>
							<th field="STRING_W" width="60px">Text W</th>
							<th field="STRING_H" width="60px">Text H</th>
							<th field="LENGTH_RESULT" syntaxColor="NG" width="100px">Wid. Result</th>
							<th field="TOTAL_RESULT" syntaxColor="FAIL" width="100px">Total Result</th>
						</tr>
					</table>
					<div id="${_wid}_pager"></div>
				</div>
			</div>
		</div>
	</div>
</form>
