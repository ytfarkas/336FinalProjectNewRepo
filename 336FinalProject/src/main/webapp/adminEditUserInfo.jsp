<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User Info</title>
</head>
<body>
	<h2>Edit User Info</h2>
	<form action="userEditer.jsp" method="POST">
		Account Number: <input type="text" name="accountNumber" required><br />
		<input type="submit" value="Edit User">
	</form>

</body>
</html>