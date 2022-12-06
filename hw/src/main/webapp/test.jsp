<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="wp.*"%>

<%
User user = UserAPI.getSessionUser(session);
%>

session login : <%= UserAPI.isSessionLogin(session) %> <br>
session id : <%= UserAPI.getSessionUserId(session) %> <br>

ID: <%= user.getId() %> <br>
Name: <%= user.getName() %> <br>