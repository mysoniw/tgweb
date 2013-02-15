<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
function fnCustomValid(value, name) {
	var retArray = [true, ""];
	
	var filter = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i;
	if(!filter.test(value)) {
		return [false, "<br/><span style='color:red;'>" + $.jgrid.edit.msg.email + "</span>"];
	}
	
	var savedRow = $(this).jqGrid('getGridParam', 'savedRow');
	if (savedRow.length < 1 || savedRow[0].id == 'new_row') {
		$.ajax({
			url: "adminUserManagement.do",
			data: {method:"checkDuplication", email:value},
			type: "post",
			async: false,
			dataType: "json",
			success: function(_response) {
				if (_response.result) {
					retArray = [false, "<br/><span style='color:red;'>e-mail already exists!</span>"];
				}			
			},
			error: function() {
				alert("xhr failed");
			}
		})
	} 
	
	return retArray;
}
</script>
<div id="tabs" class="tabs">
    <ul>
        <li><a href="#tab1"><span>사용자 관리</span></a></li>
    </ul>
    <div id="tab1">
    	<form id="searchForm">
			<div class="searchDiv">
				<ul>
					<li><input type="text" name="USER_EMPNO" size="8" class="waterMark" data="{waterMarkText:'사번'}" /></li>
					<li><input type="text" name="USER_NAME" size="8" class="waterMark" data="{waterMarkText:'이름'}" /></li>
					<li><input type="text" name="USER_EMAIL" size="14" class="waterMark" data="{waterMarkText:'e-mail'}" /></li>
					<li><select id="compName" name="COMPNAME" class="select w130px" data="{formId:'searchForm', url:'adminCommon.do?method=select', emptyLabel:'회사명', data:{target:'COMPNAME'}}"></select></li>
					<li><select id="deptName" name="DEPTNAME" class="select w260px" data="{formId:'searchForm', url:'adminCommon.do?method=select', emptyLabel:'부서명', data:{target:'DEPTNAME'}}"></select></li>
					<li><select id="userGrade" name="USER_GRADE" class="select w150px" data="{formId:'searchForm', url:'adminCommon.do?method=select', emptyLabel:'직위', data:{target:'USER_GRADE'}}"></select></li>
				    <li><button type="button" class="search" data="{gridId:'grid', formId:'searchForm'}">search</button></li>
				    <li><button type="button" class="reset" data="{formId:'searchForm'}">reset</button></li>
				    <li><button type="button" class="excel" data="{gridId:'grid', formId:'searchForm'}">excel</button></li>
			    </ul>
			</div>
			<div>
				<table id="grid" class="grid" data="{formId:'searchForm', url:'adminUserManagement.do', postData:{method:'s'}, key:'USER_EMAIL', caption:'User Management', editurl:'adminUserManagement.do?method=up', editable:true, inlineNav:true}">
					<tr>
						<th field="USER_EMPNO" editrules="{'required':true}" editoptions="{'maxlength':'50'}" width="80px">사번</th>
						<th field="USER_NAME" editrules="{'required':true}" editoptions="{'maxlength':'100'}" width="80px">이름</th>
						<th field="USER_GRADE" editoptions="{'maxlength':'50'}" width="80px">직위</th>
						<th field="USER_EMAIL" editrules="{'custom':true, 'custom_func':'fnCustomValid()'}" editoptions="{'maxlength':'100'}" width="200px">e-mail</th>
						<th field="COMPNAME" editoptions="{'maxlength':'50'}" width="120px">회사명</th>
						<th field="DEPTNAME" editoptions="{'maxlength':'50'}" width="280px">부서명</th>
						<th field="DEPTCODE" editoptions="{'maxlength':'50'}" width="80px">부서 Code</th>
						<th field="USER_AUTH" width="80px" edittype="select" editoptions="{'value':{'USER':'USER','ADMIN':'ADMIN'}}">등급</th>
					</tr>
				</table>
			</div>
			<div id="pager"></div>
			<div id="inlineNav"></div>
    	</form>
    </div>
</div>
