<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<script type="text/javascript">
var chart;
$(function() {
	var pass = parseInt("${params.PASS}");
	var fail = parseInt("${params.FAIL}");
	
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
	<input type="hidden" name="TOTAL_CYCLE" value="${params.TOTAL_CYCLE}" />
	<input type="hidden" name="PASS" value="${params.PASS}" />
	<input type="hidden" name="FAIL" value="${params.FAIL}" />
	<input type="hidden" name="PASS_RATE" value="${params.PASS_RATE}" />
	<input type="hidden" name="RESULT" value="${params.filterValue}" />
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
				<th></th>
				<td></td>
			</tr>
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
		<table id="${_wid}_grid" class="grid" data="{wid:'${_wid}', formId:'${_wid}_searchForm', url:'tgOSDCycle.do', postData:{method:'s'}, key:'TC_IDX', caption:'<spring:message code="tgweb.common.OSD.title"/> Cycle', pager:'#${_wid}_pager'}"
			filterGrid="{'column':'${params.filterColumn}', 'value':'${params.filterValue}', 'len':'${params.FAIL}'}">
			<tr>
				<th field="CYCLE" width="60px">Cycle</th>
				<th field="RESULT" syntax="{'flag':'FAIL', 'syntaxColor':'red'}" url="tgOSDDetail.do" addParam="{'method':'t'}" uid="OSDCycle" width="140px">Result</th>
				<th field="NODE_MAC" width="130px">Mac Address</th>
				<th field="NODE_IP" width="110px">IP</th>
			</tr>
		</table>
		<div id="${_wid}_pager"></div>
	</div>
	<div id="${_wid}_charting" style="width:400px; float:left; height:400px; margin-left:5em;"></div>
	<div style="clear:both;"></div>
</form>
