<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<form id="${_wid}_searchForm">
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" name="FW_VERSION" value="${params.FW_VERSION}" />
	<input type="hidden" name="TEST_PROJECT_ID" value="${params.TEST_PROJECT_ID}" />
	<input type="hidden" name="TEST_SUITE_ID" value="${params.TEST_SUITE_ID}" />
	<input type="hidden" name="SUITE_DESCRIPTION" value="${params.SUITE_DESCRIPTION}" />
	<input type="hidden" name="RESULT" value="${params.filterValue}" />
  	<div>
		<table class="lTable">
			<tr>
				<th>Category</th>
				<td>${params.CATEGORY}</td>
			</tr>
			<tr>
				<th>Model</th>
				<td>${params.MODEL}</td>
			</tr>
			<tr>
				<th>Firmware</th>
				<td>${params.FW_VERSION}</td>
			</tr>
			<tr>
				<th>Test Project</th>
				<td>${params.TEST_PROJECT_ID}</td>
			</tr>
			<tr>
				<th>Test Suite</th>
				<td>${params.TEST_SUITE_ID}</td>
			</tr>
			<tr>
				<th>Description</th>
				<td>${params.SUITE_DESCRIPTION}</td>
			</tr>
		</table>
	</div>
	<div class="searchDiv">
		<ul>
			<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
		</ul>
	</div>
	<div>
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgWebTc.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.WEB.title"/> TestCase', pager:'#${_wid}_pager'}"
			filterGrid="{'column':'${params.filterColumn}', 'value':'${params.filterValue}', 'len':'${params.TEST_CASE_FAIL_COUNT}'}">
			<tr>
				<th field="TEST_CASE_NAME" width="480px">TC</th>
				<th field="TOTAL_CYCLE" url="tgWebCycle.do" addParam="{'method':'t', 'tabTitle':'TEST_CASE_ID'}" uid="WebTc" width="80px;">Total Cycle</th>
				<th field="RESULT" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="80px">Result</th>
				<th field="PASS" width="60px">PASS</th>
				<th field="FAIL" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" url="tgWebCycle.do" addParam="{'method':'t', 'tabTitle':'TEST_CASE_ID', 'filterColumn':'RESULT', 'filterValue':'FAIL'}" width="60px">FAIL</th>
				<th field="NG" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="60px">NG</th>
				<th field="PASS_RATE" width="80px">PASS RATE</th>
			</tr>
		</table>
	</div>
	<div id="${_wid}_pager"></div>
</form>
