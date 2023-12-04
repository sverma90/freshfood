<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="freshfood.Credentials" %>

<%	// start sql stuff
	Class.forName("com.mysql.cj.jdbc.Driver");

	String userName = request.getParameter("name");
	String userEmail = request.getParameter("email");
	String userPassword = request.getParameter("password");
		
	try(Connection connection = DriverManager.getConnection(Credentials.URL, Credentials.USER_NAME, Credentials.PASSWORD)){
		boolean isAlreadyInDB = false;
		String sql = "SELECT * FROM users;";
    	Statement statement = connection.createStatement();
    	ResultSet userList = statement.executeQuery(sql);
    	while (userList.next()) {
    		String name = userList.getString("name");
    		String email = userList.getString("email");
    		String psw = userList.getString("password");
    		if (userName.equals(name) || userEmail.equals(email)) {
    			isAlreadyInDB = true;
    			break;
    		}
    	}
    	if (!isAlreadyInDB) {
    		sql = "INSERT INTO users (name, email, password) VALUES ('" + userName + "', '" + userEmail + "', '" +userPassword + "'); ";
    		statement = connection.createStatement();
    		statement.execute(sql);
    		session.setAttribute("name", userName);
    		session.setAttribute("email", userEmail);
    		session.setAttribute("password", userPassword);
    		response.sendRedirect("welcome.jsp");
    	}
	}catch(SQLException e){
		System.out.println("sql error");
		System.out.println(e);
	}
	
	// end sql stuff
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="header">
  <a href="index.jsp" class="logo">Fresh Foods</a>
  <!-- <div class="header-right">
    <a class="active" href="#about">Login</a>    
  </div> -->
</div>

<div class="content">
	<h2>Credentials Error, please try again</h2>
</div>

<div class="footer">
  <p class="footer-left"><a href="contact.html">Contact</a></p>
  <p class="footer-right"><a href="about.html">About</a></p>
</div>

</body>
</html>
