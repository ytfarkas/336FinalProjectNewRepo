<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Delete User</title>
</head>
<body>
	<h2>Delete User</h2>
	<form action="processDeleteUser.jsp" method="POST">
		UserID: <input type="text" name="userID" required><br />
		<input type="submit" value="Delete">
	</form>

</body>
</html>