<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Flight</title>
</head>
<body>
	<h2>View Flight Details</h2>

	<%
	String departInstanceID = request.getParameter("selectedDepartFlight");
	String departClass = request.getParameter("departSelectedClass");
	String departPrice = request.getParameter("departSelectedPrice");
	String returnInstanceID = null;
	String returnClass = null;
	String returnPrice = null;

	if (request.getParameter("selectedReturnFlight") != null) {
		returnInstanceID = request.getParameter("selectedReturnFlight");
		returnClass = request.getParameter("returnSelectedClass");
		returnPrice = request.getParameter("returnSelectedPrice");
	}

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String deptSql = "SELECT * FROM Flight_Schedule fs "
		+ "JOIN Flight_Avalibility fa ON fs.Flight_Number = fa.Flight_Number " + "WHERE fa.Instance_ID = ?";

		PreparedStatement depPs = con.prepareStatement(deptSql);
		depPs.setString(1, departInstanceID);
		ResultSet rs = depPs.executeQuery();

		String returnSql = "";
		PreparedStatement retPs = null;
		if (request.getParameter("selectedReturnFlight") != null) {
			returnSql = "SELECT * FROM Flight_Schedule fs "
			+ "JOIN Flight_Avalibility fa ON fs.Flight_Number = fa.Flight_Number " + "WHERE fa.Instance_ID = ?";

			retPs = con.prepareStatement(returnSql);
			retPs.setString(1, returnInstanceID);
		}
	%>
	<h3>Depart Info</h3>
	<%
	while (rs.next()) {
		String departFlightNumberData = rs.getString("Flight_Number");
		String departAirlineID = rs.getString("Airline_ID");
		String departFlightDate = rs.getString("Flight_Date");
		String departDepartAirportID = rs.getString("Departure_Airport_ID");
		String departDepartTime = rs.getString("Departure_Time");
		String departArrivalAirportID = rs.getString("Arrival_Airport_ID");
		String departArrivalTime = rs.getString("Arrival_Time");
		int departSeatsAvailable = rs.getInt("Seats_Available");

		out.println("Flight: " + departFlightNumberData + "<br>");
		out.println("Airline: " + departAirlineID + "<br>");
		out.println("Date: " + departFlightDate + "<br>");
		out.println("From: " + departDepartAirportID + " at " + departDepartTime + "<br>");
		out.println("To: " + departArrivalAirportID + " at " + departArrivalTime + "<br>");
		out.println("Seats Available: " + departSeatsAvailable + "<br>");
		out.println("Class Selected: " + departClass + "<br>");
		out.println("Price: $" + departPrice + "<br><br>");
		
	}

	if (request.getParameter("selectedReturnFlight") != null) {
		ResultSet returnRs = retPs.executeQuery();
	%>
	<h3>Return Info</h3>
	<%
	while (returnRs.next()) {
		String returnFlightNumberData = returnRs.getString("Flight_Number");
		String returnAirlineID = returnRs.getString("Airline_ID");
		String returnFlightDate = returnRs.getString("Flight_Date");
		String returnDepartAirportID = returnRs.getString("Departure_Airport_ID");
		String returnDepartTime = returnRs.getString("Departure_Time");
		String returnArrivalAirportID = returnRs.getString("Arrival_Airport_ID");
		String returnArrivalTime = returnRs.getString("Arrival_Time");
		int returnSeatsAvailable = returnRs.getInt("Seats_Available");

		out.println("Flight: " + returnFlightNumberData + "<br>");
		out.println("Airline: " + returnAirlineID + "<br>");
		out.println("Date: " + returnFlightDate + "<br>");
		out.println("From: " + returnDepartAirportID + " at " + returnDepartTime + "<br>");
		out.println("To: " + returnArrivalAirportID + " at " + returnArrivalTime + "<br>");
		out.println("Seats Available: " + returnSeatsAvailable + "<br>");
		out.println("Class Selected: " + returnClass + "<br>");
		out.println("Price: $" + returnPrice + "<br><br>");
	}
	}
	%>
	<form action="processBooking.jsp" method="post">
		<input type="hidden" name="selectedDepartFlight"
			value="<%=departInstanceID%>">
		<input type="hidden" name="departSelectedClass" value="<%=departClass%>">
		<input type="hidden" name="departSelectedPrice" value="<%=departPrice%>">
		<%
		if (returnInstanceID != null) {
		%>
		<input type="hidden" name="selectedReturnFlight"
			value="<%=returnInstanceID%>">
		<input type="hidden" name="returnSelectedClass" value="<%=returnClass%>">
		<input type="hidden" name="returnSelectedPrice" value="<%=returnPrice%>">
		<%
		}
		%>
		<input type="submit" value="Confirm Booking">
	</form>
	<%
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>