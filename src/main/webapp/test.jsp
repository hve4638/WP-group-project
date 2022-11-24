<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="wp.*" %>
<%
	if (!UserAPI.isSessionLogin(session)) {
		UserAPI.setSessionUserId(session, "user-id");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>