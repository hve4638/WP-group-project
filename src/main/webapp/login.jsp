<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="wp.*"%>

<%
request.setCharacterEncoding("UTF-8");

String uid = request.getParameter("id");
String upass = request.getParameter("pw");

if(UserAPI.isValidUser(uid, upass)){
	UserAPI.setSessionUserId(session, uid);
	response.sendRedirect("main.jsp");
}
else{
%>
	<script>
	window.onload = function() {
		alert("로그인 정보가 일치하지 않습니다.")
		location.href="./login.html";
	}
	</script>
<%	
}
%>
