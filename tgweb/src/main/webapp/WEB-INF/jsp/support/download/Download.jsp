<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript" src="/javascript/jquery/widget/grid/jqgrid-ext.js"></script>
<script type="text/javascript" src="/javascript/jquery/widget/grid/jquery-form.js"></script>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "supDownload.do").subscribe(fnInit);
	
	function fnInit() {
		$(".file").each(function(i, item) {
			$(item).parser($(item).metadata());
			$(item).file($(item).metadata());
		});
		//$.Topic("dataGrid/xhrComplete/" + "supDownload.do").unsubscribe(fnInit);
	}
	
	(function() {
		$("#grid").on("jqGridAddEditBeforeSubmit", function(event, postdata, form, formoper) {
			var isMSIE = $.browser.msie ? true : false;

			// not support files object in MS ie
			if (!isMSIE) {
				if ($("input:file", form).length > 0) {
					if ($("input:file", form)[0].files.length > 0) {
						if ($("input:file", form)[0].files[0].fileSize > 104857600) {
							return [false, "file size : " + $("input:file", form)[0].files[0].fileSize + " byte <br/>upload file size exceeded (max 100MB)"];
						}
					} else {
						if (formoper === "add")		return [false, "no attached file"];
					}
				}
			} else {
				if (formoper === "add" && $("input:file", form).val() == "") {
					return [false, "no attached file"];
				}
			}
			return [true, "success"];
		});
	}());
});
</script>
<div id="tabs" class="tabs">
    <ul>
        <li><a href="#tab1"><span>Download</span></a></li>
    </ul>
    <div id="tab1">
    	<form id="searchForm" method="post">
    		<img id="virtualImg" style="display:none" />
			<div>
				<security:authorize ifAllGranted="ROLE_ADMIN">
					<table id="grid" class="grid" data="{formId:'searchForm', url:'supDownload.do', postData:{method:'s'}, key:'IDX', caption:'Download', dataProxy:$.jgrid.ext.ajaxFormProxy, editable:true
						, grouping:true, groupingView:{groupField:['CATEGORY'],groupCollapse:false,groupText:['<span style=color:red;font-weight:bold;>{0}</span> - {1} Item(s)']}}">
						<tr>
							<th field="CATEGORY" editoptions="{'maxlength':'200'}" width="180px">Category</th>
							<th field="ITEM" editoptions="{'maxlength':'50'}" width="100px">Item</th>
							<th field="VERSION" editoptions="{'maxlength':'50'}" width="80px">Version</th>
							<th field="FILE_DESC" editoptions="{'maxlength':'200'}" width="200px">파일설명</th>
							<th field="FILE_NAME" editable="false" width="200px">파일명</th>
							<th field="FILE_SIZE" editable="false" width="100px">용량</th>
							<th field="INSERT_DATE" editable="false" width="140px">등록일</th>
							<th field="downbutton" editable="false" format="button" editoptions="{'maxlength':'100'}" width="80px">Download</th>
							<th field="FILE" hidden="true" edittype="file" editrules="{'required':true}">AttachFile</th>
						</tr>
					</table>
				</security:authorize>
				<security:authorize ifNotGranted="ROLE_ADMIN">
					<table id="grid" class="grid" data="{formId:'searchForm', url:'supDownload.do', postData:{method:'s'}, key:'IDX', caption:'Download'
						, grouping:true, groupingView:{groupField:['CATEGORY'],groupCollapse:false,groupText:['<span style=color:red;font-weight:bold;>{0}</span> - {1} Item(s)']}}">
						<tr>
							<th field="CATEGORY" width="100px">Category</th>
							<th field="ITEM" width="100px">Item</th>
							<th field="VERSION" width="80px">Version</th>
							<th field="FILE_DESC" width="200px">파일설명</th>
							<th field="FILE_NAME" width="200px">파일명</th>
							<th field="FILE_SIZE" editable="false" width="100px">용량</th>
							<th field="INSERT_DATE" editable="false" width="140px">등록일</th>
							<th field="downbutton" format="button" width="80px">Download</th>
						</tr>
					</table>
				</security:authorize>
			</div>
			<div id="pager"></div>
			<div id="inlineNav"></div>
    	</form>
    </div>
</div>
