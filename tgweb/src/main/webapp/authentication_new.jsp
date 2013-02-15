<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>Samsung mySingle</title>
<script type="text/javascript" src="<c:url value='/javascript/jquery/jquery-1.7.min.fixByAdonis750.js'/>"></script>
<script type="text/javascript" src="http://www.samsung.net/portalWeb/js/mySingleAdm.js"></script> 
<script type="text/javascript">
	function checkUseSyncEXE() {
		var useSyncExe;
		if (navigator.userAgent.toLowerCase().indexOf("windows") != -1 && navigator.userAgent.toLowerCase().indexOf("msie") == -1) {
			useSyncExe = true;
		} else {
			useSyncExe = false;
		}

		return useSyncExe;
	}

	function goInit() {
		mySingleAdm.initialize();
		mySingleAdm.useEpAdmJC(checkUseSyncEXE());
		mySingleAdm.islogin("isloginCallback");
	}

	function isloginCallback(result) {
		if (result) {
			mySingleAdm.sync("autosubmitCallback");
		} else {
			fnSingleFailure();
		}
	}

	function autosubmitCallback() {
		var rrtn = mySingleAdm.getSecureBox();
		if (rrtn != "") {
			$("#ep_data").attr("value", rrtn);
			$("#form").submit();
		} else {
			fnSingleFailure();
		}
	}
		
	function fnSingleFailure() {
		var dialogX = 400;
		var dialogY = 180;
		var postionFixY = -100;
		
		var dialog = $("<div></div>").html("<span style='color:red;font-weight:bold;'>* MySingle 인증 정보가 없습니다.</span><br/>MySingle 접속후 Retry 하시거나<br/>등록하신 Password로 Login 하시기 바랍니다.").dialog({
			autoOpen: true,
			modal: true,
			width: dialogX,
//				height: dialogY,
			position: [(($(window).width() - dialogX) / 2) + $(window).scrollLeft(), (($(window).height() - dialogY) / 2) + $(window).scrollTop() + postionFixY],
			title: "MySingle Authentication Failed",
			buttons: {
				"Login": function() {
					location.href = "/trusted/preLogin.do?method=login";
					$(this).dialog( "close" );
				},
				"Retry": function() {
					location.href = "/";
					$(this).dialog( "close" );
				}
			}
		}).height("auto");
		return false;
	}
</script>
</head>
<body>
	<form id="form" method="post" action="/j_spring_security_check">
		<input type="hidden" name="userId" id="ep_data" value="" />
		<input type="hidden" name="goURL" value="/j_spring_security_check" />
		<input type="hidden" name="goParamName" value="userId" />
	</form>
	<!-- Tag for SSO Start -->
	<script type="text/javascript">
		if (navigator.appVersion.indexOf("Mac") != -1) {
			$("#form").attr("action", "http://www.samsung.net/portalWeb/getSecureBox.jsp");
			$("#form").submit();
		} else {
			try {
				mySingleAdm.installComponent("goInit();", "http://www.samsung.net/portalWeb/cabs/");
			} catch(e) {
				//console.debug(e);
				fnSingleFailure();
			}
		}
	</script>
	<!-- Tag for SSO End -->
</body>
</html>
