<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<link rel="stylesheet" href="<c:url value='/css/menu.css'/>" type="text/css" media="all" />
<script type="text/javascript">
$(function() {
	$(".menu").fixZIndex({recursive: true, msieOnly: true, zIndex: 15});
	
	var delay = 10;
	var zIndex = 100000;
	
	$(".menu li").hover(function() {
		var itemwidth = $(this).width(); /* Getting the LI width */
		$(this).prepend("<div class='hover'></div>"); /* Inserting a blank div into within li above the <a> tag*/
		$(this).find("div").fadeIn(delay).css({"width": itemwidth}); /* Using the itemwidth for the div to display properly*/
		$(this).find("> ul").css('z-index', zIndex).fadeIn(delay).slideDown(delay).css("display", "block");
		$(this).children("a").css("color", "white").fadeIn(delay);

	}, function() {
		$(this).find("div").slideUp(delay).fadeOut(delay);/* sliding up and fading out the hover div */
		$(this).find("div").remove();/* removing the <div> code from html at every mouseout event*/
		$(this).find("> ul").fadeOut(delay); /* fading out the sub menu */
		$(this).children("a").css("color", "#9E0039").fadeIn(delay);
	});
});
</script>
<div class="menu">
    <ul>
        <li id="nav_home"><a href="/tgMainResult.do?method=l">Home</a></li>
        <li id="nav_tg"><a href="/tgMainResult.do?method=l">Test Report</a>
            <ul>
				<li><a href="/tgMainResult.do?method=l">Main Result</a></li>
				<li><a href="#" class="parent">Multimedia</a>
					<ul>
						<li><a href="/tgSearchStreamMain.do?method=l">Search Stream</a></li>
						<li><a href="/tgLiveStreamMain.do?method=l">Live Stream</a></li>
						<li><a href="/tgBandwidthMain.do?method=l">Bandwidth</a></li>
					</ul>				
				</li>
				<li><a href="#" class="parent">Image</a>
					<ul>
						<li><a href="/tgViewLatencyMain.do?method=l">View Latency</a></li>
						<li><a href="/tgImageConfirmMain.do?method=l">Image Confirm</a></li>
					</ul>				
				</li>
				<li><a href="#" class="parent">Web</a>
					<ul>
						<li><a href="/tgWebMain.do?method=l">Validation</a></li>
						<li><a href="/tgLiveStreamMain.do?method=l&isWeb=y">Live Stream</a></li>
					</ul>				
				</li>
				<li><a href="#" class="parent">PTZ</a>
					<ul>
						<li><a href="/tgRs485Main.do?method=l">Protocol</a></li>
						<li><a href="/tgPtzMain.do?method=l">Command</a></li>
					</ul>				
				</li>
				<li><a href="/tgDSTMain.do?method=l">DST</a></li>
            </ul>
        </li>
        <li id="nav_sup"><a href="/supDownload.do?method=l">Support</a>
            <ul>
				<li><a href="/supDownload.do?method=l">Download</a></li>
				<li><a href="/supBoard.do?method=l">Board</a></li>
            </ul>
        </li>
	<security:authorize ifAllGranted="ROLE_ADMIN">
		<li id="nav_admin"><a href="/adminUserManagement.do?method=l">Admin</a>
		    <ul>
		        <li><a href="/adminUserManagement.do?method=l">User Management</a></li>
		    </ul>
		</li>
	</security:authorize>
    </ul>
</div>
