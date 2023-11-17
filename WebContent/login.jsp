<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<h2 style="margin:0px;">Fresh Foods Online Login</h2>
	<div class="container">
		<form action="loginError.jsp" method="POST" class="login-form" id="login-form">
    		<label for="email" class="message">E-mail</label>
    		<input type="email" placeholder="Enter Email" name="email" required>
 	    	<label for="password" class="message">Password</label>
      		<input type="password" placeholder="Enter Password" name="password" required>
    		<input class="button" type="submit" value="Login">
		</form>
	</div>
	<a style="text-decoration: none;"  href="index.jsp"><button class="button">Go Back</button></a>
	<a style="text-decoration: none;" href="register.jsp"><button class="button">New User</button></a>
</div>

<div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>

</body>
</html>
