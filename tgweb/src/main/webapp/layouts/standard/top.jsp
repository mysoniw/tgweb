<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div id="snb">
	<ul>
		<li style="align:right;text-align:right; padding-right:8px; color:#FFFFFF; font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;">
			<b><security:authentication property="principal.userName" /></b>님 
			<span style="color:#F0F0F0">[<security:authentication property="principal.deptName" />]</span> 
			| <a href="/preAccount.do?method=registration">Preferences</a> 
			| <a href="<c:url value="/j_spring_security_logout"/>">LogOut</a>
		</li>
	</ul>
</div>