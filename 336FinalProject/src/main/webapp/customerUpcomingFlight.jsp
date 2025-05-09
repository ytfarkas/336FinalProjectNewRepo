<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>My Upcoming Flights</title>
  <style>
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    th { background: #eee; }
  </style>
</head>
<body>

<%
  Integer acctNum = (Integer) session.getAttribute("user");

	Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

  String sql =
    "SELECT fs.Flight_Number,\n" +
    "       fa.Flight_Date,\n" +
    "       fs.Departure_Airport_ID, fs.Departure_Time,\n" +
    "       fs.Arrival_Airport_ID,   fs.Arrival_Time,\n" +
    "       b.Class, b.Price\n" +
    "  FROM Bookings b\n" +
    "  JOIN Flight_Avalibility fa ON b.Instance_ID    = fa.Instance_ID\n" +
    "  JOIN Flight_Schedule   fs ON fa.Flight_Number  = fs.Flight_Number\n" +
    " WHERE b.Account_Number = ?\n" +
    "   AND fa.Flight_Date   >= CURDATE()\n" +
    " ORDER BY fa.Flight_Date, fs.Departure_Time";

  PreparedStatement ps = con.prepareStatement(sql);
  ps.setInt(1, acctNum);
  ResultSet rs = ps.executeQuery();
%>

  <h2>My Upcoming Flights</h2>
  <table>
    <tr>
      <th>Flight #</th>
      <th>Date of Flight</th>
      <th>From (Departure Time)</th>
      <th>To (Arrival Time)</th>
      <th>Class</th>
      <th>Fare ($)</th>
    </tr>
<%
  while (rs.next()) {
%>
    <tr>
      <td><%= rs.getString("Flight_Number") %></td>
      <td><%= rs.getDate("Flight_Date") %></td>
      <td>
        <%= rs.getString("Departure_Airport_ID") %>
        @ <%= rs.getTime("Departure_Time") %>
      </td>
      <td>
        <%= rs.getString("Arrival_Airport_ID") %>
        @ <%= rs.getTime("Arrival_Time") %>
      </td>
      <td><%= rs.getString("Class") %></td>
      <td><%= rs.getBigDecimal("Price") %></td>
    </tr>
<%
  }
  rs.close();
  ps.close();
  con.close();
%>
  </table>

</body>
</html>
