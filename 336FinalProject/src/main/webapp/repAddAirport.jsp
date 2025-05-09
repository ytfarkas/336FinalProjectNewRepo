<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Airport</title>
</head>
<body>
	<h2>Add Airport</h2>
	<form action="processAddAirport.jsp" method="POST">
		Airport ID: <input type="text" name="airportID" required><br />
		City: <input type="text" name="city" required><br />
		State: <input type="text" name="state" required><br />
		<input type="submit" value="Add Airport">
	</form>


</body>
</html>