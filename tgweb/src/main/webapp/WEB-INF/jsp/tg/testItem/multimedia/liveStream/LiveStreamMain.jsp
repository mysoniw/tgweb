<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgLiveStreamMain.do").subscribe(function sub() {
		$("#${_wid}_grid").jqGrid('destroyGroupHeader');
		$("#${_wid}_grid").jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [
/*
			{
				startColumnName : "CODEC",
				numberOfColumns : 7,
				titleText : "Detail Fail Counts"
			},
*/
			{
				startColumnName : "TEST_CASE_PASS_COUNT",
				numberOfColumns : 4,
				titleText : "Total Result"
			}]
		});
		
		$.Topic("dataGrid/xhrComplete/" + "tgLiveStreamMain.do").unsubscribe(sub);
	});
	
	
	
	
	$("#${_wid}_radio").buttonset();
	
	$("#${_wid}_radio").children("input[type='radio']").each(function() {
		$(this).on("click", function() {
			$("#${_wid}_searchForm").find(".search").trigger("click");
		});
	});
});
</script>
<form id="${_wid}_searchForm">
<c:if test="${empty params}">
	<input type="hidden" name="TEST_PROJECT_ID" value="<spring:message code="tgweb.common.LIVE_STREAM"/>" />
  	<div>
		<table class="lTable">
			<tr>
				<th>Test Project</th>
				<td><spring:message code="tgweb.common.LIVE_STREAM"/></td>
			</tr>
		</table>
	</div>
</c:if>
<c:if test="${not empty params}">
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" name="FW_VERSION" value="${params.FW_VERSION}" />
	<input type="hidden" name="TEST_PROJECT_ID" value="${params.TEST_PROJECT_ID}" />
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
		</table>
	</div>
</c:if>
	<div class="searchDiv">
		<ul>
<c:if test="${empty params}">
			<li><select id="${_wid}_category" name="CATEGORY" class="select w120px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=select', emptyLabel:'Category', data:{tableName:'SQE_TEST_CASE_MASTER', target:'CATEGORY'}}"></select></li>
			<li><select id="${_wid}_model" name="MODEL" class="select w130px" data="{dependon:'${_wid}_category', formId:'${_wid}_searchForm', url:'cmnCommon.do?method=select', emptyLabel:'Model', data:{tableName:'SQE_TEST_CASE_MASTER', target:'MODEL'}}"></select></li>
			<li><select id="${_wid}_fwVersion" name="FW_VERSION" class="select w180px" data="{dependon:'${_wid}_model', formId:'${_wid}_searchForm', url:'cmnCommon.do?method=select', emptyLabel:'F/W Version', data:{tableName:'SQE_TEST_CASE_MASTER', target:'FW_VERSION'}}"></select></li>
		    <li><button type="button" class="search" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">search</button></li>
		    <li><button type="button" class="reset" data="{formId:'${_wid}_searchForm'}">reset</button></li>
		    <li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
</c:if>
<c:if test="${not empty params}">
			<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
</c:if>
			<li style="padding-left:5em;<c:if test="${not empty params}">display:none;</c:if>">
				<div id="${_wid}_radio">
					<input type="radio" id="${_wid}_radio1" name="IS_WEB" value="all" <c:if test="${empty isWeb}">checked="checked"</c:if> /><label for="${_wid}_radio1">All</label>
					<input type="radio" id="${_wid}_radio2" name="IS_WEB" value="n" <c:if test="${isWeb == 'n'}">checked="checked"</c:if> /><label for="${_wid}_radio2">Direct</label>
					<input type="radio" id="${_wid}_radio3" name="IS_WEB" value="y" <c:if test="${isWeb == 'y'}">checked="checked"</c:if> /><label for="${_wid}_radio3">Web</label>
				</div>
			</li>
		</ul>
	</div>
	<div>
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgLiveStreamMain.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.LIVE_STREAM.title"/> Main', pager:'#${_wid}_pager'}">
			<tr>
<c:if test="${empty params}">
				<th field="CATEGORY" width="80px">Category</th>
				<th field="MODEL" width="80px">Model</th>
				<th field="FW_VERSION" width="140px">Firmware</th>
</c:if>
				<th field="TEST_SUITE_ID" width="400px">Test Suite</th>
				<th field="TEST_CASE_COUNT" url="tgLiveStreamTc.do" addParam="{'method':'t', 'tabTitle':'TEST_SUITE_ID'}" uid="LiveStreamMain" width="80px;">Total TC</th>
<!-- 
				<th field="CODEC" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="60px">Codec</th>
				<th field="RESOLUTION" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="80px">Resolution</th>
				<th field="FRAME_COUNT" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="80px">Frame Count</th>
				<th field="FRAME_DEVIATION" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="90px">Frame Deviation</th>
				<th field="PC_DEVIATION" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="90px">PC Deviation</th>
				<th field="FRAME_REVERSE" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="90px">Frame Reverse</th>
				<th field="GOP_COUNT" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="90px">GOP Count</th>
 -->
				<th field="TEST_CASE_PASS_COUNT" width="60px">PASS</th>
				<th field="TEST_CASE_FAIL_COUNT" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" url="tgLiveStreamTc.do" addParam="{'method':'t', 'tabTitle':'TEST_SUITE_ID', 'filterColumn':'RESULT', 'filterValue':'FAIL'}" width="60px">FAIL</th>
				<th field="NG" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="60px">NG</th>
				<th field="PASS_RATE" width="80px">PASS RATE</th>
				<th field="IS_WEB" width="60px">Web</th>
			</tr>
		</table>
	</div>
	<div id="${_wid}_pager"></div>
</form>