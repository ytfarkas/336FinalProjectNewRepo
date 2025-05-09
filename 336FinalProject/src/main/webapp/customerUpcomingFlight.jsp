<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upcoming Flights</title>
</head>
<body>
	<h2>Upcoming Flights</h2>

	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String sql = "SELECT b.Account_Number, fa.Flight_Date, fs.Flight_Number " + "FROM Bookings b "
		+ " JOIN Flight_Avalibility fa ON b.Instance_ID = fa.Instance_ID "
		+ " JOIN Flight_Schedule   fs ON fa.Flight_Number = fs.Flight_Number "
		+ "WHERE fa.Flight_Date >= CURDATE() " + "ORDER BY fa.Flight_Date";

		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
	%>
	<p>
		Flight <strong><%=rs.getString("Flight_Number")%></strong> on
		<%=rs.getDate("Flight_Date")%>
		
	</p>
	<%
	}
		con.close();

	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>