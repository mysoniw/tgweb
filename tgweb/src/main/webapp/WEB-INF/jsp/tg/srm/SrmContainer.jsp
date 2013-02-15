<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<c:if test="${not empty results.CPU}">
	<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmCPU', asyncUri:'/tgSrm.do?method=CPU'}">
		<h3><a href="#">SRM CPU Usage</a></h3>
		<div></div>
	</div>
</c:if>
<c:if test="${not empty results.PROCESS}">
	<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmProcess', asyncUri:'/tgSrm.do?method=process'}">
		<h3><a href="#">SRM CPU Process</a></h3>
		<div></div>
	</div>
</c:if>
<c:if test="${not empty results.MEMORY}">
	<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmMemory', asyncUri:'/tgSrm.do?method=memory'}">
		<h3><a href="#">SRM Memory</a></h3>
		<div></div>
	</div>
</c:if>
<c:if test="${not empty results.NETWORK}">
	<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmNetwork', asyncUri:'/tgSrm.do?method=network'}">
		<h3><a href="#">SRM Network</a></h3>
		<div></div>
	</div>
</c:if>
<c:if test="${not empty results.DISK_USAGE}">
	<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmDiskUsage', asyncUri:'/tgSrm.do?method=diskUsage'}">
		<h3><a href="#">SRM Disk Usage</a></h3>
		<div></div>
	</div>
</c:if>
<c:if test="${not empty results.DISK_IO}">
	<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmDiskIO', asyncUri:'/tgSrm.do?method=diskIO'}">
		<h3><a href="#">SRM Disk IO</a></h3>
		<div></div>
	</div>
</c:if>

<%--
<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmCPU', asyncUri:'/tgSrm.do?method=CPU'}">
	<h3><a href="#">SRM CPU Usage</a></h3>
	<div></div>
</div>
<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmProcess', asyncUri:'/tgSrm.do?method=process'}">
	<h3><a href="#">SRM CPU Process</a></h3>
	<div></div>
</div>
<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmMemory', asyncUri:'/tgSrm.do?method=memory'}">
	<h3><a href="#">SRM Memory</a></h3>
	<div></div>
</div>
<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmNetwork', asyncUri:'/tgSrm.do?method=network'}">
	<h3><a href="#">SRM Network</a></h3>
	<div></div>
</div>
<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmDiskUsage', asyncUri:'/tgSrm.do?method=diskUsage'}">
	<h3><a href="#">SRM Disk Usage</a></h3>
	<div></div>
</div>
<div class="accordionPart closed" data="{formId:'${_wid}_searchForm', url:'/tgSrm.do', method:'layout', jsp:'/tg/srm/SrmDiskIO', asyncUri:'/tgSrm.do?method=diskIO'}">
	<h3><a href="#">SRM Disk IO</a></h3>
	<div></div>
</div>
--%>