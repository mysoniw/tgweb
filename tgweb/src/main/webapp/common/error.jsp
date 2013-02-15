<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<%@page isErrorPage="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<title>Test Automation System</title>
<link rel="stylesheet" href="<c:url value='/css/common.css'/>" type="text/css" media="all">	
</head>
<body>
	<div class="error">
		<img src="${ ctx }/images/common/error.jpg" width="750px" height="170px" alt="공사중" />
		<div class="bbsItembg h25px">에러내용</div>
	    <textarea name="" cols="" rows="10" title="레이블 텍스트" class="i_text"><%=exception.getMessage() %></textarea>
	</div>
	<div id="footer"></div>
</body>
</html>
