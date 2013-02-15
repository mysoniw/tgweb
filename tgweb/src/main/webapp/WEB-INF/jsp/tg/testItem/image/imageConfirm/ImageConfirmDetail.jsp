<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/commonReady.jsp"%>
<link rel="stylesheet" type="text/css" href="/javascript/jquery/plugin/adGallery/jquery.ad-gallery.css" />
<script type="text/javascript" src="/javascript/jquery/plugin/adGallery/jquery.ad-gallery.js"></script>
<script type="text/javascript">
$(function() {
	if ("#tab_${_wid}" !== window.smileGlobal.tabHash) {
		$.Topic("#tab_${_wid}").subscribe(function tabsSub(ui) {
			$("#${_wid}_gallery").adGallery({
				loader_image: "/javascript/jquery/plugin/adGallery/loader.gif"
			});
	
			$.Topic("#tab_${_wid}").unsubscribe(tabsSub);
		});
	} else {
		$("#${_wid}_gallery").adGallery({
			loader_image: "/javascript/jquery/plugin/adGallery/loader.gif"
		});
	}
});
</script>
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
	<input type="hidden" name="TOTAL_CYCLE" value="${params.TOTAL_CYCLE}" />
	<input type="hidden" name="PASS" value="${params.PASS}" />
	<input type="hidden" name="FAIL" value="${params.FAIL}" />
	<input type="hidden" name="PASS_RATE" value="${params.PASS_RATE}" />
	<input type="hidden" name="RESULT" value="${params.RESULT}" />
	<input type="hidden" name="CAUSE" value="${params.CAUSE}" />
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
						<th class="w10">Web</th>
						<td class="w15">${params.IS_WEB}</td>
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
		</c:if>
		<c:if test="${params.CATEGORY == 'NVR'}">
					<tr>
						<th>Channel Number</th>
						<td>${params.EXTRA1}</td>
						<th>Codec</th>
						<td>${params.EXTRA3}</td>
						<th>Resolution</th>
						<td>${params.EXTRA4}</td>
						<th>Framerate</th>
						<td>${params.EXTRA5}</td>
					</tr>
		</c:if>
		<c:if test="${params.CATEGORY == 'DVR'}">
					<tr>
						<th>Channel Number</th>
						<td>${params.EXTRA1}</td>
						<th>Quality</th>
						<td>${params.EXTRA2}</td>
						<th>Resolution</th>
						<td>${params.EXTRA4}</td>
						<th></th>
						<td></td>
					</tr>
		</c:if>
					<tr>
						<th>Tolerance R</th>
						<td>${params.EXTRA13} %</td>
						<th>Tolerance G</th>
						<td>${params.EXTRA14} %</td>
						<th>Tolerance B</th>
						<td>${params.EXTRA15} %</td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th>PASS</th>
						<td>${params.PASS}</td>
						<th>FAIL</th>
						<td>${params.FAIL}</td>
						<th>PASS RATE</th>
						<td>${params.PASS_RATE}</td>
						<th></th>
						<td></td>
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
						<td>${model.START_TIME}</td>
						<th>End Time</th>
						<td>${model.END_TIME}</td>
						<th>Execution Time</th>
						<td>${model.EXECUTION_TIME}</td>
						<th>Insert Date</th>
						<td>${model.INSERT_DATE}</td>
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
						<th></th>
						<td></td>
					</tr>
		<c:if test="${params.RESULT != 'PASS'}">
					<tr>
						<th>Cause</th>
						<td colspan="7" style="text-align:left; color:#FF0000;">
							${params.CAUSE}
						</td>
					</tr>
		</c:if>
				</table>
			</div>
		</div>
	<c:if test="${params.RESULT == 'FAIL'}">
		<div class="accordionPart">
			<h3><a href="#">Excel &amp; Screen Shots</a></h3>
			<div>
				<div class="searchDiv">
					<ul>
				    	<li><button type="button" class="excel" data="{url:'tgImageConfirmDetail.do', title:'Image_Confirm_Detail', formId:'${_wid}_searchForm'}">excel</button></li>
				    </ul>
				</div>
				<div id="${_wid}_gallery" class="ad-gallery">
					<div class="ad-image-wrapper"></div>
					<div class="ad-nav">
						<div class="ad-thumbs">
							<ul class="ad-thumb-list">
								<c:forEach items="${entryList}" var="entry">
									<li><a href="cmnCommon.do?method=image&filePath=${entry.IMAGE_PATH}"> <img src="cmnCommon.do?method=image&filePath=${entry.IMAGE_PATH}" style="width:50px;height:50px;" title="RGB: ${entry.RGB}, VERTICAL_FLIP: ${entry.VERTICAL_FLIP}, HORIZONTAL_FLIP: ${entry.HORIZONTAL_FLIP}" /> </a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<c:import url="/tgSrm.do?method=container" />
	</c:if>
	</div>
</form>
