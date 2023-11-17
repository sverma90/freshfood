<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.util.*" %>
   <%@ page import="java.sql.*" %>
   <%@ page import="java.text.DecimalFormat" %>
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

HashMap<String, Integer> c = (HashMap<String, Integer>) session.getAttribute("cart");
Double price = 0.00;


Class.forName("com.mysql.cj.jdbc.Driver");

String host = "sql9.freemysqlhosting.net";
String databaseName = "sql9654705";
String port = "3306";

String url  = "jdbc:mysql://" + host + ":" + port + "/" + databaseName;

String usernameDB = "sql9654705";
String passwordDB = "cBCQdIXAv4";
String userName = request.getParameter("name");
String userEmail = request.getParameter("email");
String userPassword = request.getParameter("password");
	
try(Connection connection = DriverManager.getConnection(url, usernameDB, passwordDB)){
	boolean isAlreadyInDB = false;
	String sql = "SELECT * FROM inventory;";
	Statement statement = connection.createStatement();
	ResultSet itemList = statement.executeQuery(sql);
	while (itemList.next()) {
		String product = itemList.getString("Product");
		if (c.containsKey(product)) {
			price += itemList.getFloat("price") * c.get(product);
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
 <title>Confirmation</title>
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
<h3>Confirmation Page</h3>

<p>Dear <span class="bold"><%=name %></span>, your total cost is $<%=money.format(price) %><span class="bold"></span></p>
<form action="final.jsp">
<fieldset>
 <legend class="bold">Payment Details:</legend>
  <span>Credit Card Type: </span>
  <input type="radio" name="employment" value="Discover" required>
  <label for="employee">Discover</label>
  <input type="radio" name="employment" value="Visa" required>
  <label for="student">Visa</label> 
  <input type="radio" name="employment" value="Mastercard" required>
  <label for="speaker">Mastercard</label> 
   <br/><br/>
  <span>Credit Card Number: </span>
   <input type="password" inputmode="numeric" pattern="[0-9]{16}" name="cardnumber" required>
    <br/><br/>
   <span>Expiration Date: </span>
   <select name="expiremonth" required>
    <option value="jan">January</option>
    <option value="feb">February</option>
    <option value="mar">March</option>
    <option value="apr">April</option>
    <option value="may">May</option>
	<option value="june">June</option>
	<option value="july">July</option>
	<option value="aug">August</option>
	<option value="sept">September</option>
	<option value="oct">October</option>
	<option value="nov">November</option>
	<option value="dec">December</option>
  </select>
   <select name="expiredate" required>
    <option value="1">2023</option>
    <option value="2">2024</option>
    <option value="3">2025</option>
    <option value="4">2026</option>
    <option value="5">2027</option>
    <option value="6">2028</option>
    <option value="7">2029</option>
    <option value="8">2030</option>
  </select>
 </fieldset> 
 <br><br>
 <fieldset>
  <legend class="bold">More Actions:</legend>
	<button type="button" onclick="">Cancel</button>
	<input type="submit" value="Checkout">
 </fieldset>
 </form>

</div>
 <div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>
</body>
</html>