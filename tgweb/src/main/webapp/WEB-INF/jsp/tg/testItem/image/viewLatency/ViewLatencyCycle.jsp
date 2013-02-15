<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgViewLatencyCycle.do").subscribe(fnGroupHeaders);
	
	function fnGroupHeaders(data) {
		$("#${_wid}_grid").jqGrid('destroyGroupHeader');
		$("#${_wid}_grid").jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : 'MAX_TIME',
				numberOfColumns : 4,
				titleText : 'Delay(s)'
			}, {
				startColumnName : 'MAX_DEVIATION',
				numberOfColumns : 4,
				titleText : 'Standard Deviation(s)'
			}]
		});
		
		$.Topic("dataGrid/xhrComplete/" + "tgViewLatencyCycle.do").unsubscribe(fnGroupHeaders);
	}
});
</script>
<form id="${_wid}_searchForm">
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" name="FW_VERSION" value="${params.FW_VERSION}" />
	<input type="hidden" name="TEST_PROJECT_ID" value="${params.TEST_PROJECT_ID}" />
	<input type="hidden" name="TEST_SUITE_ID" value="${params.TEST_SUITE_ID}" />
	<input type="hidden" name="TEST_CASE_ID" value="${params.TEST_CASE_ID}" />
	<input type="hidden" name="TEST_CASE_NAME" value="${params.TEST_CASE_NAME}" />
	<input type="hidden" name="SUITE_DESCRIPTION" value="${params.SUITE_DESCRIPTION}" />
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
				<th>Total Cycle</th>
				<td>${params.TOTAL_CYCLE}</td>
				<th></th>
				<td></td>
				<th></th>
				<td></td>
				<th></th>
				<td></td>
			</tr>
		</table>
	</div>
	<div class="searchDiv">
		<ul>
	    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
	    </ul>
	</div>
	<div>
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', pginput:false, formId:'${_wid}_searchForm', url:'tgViewLatencyCycle.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.VIEW_LATENCY.title"/> Cycle', pager:'#${_wid}_pager'}">
			<tr>
				<th field="CYCLE" url="tgViewLatencyDetail.do" addParam="{'method':'t'}" uid="ViewLatencyCycle" width="80px">Cycle</th>
				<th field="RESULT" syntax="{'flag':'NG','syntaxColor':'red'}" width="80px">NG</th>
				<th field="MAX_TIME" width="70px">Max</th>
				<th field="MIN_TIME" width="70px">Min</th>
				<th field="AVG_TIME" width="70px">Avg</th>
				<th field="STDEV_TIME" width="70px">Dev</th>
				<th field="MAX_DEVIATION" width="70px">Max</th>
				<th field="MIN_DEVIATION" width="70px">Min</th>
				<th field="AVG_DEVIATION" width="70px">Avg</th>
				<th field="STDEV_DEVIATION" width="70px">Dev</th>
			</tr>
		</table>
		<div id="${_wid}_pager"></div>
	</div>
</form>
