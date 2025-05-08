<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register New Account</title>
</head>
<body>
	<h2> Register New Account</h2>
	<form action= "processNewUser.jsp" method= "POST">
		First Name: <input type="text" name="firstName" required><br/>
		Last Name: <input type="text" name="lastName" required><br/>
		Username: <input type="text" name="username" required><br/>
		Password: <input type="text" name="password" required><br/>
		SSN: <input type="text" name="ssn" required><br/>
		Role:
		<select name="role" required>
			<option value ="Customer">Customer</option>
		</select></br>
		<input type="hidden" name="location" value="register">
		<input type="submit" value="Register">
	</form>

</body>
</html>