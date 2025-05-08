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
	<h2>Select A Flight</h2>

	<%
	String oneWay_roundTrip = request.getParameter("oneWay/RoundTrip");
	String depart = request.getParameter("depart");
	String arrive = request.getParameter("arrive");
	String departDate = request.getParameter("departDate");
	String returnDate = request.getParameter("returnDate");
	Boolean flexibility = request.getParameter("flexibility") != null;

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String depSql = "SELECT fa.Instance_ID, fs.Flight_Number, fs.Airline_ID, fa.Flight_Date, fs.Departure_Airport_ID, fs.Departure_Time, "
		+ "fs.Arrival_Airport_ID, fs.Arrival_Time, fa.Seats_Available " + "FROM Flight_Schedule fs "
		+ "JOIN Flight_Avalibility fa ON fs.Flight_Number = fa.Flight_Number "
		+ "WHERE fs.Departure_Airport_ID = ? " + "AND fs.Arrival_Airport_ID = ? ";

		if (flexibility) {
			depSql += "AND fa.Flight_Date BETWEEN DATE_SUB(?, INTERVAL 3 DAY) AND DATE_ADD(?, INTERVAL 3 DAY)";
		} else {
			depSql += "AND fa.Flight_Date = ? ";
		}

		PreparedStatement depPs = con.prepareStatement(depSql);

		depPs.setString(1, depart);
		depPs.setString(2, arrive);

		if (flexibility) {
			depPs.setString(3, departDate);
			depPs.setString(4, departDate);

		} else {
			depPs.setString(3, departDate);
		}

		String returnSql = "";
		PreparedStatement retPs = null;
		if (oneWay_roundTrip.equals("round trip")) {
			returnSql = "SELECT fa.Instance_ID, fs.Flight_Number, fs.Airline_ID, fa.Flight_Date, fs.Departure_Airport_ID, fs.Departure_Time, "
			+ "fs.Arrival_Airport_ID, fs.Arrival_Time, fa.Seats_Available " + "FROM Flight_Schedule fs "
			+ "JOIN Flight_Avalibility fa ON fs.Flight_Number = fa.Flight_Number "
			+ "WHERE fs.Departure_Airport_ID = ? " + "AND fs.Arrival_Airport_ID = ? ";

			if (flexibility) {
		returnSql += "AND fa.Flight_Date BETWEEN DATE_SUB(?, INTERVAL 3 DAY) AND DATE_ADD(?, INTERVAL 3 DAY)";
			} else {
		returnSql += "AND fa.Flight_Date = ? ";
			}
			retPs = con.prepareStatement(returnSql);

			retPs.setString(1, arrive);
			retPs.setString(2, depart);

			if (flexibility) {
		retPs.setString(3, returnDate);
		retPs.setString(4, returnDate);

			} else {
		retPs.setString(3, returnDate);
			}

		}
	%>
	<form action="bookFlight.jsp" method="post">
		<h3>Departing Flights</h3>
		<%
		ResultSet rs = depPs.executeQuery();
		while (rs.next()) {
			String instanceID = rs.getString("Instance_ID");
			String flightNumber = rs.getString("Flight_Number");
			String airlineID = rs.getString("Airline_ID");
			String flightDate = rs.getString("Flight_Date");
			String departAirportID = rs.getString("Departure_Airport_ID");
			String departTime = rs.getString("Departure_Time");
			String arrivalAirportID = rs.getString("Arrival_Airport_ID");
			String arrivalTime = rs.getString("Arrival_Time");
			int seatsAvailable = rs.getInt("Seats_Available");
		%>
		<label> <input type="radio" name="selectedDepartFlight"
			value="<%=instanceID%>"> Flight: <%=flightNumber%> Airline:
			<%=airlineID%> Date: <%=flightDate%> From: <%=departAirportID%>
			Depart Time: <%=departTime%> To: <%=arrivalAirportID%> Arrival Time:
			<%=arrivalTime%>
		</label></br>


		<%
		}
		ResultSet retRs = null;
		if (oneWay_roundTrip.equals("round trip")) {
		%><h3>Return Flights</h3>
		<%
		retRs = retPs.executeQuery();
		while (retRs.next()) {
			String instanceID = retRs.getString("Instance_ID");
			String returnFlightNumber = retRs.getString("Flight_Number");
			String returnAirlineID = retRs.getString("Airline_ID");
			String returnFlightDate = retRs.getString("Flight_Date");
			String returnDepartAirportID = retRs.getString("Departure_Airport_ID");
			String returnDepartTime = retRs.getString("Departure_Time");
			String returnArrivalAirportID = retRs.getString("Arrival_Airport_ID");
			String returnArrivalTime = retRs.getString("Arrival_Time");
			int returnSeatsAvailable = retRs.getInt("Seats_Available");
		%>
		<label> <input type="radio" name="selectedReturnFlight"
			value="<%=instanceID%>"> Flight: <%=returnFlightNumber%> Airline:
			<%=returnAirlineID%> Date: <%=returnFlightDate%> From: <%=returnDepartAirportID%>
			Depart Time: <%=returnDepartTime%> To: <%=returnArrivalAirportID%> Arrival Time:
			<%=returnArrivalTime%>
		</label></br>


		<%
		}

		}
		%>
		<input type="submit" value="Confirm Selection">
	</form>
	<%
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>
</body>
</html>


