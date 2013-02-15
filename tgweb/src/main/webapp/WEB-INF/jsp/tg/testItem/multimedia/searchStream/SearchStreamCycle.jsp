<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
var chart;
$(function() {
	$.Topic("dataGrid/xhrComplete/" + "tgSearchStreamCycle.do").subscribe(function sub() {
		$("#${_wid}_grid").jqGrid('destroyGroupHeader');
		$("#${_wid}_grid").jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : "AVG_F_COUNT",
				numberOfColumns : 3,
				titleText : "Avg Values"
			}]
		});
		
		$.Topic("dataGrid/xhrComplete/" + "tgSearchStreamCycle.do").unsubscribe(sub);
	});
	
	var pass = parseInt("${params.PASS}");
	var fail = parseInt("${params.FAIL}");
	
	/*
	Highcharts.getOptions().colors = $.map(Highcharts.getOptions().colors, function(color) {
		return {
			radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
			stops: [
				[0, color],
				[1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
			]
		};
	});
	*/
	
	
	
		
	chart = new Highcharts.Chart({
		chart : {
			renderTo : "${_wid}_charting",
			plotBackgroundColor : null,
			plotBorderWidth : null,
			plotShadow : false
		},
		title : {
			text : "${params.MODEL} ${params.TEST_PROJECT_ID} PASS Rate"
		},
		subtitle : {
			text : 'Total cycle:<span style="color:#C77405">${params.TOTAL_CYCLE}</span>'
				+ ', Pass:<span style="color:#C77405">${params.PASS}</span>'
				+ ', Fail:<span style="color:#C77405">${params.FAIL}</span>' 
		},
		credits: {
	        enabled: false
	    },
		tooltip : {
			formatter : function() {
				return "<b>" + this.point.name + "</b>: " + this.y + "/" + this.total + " (" + this.percentage + "%)";
			}
		},
		plotOptions : {
			pie : {
				allowPointSelect : true,
				cursor : "pointer",
				dataLabels : {
					enabled : false
				},
				showInLegend : true
			}
		},
		series : [{
			type : "pie",
			name : "Result",
			data : [
				{
					name: "PASS",    
					y: pass,
					color : {
						radialGradient: {cx: 0.5, cy: 0.3, r: 0.7},
						stops: [[0, "#058DC7"],
								[1, Highcharts.Color("#058DC7").brighten(-0.3).get("rgb")]]
					}
				}
				, {
					name: "FAIL",    
					y: fail,
					color : {
						radialGradient: {cx: 0.5, cy: 0.3, r: 0.7},
						stops: [[0, "#ED561B"],
								[1, Highcharts.Color("#ED561B").brighten(-0.3).get("rgb")]]
					}
			}]
		}],
		exporting: {
			enabled: true,
			enableImages: false,
			filename: "${params.MODEL}_${params.FW_VERSION}_Chart",
			url: "cmnExportChart.do?method=chart",
			width: 800
		}
	});
});
</script>
<form id="${_wid}_searchForm">
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" name="FW_VERSION" value="${params.FW_VERSION}" />
	<input type="hidden" name="TEST_PROJECT_ID" value="${params.TEST_PROJECT_ID}" />
	<input type="hidden" name="TEST_SUITE_ID" value="${params.TEST_SUITE_ID}" />
	<input type="hidden" name="TEST_CASE_ID" value="${params.TEST_CASE_ID}" />
	<input type="hidden" name="TEST_CASE_NAME" value="${params.TEST_CASE_NAME}" />
	<input type="hidden" name="SUITE_DESCRIPTION" value="${params.SUITE_DESCRIPTION}" />
	<input type="hidden" name="EXTRA1" value="${params.EXTRA1}" />
	<input type="hidden" name="EXTRA2" value="${params.EXTRA2}" />
	<input type="hidden" name="EXTRA3" value="${params.EXTRA3}" />
	<input type="hidden" name="EXTRA4" value="${params.EXTRA4}" />
	<input type="hidden" name="EXTRA5" value="${params.EXTRA5}" />
	<input type="hidden" name="EXTRA6" value="${params.EXTRA6}" />
	<input type="hidden" name="EXTRA7" value="${params.EXTRA7}" />
	<input type="hidden" name="EXTRA8" value="${params.EXTRA8}" />
	<input type="hidden" name="EXTRA9" value="${params.EXTRA9}" />
	<input type="hidden" name="EXTRA10" value="${params.EXTRA10}" />
	<input type="hidden" name="EXTRA11" value="${params.EXTRA11}" />
	<input type="hidden" name="EXTRA12" value="${params.EXTRA12}" />
	<input type="hidden" name="EXTRA13" value="${params.EXTRA13}" />
	<input type="hidden" name="EXTRA14" value="${params.EXTRA14}" />
	<input type="hidden" name="EXTRA15" value="${params.EXTRA15}" />
	<input type="hidden" name="EXTRA16" value="${params.EXTRA16}" />
	<input type="hidden" name="EXTRA17" value="${params.EXTRA17}" />
	<input type="hidden" name="TOTAL_CYCLE" value="${params.TOTAL_CYCLE}" />
	<input type="hidden" name="PASS" value="${params.PASS}" />
	<input type="hidden" name="FAIL" value="${params.FAIL}" />
	<input type="hidden" name="PASS_RATE" value="${params.PASS_RATE}" />
	<input type="hidden" name="RESULT" value="${params.filterValue}" />
	<input type="hidden" name="CODEC" value="${params.CODEC}" />
	<input type="hidden" name="RESOLUTION" value="${params.RESOLUTION}" />
	<input type="hidden" name="FRAME_COUNT" value="${params.FRAME_COUNT}" />
	<input type="hidden" name="FRAME_DEVIATION" value="${params.FRAME_DEVIATION}" />
	<input type="hidden" name="PC_DEVIATION" value="${params.PC_DEVIATION}" />
	<input type="hidden" name="FRAME_REVERSE" value="${params.FRAME_REVERSE}" />
	<input type="hidden" name="GOP_COUNT" value="${params.GOP_COUNT}" />
	<input type="hidden" name="F_DEV_MIN" value="${params.F_DEV_MIN}" />
	<input type="hidden" name="F_DEV_MAX" value="${params.F_DEV_MAX}" />
	<input type="hidden" name="DEV_BASE" value="${params.DEV_BASE}" />
	<input type="hidden" name="F_DEV_TOLERANCE_BASE" value="${params.F_DEV_TOLERANCE_BASE}" />
	<input type="hidden" name="PC_DEV_TOLERANCE_BASE" value="${params.PC_DEV_TOLERANCE_BASE}" />
  	<div>
		<table class="lTable w100">
			<tr>
				<th class="w10">Category</th>
				<td class="w15">${params.CATEGORY}</td>
				<th class="w10">Model</th>
				<td class="w15">${params.MODEL}</td>
				<th class="w10">Firmware</th>
				<td class="w15">${params.FW_VERSION}</td>
				<th class="w10"></th>
				<td class="w15"></td>
			</tr>
			<tr>
				<th>Test Project</th>
				<td>${params.TEST_PROJECT_ID}</td>
				<th>Test Suite</th>
				<td>${params.TEST_SUITE_ID}</td>
				<th>Test Case</th>
				<td>${params.TEST_CASE_NAME}</td>
				<th>Description</th>
				<td>${params.SUITE_DESCRIPTION}</td>
			</tr>
