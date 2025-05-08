<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String airportID = request.getParameter("airportID");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String airportDepartSql = "SELECT fa.Instance_ID, fs.Flight_Number, fs.Airline_ID, fa.Flight_Date, fs.Departure_Airport_ID, fs.Departure_Time, "
		+ "fs.Arrival_Airport_ID, fs.Arrival_Time, fa.Seats_Available " + "FROM Flight_Schedule fs "
		+ "JOIN Flight_Avalibility fa ON fs.Flight_Number = fa.Flight_Number "
		+ "WHERE fs.Departure_Airport_ID = ? ";

		PreparedStatement airportDepPs = con.prepareStatement(airportDepartSql);
		airportDepPs.setString(1, airportID);

		String airportArrivalSql = "SELECT fa.Instance_ID, fs.Flight_Number, fs.Airline_ID, fa.Flight_Date, fs.Departure_Airport_ID, fs.Departure_Time, "
		+ "fs.Arrival_Airport_ID, fs.Arrival_Time, fa.Seats_Available " + "FROM Flight_Schedule fs "
		+ "JOIN Flight_Avalibility fa ON fs.Flight_Number = fa.Flight_Number " + "WHERE fs.Arrival_Airport_ID = ? ";

		PreparedStatement airportArrivalPs = con.prepareStatement(airportArrivalSql);
		airportArrivalPs.setString(1, airportID);
	%>
	<h2>Departing Flights</h2>
	<%
	ResultSet departRs = airportDepPs.executeQuery();
	while (departRs.next()) {
		String flightNumber = departRs.getString("Flight_Number");
		String airlineID = departRs.getString("Airline_ID");
		String flightDate = departRs.getString("Flight_Date");
		String departAirportID = departRs.getString("Departure_Airport_ID");
		String departTime = departRs.getString("Departure_Time");
		String arrivalAirportID = departRs.getString("Arrival_Airport_ID");
		String arrivalTime = departRs.getString("Arrival_Time");
		int seatsAvailable = departRs.getInt("Seats_Available");
	%>
	<p>
		Flight:
		<%=flightNumber%>
		Airline:
		<%=airlineID%>
		Date:
		<%=flightDate%>
		From:
		<%=departAirportID%>
		Depart Time:
		<%=departTime%>
		To:
		<%=arrivalAirportID%>
		Arrival Time:
		<%=arrivalTime%>
	</p>
	<%
	}
	%>
	<h2>Arriving Flights</h2>
	<%
	ResultSet airportArrivalRs = airportArrivalPs.executeQuery();
	while (airportArrivalRs.next()) {
		String flightNumber = airportArrivalRs.getString("Flight_Number");
		String airlineID = airportArrivalRs.getString("Airline_ID");
		String flightDate = airportArrivalRs.getString("Flight_Date");
		String departAirportID = airportArrivalRs.getString("Departure_Airport_ID");
		String departTime = airportArrivalRs.getString("Departure_Time");
		String arrivalAirportID = airportArrivalRs.getString("Arrival_Airport_ID");
		String arrivalTime = airportArrivalRs.getString("Arrival_Time");
		int seatsAvailable = airportArrivalRs.getInt("Seats_Available");
	%>
	<p>
		Flight:
		<%=flightNumber%>
		Airline:
		<%=airlineID%>
		Date:
		<%=flightDate%>
		From:
		<%=departAirportID%>
		Depart Time:
		<%=departTime%>
		To:
		<%=arrivalAirportID%>
		Arrival Time:
		<%=arrivalTime%>

		<%
		}

		con.close();
		} catch (Exception e) {
		out.println(e.getMessage());
		}
		%>
	
	</body>
</html>