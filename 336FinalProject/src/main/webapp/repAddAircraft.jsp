<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Aircraft</title>
</head>
<body>
	<h2>Add Aircraft</h2>
	<form action="processAddAircraft.jsp" method="POST">
		Aircraft ID: <input type="text" name="aircraftID" required><br />
		Seats: <input type="text" name="seats" required><br />
		<input type="submit" value="Add Aircraft">
	</form>


</body>
</html>