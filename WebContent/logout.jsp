<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*" %>  
<% session.invalidate();
	response.sendRedirect("index.jsp");%>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/styles.css">
 <meta charset="UTF-8">
 <title>Logout Page</title>
</head>
<body>
</body>
</html>