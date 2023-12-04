<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.util.*" %>
   <%@ page import="java.sql.*" %>
   <%@ page import="java.text.DecimalFormat" %>
   <%@ page import="freshfood.Credentials" %>
<!DOCTYPE html>
<%
//check whether user is logged in, if not logged in redirect to login.jsp
	String name=(String)session.getAttribute("name");
	if (session.getAttribute("name") == null) { 
		response.sendRedirect("login.jsp");
	} 
//money format
DecimalFormat money = new DecimalFormat(); 
money.setMaximumFractionDigits(2);

String email = (String)session.getAttribute("email");
HashMap<String, Integer> c = (HashMap<String, Integer>) session.getAttribute("cart");
Double price = 0.00;

Class.forName("com.mysql.cj.jdbc.Driver");

String userName = request.getParameter("name");
String userEmail = request.getParameter("email");
String userPassword = request.getParameter("password");
	
try(Connection connection = DriverManager.getConnection(Credentials.URL, Credentials.USER_NAME, Credentials.PASSWORD)){
	boolean isAlreadyInDB = false;
	String sql = "SELECT * FROM inventory;";
	Statement statement = connection.createStatement();
	ResultSet itemList = statement.executeQuery(sql);
	while (itemList.next()) {
		String product = itemList.getString("Product");
		int oldQuantity = itemList.getInt("Quantity");
		if (c.containsKey(product)) {
			int newQuantity = oldQuantity - c.get(product);
			String sqlUpdate = "UPDATE inventory SET quantity = " + newQuantity + " WHERE product = '" + product +"';";
			Statement s = connection.createStatement();
			s.executeUpdate(sqlUpdate);
		}
	}
}catch(SQLException e){
	System.out.println("sql error");
	System.out.println(e);
}

%>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/styles.css">
 <meta charset="UTF-8">
 <title>Thank you for shopping!</title>
</head>
<body>
<div class="header">
	<a href="index.jsp" class="logo">Fresh Foods</a>
	<% 	if (session.getAttribute("name") != null) { %>	
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
<h3>Thank you for shopping!!</h3>
<h4>A confirmation email has been sent to <%=email %></h4>
<form action="inventory.jsp">
	<input type="submit" value="back to shopping">
</form>

</div>
 <div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>
</body>
</html>
<%
c.clear();
session.setAttribute("cart", c);
%>