<%@ include file="/common/taglibs.jsp"%>
<link rel="shortcut icon" href="<c:url value='/images/smile.png'/>" />
<link rel="stylesheet" href="<c:url value='/javascript/css/jquery-ui-1.8.16.custom.css'/>" type="text/css" media="screen" />	
<link rel="stylesheet" href="<c:url value='/javascript/css/ui.jqgrid.css'/>" type="text/css" media="screen" />	
<link rel="stylesheet" href="<c:url value='/css/common.css'/>" type="text/css" media="all" />
<link rel="stylesheet" href="<c:url value='/javascript/css/jquery.qtip.css'/>" type="text/css" media="all" />
<link rel="stylesheet" href="<c:url value='/css/jqueryparse.css'/>" type="text/css" media="all" />
<link rel="stylesheet" href="<c:url value='/javascript/css/ui.selectmenu.css'/>" type="text/css" media="all" />
<!-- 
	<link href='http://fonts.googleapis.com/css?family=Ubuntu+Condensed' rel='stylesheet' type='text/css'>
 -->
<!-- Modification needed in order to make Plug-ins work in hidden jQuery tabs. -->
<style type="text/css">
	.ui-tabs .ui-tabs-hide {
		position: absolute;
		top: -100000px;
		/*left: -10000px;*/
		display: block !important;
	}
</style>
<!-- always first -->
<script type="text/javascript" src="<c:url value='/javascript/jquery/jquery-1.7.min.fixByAdonis750.js'/>"></script>
<!-- always top -->
<script type="text/javascript" src="<c:url value='/javascript/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/jquery-ui-1.8.9.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/widget/ui/accordionExtends.js'/>"></script>
<script type="text/javascript">
	window.smileGlobal = $.parseJSON('${sessionScope.preferences}') || {};
</script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/numeric/jquery.numeric.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/jquery.metadata.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/jquery.parsecss.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/ajaxfileupload.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/grid.locale-en.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/jquery.jqGrid.4.40.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/ui.tabs.closable.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/highcharts/highcharts.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/highcharts/highcharts-more.js'/>"></script>
<!-- 
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/highcharts/highcharts.2.3.beta.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/highcharts/highcharts-more.2.3.beta.js'/>"></script>
 -->
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/highcharts/themes/custom.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/highcharts/modules/exporting.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/jquery.qtip.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/jquery.require.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/widget/require.js'/>"></script>
<script type="text/javascript" src="<c:url value='/javascript/jquery/plugin/selectmenu/ui.selectmenu.js'/>"></script>

<!-- always bottom -->
<!-- 
<script type="text/javascript" src="<c:url value='/javascript/jquery/jquery.lint.js'/>"></script>
<script type="text/javascript">
jQuery.LINT.level = 1;
</script>
 -->
