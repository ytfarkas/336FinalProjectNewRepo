<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Administrator</title>
</head>
<body>
	<h1>What Would You Like To Do?</h1>
	<form action="adminEditUser.jsp" method="get">
		<button type="submit">Add, Edit, and Delete User</button>
	</form>
	<form action="adminSalesReport.jsp" method="get">
		<button type="submit">View Sales Report</button>
	</form>
	<form action="adminViewReservations.jsp" method="get">
		<button type="submit">View Reservations</button>
	</form>
	<form action="adminViewRevenue.jsp" method="get">
		<button type="submit">View Revenue Generated</button>
	</form>
	<form action="adminTopCustomer.jsp" method="get">
		<button type="submit">View Top Customer Revenue Generated</button>
	</form>
	<form action="adminActiveFligths.jsp" method="get">
		<button type="submit">View Most Active Flights</button>
	</form>
	<form action="viewAccountInformation.jsp" method="get">
		<button type="submit">View Account Information</button>
	</form>


	<a href='logout.jsp'>Log Out</a>

</body>
</html>