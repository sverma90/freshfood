<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="freshfood.Credentials" %>

<%	
//check whether user is logged in, if not logged in redirect to login.jsp
	String name=(String)session.getAttribute("name");
	if (session.getAttribute("name") == null) { 
		response.sendRedirect("login.jsp");
	} 
// money format
	DecimalFormat money = new DecimalFormat(); 
	money.setMaximumFractionDigits(2);
// start sql stuff
	Class.forName("com.mysql.cj.jdbc.Driver");

// end sql stuff
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/styles.css">
<meta charset="UTF-8">
<title>Inventory</title>
</head>
<body>

<div class="header">
	<a href="index.jsp" class="logo">Fresh Foods</a>
	<% 	if (
("name") != null) { %>
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

<div class="content scroll">

<%
	try (Connection connection = DriverManager.getConnection(Credentials.URL, Credentials.USER_NAME, Credentials.PASSWORD)) {
		String sql = "SELECT * FROM inventory;";
    	Statement statement = connection.createStatement();
    	ResultSet itemList = statement.executeQuery(sql);
    	
    	while (itemList.next()) {
    		String product = itemList.getString("Product");
    		int quantity = itemList.getInt("Quantity"); // quantity in stock
    		String description = itemList.getString("Description");
    		float price = itemList.getFloat("Price");
    		String image = itemList.getString("Image");
    		/// html stuff
    		%>
    		<form class="product" action="addToCart.jsp">
    		  <div class="product_image">
    		   <img width="120" height="120" src="<%= image %>"></img>
    		  </div>
    		  <!-- <div class="product_desc"> -->
    		   <span class="product_desc_main"><%=product %>:</span>
    		   <span class="product_desc_text"><%=description %>: </span>
    		   <span class="price">Price: $<%=money.format(price) %> </span>
    		   <input type="hidden" id="product_name" name="product" value="<%=product%>">
    			<div class="product_2column_btn">
    			
    			 <a href="addToCart.jsp?product=<%=product%>"><button class="product_desc_btn" id="btn_<%=product%>" <% if(quantity==0) {%> disabled <%} %>>Add Item</button></a>
    			<!--  </div> -->
    			<!--  <div class="product_2column_qtn"> -->
    			 <span class="qtn_text">Quantity to purchase: </span><input type="number" name="quantity" step="1"> <!-- quanty bought -->
    			 <input type="hidden" name="quantityInStock" value="<%=quantity%>">
    			 <span class="qtn_text <%if (quantity==0){%>red_text<%}%>"><%if (quantity!=0){%>Quantity in stock:<%=quantity %><%}else {%><br>OUT OF STOCK<%} %></span>
    			 <%
    			 	if (product.equals(request.getParameter("overbought_product"))) {
    			 %>
    			 	<span class="red_text qtn_text">you cannot buy that many of this item</span>
    			 <%
    			 	}
    			 %>
    			<!--  </div> --> 
    			
    			
    		  </div>
    		 </form>
    		 
    		 <br>
    		<% 
    	}
    	
	}catch(SQLException e){
		System.out.println(e);
	}	
	// end sql stuff
%>

</div>

<div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>
</body>
</html>