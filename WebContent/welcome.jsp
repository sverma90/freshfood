<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>  
<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/styles.css">
 <meta charset="UTF-8">
 <title>Welcome Page</title>
</head>

<%
	String name=(String)session.getAttribute("name");
	String email=(String)session.getAttribute("email");
	String password=(String)session.getAttribute("password");
	if ((HashMap<String, Integer>)session.getAttribute("cart") == null) {
		session.setAttribute("cart", new HashMap<String, Integer>());
	}
%>

<body>
<div class="header">
	<a href="index.jsp" class="logo">Fresh Foods</a>
	<% if (session.getAttribute("name") != null) { %>
	<div class="header-right header_2column_right">
		<a class="active" href="logout.jsp">Log Out</a>
	</div>
	<div class="header-right header_2column_right">
    	<a class="active" href="checkout.jsp">Checkout</a>
    </div>
   	<div class="header-right header_2column_left">
		<span>Hello <%= name %></span>
	</div>
    <%} %>
</div>
<div class="content">
<h1>Welcome <%= name %></h1>			<!-- set user email via session -->

<a style="text-decoration: none;" href="inventory.jsp"><button class="button">Inventory</button></a>

</div>
<!-- 

Option to browse -> takes you to inventory.jsp 

log out feature, signout.html page (you have been signed out)

shopping cart (session) -> checkout page (checkout.jsp)

look at your user history (database)

 -->
 <div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>
</body>
</html>