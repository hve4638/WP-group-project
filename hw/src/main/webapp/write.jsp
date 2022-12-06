<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String boardId = request.getParameter("boardId");
	if (boardId == null || boardId.equals("")) boardId = "talk";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>로그인</title>
</head>
<body>
   <nav class="navbar navbar-default">
      <div class="navbar-header">
         <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
         data-target="#bs-example-navbar-collapse-1"
         aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
         </button>
         <a class="navbar-brand" href="main.jsp">고양이 전문 커뮤니티</a>
      </div>   
      <div class="collapse navber-collapse" id="bs-example-navbar-collapse-1">
         <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a></li>
            <li class="active"><a href="board.jsp">게시판</a></li>
         </ul>
         <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
               <a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">접속하기<span class="caret"></span></a>
               <ul class="dropdown-menu">
                  <li class="active"><a href="login.html">로그인</a></li>
                  <li><a href="signup.html">회원가입</a></li>
               </ul>
            </li>
         </ul>
      </div>
   </nav>
   <div class="container">
      <div class="row">
         <form method="post" action="uploadPost.jsp">
         <table class="table table-striped" style="text-align: center;
         border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th colspan="2" style="background-color: #FAECC5; text-align: center;">게시판 글쓰기</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50"></td>
               </tr>
               <tr>
                  <td><textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" style="height:350px;"></textarea></td>
               </tr>
            </tbody>
         </table>
            <input type=hidden name=boardId value=<%= boardId %>>
            <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
         </form>
      </div>
   </div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
</body>
</html>