<c:if test="${params.CATEGORY == 'NCAM'}">
			<tr>
				<th>Profile Number</th>
				<td>${params.EXTRA1}</td>
				<th>Profile Name</th>
				<td>${params.EXTRA2}</td>
				<th>Encoding</th>
				<td>${params.EXTRA3}</td>
				<th>Resolution</th>
				<td>${params.EXTRA4}</td>
			</tr>
			<tr>
				<th>Framerate</th>
				<td>${params.EXTRA5}</td>
				<th>Bitrate</th>
				<td>${params.EXTRA6}</td>
				<th>Compression</th>
				<td>${params.EXTRA7}</td>
	<c:if test="${params.EXTRA3 == 'H.264'}">
				<th>Bit Control</th>
				<td>${params.EXTRA8}</td>
			</tr>
			<tr>
				<th>Encoding Priority</th>
				<td>${params.EXTRA9}</td>
				<th>GOP Size</th>
				<td>${params.EXTRA10}</td>
				<th>Entropy Coding</th>
				<td>${params.EXTRA11}</td>
				<th>Profile</th>
				<td>${params.EXTRA12}</td>
			</tr>
	</c:if>
	<c:if test="${params.EXTRA3 == 'MPEG4'}">
				<th>Bit Control</th>
				<td>${params.EXTRA8}</td>
			</tr>
			<tr>
				<th>Encoding Priority</th>
				<td>${params.EXTRA9}</td>
				<th>GOP Size</th>
				<td>${params.EXTRA10}</td>
				<th></th>
				<td></td>
				<th></th>
				<td></td>
			</tr>
	</c:if>
	<c:if test="${params.EXTRA3 != 'H.264' && params.EXTRA3 != 'MPEG4'}">
				<th></th>
				<td></td>
			</tr>
	</c:if>
			<tr>
				<th>Frame Count Tolerance</th>
				<td>${params.EXTRA13}</td>
				<th>Frame Deviation Tolerance</th>
				<td>
					${params.EXTRA14}
	<c:if test="${params.EXTRA15 == 'MILLISECOND'}">
					ms
	</c:if>
	<c:if test="${params.EXTRA15 == 'PERCENT'}">
					%
	</c:if>
				</td>
				<th>PC Deviation Tolerance</th>
				<td>
					${params.EXTRA16}
	<c:if test="${params.EXTRA17 == 'MILLISECOND'}">
					ms
	</c:if>
	<c:if test="${params.EXTRA17 == 'PERCENT'}">
					%
	</c:if>
				</td>
				<th></th>
				<td></td>
			</tr>
