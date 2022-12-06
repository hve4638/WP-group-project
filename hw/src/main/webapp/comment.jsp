<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "wp.*" %>
<%@ page import = "java.util.*" %>
<%
	String boardId = request.getParameter("boardId");
	if (boardId == null) boardId = "";
	String strNo = request.getParameter("postNo");
	int postNo = Integer.parseInt(strNo);
	List<Comment> comments = PostAPI.getComments(postNo);
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
   <div class="container">
      <div class="row">
         <form method="post" action="uploadComment.jsp">
         <table class="table table-striped" style="text-align: center;
         border: 1px solid #dddddd">
               <tr> 
               <td style="border-bottom:none;" valign="middle"><br><br></td>
               <td><input type="text" style="height:100px;" class="form-control" placeholder="댓글을 남겨주세요." name = "content"></td>
            </tr>
         </table>
         	<input type=hidden name=postNo value=<%= request.getParameter("postNo") %>>
            <td><br><br><input type="submit" class="btn-primary pull" value="댓글 작성"></td>
         </form>
      </div>
   </div>
   
<div class="container">
   <div class="row">
      <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
         <tbody>
            <tr>
               <td align="left" bgcolor="beige">댓글</td>
            </tr>
            <tr>
            <%
               for(Comment comment : comments){
            	   String date = comment.getDate();
            %>
                  <div class="container">
                     <div class="row">
                        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                           <tbody>
                              <tr>                  
                                 <td align="left"><%= comment.getUser().getName() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= date.substring(0,11) + date.substring(11,13) + "시" + date.substring(14,16) + "분" %></td>      
                                 <td colspan="2"></td>
                                 <td align="right">
                                 </td>
                              </tr>
                              <tr>
                                 <td colspan="5" align="left"><%= comment.getContent() %>
                              </tr>
                           </tbody>
                        </table>         
                     </div>
                  </div>
                  <%
                     }
                  %>
            </tr>
      </table>
   </div>
</div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
</body>
</html>