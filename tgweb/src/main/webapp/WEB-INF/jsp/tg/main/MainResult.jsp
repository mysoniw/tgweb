<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgMainResult.do").subscribe(function sub() {
		$("#grid").jqGrid('destroyGroupHeader');
		$("#grid").jqGrid('setGroupHeaders', {
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
		
		$.Topic("dataGrid/xhrComplete/" + "tgMainResult.do").unsubscribe(sub);
	});
});
</script>
<div id="tabs" class="tabs">
    <ul>
        <li><a href="#tab1"><span>${pageName}</span></a></li>
    </ul>
    <div id="tab1">
    	<form id="searchForm">
    		<div class="searchDiv">
				<ul>
				    <li><select id="category" name="CATEGORY" class="select w120px" data="{url:'cmnCommon.do?method=select', emptyLabel:'Category', data:{tableName:'SQE_TEST_CASE_MASTER', target:'CATEGORY'}}"></select></li>
				    <li><select id="model" name="MODEL" class="select w130px" data="{dependon:'category', url:'cmnCommon.do?method=select', emptyLabel:'Model', data:{tableName:'SQE_TEST_CASE_MASTER', target:'MODEL'}}"></select></li>
				    <li><button type="button" class="search" data="{gridId:'grid', formId:'searchForm'}">search</button></li>
				    <li><button type="button" class="reset" data="{formId:'searchForm'}">reset</button></li>
				    <li><button type="button" class="excel" data="{gridId:'grid', formId:'searchForm'}">excel</button></li>
				</ul>
    		</div>
			<div>
				<table id="grid" class="grid" data="{formId:'searchForm', url:'tgMainResult.do', postData:{method:'s'}, key:'TC_IDX', caption:'Main Result', customOptions:{colorCell: ['SEARCH_STREAM', 'LIVE_STREAM', 'BANDWIDTH', 'VIEW_LATENCY', 'IMAGE_CONFIRM', 'WEB', 'LIVE_STREAM_WEB', 'RS_485', 'PTZ', 'DST']}}">
					<tr>
						<th field="CATEGORY" width="80px">Category</th>
						<th field="MODEL" url="tgMainModel.do" addParam="{'method':'t'}" uid="MainResult">Model</th>
						<!-- <th field="FW_VERSION" url="tgMainFw.do" addParam="{'method':'t', 'tabTitle':'MODEL'}" uid="MainFw" width="150px">Latest F/W</th> -->
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
			<div id="pager"></div>
    	</form>
    </div>
</div>
