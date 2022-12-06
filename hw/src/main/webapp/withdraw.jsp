<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="wp.*"%>

<%
request.setCharacterEncoding("UTF-8");

String uid = request.getParameter("id");
String upass = request.getParameter("pw");

if(UserAPI.existsUser(uid)){ //유저정보(id, pw) 일치여부 확인
	if(UserAPI.isValidUser(uid, upass)){
		if(UserAPI.deleteUser(uid)){
			out.print("회원탈퇴 되었습니다.");
			response.sendRedirect("main.jsp");//main.jsp로 리다이렉션
		}
		else{
			out.print("탈퇴 중 오류가 발생했습니다.");
			response.sendRedirect("withdraw.jsp");//withdraw.html로 리다이렉션
		}
	}
	else{
		out.print("비밀번호가 올바르지 않습니다.");
		response.sendRedirect("withdraw.html");//withdraw.html로 리다이렉션
	}
}
else{
	out.print("아이디가 존재하지 않습니다.");
	response.sendRedirect("withdraw.html");//withdraw.html로 리다이렉션
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithDraw</title>
</head>
<body>
</body>
</html>