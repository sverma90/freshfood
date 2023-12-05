<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="freshfood.Credentials" %>
<% 	
	// start sql stuff
	Class.forName("com.mysql.cj.jdbc.Driver");

	String userEmail = request.getParameter("email");
	String userPassword = request.getParameter("password");
	String userName = null;
		
	try (Connection connection = DriverManager.getConnection(Credentials.URL, Credentials.USER_NAME, Credentials.PASSWORD)) {
		boolean isInDB = false;
		String sql = "SELECT * FROM users;";
    	Statement statement = connection.createStatement();
    	ResultSet userList = statement.executeQuery(sql);
    	
    	while (userList.next()) {
    		String email = userList.getString("email");
    		String psw = userList.getString("password");
    		if (userEmail.equals(email) && userPassword.equals(psw)) {
    			userName = userList.getString("name");
    			isInDB = true;
    			break;
    		}
    	}
    	if (isInDB) {
    		session.setAttribute("email", userEmail);
    		session.setAttribute("password", userPassword);
    		session.setAttribute("name", userName);
    		response.sendRedirect("welcome.jsp");
    	}
	}catch(SQLException e){
		System.out.println(e);
	}	
	// end sql stuff
%>


<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/styles.css">
 <meta charset="UTF-8">
 <title>User Error Page</title>
</head>
<body>
<div class="header">
  <a href="index.jsp" class="logo">Fresh Foods</a>
    <div class="header-right">
     <a class="active" href="login.jsp">Log In</a>    
  </div>
</div>
<div class="content">

<h1>User not in database, please register or use valid credentials</h1>

<a style="text-decoration: none;" href="login.jsp"><button class="button">Go Back</button></a>

</div>

 <div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>
</body>
</html>