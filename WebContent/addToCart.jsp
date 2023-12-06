<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="freshfood.Credentials" %>
<%


HashMap<String, Integer> c = (HashMap<String, Integer>)session.getAttribute("cart");
int quantityInStock = Integer.parseInt(request.getParameter("quantityInStock"));
//int q = Integer.parseInt(request.getParameter("quantity"));
int q = 0;
if (!request.getParameter("quantity").equals("") && request.getParameter("quality") != null) {
       q = Integer.parseInt(request.getParameter("quantity"));
}
String prod = request.getParameter("product");
q += c.getOrDefault(prod,0);
String redirectUrl = "inventory.jsp";
if (q > quantityInStock) {
	redirectUrl += "?overbought_product=" + prod;
} else {
	c.put(prod, q);
	session.setAttribute("cart", c);
}
response.sendRedirect(redirectUrl);
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/styles.css">
</head>
<body>
<h2>quantity bought: <%=q %></h2>
<h2>quantity in stock: <%=quantityInStock %></h2>
<h2>Item: <%=prod %></h2>

<div class="header">
  <a href="index.jsp" class="logo">Fresh Foods</a>
    <div class="header-right_cart">
     <a class="active" href="checkout.jsp">Shopping Cart</a>
    </div>
    <div class="header-right">
     <a class="active" href="logout.jsp">Logout</a>  
    </div>
  
</div>

<div class="content">
	<h1>add to cart page</h1>
</div>

<div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>

</body>
</html>
