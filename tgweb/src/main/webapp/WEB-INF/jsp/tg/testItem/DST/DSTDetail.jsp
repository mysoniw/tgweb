<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<form id="${_wid}_searchForm">
	<input type="hidden" name="TC_IDX" value="${params.TC_IDX}" />
	<input type="hidden" name="CATEGORY" value="${params.CATEGORY}" />
	<input type="hidden" name="MODEL" value="${params.MODEL}" />
	<input type="hidden" name="FW_VERSION" value="${params.FW_VERSION}" />
	<input type="hidden" name="TEST_PROJECT_ID" value="${params.TEST_PROJECT_ID}" />
	<input type="hidden" name="TEST_SUITE_ID" value="${params.TEST_SUITE_ID}" />
	<input type="hidden" name="TEST_CASE_ID" value="${params.TEST_CASE_ID}" />
	<input type="hidden" name="TEST_CASE_NAME" value="${params.TEST_CASE_NAME}" />
	<input type="hidden" name="SUITE_DESCRIPTION" value="${params.SUITE_DESCRIPTION}" />
	<input type="hidden" name="NODE_MAC" value="${params.NODE_MAC}" />
	<input type="hidden" name="NODE_IP" value="${params.NODE_IP}" />
	<input type="hidden" name="CYCLE" value="${params.CYCLE}" />
	<input type="hidden" name="TOTAL_CYCLE" value="${params.TOTAL_CYCLE}" />
	<input type="hidden" name="PASS" value="${params.PASS}" />
	<input type="hidden" name="FAIL" value="${params.FAIL}" />
	<input type="hidden" name="PASS_RATE" value="${params.PASS_RATE}" />
	<input type="hidden" name="RESULT" value="${params.RESULT}" />
	<input type="hidden" name="CAUSE" value="${params.CAUSE}" />
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
	<input type="hidden" name="EXTRA18" value="${params.EXTRA18}" />
	<input type="hidden" name="EXTRA19" value="${params.EXTRA19}" />
	<input type="hidden" name="EXTRA20" value="${params.EXTRA20}" />
	<input type="hidden" name="_wid" value="${params._wid}" />
	<div class="accordion">
		<div class="accordionPart">
			<h3><a href="#">Results</a></h3>
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
					<tr>
						<th>PASS</th>
						<td>${params.PASS}</td>
						<th>FAIL</th>
						<td>${params.FAIL}</td>
						<th>PASS RATE</th>
						<td>${params.PASS_RATE}</td>
						<th>Type</th>
						<td>${params.EXTRA3}</td>
					</tr>
					<tr>
						<th>Mac Address</th>
						<td>${params.NODE_MAC}</td>
						<th>IP</th>
						<td>${params.NODE_IP}</td>
						<th>Total Cycle</th>
						<td>${params.TOTAL_CYCLE}</td>
						<th>Cycle</th>
						<td>${params.CYCLE}</td>
					</tr>
					<tr>
						<th>Start Time</th>
						<td>${results.START_TIME}</td>
						<th>End Time</th>
						<td>${results.END_TIME}</td>
						<th>Execution Time</th>
						<td>${results.EXECUTION_TIME}</td>
						<th>Insert Date</th>
						<td>${results.INSERT_DATE}</td>
					</tr>
					<tr>
						<th>Log Serial</th>
						<td>
							<c:if test="${fn:indexOf(params.LOG_FILE, 'serial') > -1}">
								<button type="button" class="file" data="{formId:'${_wid}_searchForm', LOG_NAME:'serial'}"><span class="ui-icon ui-icon-document"></span></button>
							</c:if>
						</td>
						<th>Log Tool</th>
						<td>
							<c:if test="${fn:indexOf(params.LOG_FILE, 'tool') > -1}">
								<button type="button" class="file" data="{formId:'${_wid}_searchForm', LOG_NAME:'tool'}"><span class="ui-icon ui-icon-document"></span></button>
							</c:if>
						</td>
						<th>Result</th>
						<td <c:if test="${params.RESULT != 'PASS'}">style="color:#FF0000;"</c:if>>${params.RESULT}</td>
						<th>Tolerance</th>
						<td>${params.EXTRA12}</td>
					</tr>
		<c:if test="${params.RESULT != 'PASS'}">
					<tr>
						<th>Cause</th>
						<td colspan="7" style="text-align:left; color:#FF0000;">
							${params.CAUSE}
						</td>
					</tr>
		</c:if>
					<tr>
						<th>Time Difference</th>
						<td>${params.EXTRA19}</td>
						<th>Get Time Difference</th>
						<td>${params.EXTRA20}</td>
						<th></th>
						<td></td>
						<th></th>
						<td></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="accordionPart">
			<h3><a href="#">Device &amp; PC</a></h3>
			<div>
				<table class="lTable" style="width:100%;">
					<tr>
						<th colspan="8">Device</th>
					</tr>
					<tr>
						<th class="w10">Device Set Time</th>
						<td class="w15">${params.EXTRA4}</td>
						<th class="w10">Device DST Time</th>
						<td class="w15">${params.EXTRA5}</td>
						<th class="w10">Device Get Time</th>
						<td class="w15">${params.EXTRA6}</td>
						<th class="w10">Device Tolerance</th>
						<td class="w15">${params.EXTRA7} sec</td>
					</tr>
					<tr>
						<th>Device Time Zone</th>
						<td>${params.EXTRA1}</td>
						<th>Device DST State</th>
						<td>${params.EXTRA2}</td>
						<th>Device Start</th>
						<td>${params.EXTRA15}</td>
						<th>Device End</th>
						<td>${params.EXTRA16}</td>
					</tr>
					<tr>
						<th colspan="8">PC</th>
					</tr>
					<tr>
						<th>PC Set Time</th>
						<td>${params.EXTRA8}</td>
						<th>PC DST Time</th>
						<td>${params.EXTRA9}</td>
						<th>PC Get Time</th>
						<td>${params.EXTRA10}</td>
						<th>PC Tolerance</th>
						<td>${params.EXTRA11} sec</td>
					</tr>
					<tr>
						<th>PC Time Zone</th>
						<td>${params.EXTRA13}</td>
						<th>PC DST State</th>
						<td>${params.EXTRA14}</td>
						<th>PC Start</th>
						<td>${params.EXTRA17}</td>
						<th>PC End</th>
						<td>${params.EXTRA18}</td>
					</tr>
				</table>
			</div>
		</div>
	<c:if test="${params.CATEGORY == 'NCAM'}">
		<div class="accordionPart">
			<h3><a href="#">Image Comparison</a></h3>
			<div>
				<div class="searchDiv">
					<ul>
				    	<li><button type="button" class="excel" data="{wid:'${_wid}', formId:'${_wid}_searchForm', title:'<spring:message code="tgweb.common.DST.title"/> Detail', url:'tgDSTDetail.do'}">excel</button></li>
				    </ul>
				</div>
				<div>
					<table class="lTable" style="width:800px;">
						<tr>
							<th>DST Before</th>
							<th>DST After</th>
						</tr>
						<tr>
							<td>${results.REMOTE_START}</td>
							<td>${results.REMOTE_END}</td>
						</tr>
						<tr>
							<th>DST Before Image</th>
							<th>DST After Image</th>
						</tr>
						<tr>
							<td>${results.TIME_START_IMG}</td>
							<td>${results.TIME_END_IMG}</td>
						</tr>
						<tr>
							<td><img class="loupe" src="cmnCommon.do?method=image&filePath=${results.PATH_START_IMG}" alt="Start Image" style="width:300px;height:300px;" /></td>
							<td><img class="loupe" src="cmnCommon.do?method=image&filePath=${results.PATH_END_IMG}" alt="End Image" style="width:300px;height:300px;" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</c:if>
	</div>
</form>
