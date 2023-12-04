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


<!--
10/20
1. user checkout page, updates inventory (quantity in stock)
	- sessions updating shopping cart
2. admin page to update inventory
3. Index.html...if logged in, replace 2 buttons with view inventory or checkout cart....add log out at the top right

10/21
1. Create confirmation page with credit card checkout, SSL. 
	- copies items from checkout page and displays credit card info. 
2. Checkout page: 		DONE
	- needs to display selected item information
	- when going back, check whether inventory page loses quantity of selected item
	- remove item from cart when checking out 
	- hash-map for shopping cart rather than arrayList
3. 404 ERROR: Whenever someone accesses checkout.jsp web page without log-in in or adding anything into card,	DONE 
	- leads to the error: java.lang.NullPointerException: 
	- Cannot invoke "java.util.ArrayList.iterator()" because "c" is null [line 74]
	- SEE SCREENSHOT
	- Just run checkout.jsp and you will see the error. 
		* Add a redirect to get users to login
		* once logged in: 
			= if logged in user has no items in cart, display 0 items for checkout
			= else, display their items if they have any

4. Add EmailServlet to project 		PENDING
	- so when user registers or checks out, an email confirmation is sent
5. Add more items to inventory (SQL commands)	PENDING


/*	11/7/23

1. Credit card for SSL (confirm.jsp)	DONE
2. Update the quantity in the database depending on what the user bought	DONE

*/


11/16

1. Total stopped working, checkout page not working.
2. work on sold out, prevent users from adding sold out items to cart.
3. prevent -1 on inventory 
4. Code error screen 404 not found, click to go back
5. Github repository to push/pull changes		

 -->



<!-- <form action="welcome.jsp" method="POST" class="login-form" id="login-form"> -->	<!-- div for desc text must be 20 characters or more -->

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

<!--  
 <div class="product">
  <div class="product_image">
   <img width="120" height="120" src="images/carrots.png"></img>
  </div>
  <div class="product_desc">
   <span class="product_desc_main">Carrots:</span>
   <span class="product_desc_text">Fresh carrots for your family. This here is a statmenet and I am using this to test the div.</span>
	<div class="product_2column_btn">
	 <button class="product_desc_btn">Add Item</button>
	</div>
	<div class="product_2column_qtn">
	 <span class="qtn_text">Quantity: </span><input type="number" name="points" step="1">
	</div>
  </div>
 </div>
 
 <br>

 <div class="product">
  <div class="product_image">
   <img width="120" height="120" src="images/potatoes.png"></img>
  </div>
  <div class="product_desc">
   <span class="product_desc_main">Potatoes:</span>
   <span class="product_desc_text">Fresh potatoes for your family. This here is a statmenet and I am using this to test the div length.</span>
	<div class="product_2column_btn">
	 <button class="product_desc_btn">Add Item</button>
	</div>
	<div class="product_2column_qtn">
	 <span class="qtn_text">Quantity: </span><input type="number" name="points" step="1">
	</div>
  </div>
 </div>
 
 <br>
 
  <div class="product">
  <div class="product_image">
   <img width="120" height="120" src="images/medicine.png"></img>
  </div>
  <div class="product_desc">
   <span class="product_desc_main">Medicine:</span>
   <span class="product_desc_text">Fresh medicine for your family. This here is a statmenet and I am using this to test the div length.</span>
	<div class="product_2column_btn">
	 <button class="product_desc_btn">Add Item</button>
	</div>
	<div class="product_2column_qtn">
	 <span class="qtn_text">Quantity: </span><input type="number" name="points" step="1">
	</div>
  </div>
 </div>
 
 <br>
 
  <div class="product">
  <div class="product_image">
   <img width="120" height="120" src="images/apple.png"></img>
  </div>
  <div class="product_desc">
   <span class="product_desc_main">Apple:</span>
   <span class="product_desc_text">Fresh apple for your family. This here is a statmenet and I am using this to test the div length.</span>
	<div class="product_2column_btn">
	 <button class="product_desc_btn">Add Item</button>
	</div>
	<div class="product_2column_qtn">
	 <span class="qtn_text">Quantity: </span><input type="number" name="points" step="1">
	</div>
  </div>
 </div>
 
 <br>
 
  <div class="product">
  <div class="product_image">
   <img width="120" height="120" src="images/ice_cream.png"></img>
  </div>
  <div class="product_desc">
   <span class="product_desc_main">Ice Cream:</span>
   <span class="product_desc_text">Fresh ice cream for your family. This here is a statmenet and I am using this to test the div length.</span>
	<div class="product_2column_btn">
	 <button class="product_desc_btn">Add Item</button>
	</div>
	<div class="product_2column_qtn">
	 <span class="qtn_text">Quantity: </span><input type="number" name="points" step="1">
	</div>
  </div>
 </div>
 
  <br>
 
  <div class="product">
  <div class="product_image">
   <img width="120" height="120" src="images/honey.png"></img>
  </div>
  <div class="product_desc">
   <span class="product_desc_main">Honey:</span>
   <span class="product_desc_text">Fresh honey for your family. This here is a statmenet and I am using this to test the div length.</span>
	<div class="product_2column_btn">
	 <button class="product_desc_btn">Add Item</button>
	</div>
	<div class="product_2column_qtn">
	 <span class="qtn_text">Quantity: </span><input type="number" name="points" step="1">
	</div>
  </div>
 </div>
  
</form>



<!-- <div class="product">
	<span class="product_image"><img width="100" height="100" src="images/carrot.png"></img></span>
	<span class="product_name">Carrot</span>
	<p>Description: add desc here.</p>
	<button>Add to Cart</button>
</div>
<div class="product">
	<h2>Pear</h2>
	<p>Description: add desc here.</p>
	<button>Add to Cart</button>
</div> -->	

</div>

<div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>
</body>
</html>