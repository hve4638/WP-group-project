<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "wp.*" %>
<html>
<head>
<%
boolean isSignIn = UserAPI.isSessionLogin(session);
String message;

if (isSignIn) {
	User user = UserAPI.getSessionUser(session);
	message = user.getName() + "님 반갑습니다";
} else {
	message = "환영합니다";
}
%>
<script>
home = ()=>{location.href="main.jsp";}
login = ()=>{location.href="login.html";}
signup = ()=>{location.href="signup.html";}
logout = ()=>{location.href="logout.jsp";}
</script>
</head>
<body>
<div id = "wrap">
<%= message %>
<%
if(!isSignIn){ 
%>
<button id="loginBtn" class="btn btn-primary" onclick="login()">로그인</button>
<button id="joinBtn" class="btn btn-primary" onclick="signup()">회원가입</button>
<%
} else {
%>
<button id="logoutBtn" class="btn btn-primary" onclick="logout()">로그아웃</button>
<%
}
%>    
<button class="btn btn-success" onclick="home()">HOME</button>        
</div>
</body>
</html>




