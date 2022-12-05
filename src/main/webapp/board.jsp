<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="wp.*" %>
<%
	String boardId = request.getParameter("boardId");
	if (boardId == null || boardId.equals("")) boardId = "talk";
	
	List<Post> posts = PostAPI.getPostFormBoard(boardId, 5, 1);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script>
	function hrefPost(postNo) {
		let form = document.createElement("form");
		form.action = "post.jsp";
		form.method = "GET";
		let dataInput = document.createElement("input");
		dataInput.type = "hidden";
		dataInput.name = "postNo";
		dataInput.value = postNo;
	
		form.appendChild(dataInput);
		document.body.appendChild(form);
	 	form.submit();
	}
</script>
</head>
<body>
길이 : <%=posts.size() %> <br>
총 개수 d : <%=PostAPI.getPostAmount(boardId) %>
<%
	for (Post post : posts) {
%>
		<div class="post" onclick=hrefPost(<%=post.getPostNo()%>)>
			<div><%= post.getTitle()%></div>
			<div><%= post.getUserid()%></div>
			<div><%= post.getDate()%></div>
			<div><%= post.getView()%></div>
			<div><%= post.getRecommend()%></div>
		</div>
		<hr>
<%    
	}
%>
</body>
</html>