<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<html>
<head>
    <title>메인 화면</title>
    <style>
       li{
       list-style:none;
       }
       body{
       font:17px 'Nanum Gothic', sans-serif;
       }
      .menu1{
      background: #65bfff;
      }
      .menu1 ul{
      width: 500px;
      margin: 0 auto;
      overflow: hidden;
      }
      .menu1 ul li{
      float: left;
      width: 25%;
      height: 50px;
      line-height: 50px;
      text-align: center;
      background: #65bfff;
      }
      a{
      text-decoration: none;
      }
      .menu1 ul li a{
      font-family: CookieRun;
      font-size:25px;
      color: black;
      display: block;
      }
      .menu1 ul li a:hover{
      background: #32aaff;
      color: #fff;
      }
      
   </style>
</head>
<body>
   <jsp:include page="header.jsp" />
   <div style="text-align:center;background-color:#cae9ff;">
   <img src="title.png">
   </div>
   <div class="menu1">
      <ul>
         <li><a href="board.jsp?boardId=info" style="">정보</a></li>
         <li><a href="board.jsp?boardId=talk">잡담</a></li>
         <li><a href="board.jsp?boardId=etc">기타</a></li>
      </ul>
   </div>
   <jsp:include page="footer.jsp" />
</body>
</html>