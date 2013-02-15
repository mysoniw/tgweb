<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Login</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-cache" />
<link rel="stylesheet" href="<c:url value='/javascript/css/jquery-ui-1.8.16.custom.css'/>" type="text/css" media="screen" />
<link rel="stylesheet" href="<c:url value='/css/account.css'/>" type="text/css" media="screen" />
<link rel="stylesheet" href="<c:url value='/javascript/css/jquery.qtip.css'/>" type="text/css" media="all" />
<script type="text/javascript" src="<c:url value='/javascript/jquery/jquery-1.7.min.fixByAdonis750.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/jquery-ui-1.8.9.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/jquery.qtip.min.js'/>"></script>
<script type="text/javascript">
	$(function() {
		var valid = "${params.valid}";
		var dialogX = 400;
		var dialogY = 100;
		var postionFixY = -100;
		var message = "";
		
		if (valid === "password") {
			message = "<span style='color:red;font-weight:bold;'>Password incorrect!</span><br/>비밀번호 변경은 MySingle 계정으로 접속시 가능합니다.";
		} else if (valid === "id") {
			message = "<span style='color:red;font-weight:bold;'>User not found!</span><br/>사용자를 찾을 수 없습니다.<br/>시스템 관리자에게 문의하세요.<br/><br/>S/W 기술그룹 이수현 책임 (7344)<br/>S/W 기술그룹 김수엽 선임 (7360)";
		}
		
		var dialog = $("<div></div>").html(message).dialog(
				{
					autoOpen : false,
					modal : true,
					width : dialogX,
//					height : dialogY,
					position : [ (($(window).width() - dialogX) / 2) + $(window).scrollLeft(),
							(($(window).height() - dialogY) / 2) + $(window).scrollTop() + postionFixY ],
					title : "Login Failure..."
				}).height("auto");
	
		if (valid != "") {
			$("<div></div>").html(message).dialog({
						autoOpen : true,
						modal : true,
						width : dialogX,
//						height : dialogY,
						position : [ (($(window).width() - dialogX) / 2) + $(window).scrollLeft(),
								(($(window).height() - dialogY) / 2) + $(window).scrollTop() + postionFixY ],
						title : "Login Failure..."
					}).height("auto");		
			
			//dialog.dialog("open");
		}
	
		$("#password").on("keypress", function(e) {
			code = (e.keyCode ? e.keyCode : e.which);
			if (code === 13)		fnSubmit();
		});
		
		var bool = false;
		$("#password").on("keyup change", function(e) {
			if (bool !== !!$(this).attr("value").length) {
				bool = !!$(this).attr("value").length;
				fnButtonDisable(bool);
			}
		});
		
		$("#userId").on("change", function(e) {
			if (!!!$(this).val().length) {
				bool = !!$(this).val().length;
				fnButtonDisable(bool);
			}
		});
		
		$("#lbtnLogin").on("click", function(e) {
			e.preventDefault();
			fnSubmit();
		});
		
		$("#lbtnSingleLogin").on("click", function(e) {
			e.preventDefault();
			fnRedirect();
		});
	
		// browser에 비밀번호가 저장 되어 있을시를 위한 timeout
		setTimeout(function() {
			if (bool !== !!$("#password").val().length) {
				bool = !!$("#password").val().length;
				fnButtonDisable(bool);
			}
		}, 500)
		
	});
	
	function fnSubmit() {
		var emailFilter = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i;
		var ret = true;
	
		if (!emailFilter.test($("#userId").val())) {
			fnShowTooltip($("#userId"), "Not a valid email");
			ret = false;
		}
		if ($("#password").val() == "") {
			fnShowTooltip($("#password"), "Enter a password");
			ret = false;
		}
		if (ret) {
			$("form").submit();
		}
	}
	
	function fnRedirect() {
		location.href = "/authentication.jsp";
	}
	
	function fnShowTooltip(target, message) {
		var at = "bottom left";
		var my = "top right";
	
		$.each(target, function() {
			if (typeof $(this).data().qtip === "object") {
				$(this).qtip("show");
			} else {
				$(this).qtip({
					overwrite : false,
					content : "<span style='color:#FFFFFF;'>" + message + "</span>",
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
			}
		});
	}
	
	function fnButtonDisable(isInput) {
		var $loginButton = $("#lbtnLogin");
		var $singleButton = $("#lbtnSingleLogin");
		
		if (isInput) {
			$singleButton.attr("disabled", "disabled");
			$loginButton.removeAttr("disabled");
		} else {
			$loginButton.attr("disabled", "disabled");
			$singleButton.removeAttr("disabled");
		}
	}
</script>
</head>
<body class="login">
	<form method="post" action="/j_spring_security_check">
		<div style="margin: 30px auto -55px; padding: 18px; width: 520px;"></div>
		<div id="panelErrorMsg"></div>
		<div id="login">
			<div id="cap-top"></div>
			<div id="cap-body">
				<div id="branding" class="clearfix">
					<img id="imgLogo" src="/images/account/techwin_ci.png" style="border-width:0px;width:200px;float:left;" />
				</div>
				<div id="panelLogin">
					<div>
						<label> MySingle Email Address: </label> <input type="text" class="textbox340" name="userId" id="userId" value="<c:if test="${not empty rememberId}">${rememberId}</c:if><c:if test="${empty rememberId}">${params.userId}</c:if>" />
					</div>
					<div>
						<label> Password: </label> <input type="password" class="textbox340" name="password" id="password" />
					</div>
					<div class="submit clearfix" style="text-align:right;">
						<button id="lbtnLogin" class="buttonLoginV2" disabled="disabled">Login</button>
						<button id="lbtnSingleLogin" class="buttonLoginV2">Single Login</button>
					</div>
					<p class="lostpassword">
						<input type="checkbox" name="rememberId" id="rememberId" <c:if test="${not empty rememberId}">checked="checked"</c:if> />
						<label for="rememberId" style="display:inline !important;"> ID 저장</label>
						<!-- <a href="Index.aspx?A=ResetPassword" id="lostPasswordLink" target="_top"> Lost your password? </a> or <a href="http://kb.worldsecuresystems.com/portal_landing_page/SBO.html" target="_blank">Need
							help?</a> -->
					</p>
				</div>
			</div>
			<div id="cap-bottom">
				<img src="/images/account/cap-bottom.png" alt="" />
			</div>
		</div>
	</form>
</body>
</html>
