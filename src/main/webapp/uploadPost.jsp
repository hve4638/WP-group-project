<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="wp.*"%>
<%
request.setCharacterEncoding("UTF-8");
User user = UserAPI.getSessionUser(session);
 
String bid = request.getParameter("boardId");
String uid = user.getId();
String title = request.getParameter("title");
String con = request.getParameter("content");

PostAPI.uploadPost(bid, uid, title, con);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UploadPost</title>
</head>
<body>
 <script type="text/javascript">
 let form = document.createElement("form");
 form.action = "board.jsp";
 form.method = "POST";

 let dataInput = document.createElement("input");
 dataInput.type = "hidden";
 dataInput.name = "boardId";
 dataInput.value = bid;

 form.appendChild(dataInput);
 document.body.appendChild(form);
 form.submit();
 </script>
</body>
</html>