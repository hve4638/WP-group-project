<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "wp.*" %>
<html>
<head>
<%
boolean isSignIn = UserAPI.isSessionLogin(session);
String message;

if (isSignIn) {
	User user = UserAPI.getSessionUser(session);
	message = user.getName() + "�� �ݰ����ϴ�";
} else {
	message = "ȯ���մϴ�";
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
<button id="loginBtn" class="btn btn-primary" onclick="login()">�α���</button>
<button id="joinBtn" class="btn btn-primary" onclick="signup()">ȸ������</button>
<%
} else {
%>
<button id="logoutBtn" class="btn btn-primary" onclick="logout()">�α׾ƿ�</button>
<%
}
%>    
<button class="btn btn-success" onclick="home()">HOME</button>        
</div>
</body>
</html>




