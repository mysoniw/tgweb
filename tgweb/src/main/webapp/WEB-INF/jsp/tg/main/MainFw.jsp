<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<form id="${_wid}_searchForm">
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" name="FW_VERSION" value="${params.FW_VERSION}" />
  	<div>
		<table class="lTable">
			<tr>
				<th class="w100px">Category</th>
				<td class="w100px">${params.CATEGORY}</td>
			</tr>
			<tr>
				<th>Model</th>
				<td>${params.MODEL}</td>
			</tr>
			<tr>
				<th>Firmware</th>
				<td>${params.FW_VERSION}</td>
			</tr>
		</table>
	</div>
	<div class="searchDiv">
		<ul>
	    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
	    	<li><button type="button" class="report" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">report</button></li>
	    </ul>
	</div>
	<div>
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgMainFw.do', postData:{method:'s'}, key:'TC_IDX', caption:'Firmware Result', pager:'#${_wid}_pager'}">
			<tr>
				<th field="TEST_PROJECT_ID_AS" url="cmnForward.do" addParam="{'mode':'main', 'method':'t', 'tabTitle':'MODEL'}" uid="MainFw">Test Project</th>
				<th field="TEST_CASE_CNT" width="80px">Test Case</th>
				<th field="PASS" width="60px">Pass</th>
				<th field="FAIL" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="60px">Fail</th>
				<th field="NG" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="60px">NG</th>
				<th field="PASS_RATE" width="80px">Pass Rate</th>
			</tr>
		</table>
	</div>
	<div id="${_wid}_pager"></div>
</form>
