<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgMainModel.do").subscribe(function sub() {
		$("#${_wid}_grid").jqGrid('destroyGroupHeader');
		$("#${_wid}_grid").jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : "SEARCH_STREAM",
				numberOfColumns : 3,
				titleText : "Multimedia"
			}, {
				startColumnName : "VIEW_LATENCY",
				numberOfColumns : 2,
				titleText : "Image"
			}, {
				startColumnName : "WEB",
				numberOfColumns : 2,
				titleText : "Web"
			}, {
				startColumnName : "RS_485",
				numberOfColumns : 2,
				titleText : "PTZ"
			}]
		});
		
		$.Topic("dataGrid/xhrComplete/" + "tgMainModel.do").unsubscribe(sub);
	});
});
</script>
<form id="${_wid}_searchForm">
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
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
		</table>
	</div>
	<div class="searchDiv">
		<ul>
			<li><select id="${_wid}_fwVersion" name="FW_VERSION" class="select w180px" data="{formId:'${_wid}_searchForm', url:'cmnCommon.do?method=select', emptyLabel:'F/W Version', data:{tableName:'SQE_TEST_CASE_MASTER', target:'FW_VERSION'}}"></select></li>
			<li><button type="button" class="search" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">search</button></li>
			<li><button type="button" class="reset" data="{formId:'${_wid}_searchForm'}">reset</button></li>
			<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
	    </ul>
	</div>
	<div>
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgMainModel.do', postData:{method:'s'}, key:'TC_IDX', caption:'Model Result', pager:'#${_wid}_pager', customOptions:{colorCell: ['SEARCH_STREAM', 'LIVE_STREAM', 'BANDWIDTH', 'VIEW_LATENCY', 'IMAGE_CONFIRM', 'WEB', 'LIVE_STREAM_WEB', 'RS_485', 'PTZ', 'DST']}}">
			<tr>
				<th field="CATEGORY" width="80px">Category</th>
				<th field="MODEL" width="70px">Model</th>
				<th field="FW_VERSION" url="tgMainFw.do" addParam="{'method':'t', 'tabTitle':'MODEL'}" uid="MainModel" width="140px">Firmware</th>
				<th field="INSERT_DATE" width="140px">Latest Execution</th>
				<th field="SEARCH_STREAM" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="100px">Search Stream</th>
				<th field="LIVE_STREAM" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="80px">Live Stream</th>
				<th field="BANDWIDTH" syntax="{'matcher':'NOT_MATCH', 'flag':'O','syntaxColor':'red'}" width="80px">Bandwidth</th>
				<th field="VIEW_LATENCY" syntax="{'matcher':'NOT_MATCH', 'flag':'O','syntaxColor':'red'}" width="100px">View Latency</th>
				<th field="IMAGE_CONFIRM" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="100px">Image Confirm</th>
				<th field="WEB" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="80px">Validation</th>
				<th field="LIVE_STREAM_WEB" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="80px">Live Stream</th>
				<th field="RS_485" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="60px">Protocol</th>
				<th field="PTZ" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="70px">Command</th>
				<th field="DST" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="50px">DST</th>
			</tr>
		</table>
	</div>
	<div id="${_wid}_pager"></div>
</form>
