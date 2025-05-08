<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
			<title>login</title>
	</head>
<body>
<form action = "verifyLogin.jsp" method = "POST">
Username: <input type = 'text' name ="username"/> <br/>
Password: <input type = 'password' name = "password"/> <br/>
<input type="submit" value = "Log In">
</form>
<p>
Dont have an account?
<a href="register.jsp">Register Here</a>

</p>

</body>
</html>