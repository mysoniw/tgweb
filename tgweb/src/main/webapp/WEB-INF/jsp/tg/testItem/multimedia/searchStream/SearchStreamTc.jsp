<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgSearchStreamTc.do").subscribe(function sub(data) {
		var startColumnName = "AVG_F_COUNT";
		var numberOfColumns = 3;
		
		if (data.rows.length > 0 && (data.rows[0].EXTRA3 == "H.264" || data.rows[0].EXTRA3 == "MPEG4")) {
			startColumnName = "AVG_GOP_SIZE";
			numberOfColumns = 4;
		}
		
		$("#${_wid}_grid").jqGrid('destroyGroupHeader');
		$("#${_wid}_grid").jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : startColumnName,
				numberOfColumns : numberOfColumns,
				titleText : "Avg Values"
			}, {
				startColumnName : "RESULT",
				numberOfColumns : 5,
				titleText : "Total Result"
			}]
		});
		
		$.Topic("dataGrid/xhrComplete/" + "tgSearchStreamTc.do").unsubscribe(sub);
	});
});
</script>
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
<c:if test="${params.CATEGORY == 'NCAM'}">
			<tr>
				<th>Encoding</th>
				<td>${params.EXTRA3}</td>
			</tr>
</c:if>
<c:if test="${params.CATEGORY == 'NVR'}">
			<tr>
				<th>Codec</th>
				<td>${params.EXTRA3}</td>
			</tr>
</c:if>
		</table>
	</div>
	<div class="searchDiv">
		<ul>
			<li><select id="${_wid}_extra4" name="EXTRA4" class="select w120px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Resolution', data:{target:'EXTRA4'}}"></select></li>
<c:if test="${params.CATEGORY == 'NCAM'}">
			<li><select id="${_wid}_extra5" name="EXTRA5" class="select w120px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Framerate', data:{target:'EXTRA5'}}"></select></li>
			<li><select id="${_wid}_extra6" name="EXTRA6" class="select w110px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Bitrate', data:{target:'EXTRA6'}}"></select></li>
			<li><select id="${_wid}_extra7" name="EXTRA7" class="select w110px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Compression', data:{target:'EXTRA7'}}"></select></li>
	<c:if test="${params.EXTRA3 == 'MPEG4'}">
			<li><select id="${_wid}_extra8" name="EXTRA8" class="select w120px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'BitControl', data:{target:'EXTRA8'}}"></select></li>
			<li><select id="${_wid}_extra9" name="EXTRA9" class="select w110px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Priority', data:{target:'EXTRA9'}}"></select></li>
			<li><select id="${_wid}_extra10" name="EXTRA10" class="select w110px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'GOP Size', data:{target:'EXTRA10'}}"></select></li>
	</c:if>
	<c:if test="${params.EXTRA3 == 'H.264'}">
			<li><select id="${_wid}_extra8" name="EXTRA8" class="select w120px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'BitControl', data:{target:'EXTRA8'}}"></select></li>
			<li><select id="${_wid}_extra9" name="EXTRA9" class="select w110px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Priority', data:{target:'EXTRA9'}}"></select></li>
			<li><select id="${_wid}_extra10" name="EXTRA10" class="select w110px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'GOP Size', data:{target:'EXTRA10'}}"></select></li>
			<li><select id="${_wid}_extra11" name="EXTRA11" class="select w150px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Entropy Coding', data:{target:'EXTRA11'}}"></select></li>
			<li><select id="${_wid}_extra12" name="EXTRA12" class="select w110px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Profile', data:{target:'EXTRA12'}}"></select></li>
	</c:if>
</c:if>                                                                      
<c:if test="${params.CATEGORY == 'NVR'}">                                     
			<li><select id="${_wid}_extra5" name="EXTRA5" class="select w120px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Framerate', data:{target:'EXTRA5'}}"></select></li>
</c:if>                                                                       
<c:if test="${params.CATEGORY == 'DVR'}">                                     
			<li><select id="${_wid}_extra2" name="EXTRA2" class="select w110px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Quality', data:{target:'EXTRA2'}}"></select></li>
			<li><select id="${_wid}_extra5" name="EXTRA5" class="select w120px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=groupSelect', emptyLabel:'Framerate', data:{target:'EXTRA5'}}"></select></li>
</c:if>
			<li><button type="button" class="search" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">search</button></li>
		    <li><button type="button" class="reset" data="{formId:'${_wid}_searchForm'}">reset</button></li>
		    <li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
		</ul>
	</div>
	<div>
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgSearchStreamTc.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.SEARCH_STREAM.title"/> TestCase', pager:'#${_wid}_pager'}"
			filterGrid="{'column':'${params.filterColumn}', 'value':'${params.filterValue}', 'len':'${params.TEST_CASE_FAIL_COUNT}'}">
			<tr>
				<th field="TEST_CASE_NAME" width="30px">TC</th>
				<th field="EXTRA4" width="100px">Resolution</th>
<c:if test="${params.CATEGORY == 'NCAM'}">
				<th field="EXTRA5" width="80px">Framerate</th>
				<th field="EXTRA6" width="80px">Bitrate</th>
				<th field="EXTRA7" width="90px">Compression</th>
	<c:if test="${params.EXTRA3 == 'MPEG4'}">
				<th field="EXTRA8" width="80px">BitContorll</th>
				<th field="EXTRA9" width="90px">Priority</th>
				<th field="EXTRA10" width="80px">GOP Size</th>
	</c:if>
	<c:if test="${params.EXTRA3 == 'H.264'}">
				<th field="EXTRA8" width="80px">BitContorll</th>
				<th field="EXTRA9" width="90px">Priority</th>
				<th field="EXTRA10" width="70px">GOP Size</th>
				<th field="EXTRA11" width="100px">Entropy Coding</th>
				<th field="EXTRA12" width="60px">Profile</th>
	</c:if>
</c:if>
<c:if test="${params.CATEGORY == 'NVR'}">
				<th field="EXTRA5" width="80px">Framerate</th>
</c:if>
<c:if test="${params.CATEGORY == 'DVR'}">
				<th field="EXTRA2" width="80px">Quality</th>
</c:if>
				<th field="TOTAL_CYCLE" url="tgSearchStreamCycle.do" addParam="{'method':'t', 'tabTitle':'TEST_CASE_ID'}" uid="SearchStreamTc" width="80px;">Total Cycle</th>
<c:if test="${params.CATEGORY == 'NCAM'}">
	<c:if test="${params.EXTRA3 == 'H.264' || params.EXTRA3 == 'MPEG4'}">
				<th field="AVG_GOP_SIZE" width="100px">Avg GOP Value</th>
	</c:if>
</c:if>
				<th field="AVG_F_COUNT" width="100px">Frame Count</th>
				<th field="AVG_F_DEVIATION" width="100px">Frame Deviation</th>
				<th field="AVG_PC_DEVIATION" width="100px">PC Deviation</th>
				<th field="RESULT" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="80px">Result</th>
				<th field="PASS" width="60px">PASS</th>
				<th field="FAIL" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" url="tgSearchStreamCycle.do" addParam="{'method':'t', 'tabTitle':'TEST_CASE_ID', 'filterColumn':'RESULT', 'filterValue':'FAIL'}" width="60px">FAIL</th>
				<th field="NG" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="60px">NG</th>
				<th field="PASS_RATE" width="80px">PASS RATE</th>
			</tr>
		</table>
	</div>
	<div id="${_wid}_pager"></div>
</form>
