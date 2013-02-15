<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgBandwidthTc.do").subscribe(fnGroupHeaders);
	
	function fnGroupHeaders(data) {
		$("#${_wid}_grid").jqGrid('destroyGroupHeader');
		$("#${_wid}_grid").jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : 'MAX_DOWNLOAD',
				numberOfColumns : 4,
				titleText : 'Traffic (kbps)'
			}]
		});
		
		$.Topic("dataGrid/xhrComplete/" + "tgBandwidthTc.do").unsubscribe(fnGroupHeaders);
	}
	
	$("#${_wid}_sortable").sortable().disableSelection();
	
    $("#${_wid}_dialogForm").dialog({
        autoOpen: false,
        height: 300,
        width: 450,
        modal: true,
        buttons: {
            "Create a report": function(e) {
            	var text = $("#${_wid}_sortable > li").text();
            	var hiddenNames = ["x", "y", "z"];
            	$("#${_wid}_sortable > li").each(function(i) {
            		if ($("#${_wid}_" + hiddenNames[i]).length > 0) {
            			$("#${_wid}_" + hiddenNames[i]).val($(this).data().name);
            		} else {
	            		$("<input></input>").attr("type", "hidden").attr("name", hiddenNames[i]).attr("id", "${_wid}_" + hiddenNames[i]).val($(this).data().name).appendTo("#${_wid}_searchForm");
            		}
            	});
            	$("#${_wid}_searchForm .report").report("download");
                $(this).dialog("close");
            },
            "Cancel": function() {
                $(this).dialog("close");
            }
        },
        close: function() {
        	// no op
        }
    });
	
	$("#${_wid}_report").data({validation: function() {

		
		
		/*
		$("#${_wid}_extra6").selectmenu("value", 1);
		$("#${_wid}_extra7").selectmenu("value", 1);
		$("#${_wid}_extra8").selectmenu("value", 1);
		$("#${_wid}_extra9").selectmenu("value", 1);
		$("#${_wid}_extra11").selectmenu("value", 1);
		$("#${_wid}_extra12").selectmenu("value", 1);
		*/
		
		
		
		

		
		var selects = $("#${_wid}_searchForm > div.searchDiv select");
		var allSelects = $(selects).length;
		var fixedSelects = 0;
		var combinationArr = [];
		$.each(selects, function(i) {
			if ($(this).val() !== "") {
				fixedSelects++;
			} else {
				combinationArr.push({name:$(this).attr("name"), id:$(this).attr("id"), text:$(this).find("option:selected").text()});
			}
		});
		

		if (allSelects - fixedSelects <= 3 && allSelects - fixedSelects >= 2) {
			$("#${_wid}_sortable").empty();
			$.each(combinationArr, function() {
				$("<li></li>").html("<span class='ui-icon ui-icon-arrowthick-2-n-s'></span>" + this.text).addClass("ui-state-default").data(this).appendTo("#${_wid}_sortable");
			});
			
			$("#${_wid}_dialogForm").dialog("open");
			
			return true;
		} else {
			var content = "<span class='ui-icon ui-icon-alert' style='float:left;'></span>유효하지 않은 조합입니다.<br/><br/><span style='color:#FFFFFF;'>* " + allSelects + "개의 Select 중 " + fixedSelects + "개의 Select가 선택됨<br/></span><span style='color:#FFFFFF;'>* " + ((allSelects - 3) >= 0 ? (allSelects - 3) + "개 ~ " : "") + (allSelects - 2) + "개 선택 필요함" + "</span>";
			
			if (typeof $(this).data().qtip === "object") {
				$(this).qtip("option", "content.text", content);
				$(this).qtip("show");
			} else {
				$(this).qtip({
					overwrite : false,
					content : content,
					position : {
						at : "bottom center",
						my : "top left",
						viewport : $(window)
					},
					show : {
						event : false,
						ready : true
					},
					hide : {
						delay: 3000
					},
					style : {
						classes : "ui-tooltip-shadow ui-tooltip-red"
					}
				});
			}
			
			return false;
		}
	}});
});
</script>
<style>
.grab {
	cursor: hand;
	cursor: grab;
	cursor: -moz-grab;
	cursor: -webkit-grab;
}
.grabbing {
	cursor: grabbing;
	cursor: -moz-grabbing;
	cursor: -webkit-grabbing;
}
.sortable { 
	list-style-type: none; 
	margin: 0; 
	padding: 0; 
	width: 48%; 
}
.sortable li { 
	margin: 0 3px 3px 3px; 
	padding: 0.4em; 
	padding-left: 1.5em;
	font-size: 1.2em; 
	height: 18px; 
}
.sortable li span { 
	position: absolute;
	margin-left: -1.3em; 
}
</style>
<div id="${_wid}_dialogForm" title="Axis order configuration">
    <p style="color:red;">* Click on and drag an element to a new spot within the list</p>
    <form style="margin-top:2em;">
		<ul style="list-style-type:none; float:left;" class="sortable">
		    <li class="ui-state-default ui-state-disabled">Horizontal axis</li>
		    <li class="ui-state-default ui-state-disabled">Vertical axis</li>
		    <li class="ui-state-default ui-state-disabled">Sheet (Optional)</li>
		</ul>
		<ul id="${_wid}_sortable" style="list-style-type:none; margin-left:5px; float:left;" class="sortable grab">
		</ul>
    </form>
</div>
<form id="${_wid}_searchForm">
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" name="FW_VERSION" value="${params.FW_VERSION}" />
	<input type="hidden" name="TEST_PROJECT_ID" value="${params.TEST_PROJECT_ID}" />
	<input type="hidden" name="TEST_SUITE_ID" value="${params.TEST_SUITE_ID}" />
	<input type="hidden" name="SUITE_DESCRIPTION" value="${params.SUITE_DESCRIPTION}" />
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
</c:if>
			<li><button type="button" class="search" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">search</button></li>
		    <li><button type="button" class="reset" data="{formId:'${_wid}_searchForm'}">reset</button></li>
		    <li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
		    <li><button id="${_wid}_report" type="button" class="report" data="{formId:'${_wid}_searchForm', url:'tgBandwidthTc.do'}">report</button></li>
		</ul>
	</div>
	<div>
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgBandwidthTc.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.BANDWIDTH.title"/> TestCase', pager:'#${_wid}_pager', customOptions:{chartCell: ['MAX_DOWNLOAD', 'MIN_DOWNLOAD', 'AVG_DOWNLOAD', 'STDEV_DOWNLOAD']}}">
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
				<th field="TOTAL_CYCLE" url="tgBandwidthCycle.do" addParam="{'method':'t', 'tabTitle':'TEST_CASE_ID'}" uid="BWTc" width="80px;">Total Cycle</th>
				<th field="NG" syntax="{'matcher':'NOT_MATCH', 'flag':0, 'syntaxColor':'red'}" width="60px">NG</th>
				<th field="MAX_DOWNLOAD" width="100px">Max</th>
				<th field="MIN_DOWNLOAD" width="100px">Min</th>
				<th field="AVG_DOWNLOAD" width="100px">Avg</th>
				<th field="STDEV_DOWNLOAD" width="100px">Dev</th>
			</tr>
		</table>
	</div>
	<div id="${_wid}_pager"></div>
</form>
