<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head><title>Samsung mySingle</title>
<script type="text/javascript" src="<c:url value='/javascript/jquery/jquery-1.7.min.fixByAdonis750.js'/>"></script>
<script type="text/javascript">
$(function() {
	goSession();
});
function goSession() {
	if (/msie/i.test(navigator.userAgent)) {
		try {
			var rrtn = EpAdmC.GetSecureBox();
			if (rrtn != "") {
				$("#ep_data").attr("value", rrtn);
				$("#form").submit();
			} else {
				fnSingleFailure();
			}
		} catch(e) {
			fnSingleFailure();
		}
	} else {
		document.location.href = "authentication_new.jsp";
	}
	
	function fnSingleFailure() {
		var dialogX = 400;
		var dialogY = 180;
		var postionFixY = -100;
		
		var dialog = $("<div></div>").html("<span style='color:red;font-weight:bold;'>* MySingle 인증 정보가 없습니다.</span><br/>MySingle 접속후 Retry 하시거나<br/>등록하신 Password로 Login 하시기 바랍니다.").dialog({
			autoOpen: true,
			modal: true,
			width: dialogX,
//			height: dialogY,
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
}
</script>
</head>
<body>
<OBJECT ID="EpAdm2 Control" name="EpAdmC" CLASSID="CLSID:C63E3330-049F-4C31-B47E-425C84A5A725"></OBJECT>
	<form name="form" id="form" method="post" action="/j_spring_security_check">
		<input type="hidden" name="userId" id="ep_data" value="" />
	</form>
</body>
</html>