</c:if>
<c:if test="${params.CATEGORY == 'NVR'}">
			<tr>
				<th>Channel Number</th>
				<td>${params.EXTRA1}</td>
				<th>Codec</th>
				<td>${params.EXTRA3}</td>
				<th>Resolution</th>
				<td>${params.EXTRA4}</td>
				<th></th>
				<td></td>
			</tr>
			<tr>
				<th>Framerate</th>
				<td>${params.EXTRA5}</td>
				<th>Frame Count Tolerance</th>
				<td>${params.EXTRA13}</td>
				<th>Frame Deviation Tolerance</th>
				<td>
					${params.EXTRA14}
	<c:if test="${params.EXTRA15 == 'MILLISECOND'}">
					ms
	</c:if>
	<c:if test="${params.EXTRA15 == 'PERCENT'}">
					%
	</c:if>
				</td>
				<th>PC Deviation Tolerance</th>
				<td>
					${params.EXTRA16}
	<c:if test="${params.EXTRA17 == 'MILLISECOND'}">
					ms
	</c:if>
	<c:if test="${params.EXTRA17 == 'PERCENT'}">
					%
	</c:if>
				</td>
			</tr>
</c:if>
<c:if test="${params.CATEGORY == 'DVR'}">
			<tr>
				<th>Channel Number</th>
				<td>${params.EXTRA1}</td>
				<th>Quality</th>
				<td>${params.EXTRA2}</td>
				<th>Record Mode</th>
				<td>${params.EXTRA3}</td>
				<th>Resolution</th>
				<td>${params.EXTRA4}</td>
			</tr>
			<tr>
				<th>Framerate</th>
				<td>${params.EXTRA5}</td>
				<th>Frame Count Tolerance</th>
				<td>${params.EXTRA13}</td>
				<th>Frame Deviation Tolerance</th>
				<td>
					${params.EXTRA14}
	<c:if test="${params.EXTRA15 == 'MILLISECOND'}">
					ms
	</c:if>
	<c:if test="${params.EXTRA15 == 'PERCENT'}">
					%
	</c:if>
				</td>
				<th>PC Deviation Tolerance</th>
				<td>
					${params.EXTRA16}
	<c:if test="${params.EXTRA17 == 'MILLISECOND'}">
					ms
	</c:if>
	<c:if test="${params.EXTRA17 == 'PERCENT'}">
					%
	</c:if>
				</td>
			</tr>
</c:if>
			<tr>
				<th>Total Cycle</th>
				<td>${params.TOTAL_CYCLE}</td>
				<th>PASS</th>
				<td>${params.PASS}</td>
				<th>FAIL</th>
				<td>${params.FAIL}</td>
				<th>PASS RATE</th>
				<td>${params.PASS_RATE}</td>
			</tr>
		</table>
	</div>
	<div class="searchDiv">
		<ul>
	    	<li><button type="button" class="excel" data="{gridId:'${_wid}_grid', formId:'${_wid}_searchForm'}">excel</button></li>
	    </ul>
	</div>
	<div style="float:left;">
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgSearchStreamCycle.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.SEARCH_STREAM.title"/> Cycle', pager:'#${_wid}_pager'}"
			filterGrid="{'column':'${params.filterColumn}', 'value':'${params.filterValue}', 'len':'${params.FAIL}'}">
			<tr>
				<th field="CYCLE" url="tgSearchStreamDetail.do" addParam="{'method':'t'}" uid="SearchStreamCycle" width="60px">Cycle</th>
				<th field="RESULT" syntax="{'matcher':'NOT_MATCH', 'flag':'PASS','syntaxColor':'red'}" width="60px">Result</th>
<c:if test="${params.CATEGORY == 'NCAM'}">
	<c:if test="${params.EXTRA3 == 'H.264' || params.EXTRA3 == 'MPEG4'}">
				<th field="AVG_GOP_SIZE" width="100px">Avg GOP Value</th>
	</c:if>
</c:if>
				<th field="AVG_F_COUNT" width="100px">Frame Count</th>
				<th field="AVG_F_DEVIATION" width="100px">Frame Deviation</th>
				<th field="AVG_PC_DEVIATION" width="100px">PC Deviation</th>
				<th field="NODE_MAC" width="130px">Mac Address</th>
				<th field="NODE_IP" width="110px">IP</th>
			</tr>
		</table>
		<div id="${_wid}_pager"></div>
	</div>
	<div id="${_wid}_charting" style="width:400px; float:left; height:400px; margin-left:5em;"></div>
	<div style="clear:both;"></div>
</form>
