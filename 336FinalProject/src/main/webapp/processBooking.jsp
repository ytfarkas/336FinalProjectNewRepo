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
	String departInstanceID = request.getParameter("selectedDepartFlight");
	String departPrice = request.getParameter("departSelectedPrice");
	String departClass = request.getParameter("departSelectedClass");

	String returnInstanceID = request.getParameter("selectedReturnflight");
	String returnPrice = request.getParameter("returnSelectedPrice");
	String returnClass = request.getParameter("returnSelectedClass");
	
	int accountNumber = (Integer) session.getAttribute("user");
	
	

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);
		
		String departBookingSql = "INSERT INTO Bookings (Account_Number, Instance_ID, Price, Class) VALUES (?, ?, ?, ?)";
		
		PreparedStatement departBooking = con.prepareStatement(departBookingSql);
		departBooking.setInt(1, accountNumber);
		departBooking.setInt(2, Integer.parseInt(departInstanceID));
		departBooking.setDouble(3, Double.parseDouble(departPrice));
		departBooking.setString(4, departClass);
		departBooking.executeUpdate();
		
		String returnBookingSql = "";
		PreparedStatement returnBooking = null;
		if (returnInstanceID != null) {
			returnBookingSql = "INSERT INTO Bookings (Account_Number, Instance_ID, Price, Class) VALUES (?, ?, ?, ?)";
			
			returnBooking = con.prepareStatement(returnBookingSql);
			returnBooking.setInt(1, accountNumber);
			returnBooking.setInt(2, Integer.parseInt(returnInstanceID));
			returnBooking.setDouble(3, Double.parseDouble(returnPrice));
			returnBooking.setString(4, returnClass);
			returnBooking.executeUpdate();
		}
		%>
		<h1> Booking Confirmed</h1>
		<a href="customerUpcomingFlight.jsp">Click Here To View Upcoming Flights</a>
		<p> Or </p>
		<a href="customerPastFlights.jsp">Click Here To View Past Flights</a>
		
		<%
		
		
		
		
	con.close();
	} catch (Exception e) {
		out.println(e.getMessage());
		}
%>

</body>
</html>