<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="wp.*"%>
<%
request.setCharacterEncoding("UTF-8");
boolean isLogin = UserAPI.isSessionLogin(session);
User user = UserAPI.getSessionUser(session);
 
String bid = request.getParameter("boardId");
String uid = user.getId();
String title = request.getParameter("title");
String con = request.getParameter("content");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
if (isLogin) {
	PostAPI.uploadPost(bid, uid, title, con);
%>
<script>
	window.onload = function() {
		location.href="./board.jsp?boardId=<%= bid %>";
	}
</script>
<%
} else {
%>
<script>
	window.onload = function() {
		alert("오류가 발생했습니다.")
		location.href="./board.jsp?boardId=<%= bid %>";
	}
</script>
<%	
}
%>
</head>
<body>
</body>
</html>