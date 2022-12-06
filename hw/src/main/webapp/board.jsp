<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "wp.*" %>
<%@ page import = "java.util.*" %>
<%!
public void makeLine(JspWriter out, Post post) {
   int no = post.getPostNo();
   try {
      
      out.print("<tr onclick=hrefPost(" + no + ")>");
      out.print("<th>");
      out.print(no);
      out.print("</th>");
      out.print("<th>");
      out.print(post.getTitle());
      out.print("</th>");
      out.print("<th>");
      out.print(post.getUser().getName());
      out.print("</th>");
      out.print("<th>");
      out.print(post.getDate());
      out.print("</th>");
      
      out.print("</tr>");
   }
   catch (Exception e) {
      /*
       <th style="background-color: #eeeeee; text-align: center;">번호</th>
       <th style="background-color: #eeeeee; text-align: center;">제목</th>
       <th style="background-color: #eeeeee; text-align: center;">작성자</th>
       <th style="background-color: #eeeeee; text-align: center;">작성일</th>
      */
   }
}
%>
<%
   String boardId = request.getParameter("boardId");
   String pageNum = request.getParameter("page");
   String search = request.getParameter("search");
   if (boardId == null || boardId.equals("")) boardId = "talk";
   if (pageNum == null || pageNum.equals("")) pageNum = "1";
   //if (page == null || page.equals("")) page = "1";
   
   List<Post> posts;
   
   if (search == null || search.equals("")) {
      posts = PostAPI.getPostFormBoard(boardId, 10, Integer.parseInt(pageNum));
   } else {
      posts = PostAPI.getPostFormBoard(boardId, 10, Integer.parseInt(pageNum), search);
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>고먐미 커뮤니티</title>
<script>
	function hrefPost(postNo) {
		location.href="./post.jsp?boardId=<%=boardId%>"+ "&postNo=" + postNo;
	}
</script>
</head>
<body>
   <jsp:include page="header.jsp" />
   <div class="container" style="padding-top:100px;">
  		<div style="padding:50px; text-align:center;"></div>
      <div class="row">
         <table class="table table-striped" style="text-align: center;
         border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th style="background-color: #eeeeee; text-align: center;">번호</th>
                  <th style="background-color: #eeeeee; text-align: center;">제목</th>
                  <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                  <th style="background-color: #eeeeee; text-align: center;">작성일</th>
               </tr>
            </thead>
            <tbody>
            <%
            for (Post post : posts) {
               makeLine(out, post);
         %>
		<%    
		   }
		%>
            </tbody>
         </table>
         <div class="bottom_paging_box inconpaging">
         <em></em>
         </div>
         <a href="write.jsp?boardId=<%= boardId %>" class="btn btn-primary pull-right">글쓰기</a>
      </div>
   </div>
   <div>
   <!-- 
	<form method="post" action="board.jsp">
		<div style="width:15%; text-align:center; width:30%">
			<div style="display:inline;">
			<input type="text" class="form-control" style="display:inline;" placeholder="Search" name="searchWord"/>
			</div>
			<div style="display:inline;">12</div>
			
			1<span class="glyphicon glyphicon-search"></span>
			
			<button class="btn btn-primary" type="submit" >
				<span class="glyphicon glyphicon-search"></span>
			</button>
		</div>
    </form>
     -->
	</div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
</body>
</html>