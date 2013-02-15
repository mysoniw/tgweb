<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<%@ include file="/common/meta.jsp"%>
	<meta http-equiv="X-UA-Compatible" content="IE=8" />
	<title><tiles:getAsString name="title" ignore="true" /></title>
	<%@ include file="/layouts/standard/header.jsp" %>
</head>
<body id="<tiles:getAsString name="bodyId" ignore="true" />">
<div id="wrap">
	<div id="header">
		<div id="top">
			<tiles:insertAttribute name="top" />
		</div>
	</div>
	<div id="top_border"></div>
	<div id="menu">
		<tiles:insertAttribute name="menu" />
	</div>
	<div id="container">
		<%--<div id="lnb">
			<tiles:insertAttribute name="left"/>
		</div>--%>
		<div id="content">
			<div id="loading_layer"></div>
			<tiles:insertAttribute name="body" />
		</div>		
	</div>
	<div id="footer">
		<tiles:insertAttribute name="footer" />
	</div>
</div>
</body>
</html>
