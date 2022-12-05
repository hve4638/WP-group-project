<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String boardId = request.getParameter("boardId");
	boardId = "talk";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="uploadPost.jsp">
Title : <input type=text name=title> <br>
Content : <br>
<textarea cols=60 rows=30 name=content>
</textarea> <br>

<input type=hidden name=boardId value=<%= boardId %>>

<input type=submit value=submit>
</form>
</body>
</html>