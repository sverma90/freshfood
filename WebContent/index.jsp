<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="header">
	<a href="index.jsp" class="logo">Fresh Foods</a>
	<% 	String name=(String)session.getAttribute("name");
		if (session.getAttribute("name") != null) { %>
	<div class="header-right header_2column_right">
		<a class="active" href="logout.jsp">Log Out</a>
	</div>
   	<div class="header-right header_2column_left">
		<span>Hello <%= name %></span>
	</div>
    <%} %>
</div>

<div class="content">
    <p>We specialize in fresh, organic, perfectly-portioned meals delivered to your home or office so you can get back to feeling really, really good again.</p>
    <% if (session.getAttribute("name") == null) { %>
    	<a style="text-decoration: none;" href="register.jsp"><button class="button">New User</button></a>
    	<a style="text-decoration: none;" href="login.jsp"><button class="button">Log In</button></a>
    <%}else{ %>
    	<a style="text-decoration: none;" href="inventory.jsp"><button class="button">Inventory</button></a>
    	<a style="text-decoration: none;" href="checkout.jsp"><button class="button">Shopping Cart</button></a>
    <%} %>
</div>

<div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>

</body>
</html>
