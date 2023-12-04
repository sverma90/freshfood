<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="freshfood.Credentials" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="header">
  <a href="index.jsp" class="logo">Fresh Foods</a>
</div>

<div class="content">
	<div class="container">
    	<form action="crederror.jsp" method="POST" class="login-form" id="login-form">
    		<h2 style="margin:0px;">Fresh Foods Online Registration</h2>
    		<p style="margin:25px; font-size: 25px;">Please fill out this form to create an account to begin shopping.</p>
    			<label for="name" class="message">Name</label>
      			<input type="text" placeholder="Enter name" name="name" required> 
      			<label for="email" class="message">E-mail</label>
      			<input type="email" placeholder="Enter Email" name="email" required> 
      			<label for="password" class="message">Password</label>
      			<input type="password" placeholder="Enter Password" name="password" required>
    			<input class="button" type="submit" name="action" value="Confirm Registration" form="login-form">
		</form>
	</div>
	<a style="text-decoration: none;" href="index.jsp"><button class="button">Go Back</button></a>
    <a style="text-decoration: none;" href="login.jsp"><button class="button">Sign In</button></a>
</div>

<%	// start sql stuff
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("we are on this step");
	try (Connection connection = DriverManager.getConnection(Credentials.URL, Credentials.USER_NAME, Credentials.PASSWORD)) {
		System.out.println("we are connected to the database");
		String sql = "SELECT * FROM users;";
    	Statement statement = connection.createStatement();
    	ResultSet userList = statement.executeQuery(sql);
    	
    	while (userList.next()) {
    		String email = userList.getString("email");
    		String psw = userList.getString("password");
    	}
	}catch(SQLException e){
		System.out.println(e);
	}	
	// end sql stuff
%>

<div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>

</body>
</html>
