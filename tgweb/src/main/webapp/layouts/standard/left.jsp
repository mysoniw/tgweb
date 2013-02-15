<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
/*
	$("#west-grid").jqGrid({
		url : "tree.xml",
		datatype : "xml",
		height : "auto",
		pager : false,
		loadui : "disable",
		colNames : ["id", "Items", "url"],
		colModel : [{
			name : "id",
			width : 1,
			hidden : true,
			key : true
		}, {
			name : "menu",
			width : 150,
			resizable : false,
			sortable : false
		}, {
			name : "url",
			width : 1,
			hidden : true
		}],
		treeGrid : true,
		caption : "jqGrid Demos",
		ExpandColumn : "menu",
		autowidth : true,
		//width: 180,
		rowNum : 200,
		ExpandColClick : true,
		treeIcons : {
			leaf : 'ui-icon-document-b'
		}
	});
*/
</script>
<div id="left">
	<ul id="menu">
		<li><button type="button" onclick="javascript:location.href='/tgMainResult.do?method=l'">Main Result</button></li>
		<li><button type="button" onclick="javascript:location.href='/tgCodecMain.do?method=l'">Codec Main</button></li>
		<li><button type="button" onclick="javascript:location.href='/tgDSTMain.do?method=l'">DST Main</button></li>
		<li><button type="button" onclick="javascript:location.href='/tgOSDMain.do?method=l'">OSD Main</button></li>
		<li><button type="button" onclick="javascript:location.href='/tgRs485Main.do?method=l'">RS-485 Main</button></li>
		<li><button type="button" onclick="javascript:location.href='/tgBandwidthMain.do?method=l'">Bandwidth Main</button></li>
	</ul>
	<%--<table id="west-grid"></table>
--%></div>
