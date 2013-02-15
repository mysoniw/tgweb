<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgBandwidthMain.do").subscribe(fnGroupHeaders);
	
	function fnGroupHeaders(data) {
		$("#${_wid}_grid").jqGrid('destroyGroupHeader');
		$("#${_wid}_grid").jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : 'MAX_DOWNLOAD',
				numberOfColumns : 3,
				titleText : 'Download'
			}, {
				startColumnName : 'MAX_UPLOAD',
				numberOfColumns : 3,
				titleText : 'Upload'
			}]
		});
		
		$.Topic("dataGrid/xhrComplete/" + "tgBandwidthMain.do").unsubscribe(fnGroupHeaders);
	}
	
	$("#${_wid}_fullExcel").data({validation: function() {
		var object = [$("#${_wid}_category"), $("#${_wid}_model"), $("#${_wid}_fwVersion")];
		var at = ["bottom center", "top center"];
		var my = ["top left", "bottom left"];
		var flag = true;
		var returnObj = new Array();
		
		$.each(object, function(index) {
			var name = $(this).attr("name");
			var content = "<span style='color:#FFFFFF;'>" + name + "</span> is required";
			var isNotNCAM = false;

			if ($(this).attr("name") === "CATEGORY" && $(this).val() !== "" && $(this).val() !== "NCAM") {
				content = "현재는 <span style='color:#FFFFFF;'>NCAM</span>만 지원합니다."
				isNotNCAM = true;
			}
			
			var val = $(this).val();
			if (val === "" || isNotNCAM) {
				if (typeof $(this).next().data().qtip === "object") {
					$(this).next().qtip("option", "content.text", content);
					$(this).next().qtip("show");
				} else {
					$(this).next().qtip({
						overwrite : false,
						content : content,
						position : {
							at : at[index % 2],
							my : my[index % 2],
							viewport : $(window)
						},
						show : {
							event : false,
							ready : true
						},
						hide : {
							event : "click"
						},
						style : {
							classes : "ui-tooltip-shadow ui-tooltip-red"
						}
					});
				}
				flag = false;
			} else {
				returnObj.push(val);
			}
		});
		
		return (flag ? returnObj : false);
	}});
});
</script>
<form id="${_wid}_searchForm">
<c:if test="${empty params}">
	<input type="hidden" name="TEST_PROJECT_ID" value="<spring:message code="tgweb.common.BANDWIDTH"/>" />
  	<div>
		<table class="lTable">
			<tr>
				<th>Test Project</th>
				<td><spring:message code="tgweb.common.BANDWIDTH"/></td>
			</tr>
		</table>
	</div>
</c:if>
<c:if test="${not empty params}">
	<input type="hidden" id="${_wid}_category" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" id="${_wid}_model" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" id="${_wid}_fwVersion" name="FW_VERSION" value="${params.FW_VERSION}" />
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
			<!-- <li><button id="${_wid}_fullExcel" type="button" class="excel report" data="{url:'tgBandwidthMain.do', method:'report', formId:'${_wid}_searchForm', title:'<spring:message code="tgweb.common.BANDWIDTH.title"/> Main Report'}">report</button></li> -->
</c:if>
<c:if test="${not empty params}">
			<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
			<!-- <li><button id="${_wid}_fullExcel" type="button" class="excel report" data="{url:'tgBandwidthMain.do', method:'report', formId:'${_wid}_searchForm', title:'<spring:message code="tgweb.common.BANDWIDTH.title"/> Main Report'}">report</button></li> -->
</c:if>
		</ul>
	</div>
	<div>
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgBandwidthMain.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.BANDWIDTH.title"/> Main', pager:'#${_wid}_pager'}">
			<tr>
<c:if test="${empty params}">
				<th field="CATEGORY" width="80px">Category</th>
				<th field="MODEL" width="80px">Model</th>
				<th field="FW_VERSION" width="140px">Firmware</th>
</c:if>
				<th field="TEST_SUITE_ID" width="400px">Test Suite</th>
				<th field="TEST_CASE_COUNT" url="tgBandwidthTc.do" addParam="{'method':'t', 'tabTitle':'TEST_SUITE_ID'}" uid="BandwidthMain" width="80px;">Total TC</th>
				<th field="NG" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="60px">NG</th>
			</tr>
		</table>
	</div>
	<div id="${_wid}_pager"></div>
</form>
