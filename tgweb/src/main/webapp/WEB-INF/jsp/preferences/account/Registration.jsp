<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
<!--
$(function() {
	var singleAccess = false;
<security:authorize ifAllGranted="SINGLE_ACCESS">
	singleAccess = true;
</security:authorize>

	if (singleAccess) {
		$("#tabs").tabs();
	} else {
		$("#tabs").tabs({
			disabled: [0],
			selected: [1]
		});
	}
	
	// ##############################################
	// #	사용자 관리								#
	// ##############################################
	
	var accessMode = "${params.accessMode}";
	var dialogX = 400;
	var dialogY = 200;
	var postionFixY = -100;
	var accessModeMessage = "";
	
	switch (accessMode) {
	case "auto":
		accessModeMessage = "<span style='color:red;font-weight:bold;'>Password Not Registered</span><br/>MySingle에 접속하지 않은 PC에서의 <br/>접속을 위한 비밀번호 등록이 필요합니다.";
		break;
//	case "success":
//		accessModeMessage = "<span style='color:red;font-weight:bold;'>Password Registered</span><br/>비밀번호가 정상적으로 등록 되었습니다.";
//		break;
	}
	var dialog = $("<div></div>").html(accessModeMessage).dialog({
		autoOpen: false,
		modal: true,
		width: dialogX,
//		height: dialogY,
		position: [(($(window).width() - dialogX) / 2) + $(window).scrollLeft(), (($(window).height() - dialogY) / 2) + $(window).scrollTop() + postionFixY],
		title: "Password Registration",
		buttons: {
			"확인": function() {
				$(this).dialog( "close" );
			},
			"나중에 등록": function() {
				location.href = "/";
				$(this).dialog( "close" );
			}
		}
	}).height("auto");
	
	if (accessMode != "") {
		dialog.dialog("open");
	}
	
	$("#confirmPass").on("keypress", function(e) {
		code = (e.keyCode ? e.keyCode : e.which);
		if (code == 13)		$("#formSubmit").click();
	});
	
	$("#formSubmit").data({validation: function() {
		var objects = [$("#password"), $("#confirmPass")];
		//var regExp = /((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20})/;
		var failureObjects = [];
		var at = "right center";
		var my = "left center";
		var flag = true;
		
		var pair = false;
		
		$.each(objects, function(index) {
			var val = $(this).val();
			var strength = fnPassStrength(val);
			
			if (val == "") {
				$(this).data("message", "Required");
				failureObjects.push(this);
				flag = false;
			} else if (strength != true){
				$(this).data("message", strength);
				failureObjects.push(this);
				flag = false;
			} else if (pair) {
				if (pair != val) {
					$(this).data("message", "Password와 동일한 값이 필요합니다.");
					failureObjects.push(this);
					flag = false;
				}
			}
			
			pair = val;
			
			$.each(failureObjects, function() {
				if (typeof $(this).data().qtip === "object") {
					$(this).qtip("destroy");
				}
				var title = $(this).attr("title");
				var message = $(this).data("message");
				$(this).qtip({
					overwrite : false,
					content : "<span style='color:#FFFFFF;'>" + title + ": </span> " + message,
					position : {
						at : at,
						my : my,
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
			});
			
			if (failureObjects.length == 0) {
				$.each(objects, function() {
					if (typeof $(this).data().qtip === "object") {
						$(this).qtip("destroy");
					}
				});
			}
		});
		return flag;
	}});
	
	
	function fnPassStrength(password) {
		if (password.length < 8) {
			return "비밀번호는 8자리 이상이어야 합니다.";
		}
		
		if (password.length > 20) {
			return "비밀번호는 20자리 이하여야 합니다.";
		}
		
		var hasUpperCase = /[A-Z]/.test(password);
		var hasLowerCase = /[a-z]/.test(password);
		var hasNumbers = /\d/.test(password);
		var hasSpecial = /[!@#$%^&*]/.test(password);

		if (hasUpperCase + hasLowerCase + hasNumbers + hasSpecial < 2) {
			return "영문대문자, 영문소문자, 숫자, 특수문자(@#$%^&*) 중 두가지 이상의 조합이 필요합니다.";
		}
		return true;
	}
	
	
	// ##############################################
	// #	설정										#
	// ##############################################
	var defaultData = [15, 30, 50, 100, 200, 500, 1000];
	var rowList = window.smileGlobal.rowList ? window.smileGlobal.rowList : defaultData;
	var firstRowLock = true;
	
    var values = [5, 10, 15, 20, 25, 30, 40, 50, 80, 100, 150, 200, 300, 400, 500, 700, 1000];
	
	// initialize
	$.each(rowList, function() {
		fnAddRow(this);
	});
	
	// bind events
	$("#cloneTableRows").on("click", function(){
		fnAddRow();
	});
	
	$(".delRow").on("click", function(){
		$(this).parents("tr").remove();
		
		$("#rowListTable").find("tr").each(function(i) {
			if (i > 1) {
				$(this).find("td:first").text(i - 1);
			}
		});
		return false;
	});
	
	// functions
	function fnAddRow(defaultValue) {
		var thisTable = $("#rowListTable");
		var firstRow = thisTable.find("tr:first");
		var newRow = firstRow.clone(true);
		
		if (firstRowLock) {
			newRow.find("td:last").each(function() {
				$(this).children().each(function() {
					$(this).remove();
				})
			});
			firstRowLock = false;
		}
		
		newRow.css("display", "");
		thisTable.append(newRow);
		
		var trIndex = thisTable.find("tr").length - 2;
		newRow.find("td:first").text(trIndex);
		newRow.find("td :input").val(defaultValue ? defaultValue : 100);
		
		newRow.find(".textBox").each(function() {
		    $(this).numeric();
		});
		
		newRow.find(".slider").each(function() {
			var slider = $(this).slider({
				range: "min",
				//max: rangeMax,
				//min: rangeMin,
				//step: 5,
				value: defaultValue ? defaultValue : 100,
		        min: 5,
		        max: 1000,
		        //values: [0, 1000000],
		        slide: function(event, ui) {
		            var includeLeft = event.keyCode != $.ui.keyCode.RIGHT;
		            var includeRight = event.keyCode != $.ui.keyCode.LEFT;
		            var value = findNearest(includeLeft, includeRight, ui.value);
		            slider.slider('value', value);
					//var value = ui.value;
                    
                    $(this).parent().next().children().each(function() {
                    	$(this).val(value);
                    });
		            return false;
		        }		
			});
		});
		
		return false;
	}
	
    function findNearest(includeLeft, includeRight, value) {
        var nearest = null;
        var diff = null;
        for (var i = 0; i < values.length; i++) {
            if ((includeLeft && values[i] <= value) || (includeRight && values[i] >= value)) {
                var newDiff = Math.abs(value - values[i]);
                if (diff == null || newDiff < diff) {
                    nearest = values[i];
                    diff = newDiff;
                }
            }
        }
        return nearest;
    }
});
//-->
</script>
<div id="tabs">
    <ul>
        <li><a href="#tab1"><span>사용자 관리</span></a></li>
        <li><a href="#tab2"><span>설정</span></a></li>
    </ul>
    <div id="tab1">
    	<form id="form" method="post">
			<table class="lTable">
				<tr>
					<th style="width:200px !important;">Your Registered email</th>
					<td style="width:300px !important; text-align:left !important;"><security:authentication property="principal.email" /></td>
				</tr>
				<tr>
					<th>Password</th>
					<td style="text-align:left !important;">
						<input type="password" name="password" id="password" size="14" class="w80" title="Password" /><br/>
						<span>8자 이상 20자 이하 영문대문자, 영문소문자, 숫자, 특수문자(@#$%^&*) 중 두가지 이상의 조합</span>
					</td>
				</tr>
				<tr>
					<th>Confirm Password</th>
					<td style="text-align:left !important;">
						<input type="password" id="confirmPass" size="14" class="w80" title="Confirm Password" />
					</td>
				</tr>
			</table>
			<div class="searchDiv">
				<ul>
				    <li><button type="button" class="formSubmit" id="formSubmit" data="{formId:'form', url:'preAccount.do'}">저장</button></li>
			    </ul>
		    </div>
    	</form>
    </div>
    <div id="tab2">
    	<form id="configForm" method="post">
			<table id="rowListTable" class="lTable">
				<tr style="display:none;">
					<td style="width:20px;"></td>
					<td style="width:500px;"><div class="slider"></div></td>
					<td style="width:20px;"><input type="text" name="rowList" class="textBox" maxlength="5" size="5" /></td>
					<td style="width:5px;"><img src="/images/account/del.png" class="delRow" /></td>
				</tr>
				<tr>
					<th style="width:20px;"></th>
					<th style="width:500px;">Grid 표시 설정</th>
					<th style="width:20px;">Size</th>
					<td style="width:5px;"><img src="/images/account/add.png" id="cloneTableRows" /></td>
				</tr>
			</table>
			<div class="searchDiv">
				<ul>
				    <li><button type="button" class="formSubmit" id="configFormSubmit" data="{formId:'configForm', url:'preAccount.do', data:{method:'preferences'}}">저장</button></li>
			    </ul>
		    </div>
    	</form>
    </div>
</div>
