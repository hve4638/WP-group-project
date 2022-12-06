<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="wp.*"%>

<%
request.setCharacterEncoding("UTF-8");

String uid = request.getParameter("id");
String upass = request.getParameter("pw");
String uname = request.getParameter("name");

if(UserAPI.existsUser(uid) == false){
	UserAPI.insertUser(uid, upass, uname);
%>
<script>
window.onload = function() {
	alert("<%= uname %>님 환영합니다!");
	location.href="./login.html";
}
</script>
<%
}
else{
%>
<script>
window.onload = function() {
	alert("이미 존재하는 ID입니다.");
	location.href="./signup.html";
}
</script>
<%
}
%>