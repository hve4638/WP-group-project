<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "wp.*" %>
<%
	String boardId = request.getParameter("boardId");
	if (boardId == null) boardId = "";
	String no = request.getParameter("postNo");
	Post post = PostAPI.getPost(Integer.parseInt(no));
	User user = post.getUser();
	String raw = post.getContent();
	String contents[] = raw.split("\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>고양이 커뮤니티</title>
</head>
<body>
   <jsp:include page="header.jsp" />
   <div class="container">
      <div class="row">
         <table class="table table-striped" style="text-align: center;
         border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th colspan="3" style="background-color: #FAECC5; text-align: center;">게시판 글 보기</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td style="width: 20%;">글 제목</td>
                  <td colspan="2"><%= post.getTitle() %></td>
               </tr>
               <tr>
                  <td>작성자</td>
                  <td colspan="2"><%= user.getName() %></td>
               </tr>
               <tr>
                  <td>작성일자</td>
                  <td colspan="2"><%= post.getDate() %></td>
               </tr>
               <tr style="min-height: 500px;">
                  <td colspan="3" style="min-height: 1000px; text-align: left;">
                  <div style="padding:5px;">
                  
                  <%
                  	for(String line : contents){
                  		out.print("<div>");
                  		out.print(line);
                  		out.print("</div>");
                  	}
                  %>
                  </div>
                  </td>
               </tr>
            </tbody>
         </table>
         <a href="board.jsp?boardId=<%= boardId %>" class="btn btn-primary">목록</a>
         <a class="btn btn-primary pull-right" href="write.jsp?boardId=<%=boardId%>">글쓰기</a>	
   		<jsp:include page="comment.jsp" />
      </div> 
   </div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
</body>
</html>