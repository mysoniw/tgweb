<script type="text/javascript">
$(function() {
	$("link[href='<c:url value='/css/jqueryparse.css'/>']").parsecss($.parsecss.jquery);
	if ($.browser.msie) {
		$.Topic("dataGrid/loadComplete").subscribe(function() {
			// Fixes ie7,8 empty td(border) issues
			$("tr:not(.jqgfirstrow) td:empty:not([id])").html("&nbsp;");
		});
	}
});
</script>