<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="wp.*" %>
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

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script>
home = ()=>{location.href="main.jsp";}
login = ()=>{location.href="login.html";}
signup = ()=>{location.href="signup.html";}
logout = ()=>{location.href="logout.jsp";}
</script>
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
            <li><a href="board.jsp">게시판</a></li>
         </ul>
         <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
               <a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">접속하기<span class="caret"></span></a>
                  <% 
                  if(!isSignIn){ 
                  %>
                     <ul class="dropdown-menu">
                        <li class="active"><a href="login.html">로그인</a></li>
                        <li><a href="signup.html">회원가입</a></li>
                     </ul>
                  <%} else {%>
                     <ul class="dropdown-menu">
                        <li class="active"><a href="logout.jsp">로그아웃</a></li>
                     </ul>
                  <%}%>
            </li>
         </ul>
      </div>
   </nav>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
</body>
</html>