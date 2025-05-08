<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Representative</title>
</head>
<body>
	<h1>What Would You Like To Do?</h1>
	<form action="repFlightSearch.jsp" method="get">
		<button type="submit">Make Flight Reservations For Customer</button>
	</form>
	<form action="repEditReservation.jsp" method="get">
		<button type="submit">Edit Reservations For Customer</button>
	</form>
	<form action="repEditInfo.jsp" method="get">
		<button type="submit">Add, Edit, Delete information for
			Aircrafts, Airports, and Flights</button>
	</form>
	<form action="repViewWaitlist.jsp" method="get">
		<button type="submit">View Waitlist on Particular Flight</button>
	</form>
	<form action="repViewAirports.jsp" method="get">
		<button type="submit">View Flights From Given Airport</button>
	</form>
	<form action="repAnswerQuestions.jsp" method="get">
		<button type="submit">Reply To User Questions</button>
	</form>
	<form action="viewAccountInformation.jsp" method="get">
		<button type="submit">View Account Information</button>
	</form>


	<a href='logout.jsp'>Log Out</a>

</body>
</html>